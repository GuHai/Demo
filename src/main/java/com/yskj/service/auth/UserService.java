package com.yskj.service.auth;

import com.yskj.dao.UserDao;
import com.yskj.models.PageParam;
import com.yskj.models.Personalauthen;
import com.yskj.models.QueryParam;
import com.yskj.models.auth.Permission;
import com.yskj.models.auth.Role;
import com.yskj.models.auth.User;
import com.yskj.redis.RedisUtil;
import com.yskj.service.PersonalauthenService;
import com.yskj.service.base.AbstractService;
import com.yskj.service.base.RedisCacheService;
import com.yskj.vo.Member;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * 用户service层
 *
 * @author:Administrator
 * @create 2018-01-18 13:06
 */
@Service("userService")
public class UserService extends AbstractService {
    public static final String HASH_ALGORITHM = "SHA-1";
    public static final int HASH_INTERATIONS = 1024;
    private static final int SALT_SIZE = 8;

    @Autowired
    private UserDao userDao;
    @Autowired
    private PermissionService permissionService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private PersonalauthenService personalauthenService;
    @Autowired
    private RedisCacheService redisCacheService;


    public UserDao getDao() {
        return this.userDao;
    }
    public PageParam zpPage(PageParam pageParam){
        Boolean exist  =  RedisUtil.contains(Member.class.getSimpleName());
        if(!exist) { //如果不存在，则查询数据库所以数据，缓存到redis
            try {
                redisCacheService.readUserCache();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if(com.yskj.utils.StringUtils.isNotEmptyString(pageParam.getCondition().get("keyword"))){
            List<String> ids = RedisUtil.ids("Member",pageParam.getCondition().get("keyword").toString());
            if(!CollectionUtils.isEmpty(ids)){
                String idstr = "'"+ String.join("','",ids)+"'";
                pageParam.getCondition().put("keyword",null);
                pageParam.getCondition().put("wIds",idstr);
                pageParam.setList(this.getDao().zpPage(pageParam));
            }else{
                List list = this.getDao().zpPage(pageParam);
                if(CollectionUtils.isEmpty(list)){
                    pageParam.setList(new ArrayList());
                }else{
                    RedisUtil.addMatchByLike(list,new String[]{"mainName","nickName","personPhoneNumber"});
                    pageParam.setList(list);
                }

            }
        }
        return  pageParam;
    }

    public PageParam qzPage(PageParam pageParam){
        pageParam.setList(this.getDao().qzPage(pageParam));
        return  pageParam;
    }


    public Personalauthen onePersonal(QueryParam queryParam)throws Exception{
        Personalauthen personalauthen = personalauthenService.one(queryParam);
        return personalauthen;
    }

    public User getByAccountNo(String accountNo){
        return getDao().getByAccountNo(accountNo);
    }

    public AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) throws Exception {
        User authUser = (User) principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        User user = this.getByAccountNo(authUser.getAccountNo());
        if(user != null) {;
            // 根据用户名查询当前用户拥有的角色
            Set<Role> roles = roleService.findRoleSetsByAccountNo(user.getAccountNo());
            Set<String> roleNames = new HashSet<String>();
            List<String> roleIds = new ArrayList<String>();
            for (Role role : roles) {
                if(role!=null){
                    roleNames.add(role.getName());
                    roleIds.add(role.getId());
                }
            }
            // 将角色名称提供给info
            authorizationInfo.setRoles(roleNames);
            if(!CollectionUtils.isEmpty(roleIds)){
                // 根据用户名查询当前用户权限
                Set<Permission> permissions = permissionService.findPermissionsToSet(roleIds);
                Set<String> permissionNames = new HashSet<String>();
                for (Permission permission : permissions) {
                    permissionNames.add(permission.getAlias());
                }
                // 将权限名称提供给info
                authorizationInfo.setStringPermissions(permissionNames);
            }
        }
        return authorizationInfo;
    }

    public Map<String,String> userInfo(String userID){
        return this.getDao().userInfo(userID);
    }


}

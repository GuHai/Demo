package com.yskj.shiro;

import com.yskj.models.Information;
import com.yskj.models.Mylocaltion;
import com.yskj.models.QueryParam;
import com.yskj.models.auth.User;
import com.yskj.service.InformationService;
import com.yskj.service.MylocaltionService;
import com.yskj.service.auth.UserService;
import com.yskj.service.base.DictCacheService;
import com.yskj.utils.StringUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.File;


/**
 * job权限验证
 *
 * @author:Administrator
 * @create 2018-01-19 10:45
 */
public class JobShiroRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;
    @Autowired
    private InformationService informationService;
    @Autowired
    private MylocaltionService mylocaltionService;
    /*
     * 授权
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        try {
            return this.userService.doGetAuthorizationInfo(principals);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    /*
     * 登录验证
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(
            AuthenticationToken userToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) userToken;
        User user = null;
        try {
//            user = this.userService.getByAccountNo(token.getUsername());
            user = userService.one(new QueryParam("accountNo",token.getUsername()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (user != null) {
            if (user.getLocked()) {
                throw new LockedAccountException();
            }
            if (user.isDeleted()) {
                throw new DisabledAccountException();
            }
            if(user.getAttachment()!=null&&StringUtils.isNotEmpty(user.getAttachment().getAbsolutelyPath())){
                user.setImgPath(DictCacheService.UploadUrl+File.separator+user.getAttachment().getAbsolutelyPath());
            }else{
                user.setImgPath(user.getWeixin().getHeadimgurl());
            }
            System.out.println("=========imgpath===="+user.getImgPath());
           /* if(user.getWeixin()!=null){
                user.setRefreshToken( user.getWeixin().getRefreshToken());
                user.setAccessToken(user.getWeixin().getAccessToken());
                user.setTicket(user.getWeixin().getTicket());
                user.setOpenid(user.getWeixin().getOpenid());
                user.setWeixin(null);
            }*/
            String p = user.getPassword();
            QueryParam queryParam = new QueryParam();
            queryParam.put("userID",user.getId());
            try {
                Information information = informationService.one(queryParam);
                user.setInformation(information);
            } catch (Exception e) {
                e.printStackTrace();
            }

            try {
                Mylocaltion mylocaltion  = mylocaltionService.one(queryParam);
                user.setMylocaltion(mylocaltion);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return new SimpleAuthenticationInfo(user, p, this.getName());//已在配置中引入加密算法
        }else{
            throw new UnknownAccountException();
        }
    }

}

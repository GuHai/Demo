
package com.yskj.controller.auth;

import com.yskj.controller.base.BaseController;
import com.yskj.models.*;
import com.yskj.models.auth.User;
import com.yskj.redis.RedisUtil;
import com.yskj.service.EnterpriseVIPService;
import com.yskj.service.MessageTemplateService;
import com.yskj.service.PartnerUserService;
import com.yskj.service.WeChatService;
import com.yskj.service.auth.PermissionService;
import com.yskj.service.auth.RoleService;
import com.yskj.service.auth.UserService;
import com.yskj.service.base.DictCacheService;
import com.yskj.utils.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.subject.support.DelegatingSubject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.Map;


/**
 * 用户控制层
 *
 * @author:Administrator
 * @create 2018-01-19 11:15
 */

@Controller
@RequestMapping("/UserController")
public class UserController extends BaseController {

    private final static Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;
    @Autowired
    private PermissionService permissionService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private WeChatService weChatService;
    @Autowired
    private EnterpriseVIPService enterpriseVIPService;
    @Autowired
    private PartnerUserService partnerUserService ;
    @Autowired
    private MessageTemplateService messageTemplateService;

    public UserService getService() {
        return this.userService;
    }

    /**
     * 新增用户页面
     * @return
     */
    @RequiresPermissions("User")
    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String user(){
        return "system/user";
    }


    /**
     *注册
     */
    @RequestMapping("/toRegister")
    public String toRegest(String username,String password,Model m){
        User user = new User();
        user.setAccountNo(username);
        String ps = MD5Tools.getMD5Hash(username, password);
        user.setPassword(ps);
        try {
            user.setLocked(false);
            userService.add(user);
        } catch (Exception e) {
            m.addAttribute("result","注册用户失败");
            e.printStackTrace();
        }
        return "login";
    }

    /**
     *登录 h5
     */
    @RequestMapping("/h5/toLogin")
    public String toLoginWithH5(Model m){
        User user = new User();
        user.setAccountNo("o56nM0heocVpO-8vRUi0D4KU5_k4");
        user.setPassword("Amin");
        UsernamePasswordToken token = new UsernamePasswordToken(user.getAccountNo(),user.getPassword());
        Subject subject = SecurityUtils.getSubject();
//        token.setRememberMe(true);
        try {
            subject.login(token);
           /* subject.getSession().setAttribute("user",user);
            subject.getSession().setAttribute("menus",permissionService.findUserPermissionList(roleService.findRoleIdByAccountNo(user.getAccountNo())));
           */
           return "redirect:/ijob/indexMain";
        } catch (Exception e) {
            m.addAttribute("result","登录失败："+e.getMessage());
            return "/h5/error";
        }
    }
    public boolean checkLoginAuth() throws Exception{

//        InetAddress address = InetAddress.getLocalHost();//获取的是本地的IP地址 //PC-20140317PXKX/192.168.0.121
//        String hostAddress = address.getHostAddress();//192.168.0.121
//        return "112.74.36.24".equals(hostAddress);
        return "https://www.jianzhipt.cn".equals(DictCacheService.Site);
    }
    /**
     *登录 h5
     */
    @RequestMapping("/h5/toLoginByName/{name}")
    public String toLoginWithH5(Model m , @PathVariable String name, HttpServletRequest request, HttpServletResponse response)throws Exception{

        if(checkLoginAuth()){
            m.addAttribute("result","非法登录");
            return "/h5/error";
        }
        QueryParam queryParam = new QueryParam("nickname",name);
        Weixin weixin  = weChatService.one(queryParam);
//        messageTemplateService.ptShtz(weixin.getOpenid(),"测试MQ","测试MQ内容"+UUIDGenerator.getRandomString(8));
        if(weixin==null){
            queryParam.clear();
            queryParam.put("openid",name);
            weixin = weChatService.one(queryParam);
        }
        User user = new User();
        user.setAccountNo(weixin.getOpenid());
        user.setPassword(IJobUtils.toHanyuPinyin(weixin.getNickname()));
        user.setPassword(MD5Tools.MD5(user.getAccountNo()));
        UsernamePasswordToken token = new UsernamePasswordToken(user.getAccountNo(),user.getPassword());
        Subject subject = SecurityUtils.getSubject();
//        token.setRememberMe(true);
        try {

           /* String path = request.getContextPath();
            String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
            System.out.println(basePath);*/
            subject.logout();
            subject.login(token);
            return "redirect:/indexMain?menu=findJob:1";
        } catch (LockedAccountException e) {
            m.addAttribute("result","由于你多次出现违规现象，系统已将你的账户进行冻结，请联系管理员！</br>联系电话：0731-89566256");
            return "/h5/error";
        }catch (Exception e) {
            m.addAttribute("result","登录失败："+e.getMessage());
            return "/h5/error";
        }
    }

    @RequestMapping("/h5/toLoginByID/{id}")
    public String toLoginByID(Model m ,@PathVariable String id)throws Exception{
       /* if(checkLoginAuth()){
            m.addAttribute("result","非法登录");
            return "/h5/error";
        }*/
        QueryParam queryParam = new QueryParam("id",id);
        Weixin weixin  = weChatService.one(queryParam);
        if("0dc846206be9457e9c7b335896ee940b".equals(id)){
            messageTemplateService.ptShtz(weixin.getOpenid(),"测试MQ","测试MQ内容"+UUIDGenerator.getRandomString(8));
        }
        User user = new User();
        user.setAccountNo(weixin.getOpenid());
        user.setPassword(MD5Tools.MD5(user.getAccountNo()));
        UsernamePasswordToken token = new UsernamePasswordToken(user.getAccountNo(),user.getPassword());
        Subject subject = SecurityUtils.getSubject();
//        token.setRememberMe(true);
        try {
            subject.logout();
            subject.login(token);
            return "redirect:/indexMain?menu=findJob:1";
        } catch (LockedAccountException e) {
            m.addAttribute("result","由于你多次出现违规现象，系统已将你的账户进行冻结，请联系管理员！</br>联系电话：0731-89566256");
            return "/h5/error";
        }catch (Exception e) {
            m.addAttribute("result","登录失败："+e.getMessage());
            return "/h5/error";
        }
    }


    /**
     *登录 h5  招聘者登录
     */
    @RequestMapping("/h5/toLoginAdmin")
    public String toLoginWithH51(Model m){
        User user = new User();
        user.setAccountNo("test");
        user.setPassword("123456");
        UsernamePasswordToken token = new UsernamePasswordToken(user.getAccountNo(),user.getPassword());
        Subject subject = SecurityUtils.getSubject();
//        token.setRememberMe(true);
        try {
            subject.login(token);
         /*   subject.getSession().setAttribute("user",user);
            subject.getSession().setAttribute("menus",permissionService.findUserPermissionList(roleService.findRoleIdByAccountNo(user.getAccountNo())));
            */
            return "redirect:/ijob/indexMain";
        } catch (Exception e) {
            m.addAttribute("result","登录失败："+e.getMessage());
            return "/h5/error";
        }
    }

    /**
     *登录 PC
     */
    @RequestMapping("/pc/toLogin")
    public String toLoginWithPC(User user,Model m){
        UsernamePasswordToken token = new UsernamePasswordToken(user.getAccountNo(),user.getPassword());
        Subject subject = SecurityUtils.getSubject();
//        token.setRememberMe(true);
        try {
            subject.login(token);
            subject.getSession().setAttribute("user",user);
            subject.getSession().setAttribute("menus",permissionService.findUserPermissionList(roleService.findRoleIdByAccountNo(user.getAccountNo())));
            return "redirect:/ijob/index";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("user", user);
            m.addAttribute("result","用户名或密码错误");
            return "login";
        }
    }

    /**
     *登录 PC 到时候记得删除该方法（跨域请求）
     */
    @RequestMapping(value = "/pc/toLoginAdmin",method = RequestMethod.POST)
    @ResponseBody
    public Result toLoginWithAdmin(@RequestParam Map map, HttpServletRequest request){
        ServletInputStream is;
        try {
            is = request.getInputStream();
            int nRead = 1;
            int nTotalRead = 0;
            byte[] bytes = new byte[10240];
            while (nRead > 0) {
                nRead = is.read(bytes, nTotalRead, bytes.length - nTotalRead);
                if (nRead > 0)
                    nTotalRead = nTotalRead + nRead;
            }
            String str = new String(bytes, 0, nTotalRead, "utf-8");
            System.out.println(str);//前端传递过来的值，这个值存放的位置是Request Payload 中
        }catch (Exception e){
            System.out.println(1);
        }
        System.out.println(map);
        Result result = new Result();
        User user = new User();
        user.setAccountNo("test");
        user.setPassword("123456");
        UsernamePasswordToken token = new UsernamePasswordToken(user.getAccountNo(),user.getPassword());
        Subject subject = SecurityUtils.getSubject();
//        token.setRememberMe(true);
        try {
            subject.login(token);
         /*   subject.getSession().setAttribute("user",user);
            subject.getSession().setAttribute("menus",permissionService.findUserPermissionList(roleService.findRoleIdByAccountNo(user.getAccountNo())));
            */
        } catch (Exception e) {
           // m.addAttribute("result","登录失败："+e.getMessage());
        }
        return result ;
    }


    /**
     *新增
     * @param shirouser
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(User shirouser ){
        return super.add(shirouser);
    }

    /**
     * 删除
     * @param shirouser
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(User shirouser ){
        return super.delete(shirouser);
    }

    /**
     * 修改
     * @param shirouser
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(User shirouser ){
        return super.update(shirouser);
    }

    /**
     * 查询页面
     * @param pageParam
     * @return Result
     */
    @RequestMapping(value = "/findPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findPage(@RequestBody PageParam pageParam ){
        return super.findPage(pageParam);
    }

    /**
     * 查询集合
     * @param queryParam
     * @return Result
     */
    @RequestMapping(value = "/findList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findList(@RequestBody QueryParam queryParam ){
        return super.findList(queryParam);
    }


    /**
     * 模糊查询页面
     * @param pageParam
     * @return Result
     */
    @RequestMapping(value = "/findLikePage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findLikePage(@RequestBody PageParam pageParam ){
        return super.findLikePage(pageParam);
    }


    /**
     * 查询集合，模糊查询
     * @param queryParam
     * @return Result
     */
    @RequestMapping(value = "/findLikeList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findLikeList(@RequestBody QueryParam queryParam ){
        return super.findLikeList(queryParam);
    }

    /**
     * 唯一查询
     * @param queryParam
     * @return Result
     */
    @RequestMapping(value = "/one", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result one(@RequestBody QueryParam queryParam ){
        return super.one(queryParam);
    }


    @RequestMapping("/h5/myHead")
    public String myHead(Model m){
        return "/h5/qz/mine/my_head";
    }

    @RequestMapping(value = "/h5/changeMyHead", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result changeMyHead(@RequestBody User user ){
        try {
            user.setId(IJobSecurityUtils.getLoginUserId());
            user.setWeChatNo(IJobSecurityUtils.getLoginUser().getWeChatNo());
            user.setImgPath(DictCacheService.UploadUrl+File.separator+user.getAttachment().getPath()+ File.separator+user.getAttachment().getDatestr()+ File.separator+user.getAttachment().getName());
//            Map resultMap = QcloudUtil.setIMInformation("1",user.getWeChatNo(),user.getImgPath());
//            if ((Integer)resultMap.get("ErrorCode") == 0){
                userService.persistenceAndChild(user);
                Map<String,String> userinfo =  userService.userInfo(user.getId());
                RedisUtil.hset("UserSimpleInfo",user.getId(),userinfo);
                IJobSecurityUtils.updateUser(user);
//            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return new Result();
    }

    @RequestMapping(value = "/h5/zp/getEvaluateUserInfo/{id}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getEvaluateUserInfo(@PathVariable String id){
        Result result = new Result();
        try {
            result.listData(userService.get(id));
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.put("500","参数错误！请尽快联系客服！");
        }
        return result;
    }


    @RequestMapping(value = "/h5/gl/zpList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result zpList(@RequestBody PageParam pageParam){
        Result result = new Result();
        try {
            if(StringUtils.isNotEmptyString(pageParam.getCondition().get("keyword"))  ){
                String keyword = pageParam.getCondition().get("keyword").toString();
                if(keyword.equals("求职者")){
                    pageParam.put("role",1);
                    pageParam.put("keyword",null);
                }else if(keyword.equalsIgnoreCase("招聘者")){
                    pageParam.put("role",2);
                    pageParam.put("keyword",null);
                }
            }
            userService.zpPage(pageParam);
            return super.getObject2List(pageParam);
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("查询数据异常");
        }
        return result;
    }

    @RequestMapping(value = "/h5/gl/qzList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result qzList(@RequestBody PageParam pageParam){
        Result result = new Result();
        try {
            userService.qzPage(pageParam);
            return super.getObject2List(pageParam);
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("查询数据异常");
        }
        return result;
    }

    @RequestMapping(value = "/h5/gl/changeVIP/{userID}", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result changeVIP(@PathVariable String userID){
        Result result = new Result();
        try {
            QueryParam queryParam = new QueryParam();
            queryParam.put("userID",userID);
            EnterpriseVIP enterpriseVIP = enterpriseVIPService.one(queryParam);
            if(enterpriseVIP==null){
                enterpriseVIP = new EnterpriseVIP();
                enterpriseVIP.setState(1);
                enterpriseVIP.setUserID(userID);
                enterpriseVIPService.add(enterpriseVIP);
                result.setMsg("添加VIP成功");
            }else{
                enterpriseVIPService.physicalDelete(enterpriseVIP);
                result.setMsg("移除VIP成功");
            }
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("查询数据异常");
        }
        return result;
    }

    @RequestMapping(value = "/h5/gl/changeStatus/{userID}", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result changeStatus(@PathVariable String userID){
        Result result = new Result();
        try {
            User user = userService.get(userID);
            if(user!=null){
                user.setLocked(!user.getLocked());
                userService.update(user);
                result.setMsg((user.getLocked()==Boolean.TRUE?"添加":"移除")+"黑名单成功");
            }
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("查询数据异常");
        }
        return result;
    }

    @RequestMapping(value = "/h5/gl/addAlert/{msg}/{userID}/{phone}", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result addAlert(@PathVariable String userID,@PathVariable String msg,@PathVariable String phone){
        Result result = new Result();
        try {
            User user = userService.get(userID);
            user.setUserSig(msg.trim());
            userService.update(user);
            if(org.apache.commons.lang.StringUtils.isEmpty(user.getUserSig())){
                user.setUserSig("添加");
            }else{
                try{
                    AliyunUtils.sendMessage(phone,"职位发布违规警告",user.getUserSig());
                    result.setData(user);
                }catch (Exception e){
                    result.error(e.getMessage());
                }
            }
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("查询数据异常");
        }
        return result;
    }

    @RequestMapping(value = "/h5/gl/openQzVIP", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result openQzVIP(@RequestBody PartnerUser partnerUser){
        Result result = new Result();
        QueryParam queryParam = new QueryParam("userID",partnerUser.getUserID());
        try {
            PartnerUser temp = partnerUserService.one(queryParam);
            if(temp==null){
                partnerUserService.add(partnerUser);
            }else{
                if(Integer.parseInt(temp.getPartID())<Integer.parseInt(partnerUser.getPartID())){
                    temp.setStatus(partnerUser.getStatus());
                    temp.setCode(partnerUser.getCode());
                    temp.setDeleted(false);
                    partnerUserService.update(temp);
                }else{
                    result.error("不能降低用户会员等级！");
                }
            }
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("服务器繁忙！");
        }
        return result ;
    }

}

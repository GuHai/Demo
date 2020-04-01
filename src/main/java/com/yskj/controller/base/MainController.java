package com.yskj.controller.base;

import com.google.gson.Gson;
import com.yskj.models.Account;
import com.yskj.models.Personalauthen;
import com.yskj.models.QueryParam;
import com.yskj.models.Weixin;
import com.yskj.models.auth.User;
import com.yskj.models.excel.PersonMoney;
import com.yskj.redis.ProcessAssistant;
import com.yskj.redis.RedisUtil;
import com.yskj.redis.model.TemplateTaskPanel;
import com.yskj.service.*;
import com.yskj.service.auth.UserService;
import com.yskj.service.base.DictCacheService;
import com.yskj.service.base.RedisCacheService;
import com.yskj.utils.*;
import com.yskj.utils.excel.ExcelExportUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.math.BigDecimal;
import java.util.*;

/**
 * 主要的控制层
 *
 * @author zhouchuang
 * @create 2018-01-15 15:45
 */
@Controller
@RequestMapping("")
public class MainController {
    @Autowired
    private UserService userService;
    @Autowired
    private TodayJobService todayJobService;
    @Autowired
    private SigninService signinService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private WeChatService weChatService;
    @Autowired
    private RedisCacheService redisCacheService;
    @Autowired
    private PositionService positionService;
    @Autowired
    private ChatGroupService chatGroupService;
    @Autowired
    private PersonalauthenService personalauthenService;

    /**
     * 登陆页面
     * @return
     */
    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String login(){
        return "login";
    }

    /**
     * 主页
     * @return
     */
    @RequiresPermissions("home")
    @RequestMapping(value = "/home",method = RequestMethod.GET)
    public String home(){
        return "home";
    }

    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String index(){
        return "index";
    }


    @RequestMapping(value = "/noauthc",method = RequestMethod.GET)
    public String noauthc(){
        return "noauthc";
    }

    /**
     * 注册
     * @return
     */
    @RequestMapping(value = "/signup",method = RequestMethod.GET)
    public String register(){
        return "signup";
    }


    /**
     *
     * 注销
     */
    @RequestMapping(value="/logout",method=RequestMethod.GET)
    public String logout(){
        if(SecurityUtils.getSubject().isAuthenticated()){
            SecurityUtils.getSubject().logout();
        }
        return "redirect:/loginMain";
    }


    @RequestMapping(value="/loginMain",method=RequestMethod.GET)
    public String loginMain(Model model ,HttpServletRequest request ,HttpServletResponse response,String page){

        boolean isMoblie = WeixinUtil.checkTerminal(request);
        if(isMoblie){
            boolean isWechat = WeixinUtil.checkWeChat(request);
            if(isWechat){ //去微信登录
                return "redirect:/api/WeixinController/checkOpenId";
            }else{ //进入到官网
                if("system".equals(IJobSecurityUtils.getLoginUserId())){ //如果是系统
                    response.setStatus(403);
                }
                model.addAttribute("site",DictCacheService.Site);
                return getGwPage(page);
            }
//            return "/h5/login";
        }else{
//            return "/login";
            if("system".equals(IJobSecurityUtils.getLoginUserId())){ //如果是系统
                response.setStatus(403);
            }
            model.addAttribute("site",DictCacheService.Site);
            return getGwPage(page);
        }
    }
    @RequestMapping(value="/qiuzhiyunLogin/{type}",method=RequestMethod.GET)
    public String qiuzhiyunLogin(Model model ,HttpServletRequest request ,HttpServletResponse response,String page,@PathVariable String type){
        return forwardHandler(model,request,response,page,type);
    }

    @RequestMapping(value="/xinzikaLogin/{type}",method=RequestMethod.GET)
    public String xinzika(Model model ,HttpServletRequest request ,HttpServletResponse response,String page,@PathVariable String type){
        return forwardHandler(model,request,response,page,type);
    }

    private String forwardHandler(Model model ,HttpServletRequest request ,HttpServletResponse response,String page,String type){
        boolean isMoblie = WeixinUtil.checkTerminal(request);
        if(isMoblie){
            boolean isWechat = WeixinUtil.checkWeChat(request);
            if(isWechat){ //去微信登录
//                return "redirect:/ijob/indexMain?menu="+type;
                Object openId = request.getSession().getAttribute("openId");
                if(openId!=null&&StringUtils.isNotEmpty((String)openId)){
                    return "redirect:/indexMain?menu="+type;
                }else{
                    return "forward:/api/WeixinController/checkOpenId?menu=gzh&type="+type;
                }
            }else{ //进入到官网
                if("system".equals(IJobSecurityUtils.getLoginUserId())){ //如果是系统
                    response.setStatus(403);
                }
                model.addAttribute("site",DictCacheService.Site);
                return getGwPage(page);
            }
        }else{
            if("system".equals(IJobSecurityUtils.getLoginUserId())){ //如果是系统
                response.setStatus(403);
            }
            model.addAttribute("site",DictCacheService.Site);
            return getGwPage(page);
        }
    }

    private String getGwPage(String page){

        if(StringUtils.isNotEmpty(page)){
            return "/guanwang/"+page;
        }else{
            return "/guanwang/index";
        }
    }


    @RequestMapping(value="/indexMain")
    public String indexMain(Model model , HttpServletRequest request, String menu,HttpServletResponse response){
        return WeixinUtil.indexMain(model,menu,request);
    }





    /**
     * 获取基本配置
     * @return Result
     */
    @RequestMapping(value = "/getBaseConfig", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getBaseConfig(){
        Result result = new Result();
        Map<String,String> map = new HashMap<String,String>();
        /*map.put("AppID", DictCacheService.AppID);
        map.put("AppSecret", DictCacheService.AppSecret);
        map.put("AppToken", DictCacheService.AppToken);*/
        map.put("UploadPath", DictCacheService.UploadPath);
        map.put("UploadUrl", DictCacheService.UploadUrl);
        result.setData(map);
        return result;
    }

    @RequestMapping(value="/forward",method=RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String forward(Model model,String path){
        model.addAttribute("GzhID",DictCacheService.GzhID);
        model.addAttribute("site",DictCacheService.Site);
        model.addAttribute("chatIP",DictCacheService.ChatServerIP);
        return path;
    }

    @RequestMapping(value="/pay",method=RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String pay(String path){
        return "/h5/pay";
    }


    @RequestMapping(value = "/heartbeat", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public String heart() {
       return "ok";
    }

    @RequestMapping(value = "/generalRedisCache", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result generalRedisCache() {
        Result result = new Result();
        try {
            redisCacheService.readUserInfo();
        } catch (Exception e) {
            e.printStackTrace();
            result.error(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/generalTodayJob", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result generalTodayJob(){
        Result result = new Result();
        try {
           /* accountService.chechAccount();
            accountService.generalUnTxTask();*/
//           accountService.processHistoryData();
//           positionService.noticeEverybody( positionService.one(new QueryParam()));
//            todayJobService.generalTodayJob();
           /* List<String> list = userService.findIds(new QueryParam(),"id");
            for(String str : list){
                String groupID = chatGroupService.getAndSetChat(str,false);
                Message message = new Message();
                message.setContext("a");
                message.setDate(new Date());
                message.setGroupID(groupID);
                message.setType("Text");
                message.setUserID(IJobSecurityUtils.getLoginUserId());
                RedisUtil.hset("ChatCatalog",groupID,message);

                Map<String,String>   userinfo =  userService.userInfo(str);
                try{
                    RedisUtil.hset("UserSimpleInfo",str,userinfo);
                }catch (Exception e){
                }
            }*/
            ProcessAssistant.processTasks(TemplateTaskPanel.class);
        } catch (Exception e) {
            e.printStackTrace();
            result.error(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value="/welcome",method=RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String welcome(String path){
        return "/welcome/first";
    }

    @RequestMapping(value="/follow/{id}",method=RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String follow(@PathVariable  String id){
        return "forward:/api/WeixinController/checkOpenId?menu=follow&id="+id;
    }


    @RequestMapping(value="/share/{type}/{id}",method=RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String share(@PathVariable  String type ,@PathVariable  String id ){
        return "forward:/api/WeixinController/checkOpenId?menu=share&id="+id+"&type="+type+"&userID=placeholder";
    }


    @RequestMapping(value="/share/{type}/{id}/{userID}",method=RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String share(@PathVariable  String type ,@PathVariable  String id,@PathVariable  String userID  ){
        return "forward:/api/WeixinController/checkOpenId?menu=share&id="+id+"&type="+type+"&userID="+userID;
    }

    @RequestMapping(value = "/getAuthCodeStatus/{code}", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result  getAuthCodeStatus(@PathVariable String code){
        Result result = new Result();
        Object id =  RedisUtil.getStringValue("AUTHCODE:"+code);
        if(StringUtils.isNotEmptyString(id)){  //如果里面有内容了，登录操作
           try {
               Weixin weixin  = weChatService.get(id.toString());
               User user = new User();
               user.setAccountNo(weixin.getOpenid());
               user.setPassword(MD5Tools.MD5(user.getAccountNo()));
               UsernamePasswordToken token = new UsernamePasswordToken(user.getAccountNo(),user.getPassword());
               Subject subject = SecurityUtils.getSubject();
//               token.setRememberMe(true);
               subject.logout();
               subject.login(token);
               String workNumber = IJobSecurityUtils.getLoginUser().getInformation().getWorkNumber();
               IJobSecurityUtils.getLoginUser().setWorkNumber(StringUtils.isNotEmptyString(workNumber)?workNumber:"");
               result.setData(IJobSecurityUtils.getLoginUser());
           } catch (LockedAccountException e) {
               result.error("由于你多次出现违规现象，系统已将你的账户进行冻结，请联系管理员！</br>联系电话：0731-89566256");
           }catch (Exception e) {
               result.error("登录失败："+e.getMessage());
           }
       }else{
            result.error("");
        }
       return result;
    }

    @RequestMapping(value = "/authorizedLogin/{code}", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result authorizedLogin(@PathVariable String code){
        Result result = new Result();
        try{
            RedisUtil.setStringValue("AUTHCODE:"+code,IJobSecurityUtils.getLoginUser().getWeixin().getId(),60L);  //设置微信ID
        }catch (Exception e){
            result.error(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/importAccount", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result importAccount()throws Exception{
        Result result = new Result();
        try{
            QueryParam queryParam = new QueryParam();
            queryParam.put("userID","a0ee3d1d00a94110a9da7741948036c9");
            queryParam.put("type","29");
            queryParam.setOrderByClause(" and DATE_FORMAT(a.createTime,'%y-%m') = '19-04' ");
            List<Account> list   = accountService.findList(queryParam);
            List<PersonMoney> personalauthens = new ArrayList<>();
            total  = BigDecimal.ZERO;
            for(Account account : list){
                getPerson(account,personalauthens);
            }
            String path =  DictCacheService.UploadPath + File.separator + "8w"  ;
            String datestr = "2019-04";
            ExcelExportUtil.general(path,personalauthens,datestr+"工资发放");
            System.out.println(sets);
            System.out.println(total);
        }catch (Exception e){
            result.error(e.getMessage());
        }
        return result;
    }

    private  Set sets  = new HashSet();
    private  BigDecimal total = BigDecimal.ZERO;
    private void getPerson(Account account,List<PersonMoney> personalauthens ){
        String accid = account.getAccID();
        HashMap<String, Object> map = new Gson().fromJson(accid, HashMap.class);
        if(map!=null){
            synchronized (map){
                for(String k:map.keySet()){
                    BigDecimal v = new BigDecimal(map.get(k).toString());
                    total = total.add(v);
                    try {
                        Account account1 = accountService.get(k);
                        sets.add(account1.getType());
                        if(account1.getType()==19 ){
                            QueryParam queryParam = new QueryParam();
                            queryParam.put("isIn",Boolean.TRUE);
                            queryParam.put("orderNo",account1.getOrderNo());
                            Account account2 = accountService.one(queryParam);
                            getPerson(account2,personalauthens);
//                            Personalauthen personalauthen =  personalauthenService.one(new QueryParam("userID",account2.getUserID()));
//                            PersonMoney personMoney = new PersonMoney();
//                            personMoney.setDate(account2.getCreateTime());
//                            personMoney.setIdCard(personalauthen.getPersonIDCard());
//                            personMoney.setName(personalauthen.getRealName());
//                            personMoney.setOrder(account2.getOrderNo());
//                            personMoney.setMoney(account2.getMoney());
//                            personMoney.setRealMoney(v);
//                            personMoney.setOut("转账给别人"+v);
//                            personalauthens.add(personMoney);
                        }else if( account1.getType()==18){
                            Personalauthen personalauthen =  personalauthenService.one(new QueryParam("userID",account1.getUserID()));
                            PersonMoney personMoney = new PersonMoney();
                            personMoney.setDate(account1.getCreateTime());
                            personMoney.setIdCard(personalauthen.getPersonIDCard());
                            personMoney.setName(personalauthen.getRealName());
                            personMoney.setOrder(account1.getOrderNo());
                            personMoney.setMoney(account1.getMoney());
                            personMoney.setRealMoney(v);
                            personMoney.setPhoneNo(personalauthen.getPersonPhoneNumber());
                            personMoney.setOut("结算给自己"+v.subtract(account1.getMoney()));
                            personalauthens.add(personMoney);
                        }else if(account1.getType()==16){
                            QueryParam queryParam = new QueryParam();
                            queryParam.put("type",14);
                            queryParam.put("orderNo",account1.getOrderNo());
                            List<Account> accountlist = accountService.findList(queryParam);
                            for(Account account3 : accountlist){
                                Personalauthen personalauthen =  personalauthenService.one(new QueryParam("userID",account3.getUserID()));
                                PersonMoney personMoney = new PersonMoney();
                                personMoney.setDate(account3.getCreateTime());
                                personMoney.setIdCard(personalauthen.getPersonIDCard());
                                personMoney.setName(personalauthen.getRealName());
                                personMoney.setOrder(account3.getOrderNo());
                                personMoney.setPhoneNo(personalauthen.getPersonPhoneNumber());
                                if(v.compareTo(account3.getMoney())>=0){
                                    personMoney.setRealMoney(account3.getMoney());
                                }else if(v.compareTo(BigDecimal.ZERO)>0) {
                                    personMoney.setRealMoney(v);
                                }else{
                                    personMoney.setRealMoney(BigDecimal.ZERO);
                                }
                                personMoney.setMoney(account3.getMoney());
                                v = v.subtract(account3.getMoney());
                                personMoney.setOut("工资收入"+v);
                                personalauthens.add(personMoney);
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                };
            }
        }
    }
}

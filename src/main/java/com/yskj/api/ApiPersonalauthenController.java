package com.yskj.api;import com.yskj.controller.base.BaseController;import com.yskj.exception.IJobException;import com.yskj.models.*;import com.yskj.models.auth.User;import com.yskj.models.enums.Examine;import com.yskj.redis.RedisUtil;import com.yskj.service.*;import com.yskj.service.auth.UserService;import com.yskj.utils.*;import org.apache.shiro.authz.annotation.RequiresPermissions;import org.slf4j.Logger;import org.slf4j.LoggerFactory;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Controller;import org.springframework.ui.Model;import org.springframework.web.bind.annotation.RequestBody;import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.RequestMethod;import org.springframework.web.bind.annotation.ResponseBody;import java.util.HashMap;import java.util.Map;@Controller@RequestMapping(value = "/api/PersonalauthenController")public class ApiPersonalauthenController extends BaseController{    @Autowired    private UserService userService;    @Autowired    private MessageTemplateService messageTemplateService;    @Autowired    private TxAdminService txAdminService;	@Autowired	private PersonalauthenService personalauthenService;	@Autowired    private BrokerService brokerService ;	private final static Logger logger = LoggerFactory.getLogger(ApiPersonalauthenController.class);	 public PersonalauthenService getService() {         return this.personalauthenService;     }	 /**     * 页面     * @return String     */    @RequiresPermissions("Personalauthen")    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})    public String index(Model model){        return "personalauthen";    }     /**     *新增     * @param personalauthen     * @return Result     */    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    public String add(@RequestBody  Personalauthen personalauthen ){        try{            personalauthen.setUserID(IJobSecurityUtils.getLoginUserId());            personalauthen.setPersonIDCardBackTreatment(personalauthen.getPersonIDCardBackOriginal());            personalauthen.setPersonIDCardJustTreatment(personalauthen.getPersonIDCardJustOriginal());            super.add(personalauthen);        }catch (Exception e){            logger.error(e.getMessage());        }         return "h5/mine/mine";    }    /**     * 删除     * @param personalauthen     * @return Result     */    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result delete(Personalauthen personalauthen ){        return super.delete(personalauthen);    }     /**     * 修改     * @param personalauthen     * @return Result     */    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result update(@RequestBody  Personalauthen personalauthen ){        return super.update(personalauthen);    }    /**     * 修改     * @param personalauthen     * @return Result     */    @RequestMapping(value = "/updatePersonAndCert", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result updatePersonAndCert(@RequestBody  Personalauthen personalauthen ){        Result result = new Result();        try{            personalauthen.setUserID(IJobSecurityUtils.getLoginUserId());            String sessionCode = (String)IJobSecurityUtils.getSession().getAttribute("code");            if(sessionCode.equals(personalauthen.getCode()) && personalauthen.getCode() != null){                User user=IJobSecurityUtils.getLoginUser();                if(user!=null || !"".equals(user)){                    //校验电话号码是否已经使用过了                    if(personalauthenService.isValidNumber(personalauthen.getPersonPhoneNumber())){                        user.setRealName(personalauthen.getRealName());                        user.setPhoneNumber(personalauthen.getPersonPhoneNumber());                        user.setIDCard(personalauthen.getPersonIDCard());                        String IDNo = personalauthen.getPersonIDCard();                        String date = IDNo.substring(6,10)+"-"+IDNo.substring(10,12)+"-"+IDNo.substring(12,14);                        user.setBirthday(DateUtils.getDateFromString( date));                        userService.update(user);                        IJobSecurityUtils.updateUser(user);                        personalauthenService.generalPersonalAndResume(personalauthen);                        personalauthen.setStatus(0);//待审核                        result = persistenceAndChild(personalauthen);                        QueryParam queryParam = new QueryParam();                        TxAdmin txAdmin = txAdminService.one(queryParam);                        if(personalauthen.getSendBrokerInfo()!=null){                            txAdmin = txAdminService.one(new QueryParam("id","2"));                        }                        //推送给管理员                        User userAdmin  = userService.get(txAdmin.getUserID());                        WorkList workList = new WorkList();                        workList.updateType(Examine.IDCard);                        workList.setStatus(1);                        workList.setAuditor(txAdmin.getUserID());                        workList.setCallback("/api/InformationController/approvalCallback");                        workList.setRefID(personalauthen.getId());                        workList.setUrl("/h5/qz/mine/realName_check?data.smrz.userID="+user.getId());                        messageTemplateService.ptGdxx(userAdmin.getWeChatNo(),workList);                        if(personalauthen.getSendBrokerInfo()!=null){                            //自动推送经纪人审核。                            Broker broker = brokerService.one(new QueryParam("createBy",IJobSecurityUtils.getLoginUserId()));                            if(broker == null){                                broker = new Broker();                                broker.setName(personalauthen.getRealName());                                broker.setLevel(1);                                broker.setCode(SignUtils.getRandomStringByLength(16));                                broker.setStatus(1);                                brokerService.add(broker);                            }else{                                broker.setName(personalauthen.getRealName());                                broker.setLevel(1);                                broker.setCode(SignUtils.getRandomStringByLength(16));                                broker.setStatus(1);                                brokerService.update(broker);                            }                            //推送                            workList = new WorkList();                            workList.updateType(Examine.Broker);                            workList.setStatus(1);                            workList.setCallback("/api/FullTimeController/brokerCallback");                            workList.setRefID(broker.getId());                            workList.setUrl("/h5/qz/mine/broker_check?data.smrz.userID="+IJobSecurityUtils.getLoginUserId());                            messageTemplateService.tpBrokerGdxx2(workList);                        }                    }else{                        result.put("408","手机号码已经存在！");                        return result;                    }                }            }else{                throw new Exception();            }        }catch (IJobException e){            logger.error(e.getMessage());            result.put("408",e.getMessage());            return result;        }catch (Exception e){            logger.error(e.getMessage());            result.put("408","验证码错误！");            return result;        }        return result;    }    /**     * 查询页面     * @param pageParam     * @return Result     */    @RequestMapping(value = "/findPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findPage(@RequestBody PageParam pageParam ){       return super.findPage(pageParam);    }     /**     * 查询集合     * @param queryParam     * @return Result     */    @RequestMapping(value = "/findList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findList(@RequestBody QueryParam queryParam ){        return super.findList(queryParam);    }    /**    * 模糊查询页面    * @param pageParam    * @return Result    */    @RequestMapping(value = "/findLikePage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findLikePage(@RequestBody PageParam pageParam ){         return super.findLikePage(pageParam);    }    /**     * 查询集合，模糊查询     * @param queryParam     * @return Result     */    @RequestMapping(value = "/findLikeList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findLikeList(@RequestBody QueryParam queryParam ){        return super.findLikeList(queryParam);    }     /**     * 唯一查询     * @param queryParam     * @return Result     */    @RequestMapping(value = "/one", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result one(@RequestBody QueryParam queryParam ){        queryParam.put("userID",IJobSecurityUtils.getLoginUserId());        return super.one(queryParam);    }    /**     * 唯一查询通过ID     * @param id     * @return Result     */    @RequestMapping(value = "/get", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result get(String id ){        return super.get(id);    }    /**     * 更新个人信息     * @return     */    @RequestMapping(value = "/qz/addPersonalauthen",method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result addPersonalauthen(@RequestBody Personalauthen personalauthen) {        Result result = new Result();        String sessionCode = (String)IJobSecurityUtils.getSession().getAttribute("code");        String phoneNo = (String)IJobSecurityUtils.getSession().getAttribute("phoneNo");        if(StringUtils.isNotEmptyString(personalauthen.getCode())){//判断是不是正确的，            if( !personalauthen.getCode().equals(sessionCode) ) {                result.error("验证码错误");                return result;            }        }        if(StringUtils.isNotEmptyString(personalauthen.getPersonPhoneNumber())){//判断是不是正确的，            if( !personalauthen.getPersonPhoneNumber().equals(phoneNo) ) {                result.error("手机号码不一致");                return result;            }        }        try {            personalauthenService.generalPersonalAndResume(personalauthen);            if(StringUtils.isNotEmpty(personalauthen.getPersonIDCard())){                result.setCode("403");            }        } catch (IJobException e){            e.printStackTrace();            result.error(e.getMessage());            return result;        }catch (Exception e) {            e.printStackTrace();            result.error("保存身份证信息失败");            return result;        }        result.setMsg("信息完善成功，页面跳转");        return result;    }    /**     * 更新个人信息     * @return     */    @RequestMapping(value = "/qz/getPersonalauthen",method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result getPersonalauthen() {        Result result = new Result();        try {            Personalauthen personalauthen = personalauthenService.checkPersonalauthen();            if(personalauthen.getIsVerified()==Boolean.TRUE){  //如果已经验证了 则不需要验证了，跳转到下一个页面                result.listData(personalauthen);                result.error("信息已经完善，页面跳转");            }else{ //如果没有验证，跳转到验证页面                if(personalauthen!=null && personalauthen.getStatus()!=null){                    if(personalauthen.getStatus()==0){                        result.error("实名认证还在审核中，请等待审核结果");                    }else{                        result.error("实名认证未通过，请重新提交实名认证");                    }                }                result.listData(personalauthen);            }        } catch (Exception e) {            e.printStackTrace();        }        return result;    }    @RequestMapping(value = "/qz/checkFinalVerification",method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result checkFinalVerification() {        Result result = new Result();        try {            Personalauthen personalauthen = personalauthenService.checkPersonalauthen();            if(personalauthen.getId()==null){                result.error("请完善个人信息");                return result ;            }            if(personalauthen.getStatus()==1){  //如果已经验证了 则不需要验证了，跳转到下一个页面                if(StringUtils.isEmpty(personalauthen.getPersonIDCard())){                    result.error("请完善身份证信息");                }            }else{ //如果没有验证，跳转到验证页面                result.error("请完善个人信息");            }        } catch (Exception e) {            e.printStackTrace();        }        return result;    }    @RequestMapping(value = "/getPersonInfo",method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result getPersonInfo() {        Result result = new Result();        try {            result.setMsg("已实名");            Personalauthen personalauthen = personalauthenService.checkPersonalauthen();            if(personalauthen.getId()==null){                result.setMsg("未实名");            }            if(personalauthen.getStatus()==null){                result.error("实名未通过");            }else{                if(personalauthen.getStatus()==1){  //如果已经验证了 则不需要验证了，跳转到下一个页面                    if(StringUtils.isEmpty(personalauthen.getPersonIDCard())){                        result.error("未填写身份证");                    }                }else if(personalauthen.getStatus()==0){ //如果没有验证，跳转到验证页面                    result.error("实名审核中");                }else{                    result.error("实名未通过");                }            }            Map u =  RedisUtil.hget("UserSimpleInfo",IJobSecurityUtils.getLoginUserId());            if(u==null){                Weixin weixin = IJobSecurityUtils.getLoginUser().getWeixin();                u = new HashMap();                u.put("realName",weixin.getNickname());                u.put("userimg",null);                u.put("weixinimg",weixin.getHeadimgurl());                System.out.println();            }            result.setData(u);        } catch (Exception e) {            e.printStackTrace();        }        return result;    }}
package com.yskj.api;import com.yskj.controller.base.BaseController;import com.yskj.exception.IJobException;import com.yskj.models.*;import com.yskj.service.*;import com.yskj.service.base.DictCacheService;import com.yskj.utils.IJobSecurityUtils;import com.yskj.utils.Result;import com.yskj.utils.StringUtils;import org.apache.shiro.authz.annotation.RequiresPermissions;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Controller;import org.springframework.ui.Model;import org.springframework.web.bind.annotation.*;import org.slf4j.Logger;import org.slf4j.LoggerFactory;import java.util.List;@Controller@RequestMapping(value = "/api/PartnerController")public class ApiPartnerController extends BaseController{	@Autowired	private PartnerService partnerService;    @Autowired    private WxorderService wxorderService;    @Autowired    private WeChatService weChatService;    @Autowired    private PartnerUserService partnerUserService;    @Autowired    private PartnerGzhService partnerGzhService;    @Autowired    private PersonalauthenService personalauthenService;    @Autowired    private PartnerRebateService partnerRebateService;	private final static Logger logger = LoggerFactory.getLogger(ApiPartnerController.class);	 public PartnerService getService() {         return this.partnerService;     }	 /**     * 页面     * @return String     */    @RequiresPermissions("Partner")    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})    public String index(Model model){        return "partner";    }    @RequestMapping(value = "/partnerPlan",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})    public String partnerPlan(Model model,String openID){        try {            QueryParam queryParam = new QueryParam();            //查询当前分享信息，分享码，分享人            if(StringUtils.isNotEmpty(openID)){                queryParam.put("openID",openID);                PartnerGzh partnerGzh =  partnerGzhService.pumapOne(queryParam);                model.addAttribute("code",(partnerGzh.getPartnerUser()!=null?partnerGzh.getPartnerUser().getCode():""));                model.addAttribute("name",(partnerGzh.getPartnerUser()!=null?partnerGzh.getPartnerUser().getUser().getMainName():""));                model.addAttribute("headimg",(partnerGzh.getPartnerUser()!=null?partnerGzh.getPartnerUser().getUser().getImgPath():""));            }            //查询当前人的合伙人信息            queryParam.clear();            queryParam.put("userID", IJobSecurityUtils.getLoginUserId());            queryParam.put("status",Boolean.TRUE);            PartnerUser existPu = partnerUserService.one(queryParam);            model.addAttribute("partner",existPu);        } catch (Exception e) {            e.printStackTrace();        }        model.addAttribute("site", DictCacheService.Site);        return "h5/qz/mine/partnerPlan";    }     /**     *新增     * @param partnerUser     * @return Result     */    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result add(@RequestBody PartnerUser partnerUser ){        Result result = new Result();        QueryParam queryParam = new QueryParam();        queryParam.put("userID", IJobSecurityUtils.getLoginUserId());        try {            PartnerUser existPu = partnerUserService.one(queryParam);            if(existPu!=null){                /*existPu.setStatus(Boolean.FALSE);                existPu.setPartID(partnerUser.getPartID());*/                partnerUser.setId(existPu.getId());                partnerUser.setVersion(existPu.getVersion());                partnerUser.setPartID(existPu.getPartID());                partnerUser.setStatus(existPu.getStatus());            }else{                partnerUser.setUserID(IJobSecurityUtils.getLoginUserId());                partnerUser.setStatus(Boolean.FALSE);//                partnerUser.setCode(partnerUserService.generalCode());                Personalauthen personalauthen = personalauthenService.one(queryParam);                if(personalauthen==null){                    result.error("请先进行个人实名认证");                    result.setCode("403");                    return result;                }else{                    partnerUser.setCode(personalauthen.getPersonPhoneNumber());                }            }            //分享ID只保存第一次分享的那个银，以后升级的不需要更改shareID 如果为空则 肯定是第一次，如果partID是空，也肯定是第一次            if(StringUtils.isNotEmpty(partnerUser.getTempCode()) && (existPu==null || StringUtils.isEmpty(existPu.getShareID()))){                queryParam.clear();                queryParam.put("code",partnerUser.getTempCode());                queryParam.put("status",Boolean.TRUE);                PartnerUser frompu = partnerUserService.one(queryParam);                if(frompu!=null){                    partnerUser.setShareID(frompu.getId());                }else{                    result.error("你填写的邀请码错误，或者不是合伙人");                    return result;                }            }            partnerUserService.persistence(partnerUser);            partnerUser.setPartner(partnerService.get(partnerUser.getUpgradePartID()));        } catch (Exception e) {            e.printStackTrace();        }        result.setData(partnerUser);        return result;    }    @RequestMapping(value = "/getNameByPhoneNo/{phoneno}", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result getNameByPhoneNo(@PathVariable String phoneno){        Result result = new Result();        QueryParam queryParam = new QueryParam();        queryParam.put("personPhoneNumber",phoneno);        try {            Personalauthen personalauthen = personalauthenService.one(queryParam);            result.setData(personalauthen);        } catch (Exception e) {            e.printStackTrace();        }        return result;    }    @RequestMapping(value = "/getReward", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result getReward(){        Result result = new Result();        QueryParam queryParam = new QueryParam();        queryParam.put("userID",IJobSecurityUtils.getLoginUserId());        try {            PartnerRebate partnerRebate  = partnerRebateService.partnerInfo(queryParam);            result =  super.getObject2List(partnerRebate);        } catch (Exception e) {            e.printStackTrace();            result.error("获取数据失败");        }        return result;    }    @RequestMapping(value = "/rewardList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result rewardList(@RequestBody  QueryParam queryParam ){        Result result = new Result();        queryParam.put("userID",IJobSecurityUtils.getLoginUserId());        try {            List<PartnerRebate> partnerRebateList =  partnerRebateService.findList(queryParam);            result =  super.getObject2List(partnerRebateList);        } catch (Exception e) {            e.printStackTrace();            result.error("获取数据失败");        }        return result;    }    @RequestMapping(value = "/checkExist", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result checkExist(){        Result result = new Result();        QueryParam queryParam = new QueryParam();        queryParam.put("userID", IJobSecurityUtils.getLoginUserId());        try {            PartnerUser existPu = partnerUserService.one(queryParam);            result.setData(existPu);        } catch (Exception e) {            e.printStackTrace();        }        return result;    }    /**     * 删除     * @param partner     * @return Result     */    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result delete(Partner partner ){        return super.delete(partner);    }     /**     * 修改     * @param partner     * @return Result     */    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result update(Partner partner ){        return super.update(partner);    }    /**     * 查询页面     * @param pageParam     * @return Result     */    @RequestMapping(value = "/findPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findPage(@RequestBody PageParam pageParam ){       return super.findPage(pageParam);    }     /**     * 查询集合     * @param queryParam     * @return Result     */    @RequestMapping(value = "/findList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findList(@RequestBody QueryParam queryParam ){        return super.findList(queryParam);    }    /**    * 模糊查询页面    * @param pageParam    * @return Result    */    @RequestMapping(value = "/findLikePage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findLikePage(@RequestBody PageParam pageParam ){         return super.findLikePage(pageParam);    }    /**     * 查询集合，模糊查询     * @param queryParam     * @return Result     */    @RequestMapping(value = "/findLikeList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findLikeList(@RequestBody QueryParam queryParam ){        return super.findLikeList(queryParam);    }     /**     * 唯一查询     * @param queryParam     * @return Result     */    @RequestMapping(value = "/one", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result one(@RequestBody QueryParam queryParam ){        return super.one(queryParam);    }    /**     * 唯一查询通过ID     * @param id     * @return Result     */    @RequestMapping(value = "/get", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result get(String id ){        return super.get(id);    }    @RequestMapping(value = "/partnerCallback/{wxorderID}", method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})    public String partnerCallback(Model model,@PathVariable String wxorderID ){        Wxorder wxorder = null;        try {            wxorder = wxorderService.get(wxorderID);        } catch (Exception e) {            e.printStackTrace();        }        if(wxorder!=null) {            PartnerUser partnerUser =  null;            if (wxorder.getStatus() == 3) {                try {                    partnerUser =  partnerService.partnerCallback(wxorder);                } catch (Exception e) {                    e.printStackTrace();                    try {                        weChatService.refundOrder(wxorderID);                    } catch (IJobException e2) {                        e2.printStackTrace();                        model.addAttribute("msg",e2.getMessage()+"，余额退回到微信");                    } catch (Exception e1) {                        e1.printStackTrace();                        model.addAttribute("msg","回调异常，余额退回到微信");                    }                    return "/authc/error";                }                Partner partner  = partnerUser.getPartner();                if(partner.getLevel()==1){                    partner.setImg("gold");                }else if(partner.getLevel()==2){                    partner.setImg("platinum");                }else if(partner.getLevel()==3){                    partner.setImg("diamonds");                }                model.addAttribute("partner",partner);                model.addAttribute("code",partnerUser.getCode());            } else if(wxorder.getStatus()==4){                try {                    partnerUser =  partnerUserService.get(wxorder.getRefID());                    Partner partner  = partnerService.get(partnerUser.getPartID());                    model.addAttribute("partner",partner);                    model.addAttribute("code",partnerUser.getCode());                } catch (Exception e) {                    e.printStackTrace();                }            } else {                model.addAttribute("msg","请缴纳合伙人会员费");                return "/h5/qz/mine/goldMember";            }        }else{            model.addAttribute("msg","请缴纳合伙人会员费");            return "/authc/error";        }        model.addAttribute("site", DictCacheService.Site);        return "/h5/qz/mine/goldMember";    }}
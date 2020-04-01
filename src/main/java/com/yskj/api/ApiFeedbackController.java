package com.yskj.api;


import com.yskj.controller.base.BaseController;
import com.yskj.models.*;
import com.yskj.models.auth.User;
import com.yskj.models.enums.Examine;
import com.yskj.service.FeedbackService;
import com.yskj.service.MessageTemplateService;
import com.yskj.service.PersonalauthenService;
import com.yskj.service.auth.UserService;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.Result;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping(value = "/api/FeedbackController")
public class ApiFeedbackController extends BaseController{

	@Autowired
	private FeedbackService feedbackService;
	@Autowired
    private MessageTemplateService messageTemplateService;
	@Autowired
    private PersonalauthenService personalauthenService ;
	@Autowired
    private UserService userService;

	private final static Logger logger = LoggerFactory.getLogger(ApiFeedbackController.class);

	 public FeedbackService getService() {
         return this.feedbackService;
     }

	 /**
     * 页面
     * @return String
     */
    @RequiresPermissions("Feedback")
    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String index(Model model){
        return "feedback";
    }

     /**
     *新增
     * @param feedback
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(Feedback feedback ){
         return super.add(feedback);
    }

    /**
     * 删除
     * @param feedback
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(Feedback feedback ){
        return super.delete(feedback);
    }

     /**
     * 修改
     * @param feedback
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(Feedback feedback ){
        return super.update(feedback);
    }

    /**
     * 查询页面
     * @param pageParam
     * @return Result
     */
    @RequestMapping(value = "/findPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findPage(@RequestBody PageParam pageParam ){
        Result result = new Result();
        try {
            pageParam.put("createBy",IJobSecurityUtils.getLoginUserId());
            pageParam.setOrderByClause("order by f.updateTime desc");
            return super.getObject2List(feedbackService.findPage(pageParam));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙");
        }
        return result ;
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

    /**
     * 唯一查询通过ID
     * @param id
     * @return Result
     */
    @RequestMapping(value = "/get/{id}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result get(@PathVariable  String id ){
        Result result = new Result();
        try{
            QueryParam queryParam = new QueryParam();
            queryParam.put("id",id);
            Feedback feedback  = feedbackService.mapOne(queryParam);
            result =  super.getObject2List(feedback);
        }catch (Exception e){
            e.printStackTrace();
            result.error("查询失败");
        }
        return result;
    }


    /**
     * 用户进行反馈建议。
     * @param feedback
     * @return
     */
    @RequestMapping(value = "/feedFackInfo", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result feedFackInfo(@RequestBody Feedback feedback){
        Result result = new Result();
        try {
            feedback.setUserID(IJobSecurityUtils.getLoginUserId());
            if(feedback.getType()==1||feedback.getType()==2||feedback.getType()==3){
                Personalauthen personalauthen = personalauthenService.one(new QueryParam("userID",IJobSecurityUtils.getLoginUserId()));
                if(personalauthen!=null){
                    feedback.setTel(personalauthen.getPersonPhoneNumber());
                }
            }
            feedbackService.persistenceAndChild(feedback);
            WorkList workList = new WorkList();
            workList.updateType(Examine.Feedback);
            workList.setStatus(1);
            workList.setCallback("/api/FeedbackController/feedbackCallback");
            workList.setRefID(feedback.getId());
            workList.setUrl("/h5/zp/report_details?data.feedbackID="+feedback.getId());
            messageTemplateService.tpGdxx2(workList);

        }catch (Exception e){
            logger.error(e.getMessage());
            result.put("500","服务器繁忙，请稍后再试");
        }
        return result ;
    }


    @RequestMapping(value = "/feedbackCallback", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result feedFackInfo(@RequestBody WorkList workList){
        Feedback feedback = null;
        try {
            feedback = feedbackService.get(workList.getRefID());
            if(feedback!=null){
                User user = userService.get(feedback.getUserID());
                if(user!=null){
                    messageTemplateService.ptShtz(user.getWeChatNo(),"反馈信息",workList.getMsg());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @RequestMapping(value = "/getHistoryFeedBackDetail/{id}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getHistoryFeedBackDetail(@PathVariable String id){
        Result result = new Result();
        try {
            Feedback feedback = feedbackService.getHistoryFeedBackDetail(id);
            if(feedback.getUserID().equals(IJobSecurityUtils.getLoginUserId())){
                feedback.setContactNumber(null);
                feedback.setContacts(null);
                feedback.setMainName(null);
                feedback.setTel(null);
            }
            result.listData(feedback);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙");
        }
        return result ;
    }
}

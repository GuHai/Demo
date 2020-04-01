package com.yskj.api;import com.yskj.controller.base.BaseController;import com.yskj.models.*;import com.yskj.service.InterviewService;import com.yskj.service.LocaltioninfoService;import com.yskj.utils.IJobSecurityUtils;import com.yskj.utils.Result;import org.apache.shiro.authz.annotation.RequiresPermissions;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Controller;import org.springframework.ui.Model;import org.springframework.web.bind.annotation.RequestBody;import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.RequestMethod;import org.springframework.web.bind.annotation.ResponseBody;import org.slf4j.Logger;import org.slf4j.LoggerFactory;@Controller@RequestMapping(value = "/api/InterviewController")public class ApiInterviewController extends BaseController{	@Autowired	private InterviewService interviewService;	@Autowired    private LocaltioninfoService localtioninfoService;	private final static Logger logger = LoggerFactory.getLogger(ApiInterviewController.class);	 public InterviewService getService() {         return this.interviewService;     }	 /**     * 页面     * @return String     */    @RequiresPermissions("Interview")    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})    public String index(Model model){        return "interview";    }     /**     *新增     * @param interview     * @return Result     */    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result add(@RequestBody Interview interview ){        QueryParam queryParam = new QueryParam();        queryParam.put("positionID",interview.getPositionID());        try {            Interview interview1 = interviewService.one(queryParam);            if(interview1!=null){                String addrID =  interview1.getInterviewAddress();                Localtioninfo localtioninfo = localtioninfoService.get(addrID);                localtioninfoService.delete(localtioninfo);                interviewService.delete(interview1);            }        } catch (Exception e) {            e.printStackTrace();        }        Position position = (Position) IJobSecurityUtils.getSession().getAttribute("Position");        Result result = super.persistenceAndChild(interview);        //培训或面试 1 面试 2 培训        if(interview.getIsCultivate()==1){            position.setInterview(interview.getId());        }else{            position.setTrain(interview.getId());        }        return result;    }    /**     * 删除     * @param interview     * @return Result     */    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result delete(Interview interview ){        return super.delete(interview);    }     /**     * 修改     * @param interview     * @return Result     */    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result update(Interview interview ){        return super.update(interview);    }    /**     * 查询页面     * @param pageParam     * @return Result     */    @RequestMapping(value = "/findPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findPage(@RequestBody PageParam pageParam ){       return super.findPage(pageParam);    }     /**     * 查询集合     * @param queryParam     * @return Result     */    @RequestMapping(value = "/findList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findList(@RequestBody QueryParam queryParam ){        return super.findList(queryParam);    }    /**    * 模糊查询页面    * @param pageParam    * @return Result    */    @RequestMapping(value = "/findLikePage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findLikePage(@RequestBody PageParam pageParam ){         return super.findLikePage(pageParam);    }    /**     * 查询集合，模糊查询     * @param queryParam     * @return Result     */    @RequestMapping(value = "/findLikeList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findLikeList(@RequestBody QueryParam queryParam ){        return super.findLikeList(queryParam);    }     /**     * 唯一查询     * @param queryParam     * @return Result     */    @RequestMapping(value = "/one", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result one(@RequestBody QueryParam queryParam ){        return super.one(queryParam);    }    /**     * 唯一查询通过ID     * @param id     * @return Result     */    @RequestMapping(value = "/get", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result get(String id ){        return super.get(id);    }}
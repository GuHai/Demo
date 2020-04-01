package com.yskj.api;

import com.sun.mail.util.QEncoderStream;
import com.yskj.aop.SearchRecode;
import com.yskj.controller.base.BaseController;
import com.yskj.exception.IJobException;
import com.yskj.models.*;
import com.yskj.models.auth.User;
import com.yskj.models.enums.PostType;
import com.yskj.service.*;
import com.yskj.service.auth.UserService;
import com.yskj.utils.*;
import javafx.geometry.Pos;
import org.jsoup.helper.DataUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Array;
import java.util.*;

@Controller
@RequestMapping(value = "/api/FullTimeController")
public class ApiFullTimeController extends BaseController {

    @Autowired
    private PostService postService;
    @Autowired
    private PostLabelService postLabelService ;
    @Autowired
    private CompanyService companyService ;
    @Autowired
    private LocaltioninfoService localtioninfoService;
    @Autowired
    private PostRecommendBrokerService postRecommendBrokerService ;
    @Autowired
    private BrokerService brokerService ;
    @Autowired
    private PostForBrokerService postForBrokerService ;
    @Autowired
    private RecommendService recommendService ;
    @Autowired
    private PersonalauthenService personalauthenService ;
    @Autowired
    private ResumeService resumeService ;
    @Autowired
    private UserService userService ;
    @Autowired
    private AttachmentService attachmentService ;
    @Autowired
    private WeChatService weChatService ;


    private final static Logger logger = LoggerFactory.getLogger(ApiForwardShareUserBeenrecruitedController.class);
    public PostService getService() {
        return this.postService;
    }

    @RequestMapping(value = "/getPostType", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getPostType(){
        Result result = new Result();
        try {
            Class<PostType> classz = PostType.class ;
            result.listData(PostType.EnumToMap(classz));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙");
        }
        return result ;
    }

    @RequestMapping(value = "/getPostLabel", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getPostLabel(){
        Result result = new Result();
        QueryParam queryParam = new QueryParam();
        List<String> ids = new ArrayList<>();
        ids.add(IJobSecurityUtils.getLoginUserId());
        ids.add("system");
        queryParam.in("createBy",ids);
        try {
            result.listData(postLabelService.findList(queryParam));
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("服务器繁忙！");
        }
        return result ;
    }


    @RequestMapping(value = "/addPostLabel", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public synchronized Result addPostLabel(@RequestBody PostLabel postLabel){
        Result result = new Result();
        QueryParam queryParam = new QueryParam();
        try {
            queryParam.put("name",postLabel.getName());
            queryParam.put("type",postLabel.getType());
            PostLabel postLabel1 = postLabelService.one(queryParam);
            if(postLabel1!= null){
                postLabel = postLabel1 ;
            }else{
                String code = IJobUtils.toHanyuPinyinFirstChar(postLabel.getName());
                code = code.toUpperCase();
                if(code.length() > 4){
                    code = code.substring(0,4);
                }else if(code.length() < 4){
                    code = (code + code).substring(0,4);
                }
                queryParam.clear();
                queryParam.put("code",code);
                postLabel1 = postLabelService.one(queryParam);
                if(postLabel1==null){
                    postLabel.setCode(code);
                    postLabelService.add(postLabel);
                }else{
                    List<PostLabel> postLabels = postLabelService.findLikeList(queryParam);
                    code += postLabels.size();
                    postLabel.setCode(code);
                    postLabelService.add(postLabel);
                }
            }
            result.listData(postLabel);
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("服务器繁忙！");
        }
        return result ;
    }

    @RequestMapping(value = "/findLikeCompanyList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findLikeCompanyList(@RequestBody QueryParam queryParam ){
        Result result = new Result();
        try {
            List<Company> companyList = companyService.findLikeList(queryParam);
            if(companyList == null || companyList.size() == 0 ){
                Company company = new Company();
                company.setCompany("<span>"+queryParam.getCondition().get("company").toString()+"</span>");
                company.setId("0");
                companyList.add(company);
            }
            for (Company company : companyList){
                company.setCompany(company.getCompany().replace(queryParam.getCondition().get("company").toString(),
                        "<span>"+queryParam.getCondition().get("company").toString()+"</span>"));
            }
            result.listData(companyList);
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/addCompany", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result addCompany(@RequestBody Company company){
        Result result  = new Result();
        try {
            companyService.add(company);
            result.setData(company);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/findLikeAddressList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findLikeAddressList(@RequestBody QueryParam queryParam ){
        Result result = new Result();
        try {
            try {
                List<Localtioninfo> locationinfoList = localtioninfoService.findLikeList(queryParam);
                for (Localtioninfo localtioninfo : locationinfoList){
                    localtioninfo.setDetailedAddress(localtioninfo.getDetailedAddress().replace(queryParam.getCondition().get("detailedAddress").toString(),
                            "<span>"+queryParam.getCondition().get("detailedAddress").toString()+"</span>"));
                }
                Localtioninfo localtioninfo = new Localtioninfo();
                localtioninfo.setDetailedAddress("<span>添加地址</span>");
                localtioninfo.setId("0");
                locationinfoList.add(localtioninfo);
                result.listData(locationinfoList);
            }catch (Exception e){
                logger.error(e.getMessage());
                result.error("服务器繁忙!");
            }
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/addPost", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result addPost(@RequestBody Post post){
        Result result = new Result();
        try {
            if("0".equals(post.getCompany().getId())){
                post.getCompany().setId(null);
                post.setCompID(null);
            }
            if(post.getAddrID()!=null){
                post.setWorkPlace(null);
            }
            post.setStatus(true);
            postService.persistenceAndChild(post);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/postListManager", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result postListManager(){
        Result result = new Result();
        try {
            QueryParam queryParam = new QueryParam();
            queryParam.put("createBy",IJobSecurityUtils.getLoginUserId());
            queryParam.put("isDeleted",false);
            queryParam.put("status",true);
            queryParam.setOrderByClause("order by p.createTime desc");
            result.listData(postService.findList(queryParam));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }
    @RequestMapping(value = "/postJobInfo/{id}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result postJobInfo(@PathVariable String id){
        Result result = new Result();
        QueryParam queryParam = new QueryParam("id",id);
        try {
            Map map = new HashMap<>();
            Post post = initFullJob(queryParam,id);
            map.put("post",post);
            queryParam.clear();
            queryParam.put("createBy","system");
            queryParam.put("userID",IJobSecurityUtils.getLoginUserId());
            List labels = postLabelService.findListByCreate(queryParam);
            map.put("labels",labels);
            result.listData(map);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/deleteOrClosePost", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result deleteOrClosePost(@RequestBody Post post){
        Result result = new Result();
        try {
            if(post.getStatus()==null){
                postService.delete(post);
            }else{
                postService.update(post);
            }
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/postLineListManager", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result postLineListManager(){
        Result result = new Result();
        try {
            QueryParam queryParam = new QueryParam();
            queryParam.put("createBy",IJobSecurityUtils.getLoginUserId());
            queryParam.put("isDeleted",false);
            queryParam.put("status",false);
            queryParam.setOrderByClause("order by p.createTime desc");
            result.listData(postService.findList(queryParam));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }
    @RequestMapping(value = "/getFullJobList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getFullJobList(@RequestBody PageParam pageParam){
        Result result = new Result();
        pageParam.put("isDeleted",false);
        try {
            if(pageParam.getCondition().get("orderBy")!=null){
                if("2".equals(pageParam.getCondition().get("orderBy").toString())){
                    pageParam.put("orderBy","order by p.maxSalary desc");
                }else{
                    pageParam.put("orderBy",null);
                }
            }
            if(pageParam.getCondition().get("salaryOrder")!=null){
                if("1".equals(pageParam.getCondition().get("salaryOrder").toString())){
                    pageParam.put("salaryOrder","and (p.maxSalary < 3000 or p.minSalary < 3000)");
                }else if("2".equals(pageParam.getCondition().get("salaryOrder").toString())){
                    pageParam.put("salaryOrder","and ((p.maxSalary >= 3000 and p.maxSalary <= 5000 )or (p.minSalary >= 3000 and p.minSalary <= 5000))");
                }else if("3".equals(pageParam.getCondition().get("salaryOrder").toString())){
                    pageParam.put("salaryOrder","and ((p.maxSalary >= 5000 and p.maxSalary <= 7000 )or (p.minSalary >= 5000 and p.minSalary <= 7000))");
                }else if("4".equals(pageParam.getCondition().get("salaryOrder").toString())){
                    pageParam.put("salaryOrder","and ((p.maxSalary >= 7000 and p.maxSalary <= 9000 )or (p.minSalary >= 7000 and p.minSalary <= 9000))");
                }else if("5".equals(pageParam.getCondition().get("salaryOrder").toString())){
                    pageParam.put("salaryOrder","and (p.maxSalary > 9000 or p.minSalary > 9000)");
                }else{
                    pageParam.put("salaryOrder",null);
                }
            }
            postService.findPage(pageParam);
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return super.getObject2List(pageParam) ;
    }

    /**
     * 求职者查看职位信息
     * @param id
     * @return
     */
    @SearchRecode(type = SearchRecode.OpType.BROWSE_FULL)
    @RequestMapping(value = "/fullJobInfo/{id}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result fullJobInfo(@PathVariable String id){
        Result result = new Result();
        QueryParam queryParam = new QueryParam("id",id);
        try {
            Post post = initFullJob(queryParam,id) ;
            queryParam.clear();
            queryParam.put("compID",post.getCompID());
            queryParam.put("status",true);
            queryParam.put("isDeleted",false);
            queryParam.put("other",id);
            post.setOtherPostList(postService.findList(queryParam));
            result.listData(post);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    public Post initFullJob(QueryParam queryParam,String id) throws Exception{
        Post post = new Post();
        if(!"0".equals(id)){
            List<String> list = new ArrayList<>();
            post = postService.postJobInfo(queryParam);
            User user = userService.get(post.getCreateBy());
            Attachment attachment = attachmentService.get(user.getInfoHeadImg());
            user.setAttachment(attachment);
            Weixin weixin = weChatService.one(new QueryParam("userID",user.getId()));
            user.setWeixin(weixin);
            post.setUser(user);
            queryParam.clear();
            if(post.getWorkLabel()!=null){
                list.addAll(Arrays.asList(post.getWorkLabel().split(",")));
            }
            if(post.getBenefitsLabel()!=null){
                list.addAll(Arrays.asList(post.getBenefitsLabel().split(",")));
            }
            if(post.getOtherLabel()!=null){
                list.addAll(Arrays.asList(post.getOtherLabel().split(",")));
            }
            if(list.size()>0){
                queryParam.in("code",list);
                post.setPostLabelList(postLabelService.findList(queryParam));
            }
            queryParam.clear();
            Resume resume = resumeService.one(new QueryParam("userID",IJobSecurityUtils.getLoginUserId()));
            if(resume!=null){
                Recommend recommend = recommendService.one(new QueryParam("phoneNumber",resume.getPhoneNumber()));
                if(recommend!=null){
                    queryParam.put("postID",post.getId());
                    queryParam.put("recommendID",recommend.getId());
                    PostRecommendBroker postRecommendBroker = postRecommendBrokerService.one(queryParam);
                    if(postRecommendBroker!=null){
                        post.setIsLike(postRecommendBroker.getIsLike());
                    }
                }
            }
        }
        return post ;
    }

    @ResponseBody
    @RequestMapping(value = "/workerReport/{fullID}/{brokerCode}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result workerReport(@PathVariable String fullID,@PathVariable String brokerCode){
        Result result = new Result();
        try {
            postRecommendBrokerService.workerReport(fullID,brokerCode);
        }catch (IJobException ijob){
            logger.error(ijob.getMessage());
            result.put("501",ijob.getMessage());
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/allFullStatusInfo", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result allFullStatusInfo(){
        Result result = new Result();
        try {
            result.listData(postRecommendBrokerService.allFullStatusInfo(IJobSecurityUtils.getLoginUserId()));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/getFullJobInfoByStatus/{status}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result getFullJobInfoByStatus(@PathVariable String status){
        Result result = new Result();
        QueryParam queryParam = new QueryParam("createBy",IJobSecurityUtils.getLoginUserId());
        queryParam.put("status",status);
        try {
            result.listData(postRecommendBrokerService.getFullJobInfoByStatus(queryParam));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/changeWorkerStatus", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result changeWorkerStatus(@RequestBody PostRecommendBroker postRecommendBroker){
        Result result = new Result();
        try {
            PostRecommendBroker temp = postRecommendBrokerService.getWorkingJob(postRecommendBroker.getRecommendID());
            if(temp!=null&&postRecommendBroker.getStatus()==4){
                throw new IJobException("该用户已经被其他招聘者录取了");
            }else{
                postRecommendBrokerService.update(postRecommendBroker);
            }
        }catch (IJobException ijob){
            logger.error(ijob.getMessage());
            result.put("501",ijob.getMessage());
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/becomeBroker", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result becomeBroker(){
        Result result = new Result();
        try {
            brokerService.becomeBroker();
        }catch (IJobException ijob){
            logger.error(ijob.getMessage());
            result.put("401",ijob.getMessage());
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/checkBroker", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result checkBroker(){
        Result result = new Result();
        try {
            QueryParam queryParam = new QueryParam("createBy",IJobSecurityUtils.getLoginUserId());
            queryParam.put("isDeleted",false);
            Broker broker = brokerService.getDao().one(queryParam);
            queryParam.clear();
            queryParam.put("refID",broker.getId());
            if(broker==null){
                result.error("尚未成为经纪人");
            }else if(broker.getStatus()==1){
                result.put("401","正在审核中...");
            }else if(broker.getStatus()==3){
                throw new Exception();
            }
            result.listData(broker);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result;
    }

    @RequestMapping(value = "/brokerCallback", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result brokerCallback(@RequestBody WorkList workList){
        Result result = new Result();
        try {
            brokerService.brokerCallback(workList);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/getPostForBrokerInfo/{postID}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getPostForBrokerInfo(@PathVariable String postID){
        Result result = new Result();
        try {
            QueryParam queryParam = new QueryParam("postID",postID);
            PostForBroker postForBroker = postForBrokerService.one(queryParam);
            if(postForBroker==null){
                postForBroker = new PostForBroker();
                postForBroker.setUnit(2);
            }
            result.listData(postForBroker);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result;
    }

    @RequestMapping(value = "/updatePostForBrokerInfo", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result updatePostForBrokerInfo(@RequestBody PostForBroker postForBroker){
        Result result = new Result();
        try {
            PostForBroker temp = postForBrokerService.one(new QueryParam("postID",postForBroker.getPostID()));
            if(temp!=null){
                postForBroker.setVersion(temp.getVersion());
                postForBroker.setId(temp.getId());
            }
            postForBrokerService.persistence(postForBroker);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/getPostForBrokerInfoListPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getPostForBrokerInfoListPage(@RequestBody PageParam pageParam){
        Result result = new Result();
        try {
            pageParam.setOrderByClause("order by p.createTime desc");
            postForBrokerService.getPostForBrokerInfoListPage(pageParam);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return super.getObject2List(pageParam) ;
    }

    @RequestMapping(value = "/getPostForBrokerFullInfo/{id}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getPostForBrokerFullInfo(@PathVariable String id){
        Result result = new Result();
        try {
            PostForBroker postForBroker = postForBrokerService.get(id);
            if(postForBroker==null){
                QueryParam queryParam = new QueryParam("postID",id);
                postForBroker = postForBrokerService.one(queryParam);
            }
            QueryParam queryParam = new QueryParam("id",postForBroker.getPostID());
            Post post = initFullJob(queryParam,postForBroker.getPostID());
            postForBroker.setPost(post);
            result.listData(postForBroker);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result;
    }

    @RequestMapping(value = "/personRecommend", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result personRecommend(@RequestBody PostRecommendBroker postRecommendBroker){
        Result result = new Result();
        QueryParam queryParam = new QueryParam();
        try {
            Recommend recommend = recommendService.one(new QueryParam("phoneNumber",postRecommendBroker.getRecommend().getPhoneNumber()));
            if(recommend!=null){
                if(!postRecommendBroker.getRecommend().getName().equals(recommend.getName())){
                    result.put("501","该手机号码已被使用。");
                    return result ;
                }
                queryParam.put("postID",postRecommendBroker.getPostID());
                queryParam.put("recommendID",recommend.getId());
                PostRecommendBroker temp = postRecommendBrokerService.one(queryParam);
                //查询用户是否已经报名了当前职位
                if(temp!=null){
                    if(temp.getBrokerID()==null&&temp.getStatus()!=5){
                        result.put("501","该用户暂时无法推荐。");
                        return result ;
                    }
                    if(temp.getStatus()!=null){
                        //获得用户距离上次状态更改时间差距多少
                        int day = (int) ((new Date()).getTime() - (temp.getUpdateTime().getTime())) / (1000*3600*24);
                        //当小于七天的是时候
                        if(day<7){
                            if(temp.getStatus()!=9&&temp.getStatus()!=5){
                                result.put("501","该用户已经报名或被其他经纪人推荐过该职位了");
                                return result ;
                            }
                        }else{
                            if(temp.getStatus()!=9&&temp.getStatus()!=5&&temp.getStatus()!=1){
                                result.put("501","该用户已经报名或被其他经纪人推荐过该职位了");
                                return result ;
                            }
                        }
                    }else{
                        postRecommendBroker.setIsLike(temp.getIsLike());;
                    }
                    postRecommendBroker.setId(temp.getId());
                    postRecommendBroker.setVersion(temp.getVersion());
                }
                //查询用户是否已经处在工作中
                /*queryParam.put("postID",null);
                queryParam.put("status",4);
                temp = postRecommendBrokerService.one(queryParam);
                if(temp!=null){
                    result.put("501","该用户已经在工作中了。");
                    return result ;
                }*/
                postRecommendBroker.getRecommend().setId(recommend.getId());
                postRecommendBroker.getRecommend().setVersion(recommend.getVersion());
                postRecommendBroker.setStatus(1);
            }
            postRecommendBrokerService.persistenceAndChild(postRecommendBroker);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result;
    }

    @RequestMapping(value = "/deliveredResumePage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result deliveredResumePage(@RequestBody PageParam pageParam){
        Result result = new Result();
        try {
            QueryParam queryParam = new QueryParam("createBy", IJobSecurityUtils.getLoginUserId());
            queryParam.put("isDeleted",false);
            Resume resume = resumeService.one(queryParam);
            if(resume==null){
                pageParam.setList(new ArrayList<>());
                result=super.getObject2List(pageParam);
                result.put("502","请填写简历信息");
                return result;
            }
            Recommend recommend = recommendService.one(new QueryParam("phoneNumber",resume.getPhoneNumber()));
            if(recommend==null&&pageParam.getCondition().get("isLike")==null){
                pageParam.setList(new ArrayList<>());
                result=super.getObject2List(pageParam);
                result.put("502","你尚未报名过全职");
                return  result;
            }
            pageParam.put("recommendID",recommend.getId());
            return super.getObject2List(postRecommendBrokerService.deliveredResumePage(pageParam));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        result = super.getObject2List(pageParam);
        result.listData(new ArrayList<>());
        return result;
    }

    /**
     * 收藏职位
     * @param postRecommendBroker
     * @return
     */
    @RequestMapping(value = "/collectionPost", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result collectionPost(@RequestBody PostRecommendBroker postRecommendBroker){
        Result result = new Result();
        try {
            postRecommendBrokerService.collectionPost(postRecommendBroker);
        }catch (IJobException ijob){
            logger.error(ijob.getMessage());
            result.error(ijob.getMessage());
        }
        catch (Exception e){
            logger.error(e.getMessage());
            result.error("数据异常，请刷新重试");
        }
        return result ;
    }

    @RequestMapping(value = "/getMyRecommendInfo", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getMyRecommendInfo(){
        Result result = new Result();
        try {
            result.listData(postRecommendBrokerService.getMyRecommendInfo(IJobSecurityUtils.getLoginUserId()));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/myBrokerPersonDetail", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result myBrokerPersonDetail(@RequestBody QueryParam queryParam){
        Result result = new Result();
        try {
            queryParam.put("userID",IJobSecurityUtils.getLoginUserId());
            result.listData(postRecommendBrokerService.myBrokerPersonDetail(queryParam));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/checkHasResume", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result checkHasResume(){
        Result result = new Result();
        QueryParam queryParam = new QueryParam();
        queryParam.put("userID",IJobSecurityUtils.getLoginUserId());
        try {
            Resume resume = resumeService.one(queryParam);
            if(resume==null){
                result.error("aa");
            }
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/loadResume/{prbID}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result loadResume(@PathVariable String prbID){
        Result result = new Result();
        try {
            PostRecommendBroker postRecommendBroker = postRecommendBrokerService.get(prbID);
            Post post = postService.get(postRecommendBroker.getPostID());
            post.setCompany(companyService.get(post.getCompID()));
            postRecommendBroker.setPost(post);
            postRecommendBroker.setBroker(brokerService.get(postRecommendBroker.getBrokerID()));
            Recommend recommend = recommendService.get(postRecommendBroker.getRecommendID());
            Resume resume = resumeService.one(new QueryParam("phoneNumber",recommend.getPhoneNumber()));
            if(resume==null){
                resume = new Resume();
                resume.setPhoneNumber(recommend.getPhoneNumber());
                resume.setAge(recommend.getAge());
                resume.setSex(recommend.getSex());
                resume.setEvaluation(recommend.getMark());
                resume.setResumeName(recommend.getName());
            }else{
                User user = userService.get(resume.getUserID());
                Attachment attachment = attachmentService.get(user.getInfoHeadImg());
                Weixin weixin = weChatService.one(new QueryParam("userID",user.getId()));
                resume.setEvaluation(resume.getEvaluation()+recommend.getMark());
                Resume temp = resumeService.getMyResumeAllInfo(resume.getId());
                resume.setWorkexperienceList(temp.getWorkexperienceList());
                if(attachment!=null){
                    resume.setAttachment(attachment);
                }
                resume.setImgPath(weixin.getHeadimgurl());
            }
            postRecommendBroker.setResume(resume);
            result.listData(postRecommendBroker);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    @RequestMapping(value = "/deleteUsersLabel/{labelCode}", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result deleteUsersLabel(@PathVariable String labelCode){
        Result result = new Result();
        try {
            PostLabel label = postLabelService.one(new QueryParam("code",labelCode));
            postLabelService.physicalDelete(label);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }

        return result ;
    }
}

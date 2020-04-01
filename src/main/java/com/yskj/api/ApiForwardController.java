package com.yskj.api;


import com.yskj.controller.base.BaseController;
import com.yskj.models.Forward;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.models.Wxorder;
import com.yskj.service.ForwardService;
import com.yskj.service.RedPacketService;
import com.yskj.service.WeChatService;
import com.yskj.service.WxorderService;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.Result;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;


@Controller
@RequestMapping(value = "/api/ForwardController")
public class ApiForwardController extends BaseController{

	@Autowired
	private ForwardService forwardService;

	@Autowired
    private WeChatService weChatService ;

	@Autowired
    private WxorderService wxorderService ;

	@Autowired
    private RedPacketService redPacketService ;

	private final static Logger logger = LoggerFactory.getLogger(ApiForwardController.class);

	 public ForwardService getService() {
         return this.forwardService;
     }

	 /**
     * 页面
     * @return String
     */
    @RequiresPermissions("Forward")
    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String index(Model model){
        return "forward";
    }

     /**
     *新增
     * @param forward
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(Forward forward ){
         return super.add(forward);
    }

    /**
     * 删除
     * @param forward
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(Forward forward ){
        return super.delete(forward);
    }

     /**
     * 修改
     * @param forward
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(Forward forward ){
        return super.update(forward);
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

    /**
     * 唯一查询通过ID
     * @param id
     * @return Result
     */
    @RequestMapping(value = "/get", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result get(String id ){
        return super.get(id);
    }


     /**
     * 转发职位
     * @param positionID
     * @return Result
     */
    @RequestMapping(value = "/forwardPosition/{positionID}/{rewardID}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result forwardPosition(@PathVariable String positionID,@PathVariable String rewardID){
        Result result = new Result();
        try {
            QueryParam queryParam = new QueryParam("userId",IJobSecurityUtils.getLoginUserId());
            queryParam.put("positionId",positionID);
            queryParam.put("isDeleted",false);
            Forward tempForward = forwardService.one(queryParam);
            if (tempForward != null ){
                result.put("501","您已经转发过该职位！");
                return result ;
            }
            //数据准备
            Forward forward = new Forward();
            forward.setUserId(IJobSecurityUtils.getLoginUserId());
            forward.setPositionId(positionID);
            forward.setRewardID(rewardID);
            //添加
            forwardService.add(forward);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("500","转发失败！");
        }
        return result;
    }

    /**
     * 转发职位，并设置分享红包。
     * @param map
     * @return
     */
    @RequestMapping(value = "/forwardPositionByRed", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result forwardPositionByRed(@RequestBody Map map){
        Result result = new Result();
        try {
            result = forwardService.forwardPositionByRed(map);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result;
    }

    /**
     * 红包回调
     * @param wxorderID
     * @return Result
     */
    @RequestMapping(value = "/redPacketCallback/{wxorderID}", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result redPacketCallback(@PathVariable String wxorderID){
        Result result = new Result();

        //调用之前还是要检查一下，不能你说修改为已交保证金就交吧
        Wxorder wxorder = null;
        try {
            wxorder = wxorderService.get(wxorderID);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(wxorder!=null){
            if(wxorder.getStatus()==3){
                try {
                    forwardService.redPacketCallback(wxorder);
                } catch (Exception e) {
                    e.printStackTrace();
                    try {
                        weChatService.refundOrder(wxorderID);
                    } catch (Exception e1) {
                        e1.printStackTrace();
                    }
                }
            }else{
                result.error("请缴纳红包");
            }
        }else{
            result.error("请缴纳红包");
        }
        return result;
    }



}

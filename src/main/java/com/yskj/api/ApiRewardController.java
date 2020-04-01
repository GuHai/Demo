package com.yskj.api;


import com.spatial4j.core.context.SpatialContext;
import com.spatial4j.core.distance.DistanceUtils;
import com.yskj.controller.base.BaseController;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.models.Reward;
import com.yskj.service.RewardService;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.Result;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;


@Controller
@RequestMapping(value = "/api/RewardController")
public class ApiRewardController extends BaseController{

	@Autowired
	private RewardService rewardService;

	private final static Logger logger = LoggerFactory.getLogger(ApiRewardController.class);

	 public RewardService getService() {
         return this.rewardService;
     }

	 /**
     * 页面
     * @return String
     */
    @RequiresPermissions("Reward")
    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String index(Model model){
        return "reward";
    }

     /**
     *新增
     * @param reward
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(Reward reward ){
         return super.add(reward);
    }

    /**
     * 删除
     * @param reward
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(Reward reward ){
        return super.delete(reward);
    }

     /**
     * 修改
     * @param reward
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(Reward reward ){
        return super.update(reward);
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

    @RequestMapping(value = "/getNewReward/{positionID}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getNewReward(@PathVariable String positionID){
        Result result = new Result();
        try {
            Reward reward = rewardService.getNewReward(positionID);
            if (reward == null){
                reward = new Reward();
                reward.setRewardType(false);
                reward.setHourlyWage(new BigDecimal(20));
                reward.setRewardMoney(new BigDecimal(5));
                reward.setPositionID(positionID);
            }
            result.listData(reward);
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("服务器繁忙");
        }
        return result ;
    }

    @RequestMapping(value = "/insertNewReward", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result insertNewReward(@RequestBody Reward reward){
        Result result = new Result( );
        try {
            rewardService.add(reward);
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("服务器繁忙！");
        }
        return result;
    }

    /**
     * 查询页面
     * @param pageParam
     * @return Result
     */
    @RequestMapping(value = "/findPositionByRewardPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findPositionByRewardPage(@RequestBody PageParam pageParam ){
        try {
            pageParam.put("userID", IJobSecurityUtils.getLoginUserId());
            rewardService.findPositionByRewardPage(pageParam);
            SpatialContext geo = SpatialContext.GEO;
            Double lng = Double.parseDouble(pageParam.getCondition().get("lng").toString());
            Double lat = Double.parseDouble(pageParam.getCondition().get("lat").toString());
            for (Reward reward : (List<Reward>)pageParam.getList()){
                double distance = geo.calcDistance(geo.makePoint(lng, lat),geo.makePoint(reward.getPosition().getWorkPlace().getLongitude().doubleValue(), reward.getPosition().getWorkPlace().getLatitude().doubleValue()))
                        * DistanceUtils.DEG_TO_KM;
                reward.getPosition().getWorkPlace().setDistance(Double.parseDouble(String .format("%.2f",distance)));
            }
        }catch (Exception e){
            logger.error(e.getMessage());
        }
        return super.getObject2List(pageParam);
    }

}

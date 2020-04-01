package com.yskj.api;


import com.yskj.controller.base.BaseController;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.models.RedPacket;
import com.yskj.service.RedPacketService;
import com.yskj.utils.Result;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Controller
@RequestMapping(value = "/api/RedPacketController")
public class ApiRedPacketController extends BaseController{

	@Autowired
	private RedPacketService redPacketService;

	private final static Logger logger = LoggerFactory.getLogger(ApiRedPacketController.class);

	 public RedPacketService getService() {
         return this.redPacketService;
     }

	 /**
     * 页面
     * @return String
     */
    @RequiresPermissions("RedPacket")
    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String index(Model model){
        return "redPacket";
    }

     /**
     *新增
     * @param redPacket
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(RedPacket redPacket ){
         return super.add(redPacket);
    }

    /**
     * 删除
     * @param redPacket
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(RedPacket redPacket ){
        return super.delete(redPacket);
    }

     /**
     * 修改
     * @param redPacket
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(RedPacket redPacket ){
        return super.update(redPacket);
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
     *新增
     * @param redPacket
     * @return Result
     */
    @RequestMapping(value = "/addNewRedPacket", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result addNewRedPacket(@RequestBody RedPacket redPacket ){
        Result result = new Result();
        try {
            QueryParam queryParam = new QueryParam("positionID",redPacket.getPositionID());
            queryParam.put("state",true);
            queryParam.put("isDeleted",false);
            RedPacket redPacket1 = redPacketService.one(queryParam);
            if(redPacket1 != null){
                result.put("501","已经设置过红包！");
            }else{
                result= super.add(redPacket);
                result.setData(redPacket);
            }
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误");
        }

        return result;
    }
}

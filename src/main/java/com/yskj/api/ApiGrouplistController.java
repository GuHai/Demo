package com.yskj.api;


import com.yskj.controller.base.BaseController;
import com.yskj.models.Grouplist;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.service.GrouplistService;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.Result;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value = "/api/GrouplistController")
public class ApiGrouplistController extends BaseController{

	@Autowired
	private GrouplistService grouplistService;

	private final static Logger logger = LoggerFactory.getLogger(ApiGrouplistController.class);

	 public GrouplistService getService() {
         return this.grouplistService;
     }

	 /**
     * 页面
     * @return String
     */
    @RequiresPermissions("Grouplist")
    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String index(Model model){
        return "grouplist";
    }

     /**
     *新增
     * @param grouplist
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(Grouplist grouplist ){
         return super.add(grouplist);
    }

    /**
     * 删除
     * @param grouplist
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(Grouplist grouplist ){
        return super.delete(grouplist);
    }

     /**
     * 修改
     * @param grouplist
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(Grouplist grouplist ){
        return super.update(grouplist);
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

    @ResponseBody
    @RequestMapping(value = "/getGroupInfo/{groupID}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result getGroupInfo(@PathVariable String groupID){
        Result result = new Result();
        try {
            Map map = new HashMap();
            List<Map> mapList = grouplistService.getGroupUserInfo(groupID);
            map.put("groupUserList",mapList);
            for (Map tempMap : mapList){
                if(tempMap.get("userID").toString().equals(IJobSecurityUtils.getLoginUserId())){
                    map.put("nowUser",tempMap);
                    break;
                }
            }
            result.listData(map);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/exitGroup", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result exitGroup(Grouplist grouplist ){
        Result result = new Result();
        try {
            Long count = new Long(0);
            if(grouplist.getUserType() == 1){
                count = grouplistService.clearGroupByGroupID(grouplist);
            }else if(grouplist.getUserType() == 3){
                count = grouplistService.physicalDelete(grouplist);
            }
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙");
        }
        return result ;
    }

}
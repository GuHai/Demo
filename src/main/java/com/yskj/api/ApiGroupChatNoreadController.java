package com.yskj.api;


import com.yskj.controller.base.BaseController;
import com.yskj.models.GroupChatNoread;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.service.GroupChatNoreadService;
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
import java.util.Map;


@Controller
@RequestMapping(value = "/api/GroupChatNoreadController")
public class ApiGroupChatNoreadController extends BaseController{

	@Autowired
	private GroupChatNoreadService groupChatNoreadService;

	private final static Logger logger = LoggerFactory.getLogger(ApiGroupChatNoreadController.class);

	 public GroupChatNoreadService getService() {
         return this.groupChatNoreadService;
     }

	 /**
     * 页面
     * @return String
     */
    @RequiresPermissions("GroupChatNoread")
    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String index(Model model){
        return "groupChatNoread";
    }

     /**
     *新增
     * @param groupChatNoread
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(GroupChatNoread groupChatNoread ){
         return super.add(groupChatNoread);
    }

    /**
     * 删除
     * @param groupChatNoread
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(GroupChatNoread groupChatNoread ){
        return super.delete(groupChatNoread);
    }

     /**
     * 修改
     * @param groupChatNoread
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(GroupChatNoread groupChatNoread ){
        return super.update(groupChatNoread);
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
    @RequestMapping(value = "/updateMsgRead/{groupID}/{userID}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result updateMsgRead(@PathVariable String groupID,@PathVariable String userID){
        Result result = new Result();
        try {
            Map map = new HashMap<String  ,String >();
            map.put("groupID",groupID);
            map.put("userID", IJobSecurityUtils.getLoginUserId());
            groupChatNoreadService.updateMsgRead(map);
        }catch (Exception e) {
            logger.error(e.getMessage());
            result.error("服务器繁忙！");
        }
        return result ;
    }

}

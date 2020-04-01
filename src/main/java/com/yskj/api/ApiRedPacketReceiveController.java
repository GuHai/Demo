package com.yskj.api;


import com.yskj.controller.base.BaseController;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.models.RedPacketReceive;
import com.yskj.models.Weixin;
import com.yskj.service.AccountService;
import com.yskj.service.RedPacketReceiveService;
import com.yskj.service.WeChatService;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.Result;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;


@Controller
@RequestMapping(value = "/api/RedPacketReceiveController")
public class ApiRedPacketReceiveController extends BaseController {

    @Autowired
    private RedPacketReceiveService redPacketReceiveService;

    @Autowired
    private WeChatService weChatService ;

    @Autowired
    private AccountService accountService ;

    private final static Logger logger = LoggerFactory.getLogger(ApiRedPacketReceiveController.class);

    public RedPacketReceiveService getService() {
        return this.redPacketReceiveService;
    }

    /**
     * 页面
     *
     * @return String
     */
    @RequiresPermissions("RedPacketReceive")
    @RequestMapping(value = "", method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String index(Model model) {
        return "redPacketReceive";
    }

    /**
     * 新增
     *
     * @param redPacketReceive
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(RedPacketReceive redPacketReceive) {
        return super.add(redPacketReceive);
    }

    /**
     * 删除
     *
     * @param redPacketReceive
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(RedPacketReceive redPacketReceive) {
        return super.delete(redPacketReceive);
    }

    /**
     * 修改
     *
     * @param redPacketReceive
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(RedPacketReceive redPacketReceive) {
        return super.update(redPacketReceive);
    }

    /**
     * 查询页面
     *
     * @param pageParam
     * @return Result
     */
    @RequestMapping(value = "/findPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findPage(@RequestBody PageParam pageParam) {
        return super.findPage(pageParam);
    }

    /**
     * 查询集合
     *
     * @param queryParam
     * @return Result
     */
    @RequestMapping(value = "/findList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findList(@RequestBody QueryParam queryParam) {
        return super.findList(queryParam);
    }


    /**
     * 模糊查询页面
     *
     * @param pageParam
     * @return Result
     */
    @RequestMapping(value = "/findLikePage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findLikePage(@RequestBody PageParam pageParam) {
        return super.findLikePage(pageParam);
    }


    /**
     * 查询集合，模糊查询
     *
     * @param queryParam
     * @return Result
     */
    @RequestMapping(value = "/findLikeList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findLikeList(@RequestBody QueryParam queryParam) {
        return super.findLikeList(queryParam);
    }

    /**
     * 唯一查询
     *
     * @param queryParam
     * @return Result
     */
    @RequestMapping(value = "/one", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result one(@RequestBody QueryParam queryParam) {
        return super.one(queryParam);
    }

    /**
     * 唯一查询通过ID
     *
     * @param id
     * @return Result
     */
    @RequestMapping(value = "/get", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result get(String id) {
        return super.get(id);
    }

    /**
     * 查询当前用户的红包数据
     *
     * @return
     */
    @RequestMapping(value = "/findListByUserIdPage", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findListByUserIdPage(@RequestParam(value = "nextPage",required = false,defaultValue = "1") int nextPage) {
        Result result = new Result();
        PageParam pageParam = new PageParam();
        pageParam.put("userId", IJobSecurityUtils.getLoginUserId());
        pageParam.setCurrentPage(nextPage);
        try {
            result.listData(redPacketReceiveService.findListByUserIdPage(pageParam));
        } catch (Exception e) {
            e.printStackTrace();
            result.put("500", "查询数据失败");
        }
        return result;
    }
    @RequestMapping(value = "/getNoSureRedPacket", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getNoSureRedPacket(){
        Result result = new Result();
        QueryParam queryParam = new QueryParam("userID",IJobSecurityUtils.getLoginUserId());
        try {
            Weixin weixin = weChatService.one(queryParam);
            queryParam.put("time",weixin.getUpdateTime());
            weixin.setUpdateTime(new Date());
            weChatService.update(weixin);
            result.listData(accountService.getNoSureRedPacket(queryParam));
        }catch (Exception e){
            logger.error(e.getMessage());
        }
        return result;
    }



}

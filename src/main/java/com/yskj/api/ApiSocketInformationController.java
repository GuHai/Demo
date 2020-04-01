package com.yskj.api;


import com.yskj.controller.base.BaseController;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.models.SocketInformation;
import com.yskj.service.SocketInformationService;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value = "/api/SocketInformationController")
public class ApiSocketInformationController extends BaseController{

	@Autowired
	private SocketInformationService socketInformationService;

	private final static Logger logger = LoggerFactory.getLogger(ApiSocketInformationController.class);

	 public SocketInformationService getService() {
         return this.socketInformationService;
     }

     @Autowired
     private UserService userService ;
	 /**
     * 页面
     * @return String
     */
    @RequiresPermissions("SocketInformation")
    @RequestMapping(value = "",method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String index(Model model){
        return "socketInformation";
    }

     /**
     *新增
     * @param socketInformation
     * @return Result
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result add(SocketInformation socketInformation ){
         return super.add(socketInformation);
    }

    /**
     * 删除
     * @param socketInformation
     * @return Result
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result delete(SocketInformation socketInformation ){
        return super.delete(socketInformation);
    }

     /**
     * 修改
     * @param socketInformation
     * @return Result
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result update(SocketInformation socketInformation ){
        return super.update(socketInformation);
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
     * 查询最近联系人。
     * @return
     */
    @RequestMapping(value = "/recentChat", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result recentChat(){
        Result result = new Result();
        try {

            String userID = IJobSecurityUtils.getLoginUserId();
            List<SocketInformation> socketInformationList = socketInformationService.recentChat(userID);
            Map map = new HashMap();
            map.put("User",IJobSecurityUtils.getLoginUser());
            QueryParam queryParam = new QueryParam();
            for (int i = 0 ; i < socketInformationList.size() ; i++){
                queryParam.clear();
                if (userID.equals(socketInformationList.get(i).getFromuser())){
                    socketInformationList.get(i).setFromuser(null);
                    queryParam.put("id",socketInformationList.get(i).getTouser());
                    socketInformationList.get(i).setToUserObj(userService.one(queryParam));
                }else if (userID.equals(socketInformationList.get(i).getTouser())){
                    socketInformationList.get(i).setTouser(null);
                    queryParam.put("id",socketInformationList.get(i).getFromuser());
                    socketInformationList.get(i).setFromUserObj(userService.one(queryParam));
                }
            }
            map.put("socketInformationList",socketInformationList);
            result.listData(map);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.put("500","服务器繁忙！");
        }
        return result ;
    }

    /**
     * 查询聊天记录
     * @param pageParam
     * @return
     */
    @RequestMapping(value = "/getHistoryChatInfoPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getHistoryChatInfoPage(@RequestBody PageParam pageParam){
        Result result = new Result();
        try {
            if (pageParam.getCondition().get("touser").toString().indexOf("group_") == -1){
                result.setData(socketInformationService.getHistoryChatInfoPage(pageParam));
            }else{
                result.setData(socketInformationService.getGroupHistoryChatPage(pageParam));
            }
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.put("500","服务器繁忙！请稍后再试！");
        }
        return result ;
    }

    @RequestMapping(value = "/getC2CUserInfo", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getC2CUserInfo(@RequestParam Map map){
        Result result = new Result();
        try{
            Map toUser = socketInformationService.getC2CUserInfo((String) map.get("toUser"));
            Map sendUser = socketInformationService.getC2CUserInfo((String) map.get("sendUser"));
            Map resultMap = new HashMap();
            resultMap.put("toUser",toUser);
            resultMap.put("sendUser",sendUser);
            result.setData(resultMap);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.put("500","服务器繁忙！");
        }
        return result;
    }

    @RequestMapping(value = "/updateMessageType/{id}/{type}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result updateMessageType (@PathVariable String id,@PathVariable Integer type){
        Result result = new Result();
        QueryParam queryParam =  new QueryParam("type",type);
        if(type == 0){
            queryParam.put("sessionID",id);
        }else if(type == 1){
            queryParam.put("id",id);
        }
        Integer count = socketInformationService.updateMessageType(queryParam);
        if (count == 0 ){
            result.put("500","服务器繁忙！请稍后再试！");
        }
        return result;
    }

    @RequestMapping(value = "/getUserMass", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getUserMass(){
        Result result = new Result();
        QueryParam queryParam = new QueryParam("isDeleted",false);
        queryParam.put("userID",IJobSecurityUtils.getLoginUserId());
        try {
            result.setData(socketInformationService.getUserMass(queryParam));
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.put("500","服务器繁忙，请稍后再试！");
        }
        return result ;
    }
    @RequestMapping(value = "/updateForDiv", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result updateForDiv(SocketInformation socketInformation){
        Result result = new Result();
        try {
            SocketInformation socketInformationTemp = socketInformationService.get(socketInformation.getId());
            socketInformation.setVersion(socketInformationTemp.getVersion());
            socketInformationService.update(socketInformation);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.put("500","服务器繁忙");
        }
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/recentChatGroup", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result recentChatGroup(){
        Result result = new Result();
        try {
            result.listData(socketInformationService.recentChatGroup(IJobSecurityUtils.getLoginUserId()));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙！");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/getHeadImgByID/{userID}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result getHeadImgByID(@PathVariable String userID){
        Result result = new Result();
        try {
            result.listData(socketInformationService.getHeadImgByID(userID));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }




}

package com.yskj.api;

import com.example.demo.type.Group;
import com.example.demo.type.Message;
import com.yskj.controller.base.BaseController;
import com.yskj.redis.RedisUtil;
import com.yskj.service.ChatGroupService;
import com.yskj.service.auth.UserService;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.Result;
import org.apache.shiro.util.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author:Administrator
 * @create 2018-12-22 16:29
 */
@Controller
@RequestMapping(value = "/api/ApiNettyController")
public class ApiNettyController extends BaseController {
    private final static Logger logger = LoggerFactory.getLogger(ApiNettyController.class);
    @Autowired
    private ChatGroupService chatGroupService;
    @Autowired
    private UserService userService;
    public ChatGroupService getService() {
        return this.chatGroupService;
    }

    @RequestMapping(value = "/toInformation", method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String toInformation(Model model){
        model.addAttribute("userID",IJobSecurityUtils.getLoginUserId());
        return "h5/information/information";
    }

    @RequestMapping(value = "/catalog", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result catalog(){
        Result result = new Result();
        Map<Object,Long> groupmap  = RedisUtil.mget("U2GID:"+IJobSecurityUtils.getLoginUserId());
        List<Object> groups  = groupmap.entrySet().stream().map(entity->entity.getKey()).collect(Collectors.toList());
        if(groups!=null){
            List<Message> messages  = RedisUtil.hGetAll("ChatCatalog",groups);
            List<Group> groupList  = RedisUtil.hGetAll("GroupInfo",groups);
            if(!CollectionUtils.isEmpty(messages)){
                result.listData(messages);
                for(Group group : groupList){
                    for(Message message : messages){
                        if(group.getId().equals(message.getGroupID())){
                            if(group.getIsGroup()==Boolean.FALSE){
                                message.setUserID(group.getUserID().replace(IJobSecurityUtils.getLoginUserId(),"").replace(";",""));
                            }else{
                                message.setUserID(group.getUserID());
                            }
                            message.setLastTime(groupmap.get(message.getGroupID()));
                            break;
                        }
                    }
                }
            }
        }
        return result;
    }


    @RequestMapping(value = "/chat/{groupID}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result chat(@PathVariable String groupID){
        Result result = new Result();
        List<Message> messages  = RedisUtil.list("ChatGroup:"+ groupID,0L,10L);
        if(!CollectionUtils.isEmpty(messages)){
            result.listData(messages);
        }
        return result;
    }

    @RequestMapping(value = "/toChat/{userID}/{positionID}", method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String toChat(@PathVariable String userID, @PathVariable String positionID, Model model){
        String groupID = chatGroupService.getAndSetChat(userID,false);
        model.addAttribute("groupID",groupID);
        model.addAttribute("userID",IJobSecurityUtils.getLoginUserId());
        return "h5/information/chat";
    }

    @RequestMapping(value = "/toChat/{groupID}", method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})
    public String toChat2(@PathVariable String groupID,Model model){
        model.addAttribute("groupID",groupID);
        model.addAttribute("userID",IJobSecurityUtils.getLoginUserId());
        return "h5/information/chat";
    }

    @RequestMapping(value = "/userInfo/{userID}", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result userInfo(@PathVariable String userID){
        Result result = new Result();
        Map<String,String> userinfo = null;
        try{
            userinfo =  RedisUtil.hget("UserSimpleInfo",userID);
        }catch (Exception e){
        }
        if(userinfo==null){
            userinfo =  userService.userInfo(userID);
            try{
                RedisUtil.hset("UserSimpleInfo",userID,userinfo);
            }catch (Exception e){
            }
        }
        result.setData(userinfo);
        return result;


    }
}

package com.yskj.redis;

import com.example.demo.type.Message;
import com.example.demo.type.MessageType;
import com.yskj.models.*;
import com.yskj.redis.model.Task;
import com.yskj.service.MessageTemplateService;
import com.yskj.service.WeChatService;
import com.yskj.service.base.DictCacheService;
import com.yskj.utils.HttpUtils;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.StringUtils;
import lombok.Data;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import javax.annotation.PostConstruct;
import java.util.*;

/**
 * redis工具
 *
 * @author zhouchuang
 * @create 2018-03-18 20:16
 */
@Component
@Data
public class RedisUtil {
    private final static Logger logger = LoggerFactory.getLogger(RedisUtil.class);

    public static String ACCESSTOKEN =  "accessToken";
    public static String REFRESHTOKEN =  "refreshToken";
    public static String TICKET =  "ticket";
    public static String OPENID =  "openid";

    @Autowired
    private WeChatService weChatService;
    @Autowired
    private MessageTemplateService messageTemplateService;

    private static RedisUtil redisUtil ;

    @Autowired
    private RedisService redisService;


    @PostConstruct
    public void init() {
        redisUtil = this;
        redisUtil.weChatService = this.weChatService;
        redisUtil.redisService = this.redisService;
        redisUtil.messageTemplateService = this.messageTemplateService;
    }




    public static  void set(String key,String value ){
        Date now = new Date();
        if(key.equals(ACCESSTOKEN)){
            IJobSecurityUtils.getLoginUser().getWeixin().setAccessToken(value);
            IJobSecurityUtils.getLoginUser().getWeixin().setAccessTokenTime(now);
        }else if(key.equals(REFRESHTOKEN)){
            IJobSecurityUtils.getLoginUser().getWeixin().setRefreshToken(value);
            IJobSecurityUtils.getLoginUser().getWeixin().setRefreshTokenTime(now);
        }else if(key.equals(TICKET)){
            IJobSecurityUtils.getLoginUser().getWeixin().setTicket(value);
            IJobSecurityUtils.getLoginUser().getWeixin().setTicketTime(now);
        }else if(key.equals(OPENID)){
            IJobSecurityUtils.getLoginUser().getWeixin().setOpenid(value);
        }
        try {
            redisUtil.weChatService.update(IJobSecurityUtils.getLoginUser().getWeixin());
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    public static Integer setStringValue(final String key, final String value,final Long time) {
        return redisUtil.redisService.setStringValue(key,value.toString(),time);
    }


    /**
     * 根据key获取对象
     */
    public static String getStringValue(final String keyId) {
        return redisUtil.redisService.getStringValue(keyId);
    }

    public static List<String> ids(final String hashkey,final String keyword){
        Set<String> keys = redisUtil.redisService.keys(hashkey+":*"+keyword+"*");
        return redisUtil.redisService.multiGet(keys,String.class);
    }

    public static <T> List<T> multiGet(final Set<String> keys,final Class<T> clazz){
        return redisUtil.redisService.multiGet(keys,clazz);
    }

    public static <T> List<T> hGetAll(String key ,List<Object> items){
        return redisUtil.redisService.hGetAll(key,items);
    }


    /**
     * 添加集合
     */
    public static <ENTITY extends BaseEntity> boolean addAll2List(final List<ENTITY> list,String key) {
       return redisUtil.redisService.addAll2List(list,key);
    }

    public static <ENTITY extends BaseEntity> boolean addAll2List(final List<ENTITY> list) {
        String key = list.get(0).getClass().getSimpleName();
        return addAll2List(list,key);
    }

    public static <ENTITY extends BaseEntity> boolean addMatchByLike(final List<ENTITY> list,String[] fields) {
        String key = list.get(0).getClass().getSimpleName();
        return addMatchByLike(list,key,fields);
    }
    public static <ENTITY extends BaseEntity> boolean addMatchByLike(final List<ENTITY> list,String key,String[] fields) {
        return redisUtil.redisService.addMatchByLike(list,key,fields);
    }
    /**
     * 更新
     * clazz 类
     * key 封装好的字符串或者id名称
     */
    public static <ENTITY extends Object> ENTITY get(final  String key){
        Object object = redisUtil.redisService.get(key);
        if(object!=null){
            return (ENTITY)object;
        }else{
            return null;
        }
    }

    public static void del(final String key){
        redisUtil.redisService.del(key);
    }

    public static <ENTITY extends Object> ENTITY hget( final String key,final  String item){
        Object object =  redisUtil.redisService.hget(key,item);
        if(object!=null){
            return (ENTITY)object;
        }else{
            return null;
        }
    }
    public static <ENTITY extends Object> void hset( final String key,final  String item,final Object value,final Long times){
        redisUtil.redisService.hset(key,item,value,times);
    }
    public static void hset( final String key,final  String item,final Object value){
        hset(key,item,value,30*24*3600L);
    }

    public static void hdel(final String key,final String item){
        redisUtil.redisService.hdel(key,item);
    }


    /**
     * clazz 类
     * match 完整匹配路径
     * */
    public static  <ENTITY extends BaseEntity> List<ENTITY> list(Class clazz,String match){
        Set<String> keys = redisUtil.redisService.keys(match);
        return redisUtil.redisService.multiGet(keys,clazz);
    }
    public static <ENTITY extends BaseEntity> List<ENTITY> list(Class clazz){
        String match  = clazz.getSimpleName();
        return list(clazz,match+":*");
    }

    public static  <ENTITY extends BaseEntity> List<ENTITY> list(Class clazz,String match,List<String> ids){
        Set<String> keys = new HashSet<String>();
        for(String id : ids){
            keys.add(match+":"+id);
        }
        return redisUtil.redisService.multiGet(keys,clazz);
    }

    public static  <ENTITY extends BaseEntity> List<ENTITY> list(Class clazz,List<String> ids){
        String match  = clazz.getSimpleName();
        return list(clazz,match,ids);
    }

    public static PageParam ids2Page(final String hashkey,final String keyword,PageParam pageParam ){
        Set<String> keys = redisUtil.redisService.keys(hashkey+":"+keyword);
        String ids = getStringValue(keys.toArray(new String[]{})[0]);
        return idl2Page(ids.split(","),pageParam);
    }
    public static PageParam idl2Page(String[] list ,PageParam pageParam ){
       return redisUtil.redisService.idl2Page(list,pageParam);
    }





    public static Boolean contains(String key){
        if(!key.contains(":")){
            key  +=  ":*";
        }
        Set<String> keys = redisUtil.redisService.keys(key);
        return !CollectionUtils.isEmpty(keys);
    }





    public static String  getTokens(String key){
        String value = "";
        if(key.equals(ACCESSTOKEN)){
            value = getAccessToken();
        }else if(key.equals(REFRESHTOKEN)){
            value =  IJobSecurityUtils.getLoginUser().getWeixin().getRefreshToken();
        }else if(key.equals(TICKET)){
            value = getTicket();
        }else if(key.equals(OPENID)){
            value =  IJobSecurityUtils.getLoginUser().getWeixin().getOpenid();
        }
        return value;
    }

    /*private static  String getAccessToken(){
        String   value =  IJobSecurityUtils.getLoginUser().getWeixin().getAccessToken();
        if(StringUtils.isEmptyString(value)){
            value = getNewToken();
        }else{
            Date now = new Date();
            long time = now.getTime()-IJobSecurityUtils.getLoginUser().getWeixin().getAccessTokenTime().getTime();
            //大于7200重新刷新
            if(time>=7140*1000){
                value = getNewToken();
            }
        }
        return value;
    }*/
    private static  String getTicket(){
        String   value =  IJobSecurityUtils.getLoginUser().getWeixin().getTicket();
        if(StringUtils.isEmptyString(value)){
            value = getNewTicket();
        }else{
            Date now = new Date();
            long time =now.getTime()-IJobSecurityUtils.getLoginUser().getWeixin().getTicketTime().getTime();
            //大于7200重新刷新
            if(time>=7140*1000){
                value = getNewTicket();
            }
        }
        return value;
    }


    private static String  getNewToken(){
        String refresh_token = RedisUtil.getTokens(RedisUtil.REFRESHTOKEN);
        String url = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid="+ DictCacheService.AppID+"&grant_type=refresh_token&refresh_token="+refresh_token;
        Map<String,String> map =  HttpUtils.getWinxinResult(url);
        RedisUtil.set(RedisUtil.ACCESSTOKEN,map.get("access_token"));
        return map.get("access_token");
    }

    private static String  getNewTicket(){
        String ticket = "";
        String getTicketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + DictCacheService.getAccessToken() + "&type=jsapi";
        Map<String, String> resultMap = HttpUtils.getWinxinResult(getTicketUrl);
        if ("false".equals(resultMap.get("ok"))) {
            DictCacheService.refreshAccessToken();
            getTicketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + DictCacheService.getAccessToken() + "&type=jsapi";
            resultMap = HttpUtils.getWinxinResult(getTicketUrl);
        }
        ticket = resultMap.get("ticket");
        RedisUtil.set(RedisUtil.TICKET,ticket);
        return ticket;
    }

    public static <T extends Task> void pushTaskAndBroadcast( T task){
        redisUtil.redisService.pushTask(task);    //压进去信息
        broadcastTask(task.getClass().getSimpleName()); //广播任务信息，提醒他们干活
    }

    public static <T extends Task> Task popTask(String key,Class<T> clazz){
        return redisUtil.redisService.popTask(key,clazz);
    }
    public static <T extends Task> void pushTask( T task){
        //先检查队列服务是不是停止了
        if(RedisUtil.getStringValue("Heartbeat")!=null){
            redisUtil.redisService.pushTask(task);
        }else{
            ProcessAssistant.process(task);
        }
    }

    public static <T extends Object> List<T> list(String key ,Long start,Long end){
        return  (List<T>)redisUtil.redisService.lGet(key,start,end);
    }
    public static <T extends Object> List<T> list(String key){
        Long size = redisUtil.redisService.lGetListSize(key);
        return list(key,0L,size-1);
    }

    public static void lset(String key ,Object value){
        redisUtil.redisService.lSet(key,value);
    }

    public static <T extends Object> void lpush(String key ,List<T> list){
        redisUtil.redisService.lpush(key,list);
    }

    public static void mset(String key ,Map<Object,Object> map){
        redisUtil.redisService.hmset(key,map);
    }
    public static <T extends Object> Map<Object,T> mget(String key ){
        return (Map<Object,T>)redisUtil.redisService.hmget(key);
    }


    public static void broadcastTask(String taskName){
        redisUtil.redisService.broadcastTask("BroadcastTask",taskName);
    }

    public static String getAccessToken(){
        return redisUtil.redisService.getStringValue("AccessToken");
    }

    public static void set(String key,Object value){
        redisUtil.redisService.set(key,value);
    }

    public static void sendMessageTemplate(Message message){
        QueryParam queryParam  = new QueryParam();
        queryParam.put("userID",message.getUser().toString());
        try {
            Weixin weixin = redisUtil.weChatService.one(queryParam);
            if(weixin!=null){
                Map u =  redisUtil.hget("UserSimpleInfo",message.getUserID());
                redisUtil.messageTemplateService.ptYhzx(weixin.getOpenid(),u.get("realName").toString(), MessageType.getContent(message));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}

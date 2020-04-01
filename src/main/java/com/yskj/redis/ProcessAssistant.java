package com.yskj.redis;

import com.google.gson.Gson;
import com.yskj.redis.model.Task;
import com.yskj.service.base.DictCacheService;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author:Administrator
 * @create 2018-12-16 10:21
 */
public class ProcessAssistant {


    private static Map sendMessage(String param)throws Exception {
        String token = DictCacheService.getAccessToken();
        if(isNotEmptyString(token)){
            String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+ token;
            return new Gson().fromJson(post(url,param),HashMap.class);
        }else{
            DictCacheService.refreshAccessToken();
        }
        return null;
    }

    public static <T extends Task> void process(T templateTask){
        try{
           String template = templateTask.template();
            //先改变状态，然后发送消息
            templateTask.setStatus(1);
            Map result = sendMessage(template);
            if(result!=null&&result.get("errcode")!=null){
               /* if("ok".equals(result.get("errmsg").toString())){  //如果成功了怎么样
                    templateTask.setErrmsg(result.get("errmsg").toString());
                }else{ //如果不成功怎么样
                    if(result.get("errmsg").toString().startsWith("require subscribe hint")){
                    }else{
                    }
                }*/
            }else{
                templateTask.setTimes(templateTask.getTimes()+1);
                if(templateTask.getTimes()<3){
                    Thread.sleep(2000);//停两秒
                    RedisUtil.pushTask(templateTask);
                }
            }
            //processTasks(templateTask.getClass());
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static  <T extends Task> void processes(T templateTask){
        process(templateTask);
        processTasks(templateTask.getClass());
    }

    public static  void  processTasks (Class clazz){
        if(RedisUtil.getStringValue("Heartbeat")==null){  //如果没守护线程了，则直接用本机线程去处理
            Task task   = RedisUtil.popTask(clazz.getSimpleName(),clazz);
            if(task!=null){
                processes(task);
            }
        }
    }

    /**
     * 发送 post请求访问本地应用并根据传递参数不同返回不同结果
     */
    private static   String  post(String url,String xml) throws Exception {
        String result  = "";
        // 创建默认的httpClient实例.
        CloseableHttpClient httpclient = HttpClients.createDefault();
        // 创建httppost
        HttpPost httppost = new HttpPost(url);
        StringEntity requestEntity = new StringEntity(xml,"utf-8");
        requestEntity.setContentEncoding("UTF-8");
        httppost.setHeader("Content-type", "application/json");
        httppost.setEntity(requestEntity);
        try {
            CloseableHttpResponse response = httpclient.execute(httppost);
            try {
                HttpEntity entity = response.getEntity();
                if (entity != null) {
                    result = EntityUtils.toString(entity, "UTF-8");
                    Date now = new Date();
                    System.out.println((now.getMonth()+1)+"-"+now.getDate()+" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds()+" Response content:"+result);
                }
            } finally {
                response.close();
            }
        } catch (ClientProtocolException e) {
            e.printStackTrace();
            throw new Exception("客户端异常");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
            throw new Exception("编码异常");
        } catch (IOException e) {
            e.printStackTrace();
            throw new Exception("IO异常");
        } finally {
            // 关闭连接,释放资源
            try {
                httpclient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    private static Boolean isEmptyString(Object object){
        return (object==null||isEmpty(object.toString()));
    }

    private static Boolean isNotEmptyString(Object object){
        return !isEmptyString(object);
    }

    private static boolean isEmpty(CharSequence input) {
        if (input == null || "".equals(input)||"null".equals(input))
            return true;
        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            if (c != ' ' && c != '\t' && c != '\r' && c != '\n') {
                return false;
            }
        }
        return true;
    }
}

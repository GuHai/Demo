package demo;

import com.google.gson.Gson;
import com.yskj.models.Weixin;
import com.yskj.models.Wxorder;
import com.yskj.models.auth.User;
import com.yskj.service.WxorderService;
import com.yskj.utils.HttpUtils;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.MD5Tools;
import com.yskj.utils.SpringContextUtil;
import org.apache.shiro.SecurityUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

/**
 * 测试微信
 *
 * @author:Administrator
 * @create 2018-03-14 10:30
 */
//@RunWith(SpringJUnit4ClassRunner.class) // 整合
//@ContextConfiguration(locations={"classpath:/spring/*"}) // 加载配置
public class TestWeixin{

    @Autowired
    WxorderService wxorderService;
    @Test
    public void testGson(){
        String str = "{\"openid\":\"o56nM0qwFlJ8sG5LOlubnUb3ZR70\",\"privilege\":['a','b']}";
        System.out.println(str);
        // 编码后的json
        String json = null;
        try {
            json = new String(str.getBytes("ISO-8859-1"), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        System.out.println(json);
        Weixin weixin = new Gson().fromJson(json,Weixin.class);
        System.out.println(weixin);
    }

    @Test
    public void testHashMD5(){
        String ps = MD5Tools.getMD5Hash("o56nM0qwFlJ8sG5LOlubnUb3ZR70","chuang");
        System.out.println(ps);
    }

    @Test
    public void testRad(){
     /*   System.out.println(UUIDGenerator.randomUUID());

        String str = "B0000000001";
        str = str.substring(1);
        Long l = Long.parseLong(str);


        String str1 = "000000000"+l;
        System.out.println( str1.substring(str1.length()-10,str1.length()));*/

        String str = "{\"errcode\":0,\"errmsg\":\"invalid code\"}";
        Map<String,String> map =  new Gson().fromJson(str, HashMap.class);
        System.out.println(map);
        Object obj = map.get("errcode");
        System.out.println(obj.toString());

    }

    @Test
    public void testAddWeixin(){

       /* String type = "01";
        Wxorder order = new Wxorder();
        order.setCode(wxorderService.getNextCode(type));
        order.setDescription("测试微信支付");
        order.setName(wxorderService.getTypeName(type));
        order.setType(type);
        order.setUserID(IJobSecurityUtils.getLoginUserId());
        order.setStatus(1);
        try {
            wxorderService.add(order);
        } catch (Exception e) {
            e.printStackTrace();
        }*/
    }

    private void createSession(){
        User user = new User();
        user.setId("test");
    }

  /*  @Test
    public void refund(){

        String ids = "d196cb4489f14cb0b05a5a8345c57d7f";
        for(String id : ids.split("\n")){
            HttpUtils.get("http://www.jianzhipt.cn/api/WeixinController/refund?orderId="+id.trim());
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }*/

  /*  @Test
    public void refund(){

        String ids = "B20180625093252USDM6VNXX5JGNFKIN";
        for(String id : ids.split("\n")){
            HttpUtils.get("http://www.jianzhipt.cn/api/WeixinController/testOrderInfo/"+ids);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }*/


}
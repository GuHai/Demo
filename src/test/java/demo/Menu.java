package demo;

import com.yskj.utils.HttpUtils;
import org.junit.Test;

/**
 * 自定义菜单
 *
 * @author:Administrator
 * @create 2018-03-23 11:06
 */
public class Menu {
    @Test
    public void  createMenu()throws Exception{

        //https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wxdfd5dbfc4e2053b2&secret=318fe2ba67d6f40c9df24c33397742c3
//      阿里云的  String token = "8_FKGKp4BUq0vA686NW-7mKtdBiFRtAsE4omrmBPrudz0TaWX8f8A5Gu1XCEnR_zqyVzkr63AwuckRj5Ni1NoeYHJ7t53A9PDDBS1TqozQPzIEW0aeqFb_IafAXQTtO2kpUsZ7ua8cA4XPbGI-IRYiAEAVEL";
        /*String token = "1111_dIof5NtvnzVTTsdiv0F_jWVqNohBr7w7BQqaOXVpOKcqORY65Yf50mcXW8YnCr8upEiGbBzhm6lKj62pr8Rg9B7XDhB-PqnKh-GGAzcGUyVP4uGmFBqcKJvhILICDFaAJANOQ";
        String url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token="+token;
        String param = " {\n" +
                "     \"button\":[\n" +
                "      {    \n" +
                "          \"type\":\"view\",\n" +
                "          \"name\":\"找兼职\",\n" +
                "          \"url\":\"http://www.jianzhipt.com/api/WeixinController/checkOpenId?menu=findJob\"\n" +
                "      },{    \n" +
                "          \"type\":\"view\",\n" +
                "          \"name\":\"信息中心\",\n" +
                "          \"url\":\"http://www.jianzhipt.com/api/WeixinController/checkOpenId?menu=information\"\n" +
                "      },{    \n" +
                "          \"type\":\"view\",\n" +
                "          \"name\":\"个人中心\",\n" +
                "          \"url\":\"http://www.jianzhipt.com/api/WeixinController/checkOpenId?menu=personal\"\n" +
                "      }\n" +
                "    ]\n" +
                "}\n";
        String result =  HttpUtils.post(url,param);
        System.out.println(result);*/

        //测试：https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wxdfd5dbfc4e2053b2&secret=318fe2ba67d6f40c9df24c33397742c3
        //生产：https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx16b6988ce660defc&secret=97e4af3303001d5b6fda2ffc59642899
        //易职保生产：https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx1d7b145e2fefdb35&secret=20907059319cf7152ac77a1562eb6292
        //https://api.weixin.qq.com/cgi-bin/menu/get?access_token=14_ZhWLKVvaFeMrHzyGGBTYzRaiv3MFzFBkYwUqrtSrsSpA13r3KA_GyKjyrLf0dsqLOXjxfFe4sG2C0H5vKJpWg0rXFRaetQzWKwDwP5t1loMGpO3Qy33df_cUuT7dHZSG3bzhLjqH4eM2TdrVJDDhACAAUU
        String token = "24_W3h5XxExX6A4rlaRPUmQ98Q4eIXPdRpmukLbXIwqNcedE6wXoonundLUdxg3eG_b_giOzDbIXZiduHdYO5-0BSVTLWHhuXiA-JhvBlsPBuZND77VrqE9k9YpXXbPwYkjGd8fs0z8M8jhx0S5QHKcACAMDG";
        String url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token="+token;
       /* String param = " {\n" +
                "     \"button\":[\n" +
                "      {    \n" +
                "          \"type\":\"view\",\n" +
                "          \"name\":\"我的保险\",\n" +
                "          \"url\":\"https://www.jianzhipt.cn/ins/login\"\n" +
                "      },"+
                "      {    \n" +
                "          \"type\":\"view\",\n" +
                "          \"name\":\"App下载\",\n" +
                "          \"url\":\"https://www.jianzhipt.cn/ins/download/app\"\n" +
                "      }"+
                "    ]\n" +
                "}\n";*/

        String param = " {\n" +
                "     \"button\":[\n" +
                "      {    \n" +
                "          \"type\":\"view\",\n" +
                "          \"name\":\"找兼职\",\n" +
                "          \"url\":\"https://www.jianzhipt.cn/ijob/api/WeixinController/checkOpenId?menu=findJob&type=QZ\"\n" +
                "      },{    \n" +
                "          \"type\":\"view\",\n" +
                "          \"name\":\"招兼职\",\n" +
                "          \"url\":\"https://www.jianzhipt.cn/ijob/api/WeixinController/checkOpenId?menu=findJob&type=ZP\"\n" +
                "      },{    \n" +
                "          \"type\":\"view\",\n" +
                "          \"name\":\"保险\",\n" +
                "          \"url\":\"https://www.jianzhipt.cn/ins\"\n" +
                "      }\n" +
                "    ]\n" +
                "}\n";
        String result =  HttpUtils.post(url,param);
        System.out.println(result);

    }
}

package com.yskj.controller.base;

import com.google.gson.Gson;
import com.yskj.controller.AdverController;
import com.yskj.models.WeixinParam;
import com.yskj.service.base.DictCacheService;
import com.yskj.utils.HttpUtils;
import com.yskj.utils.SignUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * 微信公众号接口
 *
 * @author:Administrator
 * @create 2018-01-25 16:58
 */
@Controller
@RequestMapping("/weixinController")
public class WeixinController {

    private final static Logger logger = LoggerFactory.getLogger(AdverController.class);

    private static String APPID = "wx16b6988ce660defc";
    private static String SCOPE = "snsapi_userinfo";//应用授权作用域，snsapi_base （不弹出授权页面，直接跳转，只能获取用户openid），snsapi_userinfo （弹出授权页面，可通过openid拿到昵称、性别、所在地。并且， 即使在未关注的情况下，只要用户授权，也能获取其信息 ）
    private static String REDIRECT_URI = DictCacheService.Site+"/authCallback";
    private static String STATE = "ijob";
    private static String APPSECRET  = "97e4af3303001d5b6fda2ffc59642899";

    /**
     * 系统调用微信的接口
     * @param url
     * @return Result
     */
    public void feedback(String url){

        String jsonStr = HttpUtils.get(url);
        WeixinParam weixinParam = new Gson().fromJson(jsonStr,WeixinParam.class);
        System.out.println(weixinParam);

    }




    @RequestMapping(value = "/toLogin", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public void toLogin(){


        //String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+APPID+"&redirect_uri=REDIRECT_URI&response_type=code&scope="+SCOPE+"&state=STATE#wechat_redirect";

    }



    /**
     * 查询页面 校验token
     * @param
     * @return Result
     */
    @RequestMapping(value = "/checkToken", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public void checkToken(HttpServletRequest request, HttpServletResponse response) {
        // 微信加密签名
        String signature = request.getParameter("signature");
        // 时间戳
        String timestamp = request.getParameter("timestamp");
        // 随机数
        String nonce = request.getParameter("nonce");
        // 随机字符串
        String echostr = request.getParameter("echostr");

        PrintWriter out = null;
        try{
            out = response.getWriter();
            // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
            if (SignUtils.check(signature, timestamp, nonce,"hnyskj")) {
                out.print(echostr);
            }
            out.close();
            out = null;
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            out.close();
            out = null;
        }
    }


    //信息打印：c70f5e56541e494e234b47c9c561baa1174da9fb      1516957992      1266004740      3940284024054872573
    @RequestMapping(value = "/testCheckToken", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public void testCheckToken(HttpServletRequest request, HttpServletResponse response)throws  Exception {
        String signature = "c70f5e56541e494e234b47c9c561baa1174da9fb";
        // 时间戳
        String timestamp = "1516957992";
        // 随机数
        String nonce = "1266004740";
        // 随机字符串
        String echostr = "3940284024054872573";
        PrintWriter out = response.getWriter();
        // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
        if (SignUtils.check(signature, timestamp, nonce,"hnyskj")) {
            System.out.println("校验成功了");
            out.print(echostr);
        }
        out.close();
        out = null;
    }
}

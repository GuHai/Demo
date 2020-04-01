package com.yskj.api;

import com.yskj.utils.SignUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * @author:Administrator
 * @create 2019-01-16 10:44
 */

@Controller
@RequestMapping(value = "/api/JobCloudController")
public class JobCloudController {
    //关注
    @RequestMapping(value = "/follow", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public void  follow(HttpServletRequest request, HttpServletResponse response){
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
            if (SignUtils.check(signature, timestamp, nonce,"hnqzykj")) {
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
}

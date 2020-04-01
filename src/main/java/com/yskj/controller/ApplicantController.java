package com.yskj.controller;

import com.yskj.models.Applicant;
import com.yskj.models.ResponseObj;
import com.yskj.service.ApplicantService;
import com.yskj.utils.GsonUtils;
import com.yskj.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 用户控制层
 *
 * @author zhouchuang
 * @create 2018-01-15 17:35
 */

@Controller
@RequestMapping("/applicantAction")
public class ApplicantController {
    @Autowired
    private ApplicantService applicantService;    //自动载入Service对象

    private ResponseObj responseObj;
    private final static Logger logger = LoggerFactory.getLogger(ApplicantController.class);
    /**
     * 为什么返回值是一个ModelAndView，ModelAndView代表一个web页面<br/>
     * setViewName是设置一个jsp页面的名称
     *
     * @param req  http请求
     * @param user 发起请求后，spring接收到请求，然后封装的bean数据
     * @return 返回一个web页面
     * @throws Exception
     */
    @RequestMapping(value = "/reg", method = RequestMethod.POST)
    public ModelAndView reg(HttpServletRequest req, Applicant user) throws Exception {
       ModelAndView mav = new ModelAndView();  //创建一个jsp页面对象
        /* mav.setViewName("home");    //设置JSP文件名
        if (null == user) {
            mav.addObject("message", "用户信息不能为空！");  //加入提示信息
            return mav; //返回页面
        }
        if (StringUtils.isEmpty(user.getLoginId()) || StringUtils.isEmpty(user.getPwd())) {
            mav.addObject("message", "用户名或密码不能为空！");
            return mav;
        }
        if (null != applicantService.findA(user)) {
            mav.addObject("message", "用户已经存在！");
            return mav;
        }
        try {
            applicantService.add(user);
        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("message", "错误：用户其他信息错误");
            return mav;
        }
        mav.addObject("code", 110);
        mav.addObject("message", "恭喜。注册成功");
        req.getSession().setAttribute("user", user);*/
        return mav;
    }

    /**
     * 登录接口
     *
     * @param req
     * @param user
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST, produces = {
            "application/json; charset=utf-8"})
    @ResponseBody
    public Object login(HttpServletRequest req, HttpServletRequest request, Applicant user, HttpSession session) {
//        ModelAndView mav = new ModelAndView("login");
        String result;
        if (null == user) {
            responseObj = new ResponseObj<Applicant>();
            responseObj.setCode(ResponseObj.EMPUTY);
            responseObj.setMsg("登录信息不能为空");
            result = GsonUtils.gson.toJson(responseObj);
            return result; //返回页面
        }
        if (StringUtils.isEmpty(user.getLoginId()) || StringUtils.isEmpty(user.getPwd())) {
            responseObj = new ResponseObj<Applicant>();
            responseObj.setCode(ResponseObj.FAILED);
            responseObj.setMsg("用户名或密码不能为空");
            result = GsonUtils.gson.toJson(responseObj);
            return result;
        }
        //查找用户
        Applicant user1 = null;//userService.findUser(user);
        if (null == user1) {
            responseObj = new ResponseObj<Applicant>();
            responseObj.setCode(ResponseObj.EMPUTY);
            responseObj.setMsg("未找到该用户");
            result = GsonUtils.gson.toJson(responseObj);
        } else {
            if (user.getPwd().equals(user1.getPwd())) {
                user.setNextUrl(request.getContextPath() + "/home");
                responseObj = new ResponseObj<Applicant>();
                responseObj.setCode(ResponseObj.OK);
                responseObj.setMsg(ResponseObj.OK_STR);
                responseObj.setData(user);
                session.setAttribute("userInfo", user);
                result = GsonUtils.gson.toJson(responseObj);
                logger.info(user.getLoginId()+"登录成功了");
            } else {
                responseObj = new ResponseObj<Applicant>();
                responseObj.setCode(ResponseObj.FAILED);
                responseObj.setMsg("用户密码错误");
                result = GsonUtils.gson.toJson(responseObj);
                logger.info(user.getLoginId()+"密码错误，登录失败了");
            }
        }
        return result;
    }

}

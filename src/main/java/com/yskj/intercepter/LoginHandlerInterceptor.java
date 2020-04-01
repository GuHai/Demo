package com.yskj.intercepter;
;
import com.yskj.utils.IJobUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录拦截器
 *
 * @author zhouchuang
 * @create 2018-01-15 22:46
 */
public class LoginHandlerInterceptor extends HandlerInterceptorAdapter {
    String NO_INTERCEPTOR_PATH = ".*/((login)|(signup)|(register)|(logout)|(code)|(app)|(weixin)|(static)|(main)|(websocket)).*";    //不对匹配该值的访问路径拦截（正则）

    private final static Logger logger = LoggerFactory.getLogger(LoginHandlerInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // TODO Auto-generated method stub
       /* String path = request.getServletPath();
        if (path.matches(NO_INTERCEPTOR_PATH)) {    //匹配正则表达式的不拦截
            return true;
        } else {    //不匹配的进行处理
            try {
                if (request.getSession().getAttribute("userInfo") == null) { //session中是否存在用户信息，不存在则是未登录状态
                    response.sendRedirect(request.getContextPath() + "/login");
                    return false;
                }
            } catch (IOException e) {
                response.sendRedirect(request.getContextPath() + "/login");
                e.printStackTrace();
                return false;
            }
            return true;
        }*/






      /* if(IJobSecurityUtils.getLoginUser()!=null){
           //如果登录还访问登录页面，则跳转到indexMain页面
           if(request.getServletPath().equals("/")){
               response.sendRedirect(request.getContextPath() + "/indexMain");
               return false;
           }else if(request.getServletPath().contains("/loginMain")){
               response.sendRedirect(request.getContextPath() + "/indexMain");
               return false;
           }else if(request.getServletPath().contains("toLogin")){
               response.sendRedirect(request.getContextPath() + "/indexMain");
               return false;
           }
       }else{
           if(request.getServletPath().contains("indexMain")){
               response.sendRedirect(request.getContextPath() + "/loginMain");
               return false;
           }
       }*/

        if(!request.getServletPath().startsWith("/static"))
            logger.info("ip:"+ IJobUtils.getIpAddress(request)+"============url:"+request.getServletPath());
        if(request.getServletPath().equals("/")){
            response.sendRedirect(request.getContextPath() + "/indexMain");
            return false;
        }
       return true;
    }
}

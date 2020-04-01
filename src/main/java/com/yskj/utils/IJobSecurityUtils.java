package com.yskj.utils;

import com.yskj.models.auth.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;

/**
 * iJob平台的安全工具类
 *
 * @author:Administrator
 * @create 2018-01-23 13:03
 */
public class IJobSecurityUtils extends SecurityUtils {
    private final static org.slf4j.Logger logger = LoggerFactory.getLogger(IJobSecurityUtils.class);

    public static String getLoginUserId(){
        try{
            return getLoginUser().getId();
        }catch (NullPointerException e ){
            return "system";
        }catch (Exception e){
            return "system";
        }

    }

    //获取当前角色
    public static Integer getEmployerRole(){
        try{
            return getLoginUser().getInformation().getIdentityType();
        }catch (NullPointerException e){
            return 0;
        }
    }

    //获取登录ID
    public static  User getLoginUser(){
        try{
            Object subject = SecurityUtils.getSubject().getPrincipal();
            if(subject!=null){
                return (User)subject;
            }
        }catch (Exception e){
            logger.error("找不到登录权限");
        }
        return null;
    }

    public static Session getSession(){
        return SecurityUtils.getSubject().getSession();
    }
    public static void updateUser(User user){
        User oldUser = getLoginUser();
        for(Field field : oldUser.getClass().getDeclaredFields()){
            try {
                field.setAccessible(true);
                if(field.get(user)!=null){
                    field.set(oldUser,field.get(user));
                }
            } catch (IllegalAccessException e) {
                logger.error(e.getMessage());
            }
        }
        for(Field field : oldUser.getClass().getSuperclass().getDeclaredFields()){
            try {
                field.setAccessible(true);
                if(field.get(user)!=null){
                    field.set(oldUser,field.get(user));
                }
            } catch (IllegalAccessException e) {
                logger.error(e.getMessage());
            }
        }
    }
}

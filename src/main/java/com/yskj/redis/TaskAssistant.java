package com.yskj.redis;

import com.google.gson.Gson;
import com.yskj.exception.IJobException;
import com.yskj.redis.model.Task;
import com.yskj.service.TemplateTaskService;
import com.yskj.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.PostConstruct;

/**
 * 抽象任务层
 *
 * @author:Administrator
 * @create 2018-12-14 11:35
 */
public class TaskAssistant {

    public    static String TaskTemplate = "{\n" +
            "           \"touser\":\"${openID}\",\n" +
            "           \"template_id\":\"${templateID}\",\n" +
            "           \"url\":\"${url}\",  \n" +
            "           \"miniprogram\":{\n" +
            "             \"appid\":\"\",\n" +
            "             \"pagepath\":\"\"\n" +
            "           },          \n" +
            "           \"data\":${data}\n" +
            "       }";


    @Autowired
    private TemplateTaskService templateTaskService;
    private static TaskAssistant taskUtil ;
    @PostConstruct
    public void init() {
        taskUtil = this;
        taskUtil.templateTaskService = this.templateTaskService;

    }

    public static TemplateTaskService getTemplateTaskService() {
        return taskUtil.templateTaskService;
    }

    private static  <T extends Task> T parse(String gson, Class<T> clazz)throws Exception{
        if(StringUtils.isEmptyString(gson)){
            throw  new IJobException("参数为空");
        }else{
            return new Gson().fromJson(gson,clazz);
        }
    }

    public  static <T extends Task> T process(String gson,String className)throws Exception{
        Class clazz = Class.forName(className);
        T task = (T)parse(gson,clazz);
//        task.process();
        return task ;
    }


}

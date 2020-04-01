package com.yskj.redis.model;

import com.yskj.redis.TaskAssistant;
import lombok.Data;

import java.io.Serializable;
import java.util.Map;

/**
 * 任务容器
 *
 * @author:Administrator
 * @create 2018-12-14 16:16
 */
@Data
public class TemplateTaskPanel extends Task {
    private String openID;
    private String data;
    private String url;
    private String templateID;

    @Override
    public String template() {
        return   TaskAssistant.TaskTemplate.replace("${openID}",this.getOpenID())
                .replace("${templateID}",this.templateID)
                .replace("${url}",this.url)
                .replace("${data}",this.data);

    }
}

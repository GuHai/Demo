package com.yskj.redis.model;

import lombok.Data;

import java.io.Serializable;

/**
 * task接口
 *
 * @author:Administrator
 * @create 2018-12-14 14:33
 */
@Data
public abstract class Task implements Serializable {
    private Integer status;  //0未发送 1发送 2接受到反馈
    private String errmsg;
    private Integer times = 1;
    public abstract String template();
}

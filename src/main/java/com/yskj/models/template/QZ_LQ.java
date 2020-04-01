package com.yskj.models.template;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2018-07-03 11:31
 */
/* 任务名称：{{keyword1.DATA}}
 工资待遇：{{keyword2.DATA}}
 工作日期：{{keyword3.DATA}}
 工作地点：{{keyword4.DATA}}
 联系方式：{{keyword5.DATA}}*/
@Data
public class QZ_LQ {
    private String s0jobName;
    private String s1salary;
    private String s2date;
    private String s3address;
    private String s4telphone;
}

package com.yskj.models.template;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2018-07-03 11:31
 */
/* 兼职名称：{{keyword1.DATA}}
 职务：{{keyword2.DATA}}
 报名时间：{{keyword3.DATA}}*/
@Data
public class QZ_WLQ {
    private String s0jobName;
    private String s1duty;
    private String s2date;
}

package com.yskj.models.template;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2018-07-03 11:35
 */
/* 客户名称：{{keyword1.DATA}}
 款项名称：{{keyword2.DATA}}
 预计到款时间：{{keyword3.DATA}}*/
@Data
public class ZP_CJS {
    private String s0name;
    private String s1jobName;
    private String s2date;
}

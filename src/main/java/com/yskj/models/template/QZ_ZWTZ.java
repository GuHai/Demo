package com.yskj.models.template;

import lombok.Data;

/**
 * 职位通知
 *
 * @author:Administrator
 * @create 2018-07-29 15:58
 */


/*
公司名称：{{keyword1.DATA}}
职位名称：{{keyword2.DATA}}
职位类别：{{keyword3.DATA}}
工作地点：{{keyword4.DATA}}
薪　　资：{{keyword5.DATA}}*/


@Data
public class QZ_ZWTZ {
    private String s0compname;
    private String s1position;
    private String s2type;
    private String s3addr;
    private String s4salary;
}

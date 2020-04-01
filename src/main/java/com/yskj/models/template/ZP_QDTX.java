package com.yskj.models.template;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2018-07-03 11:35
 */


/* 企业名称：{{keyword1.DATA}}
 职位名称：{{keyword2.DATA}}
 工作地点：{{keyword3.DATA}}
 联系电话：{{keyword4.DATA}}
 签到时间：{{keyword5.DATA}}*/
@Data
public class ZP_QDTX {
    private String s0industryName;
    private String s1duty;
    private String s2address;
    private String s3telphone;
    private String s4date;
}

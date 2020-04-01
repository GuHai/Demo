package com.yskj.models.template;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2018-07-03 11:35
 */
/* 岗位名称：{{keyword1.DATA}}
 总金额：{{keyword2.DATA}}
 状态：{{keyword3.DATA}}*/

@Data
public class QZ_GZFF {
    private String s0jobName;
    private String s1salary;
    private String s2state;
}

package com.yskj.models.template;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2019-01-24 10:31
 */



//咨询用户：{{keyword1.DATA}}
//        咨询时间：{{keyword2.DATA}}
//        咨询内容：{{keyword3.DATA}}
@Data
public class PT_YHZX {
    private String s0name;
    private String s1date;
    private String s2content;
}

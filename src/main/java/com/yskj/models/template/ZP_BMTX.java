package com.yskj.models.template;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2018-07-03 11:35
 */

/*姓名：{{keyword1.DATA}}
联系方式：{{keyword2.DATA}}
类别：{{keyword3.DATA}}*/
@Data
public class ZP_BMTX {
    private String s0name;
    private String s1telphone;
    private String s2type;
}

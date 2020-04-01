package com.yskj.models.template;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2018-07-03 11:31
 */

/*兼职名称：{{keyword1.DATA}}
集合时间：{{keyword2.DATA}}
集合地点：{{keyword3.DATA}}
联系电话：{{keyword4.DATA}}*/
@Data
public class QZ_MRGZ {
    private String s0title;
    private String s1settledate;
    private String s2settleaddr;
    private String s3phone;
}

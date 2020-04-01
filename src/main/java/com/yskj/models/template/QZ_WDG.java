package com.yskj.models.template;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2018-07-05 16:26
 */

/*职位：{{keyword1.DATA}}
工作时间：{{keyword2.DATA}}
工作地点：{{keyword3.DATA}}*/
@Data
public class QZ_WDG {
    private String s0position;
    private String s1date;
    private String s2addr;
}

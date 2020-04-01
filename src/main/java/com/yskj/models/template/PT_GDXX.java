package com.yskj.models.template;

import lombok.Data;

/**
 * 工单消息提醒
 *
 * @author:Administrator
 * @create 2018-10-17 11:18
 */


/*{{first.DATA}}
工单编号：{{keyword1.DATA}}
工单标题：{{keyword2.DATA}}
时间：{{keyword3.DATA}}
{{remark.DATA}}*/

@Data
public class PT_GDXX {
    private String s0code;
    private String s1title;
    private String s2date;
}

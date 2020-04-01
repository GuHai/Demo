package com.yskj.models.template;

import lombok.Data;

/**
 * 审核结果通知
 *
 * @author:Administrator
 * @create 2018-10-25 14:50
 */

/*审核内容：{{keyword1.DATA}}
失败原因：{{keyword2.DATA}}*/
@Data
public class PT_SHTZ {
    private String s0title;
    private String s1errmsg;
}

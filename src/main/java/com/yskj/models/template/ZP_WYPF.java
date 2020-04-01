package com.yskj.models.template;

import lombok.Data;

/**
 * 违约赔付
 *
 * @author:Administrator
 * @create 2018-10-10 10:46
 */


/*{{first.DATA}}
交易时间：{{keyword1.DATA}}
交易金额：{{keyword2.DATA}}
订单编号：{{keyword3.DATA}}
{{remark.DATA}}*/
@Data
public class ZP_WYPF{
    private String s0date;
    private String s1money;
    private String s2code;
}

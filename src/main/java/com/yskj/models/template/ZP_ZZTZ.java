package com.yskj.models.template;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2018-12-22 10:29
 */

/*{{first.DATA}}
收款人：{{keyword1.DATA}}
付款方：{{keyword2.DATA}}
金额：{{keyword3.DATA}}
时间：{{keyword4.DATA}}
{{remark.DATA}}*/
@Data
public class ZP_ZZTZ {
    private String s0payee;
    private String s1remitter;
    private String s2money;
    private String s3date;
}

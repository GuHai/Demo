package com.yskj.models.template;

import lombok.Data;

/**
 * 提现申请通知
 *
 * @author:Administrator
 * @create 2018-07-16 15:52
 */
/*
用户昵称：{{keyword1.DATA}}
手机号码：{{keyword2.DATA}}
提款金额：{{keyword3.DATA}}
时间：{{keyword4.DATA}}*/
@Data
public class PT_TXTZ {
    private String s0nikeName;
    private String s1phoneNo;
    private String s2money;
    private String s3date;

}

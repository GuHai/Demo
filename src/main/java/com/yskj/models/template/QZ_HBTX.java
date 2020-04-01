package com.yskj.models.template;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2018-07-05 16:26
 */

/*推荐奖励金额：{{keyword1.DATA}}
奖励到账时间：{{keyword2.DATA}}*/
@Data
public class QZ_HBTX {
    private String  s0amountMoney;
    private String  s1paymentDate;
}

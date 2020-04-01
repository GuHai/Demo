package com.yskj.models.excel;

import com.yskj.utils.excel.ExcelAssistant;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author:Administrator
 * @create 2019-05-12 18:04
 */
@Data
public class PersonMoney {
    @ExcelAssistant(titleName = "姓名",width = 2000)
    private String name;
    @ExcelAssistant(titleName = "身份证",width = 5000)
    private String idCard;
    @ExcelAssistant(titleName = "电话",width = 5000)
    private String phoneNo;
    @ExcelAssistant(titleName = "工资",width = 2000)
    private BigDecimal money;
    @ExcelAssistant(titleName = "4月份充值实际划入",width = 4000)
    private BigDecimal realMoney;
    @ExcelAssistant(titleName = "工资发放日期",width = 3000)
    private Date date;
    @ExcelAssistant(titleName = "订单号",width = 6000)
    private String order;
    @ExcelAssistant(titleName = "资金出处",width = 3000)
    private String out;
}

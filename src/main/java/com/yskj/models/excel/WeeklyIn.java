package com.yskj.models.excel;

import com.yskj.utils.excel.ExcelAssistant;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 入账周报表
 *
 * @author:Administrator
 * @create 2018-08-08 9:56
 */
@Data
public class WeeklyIn {
    //业务单号
    @ExcelAssistant(titleName = "业务单号",width = 5000)
    private String code;
    @ExcelAssistant(titleName = "姓名",width = 2000)
    private String name;
    @ExcelAssistant(titleName = "电话",width = 3000)
    private String phone;
    @ExcelAssistant(titleName = "金额")
    private BigDecimal money;
    @ExcelAssistant(titleName = "类型")
    private String type;
    @ExcelAssistant(titleName = "备注")
    private String mark;
    @ExcelAssistant(titleName = "时间")
    private Date time;

    private String accID;
}

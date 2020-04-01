package com.yskj.models.excel;

import com.yskj.utils.excel.ExcelAssistant;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 薪资
 *
 * @author:Administrator
 * @create 2018-11-28 11:29
 */
@Data
public class Salary {
    //业务单号
    @ExcelAssistant(titleName = "姓名",width = 2000)
    private String realName;

    @ExcelAssistant(titleName = "身份证",width = 5000)
    private String personIDCard;

    @ExcelAssistant(titleName = "电话",width = 5000)
    private String personPhoneNumber;

    @ExcelAssistant(titleName = "薪资",width = 2000,showPercentile=true)
    private String salary;

    private Integer version;

    private String id;

    private String scanID;

    private BigDecimal sxf;

    private String title;

    private Boolean status;


}

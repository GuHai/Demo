package com.yskj.models.excel;

import com.yskj.utils.excel.ExcelAssistant;
import lombok.Data;

@Data
public class PayInfo {

    @ExcelAssistant(titleName = "姓名",width = 2000)
    private String realName ;

    @ExcelAssistant(titleName = "手机号码",width = 5000)
    private String phoneNumber ;

    @ExcelAssistant(titleName = "身份证号码",width = 5000)
    private String personIDCard ;

    @ExcelAssistant(titleName = "状态",width = 3000)
    private String status ;

    @ExcelAssistant(titleName = "支付时间",width = 3000)
    private String time ;

    @ExcelAssistant(titleName = "薪资",width = 3000)
    private String salary ;

    private String id;

}

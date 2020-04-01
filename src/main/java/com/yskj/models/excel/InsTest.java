package com.yskj.models.excel;

import com.yskj.utils.excel.ExcelAssistant;
import lombok.Data;

import java.util.Date;

/**
 * @author:Administrator
 * @create 2019-01-18 16:01
 */
@Data
public class InsTest {

    @ExcelAssistant(titleName = "投保人姓名",width = 2000)
    private String name ;
    @ExcelAssistant(titleName = "投保人身份证",width = 4000)
    private String cardID ;
    @ExcelAssistant(titleName = "投保人职业",width = 4000)
    private String professor ;
    @ExcelAssistant(titleName = "企业名称",width = 4000)
    private String enterprise;
    @ExcelAssistant(titleName = "参保时间（天）",width = 4000)
    private Date date;

    @ExcelAssistant(titleName = "参保类型",width = 3000)
    private String type;

    @ExcelAssistant(titleName = "性别",width = 500)
    private String sex;

    @ExcelAssistant(titleName = "年龄",width = 1000)
    private Integer age;

}

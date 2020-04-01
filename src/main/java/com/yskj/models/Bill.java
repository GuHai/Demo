package com.yskj.models;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 账单详情
 *
 * @author:Administrator
 * @create 2018-04-02 16:06
 */
@Data
public class Bill {
    private String name;
    private String code;
    private String type;
    private Date payTime;
    private Date submitTime;
    private Date ensureTime;
    private Date arrival;
    private BigDecimal money;
    private Integer status =1; //1 2 3  已提交，已审批 ，已退回
    private Boolean isReturn;
    private String mark;
    private String cpename;
}

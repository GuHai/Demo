package com.yskj.models;import lombok.Data;import java.math.BigDecimal;import java.util.Date;//表名称 logonlog@Datapublic class Logonlog extends BaseEntity {	private static final long serialVersionUID = 1L;	public Logonlog() {		super();	}	    //登陆人(关联User表主键)    private String userID;    //时间    private Date loginTime;    //登陆地址（关联地址表主键）    private String loginAddress;    //经度    private BigDecimal longitude;    //纬度    private BigDecimal latitude;}
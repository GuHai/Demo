package com.yskj.models;import lombok.Data;import java.math.BigDecimal;//表名称 mylocaltion@Datapublic class Mylocaltion extends BaseEntity {	private static final long serialVersionUID = 1L;	public Mylocaltion() {		super();	}	    //关联用户ID    private String userID;    //经度    private BigDecimal lng;    //纬度    private BigDecimal lat;    //城市id    private String cityID;    //详细地址    private String addr;    //当前定位的地址，比市小一级或者平级    private String districtID;    //区域名称    private String districtName;    //城市名称    private String cityName;}
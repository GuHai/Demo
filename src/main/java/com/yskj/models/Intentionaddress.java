package com.yskj.models;import com.yskj.aop.MapIdentification;import lombok.Data;import java.util.Date;//表名称 intentionaddress@Datapublic class Intentionaddress extends BaseEntity {	private static final long serialVersionUID = 1L;	public Intentionaddress() {		super();	}	    //所属用户（关联用户表主键）    private String userID;    //意向地区（关联城市表编号）    private String cityID;    @MapIdentification(column = "cityID")    private City city;}
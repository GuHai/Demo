package com.yskj.models;import lombok.Data;import java.util.Date;//表名称 jointable@Datapublic class Jointable extends BaseEntity {	private static final long serialVersionUID = 1L;	public Jointable() {		super();	}	    //姓名    private String name;    //联系电话    private String phoneNumber;    //代理类型(1,省代理;2,市代理;3,区/县代理;4,校园代理)    private Integer joinType;    //地区    private String region;    //说明    private String explain;}
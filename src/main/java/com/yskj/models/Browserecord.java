package com.yskj.models;import lombok.Data;import java.util.Date;//表名称 browserecord@Datapublic class Browserecord extends BaseEntity {	private static final long serialVersionUID = 1L;	public Browserecord() {		super();	}	    //浏览人（关联用户表主键）    private String userID;    //浏览类别（0，简历;1，职位）    private Integer browseType;    //浏览时间    private Date browseTime;    //停留时间    private Integer sleepTime;    //浏览地址    private String browseAddress;    //    private String browseID;}
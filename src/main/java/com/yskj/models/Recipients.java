package com.yskj.models;import com.yskj.models.auth.User;import lombok.Data;//表名称 recipients@Datapublic class Recipients extends BaseEntity {	private static final long serialVersionUID = 1L;	public Recipients() {		super();	}	    //电话号码    private String phoneNumber;    //地址ID    private String localtion;    //详细地址    private String detail;    //    private String userID;    //收件人    private String name ;    private User user ;}
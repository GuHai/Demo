package com.yskj.models;import lombok.Data;//表名称 usershare@Datapublic class UserShare extends BaseEntity {	private static final long serialVersionUID = 1L;	public UserShare() {		super();	}	    //分享人    private String userID;    //关联编号    private String positionID;    //类型(1,关联编号代表转发表主键,2,代表职位表主键。)    private Integer type;}
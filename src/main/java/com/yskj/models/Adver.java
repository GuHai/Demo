package com.yskj.models;import lombok.Data;import java.util.Date;//表名称 adver@Datapublic class Adver extends BaseEntity {	private static final long serialVersionUID = 1L;	public Adver() {		super();	}	    //地区编号(关联城市信息表主键)    private String cityID;    //开始日期    private Date startTime;    //结束日期    private Date endTime;    //位置标识    private Integer position;    //图片地址    private String imgUrl;    //连接地址    private String connectionUrl;    //状态（1，下架;2未下架）    private Boolean adverState;    //描述    private String description;    //优先级    private Boolean sort;    //停留时间(m秒)    private Integer sleep;}
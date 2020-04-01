package com.yskj.models;import com.yskj.aop.StorageChild;import lombok.Data;import java.util.Date;//表名称 post_recommend_broker@Datapublic class PostRecommendBroker extends BaseEntity {	private static final long serialVersionUID = 1L;	public PostRecommendBroker() {		super();	}	    //经济人ID    private String brokerID;    //职位ID    private String postID;    //状态 1推荐/报名 2面试 3待入职 4入职 5离职 9不合适    private Integer status;    //入职时间    private Date entry;    //离职时间    private Date quit;    //全职人员ID 关联Recommend 表的主键    private String recommendID ;    @StorageChild(refColumn = "recommendID",service = "recommendService")    private Recommend recommend ;    @StorageChild(refColumn = "postID")    private Post post ;    @StorageChild(refColumn = "brokerID")    private Broker broker ;    private String setBrokerIDNull ;    //是否对该职位感兴趣    private Integer isLike ;    private Resume resume ;}
package com.yskj.models;import lombok.Data;import java.math.BigDecimal;//表名称 partnerrebate@Datapublic class PartnerRebate extends BaseEntity {	private static final long serialVersionUID = 1L;	public PartnerRebate() {		super();	}	    //    private String userID;    //奖励了多少钱    private BigDecimal fee;    //通过你的账号注册成为的合伙人    private String shareUserID;    //当前分享的你的合伙人级别    private Integer upartID;    //    private String remarks;    //别人购买的合伙人种类    private String partID;    //第几层分销    private Integer layer;    private String orderNumber;    //个数    private Integer num;    //总额    private BigDecimal total;    private Integer tj;    private Integer tg;    private Integer td;    private String nickName;}
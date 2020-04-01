package com.yskj.models;import com.yskj.models.auth.User;import lombok.Data;import java.math.BigDecimal;import java.util.Date;//表名称 withdrawals@Datapublic class Withdrawals extends BaseEntity {	private static final long serialVersionUID = 1L;	public Withdrawals() {		super();	}	    //订单编号    private String settlementOrderNumber;    //金额    private BigDecimal price;    //备注    private String remarks;    //状态(1,处理中;2,已发放;3,拒绝;)    private Integer settlementState;    //提现人员（关联用户表主键）    private String presentParty;    //审核人员(关联用户表)    private String auditor;    //审核备注    private String reviewNotes;    //发起时间    private Date launchTime;    //放款时间    private Date lendingTime;    //审核时间    private Date auditTime;    //发放时间    private Date releaseTime;    //第三方状态(1,成功;0,不成功)    private Boolean thirdState;    //第三方订单编号    private String thirdOrderNumber;    //异常说明    private String errorsDesc;    //收款方帐号    private String receivableAccount;    private User user;}
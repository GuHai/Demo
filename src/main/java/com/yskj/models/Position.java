package com.yskj.models;import com.yskj.aop.StorageChild;import com.yskj.models.auth.User;import com.yskj.service.base.DictCacheService;import jdk.nashorn.internal.ir.annotations.Ignore;import lombok.Data;import java.math.BigDecimal;import java.util.Date;import java.util.List;import java.util.Map;//表名称 position@Datapublic class Position extends BaseEntity {	private static final long serialVersionUID = 1L;	public Position() {		super();	}	    //标题    private String title;    //薪资类型（1,元/小时;2，元/天;3,元/周;4,元/月）    private Integer salaryType;    //招聘开始时间    private Date recruitStartTime;    //招聘结束时间    private Date recruitEndTime;    //薪资待遇    private BigDecimal salary;    //日薪资    private BigDecimal dailySalary;    //违约金    private BigDecimal liquidatedDamages;    //招聘人数    private Integer recruitsSum;    //性别要求  3女 1男 2男女不限    private Integer sexRequirements;    //工作地址（关联地址信息表）    private String workPalce;    //工作日期（数据格式：年[月[日、日]]）    private String workDate;    //集合地址（关联地址信息表）    private String aggregate;    //集合日期    private Date setDate;    //集合日期字符串    @Ignore    private String setDateStr ;    //联系人    private String contacts;    //联系电话    private String contactNumber;    //结算方式(1,日结;2,周结;3,月结;4,完工结算 )    private Integer settlement;    //注意事项    private String matters;    //工作要求    private String jobRequirements;    //工作内容    private String jobContent;    //是否管饭0000(早中晚夜宵都不管)、0001、0010、0100、1000、    private String includeBoard ;    //是否管住(不管住存入0，管住存入管住详情。)    private String controlSleep;    //是否面试(关联面试培训表主键)    private String interview;    //底薪任务(当没有底薪任务的时候，数据库存入0)    private String baseTask;    //绩效提成(当没有绩效提成的时候，数据库存入0)    private String commission;    //是否培训(关联面试培训表主键)    private String train;    //已招聘人数(默认为0)    private Integer beenRecruitedSum;    //类别(关联求职意向表主键)    private String workTypeID;    //所属用户（关联User表 主键）    private String userID;    //状态(1,职位保证金未支付;2,职位开放3、职位关闭;4、职位彻底关闭，不能再开放了，11，职位模版已默认;12,职位模版未默认)    private Integer open;    //类别（0，发布职位;1，职位模版）    private Boolean type;    //工作时间  多少分  比如9:00 则是 9*60    18:30 则是 18.5*60    private Integer startTime;    private Integer endTime;    private Date publishTime;    private Double chageMoney ;    @Ignore    private Boolean isVip ;    //每天多少人    private Integer personNumDay;    //一共多少天    private Integer workDayNum=0;    private String realName ;    @Ignore    private Boolean isPush;    @Ignore    private String hasRedPacketForward ;    @Ignore    private String hasRedPacket ;    @Ignore    private String forwardID ;    /*@Ignore*/    @StorageChild(refColumn = "workPalce",service = "localtioninfoService")    private Localtioninfo workPlace;    /*@Ignore*/    @StorageChild(revColumn = "positionID" ,service = "labelService")    private List<Label> labelList ;    /*@Ignore*/    @StorageChild(refColumn = "userID")    private User positionUser ;    @Ignore    @StorageChild(refColumn = "userID",revColumn = "userID")    private Information publish;    @Ignore    @StorageChild(refColumn = "workTypeID")    private Huntingtype huntingtype;    /*@Ignore*/    @StorageChild(refColumn = "aggregate",service = "localtioninfoService")    private Localtioninfo gather;    @Ignore    @StorageChild(refColumn = "interview",service = "interviewService")    private Interview interviewAddr;    @Ignore    @StorageChild(refColumn = "train",service = "interviewService")    private Interview trainAddr;    @Ignore    private Resume defaultResume;    @Ignore    private Beenrecruited beenrecruited;    @Ignore    private Signin signin;    @Ignore    @StorageChild(revColumn = "positionID")    private List<Signin> signins;    @Ignore    private Map settlementPerson;    @Ignore    private Settlementperson currSettlePerson;    @Ignore    private ApplySettlement applySettlement;    @Ignore    @StorageChild(revColumn = "positionID")    private List<ApplySettlement> applySettlementList ;    @Ignore    private String noSure ;    @Ignore    private String waitInterview ;    @Ignore    private String admissioned ;    @Ignore    private String waitToPosition ;    @Ignore    private String working ;    @Ignore    private String waitSettlement ;    @Ignore    private String settlements ;    @Ignore    private String waitEvaluate ;    @Ignore    private String evaluateed ;    @Ignore    private String appeal ;    @Ignore    private Integer settlementCount;    @Ignore    @StorageChild(service = "",revColumn = "positionID")    private List<Beenrecruited> beenrecruitedList ;    @Ignore    @StorageChild(service = "",revColumn = "positionID")    private List<Settlementperson> settlementpersonList ;    @Ignore    private Wxorder wxorder;    @Ignore    private String positionDelete;    @Ignore    private Bondtransaction bondtransaction;    @Ignore    private String bondStatus;    @Ignore    private Integer browseNum;    @Ignore    private Weixin weixin;    @Ignore    private boolean attention ;    @Ignore    private Integer signCount ;    @Ignore    private String signAdd ;    @Ignore    private Date signTime ;    @Ignore    private String signID;    public Integer getWorkDayNum(){        if(this.workDayNum==null  && this.personNumDay!=null ){            this.workDayNum  = this.recruitsSum/this.personNumDay;        }        return this.workDayNum;    }    private Personalauthen personalauthen;    private List<BigDecimal> bondList;    public List<BigDecimal> getBondList(){        return DictCacheService.bondList;    }    private Integer browser;    private List<String> pushList;}
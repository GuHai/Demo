package com.yskj.models;import com.yskj.aop.StorageChild;import com.yskj.models.auth.User;import jdk.nashorn.internal.ir.annotations.Ignore;import lombok.Data;import java.math.BigDecimal;import java.util.List;//表名称 post@Datapublic class Post extends BaseEntity {	private static final long serialVersionUID = 1L;	public Post() {		super();	}	    //标题    private String title;    //公司    private String compID;    @StorageChild(refColumn = "compID",service = "companyService")    private Company company ;    //地址    @Ignore    private String addrID;    @StorageChild(refColumn = "addrID",service = "localtioninfoService")    private Localtioninfo workPlace ;    //最低薪水    private BigDecimal minSalary;    //最高薪水    private BigDecimal maxSalary;    //福利标签  关联到PostLabel表code  用，号隔开    private String benefitsLabel;    //工作标签  关联到PostLabel表code  用，号隔开    private String workLabel;    //其他标签  关联到PostLabel表code  用，号隔开    private String otherLabel;    //招聘人数    private Integer recruits;    //描述    private String descript;    //面试安排    private String arrange;    //状态0 关闭，1打开    private Boolean status;    //联系电话    private String phone;    //联系人    private String contacts;    //最小年纪    private Integer minAge;    //最大年龄    private Integer maxAge;    //职位类型    private String postType;    private List<PostLabel> postLabelList ;    private List<Post> otherPostList ;    //0不喜欢，1喜欢    private Integer isLike ;    @StorageChild(revColumn = "postID")    private PostForBroker postForBroker;    private Integer browser;    private User user ;}
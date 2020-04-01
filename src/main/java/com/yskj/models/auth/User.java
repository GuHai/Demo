package com.yskj.models.auth;

import com.yskj.aop.StorageChild;
import com.yskj.models.*;
import com.yskj.utils.StringUtils;
import jdk.nashorn.internal.ir.annotations.Ignore;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 用户
 *
 * @author:Administrator
 * @create 2018-01-18 9:56
 */
@Data
public class User extends BaseEntity {
    private static final long serialVersionUID = 1L;
    //用户名
    private String accountNo;
    //密码明文，不保存到数据库
    @Ignore
    private String expressPassword;
    //登录密码
    private String password;
    //用户微信号
    private String weChatNo;
    //昵称
    private String nickName;
    //性别(1,男,2,女)
    private Integer sex;
    //手机号码
    private String phoneNumber;
    //上次登录时间
    private Date lastLoginTime;
    //本次登录时间
    private Date loginTime;
    //是否禁用
    private Boolean status;
    //真实姓名
    private String realName;
    //身份证
    private String IDCard;
    //个人头像
    private String infoHeadImg;
    //
    private Boolean locked;
    //用户签名
    private String userSig;

    //用户生日
    private Date birthday;

    private String pinyin;

    @Ignore
    private Information information;

    @StorageChild(service = "attachmentService",refColumn = "infoHeadImg")
    private Attachment attachment;
    @Ignore
    private String imgPath;

    @Ignore
    private String myPositionSize ;

    @Ignore
    private Integer signinCount ;
    @Ignore
    private Integer applySettlementNoHandle ;
    @Ignore
    private Integer applySettlementRefuse ;
    @Ignore
    private Integer applySettlementSum ;
    @StorageChild(revColumn = "userID")
    private Weixin weixin;
    @Ignore
    private Signin signin ;
    @Ignore
    private Mylocaltion mylocaltion;
    @Ignore
    private String unionid;


   /* private String accessToken;
    private String refreshToken;
    private String ticket;
    private String openid;*/
   private String mainName;
   public String getMainName(){
       if(StringUtils.isNotEmpty(this.realName))
           return this.realName;
       else
           return this.nickName;
   }

    private String authCode;  //授权登录码

    private BigDecimal money ;
    private BigDecimal mySettle ;
    private String workNumber="";

}

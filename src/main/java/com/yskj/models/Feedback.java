package com.yskj.models;

import com.yskj.aop.StorageChild;
import lombok.Data;

//表名称 feedback

@Data
public class Feedback extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public Feedback() {
		super();
	}
	
    //反馈人（关联用户ID）
    private String userID;
    //反馈内容
    private String feedContent;
    //反馈图片
    private String feedImg;
    //职位ID
    private String positionID ;
    //举报类型 1,工资纠纷;2,虚假信息;3,违约现象;4,平台问题;5,其它问题;
    private Integer type ;

    private String name;

    private String tel;

    private Integer status;

    //图片对象
    @StorageChild(refColumn = "feedImg",service = "attachmentService")
    private Attachment feedImgObj ;

    private String positionTitle ;

    private String mainName ;

    private String contacts ;

    private String contactNumber ;

}


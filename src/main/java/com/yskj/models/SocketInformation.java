package com.yskj.models;

import com.yskj.aop.StorageChild;
import com.yskj.models.auth.User;
import lombok.Data;

//表名称 socketinformation

@Data
public class SocketInformation extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public SocketInformation() {
		super();
	}
	
    //发送者
    private String fromuser;
    //接受者
    private String touser;
    //发送内容
    private String messsag;
    //状态(0未读,1,已读)
    private Boolean type;
    //是否换行
    private String needbr;
    //锁定
    private Boolean locked;
    //未读信息条数
    private Integer noReadCount ;
    //会话编号
    private String sessionID;

    //发送者对象
    @StorageChild(refColumn = "fromuser")
    private User fromUserObj ;

    //接收者对象
    @StorageChild(refColumn = "touser")
    private User toUserObj ;

    private Grouplist grouplist ;

}


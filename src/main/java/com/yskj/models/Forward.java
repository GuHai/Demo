package com.yskj.models;

import com.yskj.aop.StorageChild;
import com.yskj.models.auth.User;
import jdk.nashorn.internal.ir.annotations.Ignore;
import lombok.Data;

//表名称 forward

@Data
public class Forward extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public Forward() {
		super();
	}
	
    private String userId;
    private String positionId;
    private String forwardingCode;

    private User user;
    @StorageChild(refColumn = "positionId")
    private Position position;

    @Ignore
    private RedPacket redPacket ;
    private String rewardID ;

    @StorageChild(refColumn = "userId")
    private User payRedPacketUser;

}


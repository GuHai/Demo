package com.yskj.models;

import com.yskj.aop.StorageChild;
import com.yskj.models.auth.User;
import lombok.Data;

import java.math.BigDecimal;

//表名称 red_packet_receive

@Data
public class RedPacketReceive extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public RedPacketReceive() {
		super();
	}
	
    private String userId;
    private String redPacketId;
    private BigDecimal money;
    private Boolean isActivation;
    private String beenrecruitedID;
    private Integer beenrecruitedState;

    @StorageChild(refColumn = "userId")
    private User getRedPacketUser ;


}


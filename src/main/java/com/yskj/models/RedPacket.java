package com.yskj.models;

import com.yskj.aop.StorageChild;
import jdk.nashorn.internal.ir.annotations.Ignore;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

//表名称 red_packet

@Data
public class RedPacket extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public RedPacket() {
		super();
	}
	
    private String forwardId;
    private String remark;
    private Integer residueCount;
    private BigDecimal oneOfMoney;
    private BigDecimal allOfMoney;
    private String orderNumber ;

    //由哪个转发产生的红包
    @Ignore
    @StorageChild(refColumn = "forwardId")
    private Forward forward;

    //支付状态，0，未支付；1，已支付
    private Boolean state ;

    @StorageChild(revColumn = "redPacketId")
    private List<RedPacketReceive> redPacketReceiveList ;

    private BigDecimal backMoney ;
    private String positionID;

    @StorageChild(refColumn = "positionID")
    private Position position ;
}


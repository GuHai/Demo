package com.yskj.models;

import com.yskj.aop.StorageChild;
import lombok.Data;

import java.math.BigDecimal;

//表名称 reward

@Data
public class Reward extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public Reward() {
		super();
	}
	
    private BigDecimal hourlyWage;
    private BigDecimal rewardMoney;
    private Boolean rewardType;
    private String positionID;

    @StorageChild(refColumn = "positionID")
    private Position position ;

}


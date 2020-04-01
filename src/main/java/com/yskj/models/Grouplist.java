package com.yskj.models;

import lombok.Data;

//表名称 grouplist

@Data
public class Grouplist extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public Grouplist() {
		super();
	}
	
    private String userID;
    private String positionID;
    private Integer userType;
    private String groupName ;
    private String groupID ;
    private String userNickName ;

}


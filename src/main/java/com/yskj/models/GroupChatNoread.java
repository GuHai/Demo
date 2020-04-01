package com.yskj.models;

import lombok.Data;

//表名称 groupchatnoread

@Data
public class GroupChatNoread extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public GroupChatNoread() {
		super();
	}
	
    private String groupID;
    private String userID;
    private Integer noreadcount;

}


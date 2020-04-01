package com.yskj.models;

import lombok.Data;

//表名称 usersetting

@Data
public class UserSetting extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public UserSetting() {
		super();
	}
	
    //用户编号(关联shiro_user 表主键)
    private String userID;
    //系统通知是否开启
    private Boolean gmnotic;
    //聊天通知是否开启
    private Boolean chatinfo;
    //当前系统版本
    private String gmversion;

}


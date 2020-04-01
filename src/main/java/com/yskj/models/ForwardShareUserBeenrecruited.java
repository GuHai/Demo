package com.yskj.models;

import lombok.Data;

//表名称 forward_shareUser_beenrecruited

@Data
public class ForwardShareUserBeenrecruited extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public ForwardShareUserBeenrecruited() {
		super();
	}
	
    private String forwardId;
    private String shareUserId;
    private String beenrecruitedId;
    private Integer isReportToDuty;
    private Boolean isActivation;

}


package com.yskj.models;

import lombok.Data;

//表名称 label

@Data
public class Label extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public Label() {
		super();
	}
	
    private String name;
    private String positionID;
	private Boolean type;

}


package com.yskj.models;import lombok.Data;//表名称 insprofessionlist@Datapublic class InsProfessionList extends BaseEntity {	private static final long serialVersionUID = 1L;	public InsProfessionList() {		super();	}	    //名字    private String name;    //上级ID    private String parentID;    //类别    private Integer level;    @Override    public String toString(){        return name+";"+level;    }}
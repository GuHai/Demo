package com.yskj.models.enums;

public enum ActiveStatus {
    Promotion(1,"推广大使");
    private Integer no;
    private String desc;
    private ActiveStatus(Integer no ,String desc){
        this.desc = desc;
        this.no = no;
    }

    public Integer getNo() {
        return no;
    }

    public void setNo(Integer no) {
        this.no = no;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}

package com.yskj.models.enums;

public enum ApproveStatus {
    Approve("A","点赞",2),Follow("B","关注",4),Valid("C","未取关",2),ApplicationForPromotion("D","申请推广",4),Receive("E","领取奖励",0);
    private String code;
    private String desc;
    private Integer money; //单位毛
    private ApproveStatus(String code, String desc, Integer money){
        this.code = code;
        this.desc = desc;
        this.money = money;
    }

    public Integer getMoney() {
        return money;
    }

    public void setMoney(Integer money) {
        this.money = money;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

   /* public String getCodeByName(){
        for(ApproveStatus approveStatus : this.values()){
            if(approveStatus.name().equals(this.name())){
                return approveStatus.code;
            }
        }
        return "";
    }*/
}

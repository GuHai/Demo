package com.yskj.models.enums;

/**
 * 签到状态
 *
 * @author:Administrator
 * @create 2018-03-04 15:59
 */
public enum SigninStatus {
    WORK("工作",1),INTERVIEW("签到",2),TRAIN("培训",3);
    private String name;
    private int value;
    private SigninStatus(String name, int value) {
        this.name = name;
        this.value = value;
    }
}

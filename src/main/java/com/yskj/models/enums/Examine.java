package com.yskj.models.enums;

import com.yskj.utils.StringUtils;
import lombok.Getter;

/**
 * 审核信息
 *
 * @author:Administrator
 * @create 2018-10-23 9:44
 */
@Getter
public enum Examine {
    IDCard("身份认证","01","SF"),Recharge("充值","02","CZ"),Invoice("发票","03","FP"),Appeal("申述","04","SS"),Feedback("反馈","05","FK"),Extension("推广","06","TG"),Broker("经纪人","07","JJ");
    private String name;
    private String value;
    private String code;
    private Examine(String name, String value,String code) {
        this.name = name;
        this.value = value;
        this.code = code;
    }

    public static String getCode(String examine){
        if (StringUtils.isEmpty(examine)){
            return null;
        }
        for (Examine e:Examine.values()) {
            if (examine.equals(e.toString())){
                return e.code;
            }
        }
        return  null;
    }

    public static String getTitle(String examine){
        if (StringUtils.isEmpty(examine)){
            return null;
        }
        for (Examine e:Examine.values()) {
            if (examine.equals(e.toString())){
                return e.name;
            }
        }
        return  null;
    }
}

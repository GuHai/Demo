package com.yskj.vo;

import com.yskj.models.BaseEntity;
import lombok.Data;

/**
 * 意向人员
 *
 * @author:Administrator
 * @create 2018-12-07 16:36
 */
@Data
public class IntePerson extends BaseEntity {
    private String inte;
    private String name;
    private Integer sex;
    private String headimg;
    private String localimg;
}

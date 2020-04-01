package com.yskj.models.auth;

import com.yskj.models.BaseEntity;
import lombok.Data;

/**
 * 角色表
 *
 * @author:Administrator
 * @create 2018-01-18 9:56
 */
@Data
public class Role extends BaseEntity {
    private String name;
    private String description;
    private Boolean status;
}

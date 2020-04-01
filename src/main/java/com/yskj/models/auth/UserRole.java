package com.yskj.models.auth;

import com.yskj.aop.StorageChild;
import com.yskj.models.BaseEntity;
import lombok.Data;

import java.util.List;

/**
 * 用户角色表
 *
 * @author:Administrator
 * @create 2018-01-18 9:57
 */
@Data
public class UserRole extends BaseEntity {
    private String userId;
    private String roleId;

    @StorageChild(refColumn = "roleId")
    private Role role;
}

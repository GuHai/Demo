package com.yskj.models.auth;

import com.yskj.aop.StorageChild;
import com.yskj.models.BaseEntity;
import lombok.Data;

import java.util.List;

/**
 * 权限表
 *
 * @author:Administrator
 * @create 2018-01-18 9:57
 */
@Data
public class RolePermission extends BaseEntity {
    private String roleId;
    private String permissionId;
    private String buttonPermission; //hasView,hasDel,hasUpdate,hasAdd 基本的

    @StorageChild(refColumn = "permissionId")
    List<Permission> permissionList;
}

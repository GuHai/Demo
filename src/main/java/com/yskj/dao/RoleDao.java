package com.yskj.dao;

import com.yskj.models.PageParam;
import com.yskj.models.auth.Role;

import java.util.HashMap;
import java.util.List;

/**
 * 角色dao层
 *
 * @author:Administrator
 * @create 2018-01-19 18:12
 */
public interface RoleDao   extends Dao{
    List<Role> findRolesByAccountNo(String accountNo);
    List<HashMap> queryHashMap (PageParam pageParam);
}

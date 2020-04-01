package com.yskj.models.auth;

import com.yskj.models.BaseEntity;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * 权限表
 *
 * @author:Administrator
 * @create 2018-01-18 9:57
 */
@Data
public class Permission extends BaseEntity {
    private String name;
    private String alias;
    private String url;
    private String parentId;
    private int type;    //01 菜单 02 按钮
    private String sort;  //0001000200030004最多四级菜单
    private int depth; //1 2 3 4
    private int platform;//1 PC  2 H5
    private String description;
    private Boolean status;

    private List<Permission> menuList;
    public void addMenu(Permission permission){
        if(menuList==null){
            menuList=new ArrayList<Permission>();
        }
        menuList.add(permission);
    }
    public Permission getLastMenuByDepth(int depth){//获取某层级的最后一个Menu
        Permission currentPermission = this;
        while(depth-->1){
            currentPermission  = currentPermission.getMenuList().get(currentPermission.getMenuList().size()-1);
        }
        return currentPermission;
    }
}

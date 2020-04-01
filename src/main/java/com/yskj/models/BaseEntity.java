package com.yskj.models;

import com.yskj.models.auth.User;
import com.yskj.utils.IJobSecurityUtils;
import lombok.Data;
import org.apache.shiro.SecurityUtils;

import java.io.Serializable;
import java.util.Date;

/**
 * 基础类
 *
 * @author:Administrator
 * @create 2018-01-18 9:52
 */
@Data
public class BaseEntity implements Serializable{


    private String id;
    /**
     * 创建人
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新人
     */
    private String updateBy;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 版本号
     */
    private int version;
    /**
     * 是否删除 ，默认为否
     */
    private boolean isDeleted = false;

    public void updatePre(){
        Date now = new Date();
        this.updateTime = now;
        this.updateBy = IJobSecurityUtils.getLoginUserId();
    }

    public void addPre(){
        Date now = new Date();
        this.createBy = IJobSecurityUtils.getLoginUserId();
        this.createTime = now;
        this.updateTime = now;
        this.updateBy = createBy;
        this.version = 1;

    }

    public Boolean where(PageParam pageParam){
        return true;
    }

}

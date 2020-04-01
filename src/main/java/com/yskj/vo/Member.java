package com.yskj.vo;

import com.yskj.models.BaseEntity;
import com.yskj.models.PageParam;
import com.yskj.utils.StringUtils;
import lombok.Data;

/**
 * Member
 *
 * @author:Administrator
 * @create 2018-10-30 15:13
 */
@Data
public class Member extends BaseEntity{
    private String userID;
    private String realName;
    private String nickName;
    private Integer locked;
    private String userSig;
    private String personPhoneNumber;
    private String prealName;
    private String mainName;
    private Integer num;
    private Integer vip;
    private Integer role;


    public Boolean where(PageParam pageParam){
        if(pageParam.getCondition()!=null){
            if(StringUtils.isNotEmptyString(pageParam.getCondition().get("keyword"))){
                String keyword = pageParam.getCondition().get("keyword").toString().toUpperCase();
                if(!(StringUtils.isNotEmptyString(this.realName)&&this.realName.contains(keyword)
                        || StringUtils.isNotEmptyString(this.nickName)&&nickName.contains(keyword)
                        || StringUtils.isNotEmptyString(this.personPhoneNumber)&&personPhoneNumber.contains(keyword))){
                    return false;
                }
            }

            if(pageParam.getCondition().get("role")!=null){
                Integer role = (Integer) pageParam.getCondition().get("role");
                if(role!=this.role){
                    return false;
                }
            }

        }
        return true;
    }
}

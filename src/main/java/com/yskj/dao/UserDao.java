package com.yskj.dao;

import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.models.auth.User;
import com.yskj.vo.Member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户Dao层
 *
 * @author:Administrator
 * @create 2018-01-18 13:06
 */
public interface UserDao  extends Dao{
    List<HashMap> queryHashMap (PageParam pageParam);
    User getByAccountNo(String accountNo);
    List<Member> zpPage(QueryParam queryParam);
    List<HashMap> qzPage(QueryParam queryParam);
    Map<String,String> userInfo(String userID);
}

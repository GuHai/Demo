package com.yskj.service.base;

import com.yskj.dao.IntentiontypeDao;
import com.yskj.dao.UserDao;
import com.yskj.models.Intentiontype;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.redis.RedisUtil;
import com.yskj.service.auth.UserService;
import com.yskj.vo.IntePerson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * redis缓存service
 *
 * @author:Administrator
 * @create 2018-12-08 17:48
 */
@Service
public class RedisCacheService {
    @Autowired
    private IntentiontypeDao intentiontypeDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private UserService userService;



    //读取redis缓存
    public void readRedisCacheFromDB()throws Exception{
        readIntentionCache(new QueryParam());
        readUserCache();
        readUserInfo();
    }

    @Async
    public void readIntentionCache(QueryParam queryParam)throws Exception{
        List<Intentiontype> intelist = intentiontypeDao.getHuntGroupWithUserID(queryParam);
        RedisUtil.addMatchByLike(intelist,new String[]{"htID"});

        PageParam pageParam = new PageParam();
        pageParam.setPageSize(100000);
        List<IntePerson> personList  = intentiontypeDao.findIntePersonPage(pageParam);
        RedisUtil.addAll2List(personList);
    }

    public void readUserCache()throws Exception{
        PageParam newPageParam = new PageParam();
        newPageParam.setPageSize(1000000); //100w数据，如果将来超过了，我从办公室跳下去
        newPageParam.setCurrentPage(1);
        RedisUtil.addMatchByLike(userDao.zpPage(newPageParam),new String[]{"mainName","nickName","personPhoneNumber"});
    }

    public void readUserInfo()throws Exception{

        List<String> list = userService.findIds(new QueryParam(),"id");
        for(String str : list){
            Map<String,String> userinfo =  userService.userInfo(str);
            try{
                RedisUtil.hset("UserSimpleInfo",str,userinfo);
            }catch (Exception e){
            }
        }
    }

}

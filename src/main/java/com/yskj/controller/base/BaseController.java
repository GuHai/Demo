package com.yskj.controller.base;

import com.yskj.models.BaseEntity;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.service.base.AbstractService;
import com.yskj.utils.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 基础控制层类
 *
 * @author:Administrator
 * @create 2018-01-22 11:11
 */
public abstract class BaseController {
    private final static Logger logger = LoggerFactory.getLogger(BaseController.class);
    public abstract AbstractService getService();
    public <ENTITY extends BaseEntity> Result add(ENTITY entity ){
        Result result = new Result();
        try {
            result.byInsert(getService().add(entity));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","新增失败："+e.getMessage());
        }
        return result;
    }


    public <ENTITY extends BaseEntity>  Result delete(ENTITY entity ){
        Result result = new Result();
        try {
            result.byDelete(getService().delete(entity));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","删除失败："+e.getMessage());
        }
        return result;
    }

    public <ENTITY extends BaseEntity>  Result deleteList(List<ENTITY> entity ){
        Result result = new Result();
        try {
            result.byDelete(getService().deleteList(entity));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","删除失败："+e.getMessage());
        }
        return result;
    }

    public <ENTITY extends BaseEntity>  Result update(ENTITY entity ){
        Result result = new Result();
        try{
            result.byUpdate(getService().update(entity));
            result.setData(entity);
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","修改失败："+e.getMessage());
        }
        return result;
    }

    public <ENTITY extends BaseEntity>  Result persistence(ENTITY entity ){
        Result result = new Result();
        try{
            result.byUpdate(getService().persistence(entity));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","持久化失败："+e.getMessage());
        }
        return result;
    }

    public <ENTITY extends BaseEntity>  Result persistenceAndChild(ENTITY entity ){
        Result result = new Result();
        try{
            result.byUpdate(getService().persistenceAndChild(entity));
            result.setData(entity);
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","持久化失败："+e.getMessage());
        }
        return result;
    }

    public Result findPage(PageParam pageParam ){
        Result result = new Result();
        try{
            result.setData(getService().findPage(pageParam));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","查询失败："+e.getMessage());
        }
        return result;
    }

    public Result findLikePage(PageParam pageParam ){
        Result result = new Result();
        try{
            result.setData(getService().findLikePage(pageParam));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","查询失败："+e.getMessage());
        }
        return result;
    }
    public Result one(QueryParam queryParam ){
        Result result = new Result();
        try{
            result.setData(getService().one(queryParam));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","查询失败："+e.getMessage());
        }
        return result;
    }
    public Result get(String id ){
        Result result = new Result();
        try{
            result.setData(getService().get(id));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","查询失败："+e.getMessage());
        }
        return result;
    }

    public Result get2List(String id ){
        Result result = new Result();
        try{
            result.listData(getService().get(id));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","查询失败："+e.getMessage());
        }
        return result;
    }

    public Result getObject2List(Object object){
        if(object instanceof Result){
            object = (Result)object;
            ((Result) object).listData(((Result) object).fromDataList());
            return (Result)object;
        }else if(object instanceof PageParam){
            Result result = new Result();
            result.setTotalPage(((PageParam)object).getTotalPage());
            result.setNextPage(((PageParam)object).getCurrentPage()+1);
//            result.listData( (PageParam)((PageParam) object).getList() );
            result.listData(((PageParam)object).getList());
            return result;
        }else {
            Result result = new Result();
            result.listData(object);
            return result;
        }
    }
    public Result findList2List(QueryParam queryParam ){
        Result result = new Result();
        try{
            result.listData(getService().findList(queryParam));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","查询失败："+e.getMessage());
        }
        return result;
    }


    public Result findList(QueryParam queryParam ){
        Result result = new Result();
        try{
            result.setData(getService().findList(queryParam));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","查询失败："+e.getMessage());
        }
        return result;
    }

    public Result findLikeList(QueryParam queryParam ){
        Result result = new Result();
        try{
            result.setData(getService().findLikeList(queryParam));
        }catch(Exception e){
            logger.error(e.getMessage());
            result.put("500","查询失败："+e.getMessage());
        }
        return result;
    }

}

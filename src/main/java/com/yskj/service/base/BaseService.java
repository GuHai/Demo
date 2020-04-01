package com.yskj.service.base;


import com.yskj.models.BaseEntity;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;

import java.util.List;

/**
 * Created by Administrator on 2016/9/25.
 */
public interface BaseService {
    <ENTITY extends BaseEntity> Long add (ENTITY entity) throws Exception;
    <ENTITY extends BaseEntity> Long delete(ENTITY entity) throws Exception;
    <ENTITY extends BaseEntity> Long update(ENTITY entity) throws Exception;
    PageParam findPage(PageParam pageParam) throws Exception;
    <ENTITY extends BaseEntity> ENTITY get(String id) throws Exception;
    Long count(QueryParam queryParam)throws Exception;
    PageParam findLikePage(PageParam pageParam)throws Exception;
    <ENTITY extends BaseEntity> ENTITY one(QueryParam queryParam) throws Exception;
    <ENTITY extends BaseEntity> List<ENTITY> findList(QueryParam queryParam)throws Exception;
    <ENTITY extends BaseEntity> List<ENTITY> findLikeList(QueryParam queryParam)throws Exception;
    List<String> findIds(QueryParam queryParam,String idsName)throws Exception;
    List<String> findLikeIds(QueryParam queryParam,String idsName)throws Exception;
}

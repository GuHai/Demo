package com.yskj.dao;import java.util.HashMap;import java.util.List;import com.yskj.models.PageParam;public interface IntentiondateDao extends Dao {	List<HashMap> queryHashMap(PageParam pageParam);}
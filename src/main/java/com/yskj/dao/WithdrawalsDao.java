package com.yskj.dao;import com.yskj.models.PageParam;import java.math.BigDecimal;import java.util.HashMap;import java.util.List;public interface WithdrawalsDao extends Dao {	List<HashMap> queryHashMap(PageParam pageParam);	Double getPriceSum(String id);	Double getReturnBond(String id);	Double getSurplusMoney(String userID);}
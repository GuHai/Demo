package com.yskj.dao;import java.util.HashMap;import java.util.List;import com.yskj.models.Intentionaddress;import com.yskj.models.PageParam;public interface IntentionaddressDao extends Dao {	List<HashMap> queryHashMap(PageParam pageParam);	List<Intentionaddress> mapPage(PageParam pageParam);}
package com.yskj.dao;import java.util.HashMap;import java.util.List;import com.yskj.models.PageParam;import com.yskj.models.PostForBroker;import org.springframework.data.domain.Page;public interface PostForBrokerDao extends Dao {	List<HashMap> queryHashMap(PageParam pageParam);	List<PostForBroker> getPostForBrokerInfoListPage(PageParam pageParam);	PostForBroker getPostForBrokerFullInfo(String id);}
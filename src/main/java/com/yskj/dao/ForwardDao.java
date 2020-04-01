package com.yskj.dao;


import com.yskj.models.Forward;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ForwardDao extends Dao {

	List<HashMap> queryHashMap(PageParam pageParam);

	Forward checkPosition(QueryParam queryParam);

	Map getRewardMoney(QueryParam queryParam);
}

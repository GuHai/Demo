package com.yskj.dao;


import com.yskj.models.Feedback;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;

import java.util.HashMap;
import java.util.List;

public interface FeedbackDao extends Dao {

	List<HashMap> queryHashMap(PageParam pageParam);

	Feedback mapOne(QueryParam queryParam);

	Feedback getHistoryFeedBackDetail(String id);
}

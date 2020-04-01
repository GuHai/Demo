package com.yskj.dao;


import com.yskj.models.GroupChatNoread;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface GroupChatNoreadDao extends Dao {

	List<HashMap> queryHashMap(PageParam pageParam);

	GroupChatNoread getNoReadCount(QueryParam queryParam);

	void updateMsgRead(Map map);
}

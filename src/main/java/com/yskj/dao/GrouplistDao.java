package com.yskj.dao;


import com.yskj.models.Grouplist;
import com.yskj.models.PageParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface GrouplistDao extends Dao {

	List<HashMap> queryHashMap(PageParam pageParam);

	List<Grouplist> getGroupUser(String groupID);

	List<Map> getGroupUserInfo(String groupID) ;

	Long clearGroupByGroupID(Grouplist grouplist);

	void updateGroupNameTitleByPosition(Grouplist grouplist);
}

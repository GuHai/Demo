package com.yskj.dao;


import com.yskj.models.PageParam;

import java.util.HashMap;
import java.util.List;

public interface UserSettingDao extends Dao {

	List<HashMap> queryHashMap(PageParam pageParam);
}

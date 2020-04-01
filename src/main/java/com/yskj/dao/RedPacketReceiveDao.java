package com.yskj.dao;


import com.yskj.models.PageParam;
import com.yskj.models.RedPacket;

import java.util.HashMap;
import java.util.List;

public interface RedPacketReceiveDao extends Dao {

	List<HashMap> queryHashMap(PageParam pageParam);

	/**
	 * 根据用户 id 查询用户的红包
	 * @param pageParam
	 * @return
	 */
	List<RedPacket> findListByUserIdPage(PageParam pageParam);

}

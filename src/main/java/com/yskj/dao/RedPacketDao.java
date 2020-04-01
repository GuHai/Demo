package com.yskj.dao;


import com.yskj.models.PageParam;
import com.yskj.models.RedPacket;

import java.util.HashMap;
import java.util.List;

public interface RedPacketDao extends Dao {

	List<HashMap> queryHashMap(PageParam pageParam);

	RedPacket getRedPacketBack(String id);

	RedPacket redpacketmap(String id);

	RedPacket redpacketorthermap(String id);
}

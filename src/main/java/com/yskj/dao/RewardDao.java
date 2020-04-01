package com.yskj.dao;


import com.yskj.models.PageParam;
import com.yskj.models.Reward;

import java.util.HashMap;
import java.util.List;

public interface RewardDao extends Dao {

	List<HashMap> queryHashMap(PageParam pageParam);

	Reward getNewReward(String positionID) ;

	List<Reward> findPositionByRewardPage(PageParam pageParam);
}

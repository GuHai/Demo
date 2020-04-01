package com.yskj.service;

import com.yskj.dao.RewardDao;
import com.yskj.models.PageParam;
import com.yskj.models.Reward;
import com.yskj.service.base.AbstractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RewardService extends AbstractService {
	@Autowired
    private RewardDao rewardDao;

	public RewardService() {
		super();
	}

	@Override
	public RewardDao getDao() {
		return this.rewardDao;
	}

	public Reward getNewReward(String positionID){
		return rewardDao.getNewReward(positionID);
	}

	public PageParam findPositionByRewardPage(PageParam pageParam){
		pageParam.setList(rewardDao.findPositionByRewardPage(pageParam));
		return pageParam;
	}

}

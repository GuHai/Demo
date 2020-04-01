package com.yskj.service;

import com.yskj.dao.ForwardDao;
import com.yskj.models.Forward;
import com.yskj.models.QueryParam;
import com.yskj.models.RedPacket;
import com.yskj.models.Wxorder;
import com.yskj.service.base.AbstractService;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Map;

@Service
public class ForwardService extends AbstractService {
	@Autowired
    private ForwardDao forwardDao;
	@Autowired
	private RedPacketService redPacketService;
	@Autowired
	private WxorderService wxorderService ;


	public ForwardService() {
		super();
	}

	@Override
	public ForwardDao getDao() {
		return this.forwardDao;
	}

	@Transactional(rollbackFor = Exception.class)
	public void redPacketCallback(Wxorder wxorder) throws Exception{
		RedPacket redPacket = redPacketService.get(wxorder.getRefID());
		redPacket.setState(true);
		redPacket.setOrderNumber(wxorder.getCode());
		redPacketService.update(redPacket);
		Forward forward = forwardDao.one(new QueryParam("id",redPacket.getForwardId()));
		if(forward!=null){
			forward.setDeleted(false);
			this.update(forward);
		}
		//修改订单已回调状态为已经执行回调
		wxorder.setStatus(4);
		wxorderService.update(wxorder);
	}

	public Forward checkPosition(QueryParam queryParam){
		return forwardDao.checkPosition(queryParam);
	}

	public Map getRewardMoney(QueryParam queryParam){
		return forwardDao.getRewardMoney(queryParam);
	}

	@Transactional
	public Result forwardPositionByRed(Map map) throws Exception{
		Result result = new Result();
		Forward forward = new Forward();
		RedPacket redPacket = new RedPacket();
		QueryParam queryParam = new QueryParam("userId", IJobSecurityUtils.getLoginUserId());
		queryParam.put("positionId",map.get("positionID").toString());
		queryParam.put("isDeleted",false);
		Forward tempForward = this.one(queryParam);
		if (tempForward != null ){
			result.put("501","您已经转发过该职位！");
			return result ;
		}
		forward.setUserId(IJobSecurityUtils.getLoginUserId());
		forward.setPositionId(map.get("positionID").toString());
		forward.setDeleted(Boolean.TRUE);
		forward.setRewardID(map.get("rewardID").toString());
		//添加
		this.add(forward);
		redPacket.setForwardId(forward.getId());
		redPacket.setAllOfMoney(new BigDecimal(map.get("allOfMoney").toString()));
		redPacket.setOneOfMoney(new BigDecimal(map.get("oneOfMoney").toString()));
		redPacket.setResidueCount(new Integer(map.get("residueCount").toString()));
		redPacket.setState(Boolean.FALSE);
		redPacketService.add(redPacket);
		forward.setRedPacket(redPacket);
		result.setData(forward);
		return result;
	}

}

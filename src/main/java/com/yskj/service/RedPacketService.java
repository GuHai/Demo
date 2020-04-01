package com.yskj.service;

import com.yskj.dao.RedPacketDao;
import com.yskj.models.RedPacket;
import com.yskj.service.base.AbstractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RedPacketService extends AbstractService {
	@Autowired
    private RedPacketDao redPacketDao;

	public RedPacketService() {
		super();
	}

	@Override
	public RedPacketDao getDao() {
		return this.redPacketDao;
	}

	public RedPacket getRedPacketBack(String id){
		return redPacketDao.getRedPacketBack(id);
	}

	public RedPacket redpacketmap(String id){
		return redPacketDao.redpacketmap(id);
	}

	public RedPacket redpacketorthermap(String id){
		return redPacketDao.redpacketorthermap(id);
	}

}

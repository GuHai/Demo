package com.yskj.service;

import com.yskj.dao.GrouplistDao;
import com.yskj.models.Grouplist;
import com.yskj.service.base.AbstractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class GrouplistService extends AbstractService {
	@Autowired
    private GrouplistDao grouplistDao;

	public GrouplistService() {
		super();
	}

	@Override
	public GrouplistDao getDao() {
		return this.grouplistDao;
	}

	public List<Grouplist> getGroupUser(String groupID){
		return grouplistDao.getGroupUser(groupID);
	}

	public List<Map> getGroupUserInfo(String groupID){
		return grouplistDao.getGroupUserInfo(groupID);
	}

	public Long clearGroupByGroupID(Grouplist grouplist){
		return grouplistDao.clearGroupByGroupID(grouplist);
	}

	public void updateGroupNameTitleByPosition(Grouplist grouplist){
		grouplistDao.updateGroupNameTitleByPosition(grouplist);
	}

}

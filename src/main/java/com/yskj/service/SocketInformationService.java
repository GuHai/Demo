package com.yskj.service;

import com.yskj.dao.SocketInformationDao;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.models.SocketInformation;
import com.yskj.service.base.AbstractService;
import com.yskj.utils.IJobSecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@Service
public class SocketInformationService extends AbstractService {
	@Autowired
    private SocketInformationDao socketInformationDao;

	public SocketInformationService() {
		super();
	}

	@Override
	public SocketInformationDao getDao() {
		return this.socketInformationDao;
	}

	public List<SocketInformation> recentChat(String userID){
		return socketInformationDao.recentChat(userID);
	}

	public PageParam getHistoryChatInfoPage(PageParam pageParam){
		List<SocketInformation> socketInformationList = socketInformationDao.getHistoryChatInfoPage(pageParam);
		String userID = IJobSecurityUtils.getLoginUserId();
		for (SocketInformation socketInformation : socketInformationList){
			if (userID.equals(socketInformation.getFromuser()))
				socketInformation.setNeedbr("self");
			else
				socketInformation.setNeedbr("he");
		}
		Collections.reverse(socketInformationList);
		pageParam.setList(socketInformationList);
		return pageParam;
	}

	public String getSessionID(QueryParam queryParam){
		SocketInformation socketInformation = socketInformationDao.getSessionID(queryParam);
		if(null == socketInformation){
			return null;
		}else{
			return socketInformation.getSessionID();
		}
	}

	public Map getC2CUserInfo(String id){
		return socketInformationDao.getC2CUserInfo(id);
	}

	public Integer updateMessageType(QueryParam queryParam){
		try {
			socketInformationDao.updateMessageType(queryParam);
		}catch (Exception e){
			return 0;
		}
		return 1;
	}

	public Integer getUserMass(QueryParam queryParam){
		return socketInformationDao.getUserMass(queryParam) + socketInformationDao.getGroupMsgCount(IJobSecurityUtils.getLoginUserId());
	}

	public Integer getGroupMsgCount(String userID){
		return socketInformationDao.getGroupMsgCount(userID);
	}

	public List<Map> recentChatGroup(String userID){
		return socketInformationDao.recentChatGroup(userID);
	}

	public PageParam getGroupHistoryChatPage(PageParam pageParam){
		List<Map> listMap = socketInformationDao.getGroupHistoryChatPage(pageParam);
		String userID = IJobSecurityUtils.getLoginUserId();
		for (Map map : listMap){
			if (userID.equals(map.get("fromuser").toString()))
				map.put("needbr","self");
			else
				map.put("needbr","he");
		}
		Collections.reverse(listMap);
		pageParam.setList(listMap);
		return pageParam;
	}

	public SocketInformation getGrouplistSessionID(String groupID){
		return socketInformationDao.getGrouplistSessionID(groupID);
	}

	public String getHeadImgByID(String userID){
		return socketInformationDao.getHeadImgByID(userID);
	}
}

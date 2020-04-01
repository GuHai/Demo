package com.yskj.dao;


import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.models.SocketInformation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface SocketInformationDao extends Dao {

	List<HashMap> queryHashMap(PageParam pageParam);

	List<SocketInformation> recentChat(String userID);

	List<SocketInformation> getHistoryChatInfoPage(PageParam pageParam);

	SocketInformation getSessionID(QueryParam queryParam);

	Map getC2CUserInfo(String id);

	Integer updateMessageType(QueryParam queryParam);

	Integer getUserMass(QueryParam queryParam);

	List<Map> recentChatGroup(String userID) ;

	List<Map> getGroupHistoryChatPage(PageParam pageParam) ;

	SocketInformation getGrouplistSessionID(String groupID);

	String getHeadImgByID(String userID);

	Integer getGroupMsgCount(String userID);
}

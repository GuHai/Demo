package com.yskj.service;

import com.yskj.dao.GroupChatNoreadDao;
import com.yskj.models.BaseEntity;
import com.yskj.models.GroupChatNoread;
import com.yskj.models.QueryParam;
import com.yskj.service.base.AbstractService;
import com.yskj.utils.StringUtils;
import com.yskj.utils.UUIDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Map;

@Service
public class GroupChatNoreadService extends AbstractService {
	@Autowired
    private GroupChatNoreadDao groupChatNoreadDao;

	public GroupChatNoreadService() {
		super();
	}

	@Override
	public GroupChatNoreadDao getDao() {
		return this.groupChatNoreadDao;
	}

	public GroupChatNoread getNoReadCount(QueryParam queryParam){
		return groupChatNoreadDao.getNoReadCount(queryParam);
	}

	public void updateMsgRead(Map map){
		groupChatNoreadDao.updateMsgRead(map);
	}

	public <ENTITY extends BaseEntity> Long persistence(ENTITY entity)throws Exception{
		if(entity!=null){
			if(StringUtils.isNotEmpty(entity.getId())){
				return this.update(entity);
			}else{
				return this.add(entity);
			}
		}
		return -1L;
	}

	/**
	 * 更新操作
	 * @param entity
	 * @return List<ENTITY>
	 * @exception Exception
	 */
	public <ENTITY extends BaseEntity> Long update(ENTITY entity) throws Exception{
		if(entity!=null){
			entity.setVersion(entity.getVersion()+1);
			entity.setUpdateTime(new Date());
			return this.getDao().update(entity);
		}
		return -1L;
	}

	/**
	 * 新增操作
	 * @param entity
	 * @return List<ENTITY>
	 * @exception Exception
	 */
	public <ENTITY extends BaseEntity> Long add(ENTITY entity) throws Exception {
		if(entity!=null){
			if(StringUtils.isEmpty(entity.getId())){
				entity.setId(UUIDGenerator.randomUUID());
			}
			Date now = new Date();
			entity.setCreateTime(now);
			entity.setUpdateTime(now);
			entity.setVersion(1);
			return this.getDao().add(entity);
		}
		return  -1L;
	}

}

package com.yskj.service;import com.yskj.dao.AttentionDao;import com.yskj.models.QueryParam;import com.yskj.service.base.AbstractService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;import java.util.List;import java.util.Map;@Servicepublic class AttentionService extends AbstractService {	@Autowired    private AttentionDao attentionDao;	public AttentionService() {		super();	}	@Override	public AttentionDao getDao() {		return this.attentionDao;	}	public List<Map> getFocusList(QueryParam queryParam){ return attentionDao.getFocusList(queryParam); }	public List<Map> getFansList(QueryParam queryParam){ return attentionDao.getFansList(queryParam); }}
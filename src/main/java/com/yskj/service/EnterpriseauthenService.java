package com.yskj.service;import com.yskj.dao.EnterpriseauthenDao;import com.yskj.models.Enterpriseauthen;import com.yskj.models.PageParam;import com.yskj.models.QueryParam;import com.yskj.service.base.AbstractService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;@Servicepublic class EnterpriseauthenService extends AbstractService {	@Autowired    private EnterpriseauthenDao enterpriseauthenDao;	public EnterpriseauthenService() {		super();	}	@Override	public EnterpriseauthenDao getDao() {		return this.enterpriseauthenDao;	}	public Enterpriseauthen mapOne(QueryParam queryParam) throws Exception {		return this.getDao().mapOne(queryParam);	}}
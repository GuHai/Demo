package com.yskj.service;import com.yskj.dao.PartnerRebateDao;import com.yskj.models.PartnerRebate;import com.yskj.models.QueryParam;import com.yskj.service.base.AbstractService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;@Servicepublic class PartnerRebateService extends AbstractService {	@Autowired    private PartnerRebateDao partnerRebateDao;	public PartnerRebateService() {		super();	}	@Override	public PartnerRebateDao getDao() {		return this.partnerRebateDao;	}	public PartnerRebate partnerInfo(QueryParam queryParam)throws Exception{		return this.getDao().partnerInfo(queryParam);	}}
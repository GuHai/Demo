package com.yskj.service;import com.yskj.dao.RefundDao;import com.yskj.models.PageParam;import com.yskj.models.QueryParam;import com.yskj.models.Refund;import com.yskj.models.Wxorder;import com.yskj.service.base.AbstractService;import com.yskj.utils.DateUtils;import com.yskj.utils.SignUtils;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;@Servicepublic class RefundService extends AbstractService {	@Autowired    private RefundDao refundDao;	public RefundService() {		super();	}	@Override	public RefundDao getDao() {		return this.refundDao;	}	public Refund mapOne(QueryParam queryParam) throws Exception {		return getDao().mapOne(queryParam);	}	public String getNextCode(String type){		return getCodeTitle(type)+ DateUtils.getCurrTime()+ SignUtils.getRandomStringByLength(16);	}	private   String getCodeTitle(String type ){		if(Wxorder.Bond==type){			return "TB";		}		return "TR";	}}
package com.yskj.service;import com.yskj.dao.RechargeDao;import com.yskj.models.QueryParam;import com.yskj.models.Recharge;import com.yskj.service.base.AbstractService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;import java.util.List;@Servicepublic class RechargeService extends AbstractService {	@Autowired    private RechargeDao rechargeDao;	public RechargeService() {		super();	}	@Override	public RechargeDao getDao() {		return this.rechargeDao;	}	public void updateRechargeList(QueryParam queryParam){		rechargeDao.updateRechargeList(queryParam);	}	public void callbackRecharge(QueryParam queryParam){		rechargeDao.callbackRecharge(queryParam);	}	public List<Recharge> getRechargeListByInvoiceID(QueryParam queryParam){		return rechargeDao.getRechargeListByInvoiceID(queryParam);	}	public void updateCallbackRecharge(String userID){		rechargeDao.updateCallbackRecharge(userID);	}}
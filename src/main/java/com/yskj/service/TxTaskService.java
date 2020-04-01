package com.yskj.service;import com.yskj.dao.TxTaskDao;import com.yskj.models.TxTask;import com.yskj.models.Withdrawals;import com.yskj.service.base.AbstractService;import com.yskj.utils.DateUtils;import com.yskj.utils.StringUtils;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;import org.springframework.transaction.annotation.Transactional;import java.util.Date;@Servicepublic class TxTaskService extends AbstractService {	@Autowired    private TxTaskDao txTaskDao;	@Autowired	private WithdrawalsService withdrawalsService;	public TxTaskService() {		super();	}	@Override	public TxTaskDao getDao() {		return this.txTaskDao;	}	public void deleteAll()throws Exception{		this.getDao().deleteAll();	}	@Transactional	public void deleteTxTask(String id)throws Exception{		TxTask txTask  = this.get(id);		this.delete(txTask); //删除提现记录后，还需要吧删除原因加上去		Withdrawals withdrawals = withdrawalsService.get(txTask.getTxID());		if(StringUtils.isNotEmptyString(txTask.getErrmsg())){			withdrawals.setRemarks(withdrawals.getRemarks()+"\n"+ DateUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss")+"："+txTask.getErrmsg());		}		withdrawalsService.update(withdrawals);	}}
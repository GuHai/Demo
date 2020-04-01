package com.yskj.service;import com.yskj.dao.ApproveDao;import com.yskj.exception.IJobException;import com.yskj.models.Approve;import com.yskj.models.enums.ApproveStatus;import com.yskj.service.base.AbstractService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;import java.math.BigDecimal;@Servicepublic class ApproveService extends AbstractService {	@Autowired    private ApproveDao approveDao;	public ApproveService() {		super();	}	@Override	public ApproveDao getDao() {		return this.approveDao;	}	public void updateTask(ApproveStatus approveStatus, Approve approve)throws Exception{		approve.setTask(approve.getTask().replace(approveStatus.getCode().toLowerCase(),approveStatus.getCode()));		if(approve.getMoney()==null){			approve.setMoney(BigDecimal.ZERO);		}		approve.setMoney(approve.getMoney().add(new BigDecimal(approveStatus.getMoney()/10.0)).setScale(2,BigDecimal.ROUND_HALF_UP));		if(new BigDecimal(1.2).setScale(2,BigDecimal.ROUND_HALF_UP).compareTo(approve.getMoney())<0){			throw new IJobException("金额异常，可能存在非法操作");		}		this.persistence(approve);	}	//取消任务	public void cancelTask(ApproveStatus approveStatus, Approve approve)throws Exception{		approve.setTask(approve.getTask().replace(approveStatus.getCode(),approveStatus.getCode().toLowerCase()));		if(approve.getMoney()==null){			approve.setMoney(BigDecimal.ZERO);		}		approve.setMoney(approve.getMoney().subtract(new BigDecimal(approveStatus.getMoney()/10.0)).setScale(2,BigDecimal.ROUND_HALF_UP));		if(new BigDecimal(1.2).setScale(2,BigDecimal.ROUND_HALF_UP).compareTo(approve.getMoney())<0){			throw new IJobException("金额异常，可能存在非法操作");		}		this.persistence(approve);	}}
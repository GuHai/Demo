package com.yskj.service;import com.yskj.dao.JumpDao;import com.yskj.service.base.AbstractService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;@Servicepublic class JumpService extends AbstractService {	@Autowired    private JumpDao jumpDao;	public JumpService() {		super();	}	@Override	public JumpDao getDao() {		return this.jumpDao;	}}
package com.yskj.service;import com.yskj.dao.JointableDao;import com.yskj.service.base.AbstractService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;@Servicepublic class JointableService extends AbstractService {	@Autowired    private JointableDao jointableDao;	public JointableService() {		super();	}	@Override	public JointableDao getDao() {		return this.jointableDao;	}}
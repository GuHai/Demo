package com.yskj.service;import com.yskj.dao.UniversityDao;import com.yskj.service.base.AbstractService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;@Servicepublic class UniversityService extends AbstractService {	@Autowired    private UniversityDao universityDao;	public UniversityService() {		super();	}	@Override	public UniversityDao getDao() {		return this.universityDao;	}}
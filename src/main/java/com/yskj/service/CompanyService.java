package com.yskj.service;import com.yskj.dao.CompanyDao;import com.yskj.service.base.AbstractService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;@Servicepublic class CompanyService extends AbstractService {	@Autowired    private CompanyDao companyDao;	public CompanyService() {		super();	}	@Override	public CompanyDao getDao() {		return this.companyDao;	}}
package com.yskj.service;import com.yskj.dao.TaxDao;import com.yskj.service.base.AbstractService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;@Servicepublic class TaxService extends AbstractService {	@Autowired    private TaxDao taxDao;	public TaxService() {		super();	}	@Override	public TaxDao getDao() {		return this.taxDao;	}}
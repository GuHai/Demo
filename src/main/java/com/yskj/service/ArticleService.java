package com.yskj.service;import com.yskj.dao.ArticleDao;import com.yskj.service.base.AbstractService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;@Servicepublic class ArticleService extends AbstractService {	@Autowired    private ArticleDao articleDao;	public ArticleService() {		super();	}	@Override	public ArticleDao getDao() {		return this.articleDao;	}}
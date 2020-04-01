package com.yskj.service;

import com.yskj.dao.ForwardShareUserBeenrecruitedDao;
import com.yskj.service.base.AbstractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ForwardShareUserBeenrecruitedService extends AbstractService {
	@Autowired
    private ForwardShareUserBeenrecruitedDao forwardShareUserBeenrecruitedDao;

	public ForwardShareUserBeenrecruitedService() {
		super();
	}

	@Override
	public ForwardShareUserBeenrecruitedDao getDao() {
		return this.forwardShareUserBeenrecruitedDao;
	}

}

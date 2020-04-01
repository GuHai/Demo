package com.yskj.service;

import com.yskj.dao.UserSettingDao;
import com.yskj.service.base.AbstractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserSettingService extends AbstractService {
	@Autowired
    private UserSettingDao userSettingDao;

	public UserSettingService() {
		super();
	}

	@Override
	public UserSettingDao getDao() {
		return this.userSettingDao;
	}

}

package com.yskj.service;

import com.yskj.dao.LabelDao;
import com.yskj.service.base.AbstractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LabelService extends AbstractService {
	@Autowired
    private LabelDao labelDao;

	public LabelService() {
		super();
	}

	@Override
	public LabelDao getDao() {
		return this.labelDao;
	}

	public Boolean deleteLabelForPosition(String positionID){
		try {
			labelDao.deleteLabelForPosition(positionID);
		}catch (Exception e){
			return false ;
		}
		return true ;
	}

}

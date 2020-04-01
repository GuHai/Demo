package com.yskj.service;


import com.yskj.dao.ApplicantDao;
import com.yskj.dao.Dao;
import com.yskj.dao.UserDao;
import com.yskj.models.Applicant;
import com.yskj.service.base.AbstractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2016/9/25.
 */
@Service("applicantService")
public class ApplicantService extends AbstractService {
    @Autowired
    private ApplicantDao applicantDao;

    private ApplicantService applicantService;


    public Dao getDao() {
        return applicantDao;
    }
}

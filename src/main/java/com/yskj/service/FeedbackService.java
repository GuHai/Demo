package com.yskj.service;

import com.yskj.dao.FeedbackDao;
import com.yskj.models.Feedback;
import com.yskj.models.PageParam;
import com.yskj.models.QueryParam;
import com.yskj.service.base.AbstractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FeedbackService extends AbstractService {
	@Autowired
    private FeedbackDao feedbackDao;

	public FeedbackService() {
		super();
	}

	@Override
	public FeedbackDao getDao() {
		return this.feedbackDao;
	}

	public Feedback mapOne(QueryParam queryParam)throws Exception{
		return this.getDao().mapOne(queryParam);
	}

	@Override
	public PageParam findPage(PageParam pageParam) throws Exception {
		pageParam.setList(super.findPage(pageParam).getList());
		return pageParam;
	}

	public Feedback getHistoryFeedBackDetail(String id){
		return this.getDao().getHistoryFeedBackDetail(id);
	}
}

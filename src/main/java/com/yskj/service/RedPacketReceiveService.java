package com.yskj.service;

import com.yskj.dao.RedPacketReceiveDao;
import com.yskj.models.PageParam;
import com.yskj.models.RedPacket;
import com.yskj.service.base.AbstractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RedPacketReceiveService extends AbstractService {
    @Autowired
    private RedPacketReceiveDao redPacketReceiveDao;

    public RedPacketReceiveService() {
        super();
    }

    @Override
    public RedPacketReceiveDao getDao() {
        return this.redPacketReceiveDao;
    }

    /**
     * 根据用户 id 查询分页的红包列表
     *
     * @param pageParam
     * @return
     */
    public List<RedPacket> findListByUserIdPage(PageParam pageParam) {
        return redPacketReceiveDao.findListByUserIdPage(pageParam);
    }

}

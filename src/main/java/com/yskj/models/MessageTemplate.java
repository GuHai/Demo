package com.yskj.models;

import com.yskj.models.template.*;
import lombok.Data;

import java.util.HashMap;
import java.util.Map;

/**
 * 消息模板
 *
 * @author:Administrator
 * @create 2018-07-02 15:56
 */

@Data
public class MessageTemplate extends BaseEntity{

    private static final long serialVersionUID = 1L;

    public MessageTemplate() {
        super();
    }

    private String templateID;
    private String type;
    private String title;

    private String openID;
    private String url;
    private String first ;
    private String remark;
    private Map<String,Map<String,String>> data = new HashMap<String,Map<String,String>>();
    private QZ_LQ qz_lq;
    private QZ_GZFF qz_gzff;
    private QZ_MRGZ qz_mrgz;
    private QZ_WLQ qz_wlq;
    private QZ_HBTX qz_hbtx;
    private ZP_BMTX zp_bmtx;
    private ZP_CJS zp_cjs;
    private ZP_QDTX zp_qdtx;
    private QZ_WDG qz_wdg;
    private PT_TXTZ pt_txtz;
    private QZ_ZWTZ qz_zwtz;
    private PT_BBGX pt_bbgx;
    private ZP_WYPF zp_wypf;
    private PT_GDXX pt_gdxx;
    private PT_SHTZ pt_shtz;
    private ZP_ZZTZ zp_zztz;
    private PT_YHZX pt_yhzx;

    public void setRemark(String msg){
        this.remark = "\n\r"+msg;
    }

    public void setFirst(String msg){
        this.first = msg+"\n\r";
    }

}

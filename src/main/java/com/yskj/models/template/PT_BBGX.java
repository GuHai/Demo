package com.yskj.models.template;

import lombok.Data;

/**
 * 版本更新
 *
 * @author:Administrator
 * @create 2018-08-14 17:39
 */


//
//项目：{{keyword1.DATA}}
//服务器：{{keyword2.DATA}}
//版本：{{keyword3.DATA}}
//状态：{{keyword4.DATA}}

@Data
public class PT_BBGX {
    private String s0objectName;
    private String s1server;
    private String s2versionNo;
    private String s3status;
}

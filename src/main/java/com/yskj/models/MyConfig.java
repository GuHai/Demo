package com.yskj.models;

/**
 * 微信支付配置
 *
 * @author:Administrator
 * @create 2018-03-16 16:15
 */
import com.github.wxpay.sdk.WXPayConfig;
import com.yskj.service.base.DictCacheService;

import java.io.*;

public class MyConfig implements WXPayConfig{

    private byte[] certData;

    public MyConfig() throws  IOException{
        String certPath = "/path/to/apiclient_cert.p12";
        File file = new File(certPath);
        InputStream certStream = new FileInputStream(file);
        this.certData = new byte[(int) file.length()];
        certStream.read(this.certData);
        certStream.close();
    }

    public String getAppID() {
        return DictCacheService.AppID;
    }

    public String getMchID() {
        return DictCacheService.MerchantNo;
    }

    public String getKey() {
        return DictCacheService.ApiSecret;
    }

    public InputStream getCertStream() {
        ByteArrayInputStream certBis = new ByteArrayInputStream(this.certData);
        return certBis;
    }

    public int getHttpConnectTimeoutMs() {
        return 8000;
    }

    public int getHttpReadTimeoutMs() {
        return 10000;
    }
}
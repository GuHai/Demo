package com.yskj.service.base;

import com.yskj.redis.RedisUtil;
import com.yskj.utils.DateUtils;
import com.yskj.utils.HttpUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.*;

/**
 * 字典类
 *
 * @author:Administrator
 * @create 2018-01-21 13:39
 */
@Service
public class DictCacheService {
    public static String OUT_JAVA_PATH = "C:/generalCode";
    private final static Logger logger = LoggerFactory.getLogger(DictCacheService.class);
    private static  Map<String,String> position  ;

    public static String AppID ;
    public static String AppSecret;
    public static String AppToken;
    public static String UploadPath;
    public static String UploadUrl;
    public static String RedirectUri;
    public static String MerchantNo;
    public static String SCOPE;
    public static String STATE;
    public static String RESPONSE_TYPE;
    public static String PaymentUrl;
    public static String ApiSecret;
    public static String FindJob;
    public static String Information;
    public static String Personal;
    public static String Follow;
    public static String Share;
    public static String  Gzh;
    public static String Site;
    public static String Protocol;
    public static String ChatServerIP;
    public static volatile String ACCESSTOKEN;
    private static Date ACCESSTOKENTime;
    public static String GzhID;
    public static String EmailAccount;
    public static String EmailPassword;
    public static String EmailSendHost;
    public static String Bonds;
    public static List<BigDecimal> bondList;
    public static String Version;
    @PostConstruct
    public  void init(){
        position = new HashMap<String, String>();
        position.put("0001","模特");
        position.put("0002","发传单");
        try {
            String os = System.getProperty("os.name");
            readConfig(os.toLowerCase().startsWith("windows")?false:true);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }
    //读取配置文件
    public void readConfig(boolean isLinux)throws Exception{
        Properties properties=new Properties();
        //获得输入流
        InputStream is=DictCacheService.class.getClassLoader().getResourceAsStream("ijob.properties");
        properties.load(is);
        is.close();
        AppID = (String)properties.get("weixin.AppID");
        AppSecret = (String)properties.get("weixin.AppSecret");
        AppToken = (String)properties.get("weixin.AppToken");
        MerchantNo = (String)properties.get("weixin.MerchantNo");
        SCOPE = (String)properties.get("weixin.SCOPE");
        STATE = (String)properties.get("weixin.STATE");
        RESPONSE_TYPE = (String)properties.get("weixin.RESPONSE_TYPE");
        PaymentUrl = (String)properties.get("weixin.PaymentUrl");
        ApiSecret = (String)properties.get("weixin.ApiSecret");
        Protocol = (String)properties.get("web.Protocol");
        Site = Protocol+"://"+(String)properties.get("web.Url");

        FindJob = Site+(String)properties.get("weixin.menu.FindJob");
        Information = Site+(String)properties.get("weixin.menu.Information");
        Personal =  Site+(String)properties.get("weixin.menu.Personal");
        Follow =  Site+(String)properties.get("weixin.menu.Follow");
        Share =  Site+(String)properties.get("weixin.menu.Share");
        Gzh =  Site+(String)properties.get("weixin.menu.Gzh");
        RedirectUri = Site+(String)properties.get("weixin.RedirectUri");
        ChatServerIP = (String)properties.get("web.chatServerIP");
        GzhID  = (String)properties.get("weixin.GzhID");

        UploadPath = (String)properties.get(isLinux?"linux.upload.path":"windows.upload.path");
        UploadUrl = (String)properties.get("upload.url");

        EmailAccount  = (String)properties.get("ijob.email.account");
        EmailPassword  = (String)properties.get("ijob.email.password");
        EmailSendHost = (String)properties.get("ijob.email.host.send");

        Bonds = (String)properties.get("ijob.position.bond");
//        Version = (String)properties.get("ijob.version");
        Version = DateUtils.format(new Date(),"hhmmss");
        bondList = new ArrayList<BigDecimal>();
        for(String bond:Bonds.split(",")){
            bondList.add( new BigDecimal(bond));
        }



    }

    public  static String  getPosition(String value){
        for(String key : position.keySet()){
            if(position.get(key).equals(value)){
                return key;
            }
        }
        return null;
    }


    public static String getAccessToken(){
        synchronized(DictCacheService.class){
            if(ACCESSTOKEN == null){
                return  getNewAccessToken();
            }else{
//                return RedisUtil.getStringValue("AccessToken").toString();
                return ACCESSTOKEN;
            }
        }
    }

    public static void refreshAccessToken(){
        synchronized(DictCacheService.class){
            getNewAccessToken();
        }
    }

    private static synchronized String getNewAccessToken(){
        String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+AppID+"&secret="+AppSecret;
        Map<String,String> map   =  HttpUtils.getWinxinResult(url);
        String token = map.get("access_token");
        RedisUtil.setStringValue("AccessToken",token,7200L);
        ACCESSTOKEN = token;
        logger.info("newtoken:"+token);
        return token;
    }

}

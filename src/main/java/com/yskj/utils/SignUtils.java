package com.yskj.utils;
import com.github.wxpay.sdk.WXPayUtil;
import com.yskj.service.base.DictCacheService;

import javax.servlet.http.HttpServletRequest;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Map;
import java.util.Random;

/**
 * 微信的token校验工具
 *
 * @author:Administrator
 * @create 2018-01-26 16:24
 */
public class SignUtils {
    
    //加密方法

    private static String SHA1(String strs) {
        try {
            MessageDigest digest = java.security.MessageDigest.getInstance("SHA-1");
            digest.update(strs.getBytes());
            byte messageDigest[] = digest.digest();
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < messageDigest.length; i++) {
                String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
                if (shaHex.length() < 2) {
                    hexString.append(0);
                }
                hexString.append(shaHex);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "";
    }
    public static boolean check(String signature,String  timestamp, String nonce,String token){
        String[] arr = {token, timestamp, nonce };
        Arrays.sort(arr);
        String str="";
        for (int i = 0; i < arr.length; i++) {
            str+=arr[i];
        }
        String pwd= SHA1(str);
        if(pwd.equals(signature)){
            return true;
        }else{
            return false;
        }
    }

    //键值对排序然后拼接
    private static String getSignatureString(Map<String,String> param){
        String[] arr = new String[param.keySet().size()];
        int i=0;
        for(String key : param.keySet()){
            arr[i++] = key;
        }
        Arrays.sort(arr);
        String str="";
        for(String key : arr){
            String value = param.get(key);
            str += (key+"="+value+"&");
        }
        str = str.substring(0,str.length()-1);
        return str;
    }

    public static String getSignatureBySHA1(Map<String,String> param){
        return SHA1(getSignatureString(param));
    }

    public static String getSignatureByMD5toUpperCase(Map<String,String> param){
        String str = getSignatureString(param);
        str += ("&key="+ DictCacheService.ApiSecret);
//        return MD5Tools.MD5Encode(str, "UTF-8").toUpperCase();
        try {
            return WXPayUtil.MD5(str);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

/*
    *//**
     * 获取签名 md5加密(微信支付必须用MD5加密)
     * 获取支付签名
     * @param params
     * @return
     *//*
    public static String getSign(SortedMap<String, String> params){
        String sign = null;
        StringBuffer sb = new StringBuffer();
        Set es = params.entrySet();
        Iterator iterator = es.iterator();
        while(iterator.hasNext()){
            Map.Entry entry = (Map.Entry)iterator.next();
            String k = (String)entry.getKey();
            String v = (String)entry.getValue();
            if (null != v && !"".equals(v) && !"sign".equals(k)&& !"key".equals(k)) {
                sb.append(k+"="+v+"&");
            }
        }
        sb.append("key="+ DictCacheService.AppSecret);
        sign = MD5Tools.MD5Encode(sb.toString(), "UTF-8").toUpperCase();
        return sign;
    }*/


    /**
     * 获取一定长度的随机字符串
     * @param length 指定字符串长度
     * @return 一定长度的字符串
     */
    public static String getRandomStringByLength(int length) {
        String base = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < length; i++) {
            int number = random.nextInt(base.length());
            sb.append(base.charAt(number));
        }
        return sb.toString();
    }

    /**
     * 获取用户真实IP地址，不使用request.getRemoteAddr();的原因是有可能用户使用了代理软件方式避免真实IP地址,
     *
     * 可是，如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP值，究竟哪个才是真正的用户端的真实IP呢？
     * 答案是取X-Forwarded-For中第一个非unknown的有效IP字符串。
     *
     * 如：X-Forwarded-For：192.168.1.110, 192.168.1.120, 192.168.1.130,
     * 192.168.1.100
     *
     * 用户真实IP为： 192.168.1.110
     *
     * @param request
     * @return
     */
    public static String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}

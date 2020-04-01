package com.yskj.utils;

import com.google.gson.Gson;
import com.yskj.models.BaseEntity;
import com.yskj.service.base.DictCacheService;
import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * IJob常用工具
 *
 * @author:Administrator
 * @create 2018-01-21 12:14
 */
public class IJobUtils {
    public static String getNextSort(String sort,int len){
        int sortint = 0;
        if(StringUtils.isNotEmpty(sort)){
            sortint = Integer.parseInt(sort.substring(sort.length()-len));
        }
        sortint++;
        String tempSort =  "00000000"+sortint;
        return tempSort.substring(tempSort.length()-4,tempSort.length());
    }

    //翻译是否管饭
    public static String formatBoard(String status){
        String str = "早饭,中饭,晚饭,宵夜";
        String result = "";
        String[] ss = status.split("");
        for(int i=0;i<ss.length;i++){
            if(ss[i].equals("1")){
                result += "管"+ str.split(",")[i]+ " ";
            }
        }
        return result;
    }

    //翻译结算方式 1,日结;2,周结;3,月结;4,完工结算
    public static String formatSettlement(int status){
        String str = "日结,周结,月结,完工结算";
        return str.split(",")[status-1];
    }

    //翻译性别需求  0女 1男 2人妖
    public static String formatSex(int status){
        String str = "女,男,男女不限";
        return str.split(",")[status];
    }

    public static Object createObject(Class clazz){
        try {
            return clazz.newInstance();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static <ENTITY extends BaseEntity> ENTITY getNotNullObject(ENTITY object,ENTITY newObject){
        if(object!=null)return object;
        else return newObject;
    }

    /**
     * 将文字转为汉语拼音
     * @param ChineseLanguage 要转成拼音的中文
     */
    public static String toHanyuPinyin(String ChineseLanguage){
        char[] cl_chars = ChineseLanguage.trim().toCharArray();
        String hanyupinyin = "";
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
        defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);// 输出拼音全部小写
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);// 不带声调
        defaultFormat.setVCharType(HanyuPinyinVCharType.WITH_V) ;
        try {
            for (int i=0; i<cl_chars.length; i++){
                if (String.valueOf(cl_chars[i]).matches("[\u4e00-\u9fa5]+")){// 如果字符是中文,则将中文转为汉语拼音
                    hanyupinyin += PinyinHelper.toHanyuPinyinStringArray(cl_chars[i], defaultFormat)[0];
                } else {// 如果字符不是中文,则不转换
                    hanyupinyin += cl_chars[i];
                }
            }
        } catch (BadHanyuPinyinOutputFormatCombination e) {
            System.out.println("字符不能转成汉语拼音");
        }
        return hanyupinyin;
    }

    /**
     * 将文字转为汉语拼音
     * @param ChineseLanguage 要转成拼音的中文
     */
    public static String toHanyuPinyinFirstChar(String ChineseLanguage){
        char[] cl_chars = ChineseLanguage.trim().toCharArray();
        String hanyupinyin = "";
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
        defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);// 输出拼音全部小写
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);// 不带声调
        defaultFormat.setVCharType(HanyuPinyinVCharType.WITH_V) ;
        try {
            for (int i=0; i<cl_chars.length; i++){
                if (String.valueOf(cl_chars[i]).matches("[\u4e00-\u9fa5]+")){// 如果字符是中文,则将中文转为汉语拼音
                    hanyupinyin += PinyinHelper.toHanyuPinyinStringArray(cl_chars[i], defaultFormat)[0].substring(0,1);
                } else if(String.valueOf(cl_chars[i]).matches("[0-9a-zA-Z]")) {// 如果字符不是中文,则不转换
                    hanyupinyin += cl_chars[i];
                }
            }
        } catch (BadHanyuPinyinOutputFormatCombination e) {
            System.out.println("字符不能转成汉语拼音");
        }
        return hanyupinyin;
    }

    public static String getDistrictByAddr(String addr){
        int s1 = addr.indexOf("市");
        int s2 = addr.indexOf("州");
        int s  = Math.min(s1,s2)==-1?Math.max(s1,s2):Math.min(s1,s2);
        int e1 = addr.indexOf("区",s+1);
        int e2 = addr.indexOf("县",s+1);
        int e3 = addr.indexOf("市",s+1);

        int e  = Math.min(e1,e2)==-1?Math.max(e1,e2):Math.min(e1,e2);
        if(e3>-1){
            e = Math.min(e,e3)==-1?Math.max(e,e3):Math.min(e,e3);
        }
        return addr.substring(s+1,e+1);
    }



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

    public static String getTemplate(String reviceTemp, Map<String,String> map ,String msg){
       return  reviceTemp.replace("${toUser}", map.get("FromUserName")).
                replace("${fromUser}", map.get("ToUserName")).
                replace("${CreateTime}", new Date().getTime()  +"").
                replace("${msg}", msg);
    }

}

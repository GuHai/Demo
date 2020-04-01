package com.yskj.utils;

import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;
import org.junit.Test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.util.*;

/**
 * 时间转换工具
 *
 * @author:Administrator
 * @create 2018-01-31 15:46
 */
public class DateUtils {

    // G 年代标志符
    //  y 年
    //  M 月
    //  d 日
    //  h 时 在上午或下午 (1~12)
    //  H 时 在一天中 (0~23)
    //  m 分
    //  s 秒
    //  S 毫秒
    //  E 星期
    //  D 一年中的第几天
    //  F 一月中第几个星期几
    //  w 一年中第几个星期
    //  W 一月中第几个星期
    //  a 上午 / 下午 标记符
    //  k 时 在一天中 (1~24)
    //  K 时 在上午或下午 (0~11)
    //  z 时区
    public static String formatMdW(Date date ){
        return format(date,"MM月dd日（E）");
    }

    public static String formatYMd(Date date ){
        return format(date,"yyyy年MM月dd日");
    }

    public static String formatYM(Date date ){
        return format(date,"yyyy-MM");
    }

    public static String getDateByMinute(Integer number){
        return fullNum(number/60)+":"+fullNum(number%60);
    }

    private static String fullNum(Integer number){
        return (number<10?"0":"")+number;
    }

    /**
     * 获取当前时间 yyyyMMddHHmmss
     * @return String
     */
    public static String getCurrTime() {
        Date date  = new Date();
        return format(date,"yyyyMMddHHmmss");
    }

    public static String format(Date date ,String format){
        //用给定的模式和默认语言环境的日期格式符号构造 SimpleDateFormat
        SimpleDateFormat date1  = new SimpleDateFormat(format);
        String str =date1.format(date);
        return str;
    }
    public static String formatByNum(int num){
        return fullNum(num/60)+":"+fullNum(num%60);
    }
    private static String fullNum(int num){
        return (num<10?"0":"")+num;
    }

    public static Boolean isWorkDayByToday(String date){

        return isWorkDay(date,new Date());

    }

    public static Boolean isWorkDayByTomorrow(String date){

        return isWorkDay(date,new Date(new Date().getTime()+24*3600000));

    }

    public static Boolean isSameDay(Date date1 ,Date date2){
        SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
        return fmt.format(date1).equals(fmt.format(date2));
    }


    //判断是不是最后一天
    public static Boolean isWorkDay(String date,Date currentDate){
        Gson gson = new Gson();
        HashMap map = gson.fromJson(date,HashMap.class);
        System.out.println(map);
        Object year = map.get((currentDate.getYear()+1900)+"");
        if(year!=null){
            Object month = ((LinkedTreeMap)year).get((currentDate.getMonth()+1)+"");
            if(month!=null){
                Object day = ((LinkedTreeMap)month).get(currentDate.getDate()+"");
                if(day!=null)return true;
            }
        }
        return false;
    }

    //判断是不是最后一天
    public static Boolean isLastWorkDay(String date,Date currentDate){
        Date lastDate  = getLastDay(date);
        if((currentDate.getTime()-lastDate.getTime())>0){
            return true;
        }else{
            return  false;
        }
    }

    private static Date getLastDay(String datetime){
        Gson gson = new Gson();
        LinkedTreeMap map = gson.fromJson(datetime,LinkedTreeMap.class);
        Integer year = getMaxNumFromMap(map);
        map = (LinkedTreeMap) map.get(year.toString());
        Integer month = getMaxNumFromMap(map);
        map = (LinkedTreeMap) map.get(month.toString());
        Integer day = getMaxNumFromMap(map);
        //设置为10分钟的时候，防止定时器执行时间太长超过了第二天的最后时间
        return new Date(year-1900,month-1,day,0,10);
    }

    private static  Integer getMaxNumFromMap(LinkedTreeMap map ){
        Integer num = 0;
        for(Object key : map.keySet()){
            if(Integer.parseInt(key.toString())>num){
                num = Integer.parseInt(key.toString());
            }
        }
        return num;
    }




    public static Long compare(Date start ,Date end){
        return (start.getTime()-end.getTime())/1000;
    }

    public static Date getDateFromString(String string){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return sdf.parse(string);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String getDateFromArr(List<Date> dateList){
        Map<String,Object> datejson = new HashMap<String,Object>();
        for (Date date : dateList) {

            String year = (date.getYear()+1900)+"";
            String month = (date.getMonth()+1)+"";
            String day = date.getDate()+"";
            if (datejson.get(year)==null) {
                datejson.put(year,new HashMap<String,Object>());
            }
            if (  ((HashMap<String,Object>)datejson.get(year)).get(month)==null ) {
                ((HashMap<String,Object>)datejson.get(year)).put(month,new HashMap<String,Object>());
            }
            ((HashMap<String,Object>)((HashMap<String,Object>)datejson.get(year)).get(month)).put(day,true);
        }
        return new Gson().toJson(datejson);
    }

    //{"2018":{"6":{"26":true,"27":true,"28":true}}}
    public static List<String> getDataListFromString(String date){
        List<String> dates = new ArrayList<String>();
        if (StringUtils.isNotEmpty(date)) {
            Map<String,Object> datejson  = new Gson().fromJson(date,HashMap.class);
            for (String yk : datejson.keySet()) {
                Map<String,Object> yv = (Map<String,Object>)datejson.get(yk);
                for (String mk : yv.keySet()) {
                    Map<String,Boolean> mv = (Map<String,Boolean>)yv.get(mk);
                    for(String dk : mv.keySet()){
                        dates.add(yk+"-"+mk+"-"+dk);
                    }
                }
            }
        }
        return dates;
    }

    public static int countDaysInMonth(Month month){
        return LocalDate.now()
                .withMonth(month.getValue())
                .lengthOfMonth();
    }

    public static Integer getValidDateNum(String datestr,Integer num){
        List<String> dates = getDataListFromString(datestr);
        List<String> newDates = new ArrayList<String>();
        Date now = new Date();
        for(String date : dates){
            Date cdate = getDateByYMD(date);
            if(num>0 || cdate.getTime()>now.getTime()){
                newDates.add(date);
            }
        }
        return newDates.size()*num;
    }
    public static String  updateDateNum(String date,Integer add){
        Map<String,Object> datejson  = new Gson().fromJson(date,HashMap.class);
        if (StringUtils.isNotEmpty(date)) {
            for (String yk : datejson.keySet()) {
                Map<String,Object> yv = (Map<String,Object>)datejson.get(yk);
                for (String mk : yv.keySet()) {
                    Map<String,Object> mv = (Map<String,Object>)yv.get(mk);
                    for(String dk : mv.keySet()){
                        Integer newdate = Integer.parseInt(mv.get(dk).toString().split("\\.")[0])+add;
                        mv.put(dk,newdate);
                    }
                }
            }
        }
        return new Gson().toJson(datejson);
    }

    public static String  updateDateNumByBeen(String olddate,String mydate,Integer num){
        Map<String,Object> datejson  = new Gson().fromJson(mydate,HashMap.class);
        Map<String,Object> olddatejson  = new Gson().fromJson(olddate,HashMap.class);
        Date now = new Date();
        if (StringUtils.isNotEmpty(olddate)) {
            for (String yk : datejson.keySet()) {
                Map<String,Object> yv = (Map<String,Object>)datejson.get(yk);
                for (String mk : yv.keySet()) {
                    Map<String,Object> mv = (Map<String,Object>)yv.get(mk);
                    for(String dk : mv.keySet()){
                        Date cdate  = getDateByYMD(yk+"-"+mk+"-"+dk);
                        if(num<0  ||  cdate.getTime()>now.getTime()){ //为减的都改变 或者为加  则必须今天之前的工作都不能改  只需要改变今天之后的
                            Map<String,Object> dayMap  = ((Map<String,Object>)(((Map<String,Object>)olddatejson.get(yk)).get(mk)));
                            dayMap.put(dk,Integer.parseInt(dayMap.get(dk).toString().split("\\.")[0])+num);
                        }
                    }
                }
            }
        }
        return new Gson().toJson(olddatejson);
    }

    private static Date getDateByYMD(String date){
        return new Date(Integer.parseInt(date.split("-")[0])-1900,Integer.parseInt(date.split("-")[1])-1,Integer.parseInt(date.split("-")[2]));
    }

    public static Date getBirthdayByAge(Integer age ){
        Date now  = new Date();
        return new Date(now.getYear()-age,now.getMonth(),now.getDate());
    }

    /**
     * 根据身份证号获取年龄
     * @param certId
     * @return
     */
    public static String getAgeByCertId(String certId) {
        String birthday = "";
        if (certId.length() == 18) {
            birthday = certId.substring(6, 10) + "/"
                    + certId.substring(10, 12) + "/"
                    + certId.substring(12, 14);
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        Date now = new Date();
        Date birth = new Date();
        try {
            birth = sdf.parse(birthday);
        } catch (ParseException e) {
        }
        long intervalMilli = now.getTime() - birth.getTime();
        int age = (int) (intervalMilli/(24 * 60 * 60 * 1000))/365;
        return age +"";
    }
}

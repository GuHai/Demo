package com.yskj.component;

import com.google.gson.Gson;
import com.yskj.models.Account;
import com.yskj.models.QueryParam;
import com.yskj.models.TxAdmin;
import com.yskj.models.excel.WeeklyIn;
import com.yskj.redis.ProcessAssistant;
import com.yskj.redis.RedisUtil;
import com.yskj.redis.model.TemplateTaskPanel;
import com.yskj.service.*;
import com.yskj.service.base.DictCacheService;
import com.yskj.utils.DateUtils;
import com.yskj.utils.StringUtils;
import com.yskj.utils.excel.ExcelExportUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.File;
import java.math.BigDecimal;
import java.time.Month;
import java.util.*;

/**
 * 定时任务
 *
 * @author:Administrator
 * @create 2018-04-09 17:08
 */
@Component("taskJob")
public class
QuartzTask {
    private final static Logger logger = LoggerFactory.getLogger(QuartzTask.class);
    @Autowired
    private TodayJobService todayJobService;
    @Autowired
    private SigninService signinService;
    @Autowired
    private TomorrowJobService tomorrowJobService;
    @Autowired
    private TemplateTaskService templateTaskService;
    @Autowired
    private MessageTemplateService messageTemplateService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private TxAdminService txAdminService;
    @Autowired
    private WxorderService wxorderService;
    @Autowired
    private FollowService followService;
    @Autowired
    private SettlementService settlementService;
    /**
     * CRON表达式                含义
     "0 0 12 * * ?"            每天中午十二点触发
     "0 15 10 ? * *"            每天早上10：15触发
     "0 15 10 * * ?"            每天早上10：15触发
     "0 15 10 * * ? *"        每天早上10：15触发
     "0 15 10 * * ? 2005"    2005年的每天早上10：15触发
     "0 * 14 * * ?"            每天从下午2点开始到2点59分每分钟一次触发
     "0 0/5 14 * * ?"        每天从下午2点开始到2：55分结束每5分钟一次触发
     "0 0/5 14,18 * * ?"        每天的下午2点至2：55和6点至6点55分两个时间段内每5分钟一次触发
     "0 0-5 14 * * ?"        每天14:00至14:05每分钟一次触发
     "0 10,44 14 ? 3 WED"    三月的每周三的14：10和14：44触发
     "0 15 10 ? * MON-FRI"   每个周一、周二、周三、周四、周五的10：15触发
     */


    //关闭掉改为实时发送
    @Scheduled(cron = "0 0/5 * * * ?") //每五分钟查询一次
    public void templateTask(){
        /*logger.info("========templateTaskService.templateTask>start==========="+System.currentTimeMillis());
        QueryParam queryParam  = new QueryParam();
        queryParam.in("status", CollectionUtils.asList("1,2".split(",")));
        try {
            List<TemplateTask> templateTaskList =  templateTaskService.findList(queryParam);
            for(TemplateTask templateTask : templateTaskList){
                messageTemplateService.runTemplateTask(templateTask);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }*/
        if(RedisUtil.getStringValue("Heartbeat")==null){  //如果队列守护线程停止了，则在本机器上执行任务
            ProcessAssistant.processTasks(TemplateTaskPanel.class);
        }

    }

    /**
     * 每天23点59分触发（处理签到和未签到的数据）
     */
    @Scheduled(cron = "0 59 23 * * ?")
    public void signTask(){
        logger.info("========signinService.processSigninByTask>start==========="+System.currentTimeMillis());
        try {
            signinService.processSigninByTask(); //处理已到岗和未到岗
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("!!!!!!!!!!!!!!!processSigninByTask fail!!!!!!!!!!!!!!!");
            respAdmin("处理签到信息异常",e.getMessage());
        }
        try {
            signinService.processSignupNoSure(); //处理报名为待确认信息
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("!!!!!!!!!!!!!!!processSignupNoSure fail!!!!!!!!!!!!!!!");
            respAdmin("处理报名未确认信息异常",e.getMessage());
        }

        try{
            followService.clearTimes();
        }catch (Exception e){
            e.printStackTrace();
            logger.error("!!!!!!!!!!!!!!!clearTimes fail!!!!!!!!!!!!!!!");
            respAdmin("清除发送次数数据异常",e.getMessage());
        }
        logger.info("========signinService.processSignupNoSure>end==========="+System.currentTimeMillis());
    }

    public void respAdmin(String title ,String msg){
        try {
            //AliyunUtils.sendMessage("18607371493",title,msg);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 每天0点过1分触发（清空我的今日工作，生成新的今日工作）
     */
    @Scheduled(cron = "0 1 0 * * ?")
    public void todayJobTask(){
        logger.info("========" +
                ".generalTodayJob>start==========="+System.currentTimeMillis());
        try {
            todayJobService.generalTodayJob();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("!!!!!!!!!!!!!!!generalTodayJob fail!!!!!!!!!!!!!!!");
            respAdmin("处理我的今日工作异常",e.getMessage());
        }
        logger.info("========todayJobService.generalTodayJob>end==========="+System.currentTimeMillis());
    }


    /**
     * 每天5点触发（提现任务）9点到23点每个小时执行一次
     */
//    @Scheduled(cron = "0 * * * * ?")
    @Scheduled(cron="0 0 9-23 * * ?")
    public void txTask(){
        try {
            //生成未提现支付订单
            accountService.generalUnTxTask();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Scheduled(cron="0 59 8-22 * * ?")
    public void checkAccount(){
        try {
            //首先检查每天的账号是不是有异常信息
            accountService.chechAccount(null);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 每天12点过1分触发（清空我的明日工作，生成新的明日工作）
     */
    @Scheduled(cron = "0 0 12 * * ?")
    public void tomorrowJobTask(){
        logger.info("========tomorrowJobService.tomorrowJobTask>start==========="+System.currentTimeMillis());
        try {
            tomorrowJobService.generalTomorrowJob();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("!!!!!!!!!!!!!!!tomorrowJobTask fail!!!!!!!!!!!!!!!");
            respAdmin("处理我的明日工作异常",e.getMessage());
        }
        logger.info("========tomorrowJobService.tomorrowJobTask>end==========="+System.currentTimeMillis());
    }




    private static String WEEK_PATH = "iJob/file/report/week";
    private static String MONTH_PATH = "iJob/file/report/month";
    /**
     * "0 15 10 ? * MON-FRI"   每个周一、周二、周三、周四、周五的10：15触发
     */
    @Scheduled(cron = "0 10 0 ? * MON")  //每周一0点过10触发
    public void financeWeekTask(){
        logger.info("========financeWeekTask>start==========="+System.currentTimeMillis());
        try {
            TxAdmin txAdmin = txAdminService.one(new QueryParam());
            String to  = txAdmin.getEmail();
            Integer day = 7;
            QueryParam queryParam = new QueryParam();
            queryParam.put("type",5);
            queryParam.put("isPass",Boolean.TRUE);
            queryParam.put("interval",day);
            List<Account> accounts = accountService.findList(queryParam);
            List<WeeklyIn> weeklyOuts = new  ArrayList<WeeklyIn>();
            for(Account account : accounts){
                if(StringUtils.isNotEmpty(account.getAccID())){
                    queryParam.clear();
                    queryParam.put("accIds","'"+account.getAccID().replaceAll(",","','")+"abcdefg'");
                    List<WeeklyIn> weeklyIns  =  accountService.weeklyReportForB(queryParam);
                    for(WeeklyIn weeklyIn : weeklyIns){
                        if(StringUtils.isNotEmpty(weeklyIn.getAccID()) && weeklyIn.getAccID().length()>50){//肯定是多个单了
                            String realmoeny = new Gson().fromJson(weeklyIn.getAccID(), HashMap.class).get(account.getId()).toString();
                            weeklyIn.setMoney(new BigDecimal(realmoeny));
                        }
                        weeklyOuts.add(weeklyIn);
                    }
                }
            }

            List<WeeklyIn> weeklyIns = accountService.weeklyReportForA(new QueryParam("interval",day));
            String datestr = DateUtils.format(new Date(), "yyyy-MM-dd");
            String path =  DictCacheService.UploadPath + File.separator + WEEK_PATH  ;
            ExcelExportUtil.general(path,weeklyIns,datestr+"A");
            ExcelExportUtil.general(path,weeklyOuts,datestr+"B");
            String[] filenames = new String[2];
            filenames[0] = datestr+"A.xlsx";
            filenames[1] = datestr+"B.xlsx";
            ExcelExportUtil.sendMailAndAtta(to, DateUtils.formatYMd(new Date())+"入账周报表","一生科技入账周报表",filenames,path);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("!!!!!!!!!!!!!!!financeWeekTask fail!!!!!!!!!!!!!!!");
            respAdmin("处理我的财务报表失败",e.getMessage());
        }
        logger.info("========financeWeekTask>end==========="+System.currentTimeMillis());
    }


    @Scheduled(cron = "0 15 0 1 * ?")  //每个月一号 零点15分
//   @Scheduled(cron = "0 21 9 * * ?")
    public void financeMonthTask(){
        logger.info("========financeMonthTask>start==========="+System.currentTimeMillis());
        try {
            TxAdmin txAdmin = txAdminService.one(new QueryParam());
            String to  = txAdmin.getEmail();
            Date date  = new Date(new Date().getTime()-3600000*24);//获取上一个
            Integer day = DateUtils.countDaysInMonth(Month.of(date.getMonth()+1));
            QueryParam queryParam = new QueryParam();
            queryParam.put("type",5);
            queryParam.put("isPass",Boolean.TRUE);
            queryParam.put("interval",day);
            List<Account> accounts = accountService.findList(queryParam);
            List<WeeklyIn> weeklyOuts = new  ArrayList<WeeklyIn>();
            for(Account account : accounts){
                if(StringUtils.isNotEmpty(account.getAccID())){
                    queryParam.clear();
                    queryParam.put("accIds","'"+account.getAccID().replaceAll(",","','")+"abcdefg'");
                    List<WeeklyIn> weeklyIns  =  accountService.weeklyReportForB(queryParam);
                    for(WeeklyIn weeklyIn : weeklyIns){
                        if(StringUtils.isNotEmpty(weeklyIn.getAccID()) && weeklyIn.getAccID().length()>50){//肯定是多个单了
                            String realmoeny = new Gson().fromJson(weeklyIn.getAccID(), HashMap.class).get(account.getId()).toString();
                            weeklyIn.setMoney(new BigDecimal(realmoeny));
                        }
                        weeklyIn.setTime(account.getUpdateTime());
                        weeklyOuts.add(weeklyIn);
                    }
                }
            }
            List<WeeklyIn> weeklyIns = accountService.weeklyReportForA(new QueryParam("interval",day));
            String datestr = DateUtils.format(date, "yyyy-MM");
            String path =  DictCacheService.UploadPath + File.separator + MONTH_PATH  ;
            ExcelExportUtil.general(path,weeklyIns,datestr+"A");
            ExcelExportUtil.general(path,weeklyOuts,datestr+"B");
            String[] filenames = new String[2];
            filenames[0] = datestr+"A.xlsx";
            filenames[1] = datestr+"B.xlsx";
            ExcelExportUtil.sendMailAndAtta(to,DateUtils.formatYM(date)+"入账月报表","一生科技入账月报表",filenames,path);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("!!!!!!!!!!!!!!!financeMonthTask fail!!!!!!!!!!!!!!!");
            respAdmin("处理我的财务报表失败",e.getMessage());
        }
        logger.info("========financeMonthTask>end==========="+System.currentTimeMillis());
    }

    //退款，如果有那种付款了，但是没有正常办理业务的，都退款  改为当天处理一次，不然会有很多幺蛾子
//    @Scheduled(cron = "0 * * * * ?")
    @Scheduled(cron="30 59 8-22 * * ?")
    public void refundTask() {
        logger.info("========refundTask>start===========" + System.currentTimeMillis());
        QueryParam queryParam = new QueryParam();
        queryParam.put("status",2);
        try {
            accountService.refundAuto(queryParam);
            wxorderService.clearGarbageOrder();
            settlementService.clearGarbageOrder();
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("========refundTask>end===========" + System.currentTimeMillis());
    }

}
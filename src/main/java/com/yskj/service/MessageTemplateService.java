package com.yskj.service;

import com.google.gson.Gson;
import com.yskj.dao.MessageTemplateDao;
import com.yskj.exception.IJobException;
import com.yskj.models.*;
import com.yskj.models.auth.User;
import com.yskj.models.template.*;
import com.yskj.redis.RedisUtil;
import com.yskj.redis.model.TemplateTaskPanel;
import com.yskj.service.auth.UserService;
import com.yskj.service.base.AbstractService;
import com.yskj.service.base.DictCacheService;
import com.yskj.utils.DateUtils;
import com.yskj.utils.HttpUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.*;

/**
 * 消息模板
 *
 * @author:Administrator
 * @create 2018-07-02 15:46
 */
@Service
public class MessageTemplateService  extends AbstractService {
    @Autowired
    private MessageTemplateDao messageTemplateDao;
    @Autowired
    private TemplateTaskService templateTaskService;
    @Autowired
    private FollowService followService;
    @Autowired
    private WorkListService workListService;
    @Autowired
    private TxAdminService txAdminService;
    @Autowired
    private UserService userService;
    public MessageTemplateService() {
        super();
    }

    @Override
    public MessageTemplateDao getDao() {
        return this.messageTemplateDao;
    }

    private String template = "{\n" +
            "           \"touser\":\"${openID}\",\n" +
            "           \"template_id\":\"${templateID}\",\n" +
            "           \"url\":\"${url}\",  \n" +
            "           \"miniprogram\":{\n" +
            "             \"appid\":\"\",\n" +
            "             \"pagepath\":\"\"\n" +
            "           },          \n" +
            "           \"data\":${data}\n" +
            "       }";



    private String getParam(MessageTemplate messageTemplate){
        String template = this.template.replace("${openID}",messageTemplate.getOpenID())
                .replace("${templateID}",messageTemplate.getTemplateID())
                .replace("${url}",messageTemplate.getUrl())
                .replace("${data}",new Gson().toJson(messageTemplate.getData()));
        return template;
    }

    private TemplateTaskPanel addTemplateTask(MessageTemplate messageTemplate) throws Exception{
        TemplateTaskPanel templateTask = new TemplateTaskPanel();
        templateTask.setUrl(messageTemplate.getUrl());
        templateTask.setTemplateID(messageTemplate.getTemplateID());
        templateTask.setOpenID(messageTemplate.getOpenID());
        templateTask.setData(new Gson().toJson(messageTemplate.getData()));
        templateTask.setStatus(0);
//        templateTaskService.add(templateTask);
        return templateTask;
    }

    public void runTemplateTask(TemplateTask templateTask){
        try{
            String template = this.template.replace("${openID}",templateTask.getOpenID())
                    .replace("${templateID}",templateTask.getTemplateID())
                    .replace("${url}",templateTask.getUrl())
                    .replace("${data}",templateTask.getData());
            //先改变状态，然后发送消息
            templateTask.setStatus(1);
            templateTaskService.update(templateTask);
            Map result = sendMessage(template);
            if(result.get("errcode")!=null){
                if("ok".equals(result.get("errmsg").toString())){  //如果成功了怎么样
                    templateTask.setErrmsg(result.get("errmsg").toString());
                    templateTaskService.update(templateTask);
                }else{ //如果不成功怎么样
                    //require subscribe hint  如果是未关注的，直接删除掉算了
                    if(result.get("errmsg").toString().startsWith("require subscribe hint")){
                        templateTaskService.physicalDelete(templateTask);
                    }else{
                        DictCacheService.refreshAccessToken();
                        if(templateTask.getVersion()<5){  //版本小于7次的时候，重新调用该方法
                            runTemplateTask(templateTask);
                        }else{
                            templateTask.setErrmsg(result.get("errmsg").toString());
                            templateTaskService.update(templateTask);
                        }
                    }

                }

            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //录取
    @Async
    public  void  qzLq(Position position, Beenrecruited beenrecruited,User user){
        try{
            QueryParam queryParam = new QueryParam("type","QZ_LQ");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("恭喜，你报名的"+position.getTitle()+"岗位，已通过录取");
            messageTemplate.setRemark("请及时到岗，切勿迟到");
            messageTemplate.setOpenID(user.getWeChatNo());
            QZ_LQ qz_lq = new QZ_LQ();
            qz_lq.setS0jobName(position.getTitle());
            qz_lq.setS1salary(position.getDailySalary()+"元/天");
            qz_lq.setS2date(String.join(",", DateUtils.getDataListFromString(beenrecruited.getWorkDate())));
            qz_lq.setS3address(position.getWorkPlace().getDetailedAddress());
            qz_lq.setS4telphone(user.getPhoneNumber());
            messageTemplate.setQz_lq(qz_lq);
            sendMessageHandler(sortFieldList(messageTemplate.getQz_lq().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getQz_lq());
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    //未录取
    @Async
    public  void  qzWlq(Position position, Beenrecruited beenrecruited,User user ){
        try{
            QueryParam queryParam = new QueryParam("type","QZ_WLQ");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("很遗憾，你投递的"+position.getTitle()+"岗位未能被录取");
            messageTemplate.setRemark("请继续努力");
            messageTemplate.setOpenID(user.getWeChatNo());
            QZ_WLQ qz_wlq = new QZ_WLQ();
            qz_wlq.setS0jobName(position.getTitle());
            qz_wlq.setS1duty(position.getTitle());
            qz_wlq.setS2date(DateUtils.format(beenrecruited.getSignUp(),"yyyy-MM-dd HH:mm:ss"));
            messageTemplate.setQz_wlq(qz_wlq);
            sendMessageHandler(sortFieldList(messageTemplate.getQz_wlq().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getQz_wlq());
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //工资发放
    @Async
    public  void  qzGzff(Position position , Settlementperson settlementperson,User user ){
        try{
            QueryParam queryParam = new QueryParam("type","QZ_GZFF");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("恭喜你，你完成的"+position.getTitle()+"岗位工资已转到工资卡");
            if(settlementperson.getSxf()!=null&&settlementperson.getSxf().compareTo(BigDecimal.ZERO)>0){
                messageTemplate.setRemark("扫码结算薪资共"+(settlementperson.getSettlementMoney().subtract(settlementperson.getSxf()))+"元，企业另赠送您"+settlementperson.getSxf()+"元用于抵扣提现手续费，已纳入工资卡");
            }else{
                messageTemplate.setRemark("扫码结算薪资共"+settlementperson.getSettlementMoney()+"元");
            }
            messageTemplate.setOpenID(user.getWeChatNo());
            QZ_GZFF qz_gzff = new QZ_GZFF();
            qz_gzff.setS0jobName(position.getTitle());
            qz_gzff.setS1salary(settlementperson.getSettlementMoney().toString()+"元");
            qz_gzff.setS2state("已发放");
            messageTemplate.setQz_gzff(qz_gzff);
            sendMessageHandler(sortFieldList(messageTemplate.getQz_gzff().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getQz_gzff());
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    //转账通知
    @Async
    public  void  zpZztz(String openID,String payee,String remitter,BigDecimal money ){
        try{
            QueryParam queryParam = new QueryParam("type","ZP_ZZTZ");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("您收到一笔转账提醒");
            messageTemplate.setRemark("谢谢您的使用");
            messageTemplate.setOpenID(openID);
            ZP_ZZTZ zp_zztz = new ZP_ZZTZ();
            zp_zztz.setS0payee(payee);
            zp_zztz.setS1remitter(remitter);
            zp_zztz.setS2money(money+"元");
            zp_zztz.setS3date(DateUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
            messageTemplate.setZp_zztz(zp_zztz);
            sendMessageHandler(sortFieldList(messageTemplate.getZp_qdtx().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getZp_qdtx());
        }catch (Exception e){
            e.printStackTrace();
        }

    }


    //催结算
    @Async
    public  void  zpCjs(Position position ,User user,String openID){
        try{
            QueryParam queryParam = new QueryParam("type","ZP_CJS");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("你发布的"+position.getTitle()+"岗位，收到一个结算请求");
            messageTemplate.setRemark("请及时处理");
            messageTemplate.setOpenID(openID);
            ZP_CJS zp_cjs = new ZP_CJS();
            zp_cjs.setS0name(user.getMainName());
            zp_cjs.setS1jobName(position.getTitle());
            zp_cjs.setS2date(DateUtils.format(new Date(),"yyyy-MM-dd"));
            messageTemplate.setZp_cjs(zp_cjs);
            sendMessageHandler(sortFieldList(messageTemplate.getZp_cjs().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getZp_cjs());
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    //签到提醒
    @Async
    public  void  zpQdtx(String industName,Position position,User user ,Signin signin,String OpenID){
        try{
            QueryParam queryParam = new QueryParam("type","ZP_QDTX");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("你的岗位"+position.getTitle()+"，"+user.getMainName()+"刚刚签到了");
            messageTemplate.setRemark("请及时确认");
            messageTemplate.setOpenID(OpenID);
            ZP_QDTX zp_qdtx = new ZP_QDTX();
            zp_qdtx.setS0industryName(industName);
            zp_qdtx.setS1duty(position.getTitle());
            zp_qdtx.setS2address(position.getWorkPlace().getDetailedAddress());
            zp_qdtx.setS3telphone(user.getPhoneNumber());
            zp_qdtx.setS4date(DateUtils.format(signin.getSignTime(),"yyyy-MM-dd HH:mm:ss"));
            messageTemplate.setZp_qdtx(zp_qdtx);
            sendMessageHandler(sortFieldList(messageTemplate.getZp_qdtx().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getZp_qdtx());
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    //报名提醒
    @Async
    public  void  zpBmtx(Position position ,User user ,String opendID,Beenrecruited beenrecruited){

        try{
            QueryParam queryParam = new QueryParam("type","ZP_BMTX");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("你发布的"+position.getTitle()+"岗位刚刚收到一份简历");
            messageTemplate.setRemark("请及时查看");
            messageTemplate.setOpenID(opendID);
            ZP_BMTX zp_bmtx  = new ZP_BMTX();
            if(user.getSex()==2||user.getSex()==null){
                zp_bmtx.setS0name(user.getMainName()+" 女");
            }
            if(user.getSex()==1){
                zp_bmtx.setS0name(user.getMainName()+" 男");
            }
            zp_bmtx.setS1telphone(user.getPhoneNumber());
            zp_bmtx.setS2type("待录取，最新报名日期："+ StringUtils.join(DateUtils.getDataListFromString(beenrecruited.getWorkDate()),","));
            messageTemplate.setZp_bmtx(zp_bmtx);
            sendMessageHandler(sortFieldList(messageTemplate.getZp_bmtx().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getZp_bmtx());
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    //修改了日期
    @Async
    public  void  zpBmxg(Position position ,User user ,String opendID,Beenrecruited beenrecruited)throws Exception{

        QueryParam queryParam = new QueryParam("type","ZP_BMTX");
        MessageTemplate messageTemplate = this.getDao().one(queryParam);
        messageTemplate.setUrl(DictCacheService.Site);
        messageTemplate.setFirst("你发布的"+position.getTitle()+"岗位，刚刚有人修改了报名日期");
        messageTemplate.setRemark("请及时查看");
        messageTemplate.setOpenID(opendID);
        ZP_BMTX zp_bmtx  = new ZP_BMTX();
//        zp_bmtx.setS0name(user.getMainName());
        if(user.getSex()==2||user.getSex()==null){
            zp_bmtx.setS0name(user.getMainName()+" 女");
        }
        if(user.getSex()==1){
            zp_bmtx.setS0name(user.getMainName()+" 男");
        }
        zp_bmtx.setS1telphone(user.getPhoneNumber());
        zp_bmtx.setS2type("待录取，最新报名日期："+ StringUtils.join(DateUtils.getDataListFromString(beenrecruited.getWorkDate()),","));
        messageTemplate.setZp_bmtx(zp_bmtx);
        sendMessageHandler(sortFieldList(messageTemplate.getZp_bmtx().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getZp_bmtx());
    }


    //明日工作
    @Async
    public  void  qzMrgz(Position position,User user  ){
        try{
            QueryParam queryParam = new QueryParam("type","QZ_MRGZ");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("你有一项明日工作");
            messageTemplate.setRemark("请准时到达，到达工作地点后请记得签到");
            messageTemplate.setOpenID(user.getWeChatNo());
            QZ_MRGZ qz_mrgz = new QZ_MRGZ();
            qz_mrgz.setS0title(position.getTitle());
            qz_mrgz.setS1settledate(DateUtils.format(position.getSetDate(),"HH:mm"));
            qz_mrgz.setS2settleaddr(position.getGather().getDetailedAddress());
            qz_mrgz.setS3phone(position.getPersonalauthen().getPersonPhoneNumber());
            messageTemplate.setQz_mrgz(qz_mrgz);
            sendMessageHandler(sortFieldList(messageTemplate.getQz_mrgz().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getQz_mrgz());
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    //红包提现
    @Async
    public  void  qzHbtx(String openID,String msg,String money){
        try{
            QueryParam queryParam = new QueryParam("type","QZ_HBTX");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
//            messageTemplate.setFirst("你好，你的朋友"+name+"在您的推荐的"+position.getTitle()+"职位已经成功录取");
            messageTemplate.setFirst(msg);
            messageTemplate.setRemark("感谢你的参与");
            messageTemplate.setOpenID(openID);
            QZ_HBTX qz_hbtx = new QZ_HBTX();
            qz_hbtx.setS0amountMoney(money);
            qz_hbtx.setS1paymentDate(DateUtils.format(new Date(),"HH:mm:ss"));
            messageTemplate.setQz_hbtx(qz_hbtx);
            sendMessageHandler(sortFieldList(messageTemplate.getQz_hbtx().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getQz_hbtx());
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    //未到岗
    @Async
    public  void  qzWdg(Position position,User user){
        try{
            QueryParam queryParam = new QueryParam("type","QZ_WDG");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("您报名的"+position.getTitle()+"岗位，被确认未到岗");
            messageTemplate.setRemark("请准时到达");
            messageTemplate.setOpenID(user.getWeChatNo());
            QZ_WDG qz_wdg = new QZ_WDG();
            qz_wdg.setS0position(position.getTitle());
            qz_wdg.setS1date(DateUtils.getDateByMinute(position.getStartTime())+"-"+DateUtils.getDateByMinute(position.getEndTime()));
            qz_wdg.setS2addr(position.getWorkPlace().getDetailedAddress());
            messageTemplate.setQz_wdg(qz_wdg);
            sendMessageHandler(sortFieldList(messageTemplate.getQz_wdg().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getQz_wdg());
        }catch (Exception e){
            e.printStackTrace();
        }


    }


    //平台提现通知
    @Async
    public void ptTxtz(Withdrawals withdrawals,User user,Personalauthen personalauthen,TxTask txTask){
        try{
            QueryParam queryParam = new QueryParam("type","PT_TXTZ");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site+"/share/TX/"+txTask.getCode());
            messageTemplate.setFirst("提现申请通知");
            messageTemplate.setRemark("请及时处理");
            messageTemplate.setOpenID(user.getWeChatNo());
            PT_TXTZ pt_txtz = new PT_TXTZ();
            pt_txtz.setS0nikeName(personalauthen.getRealName());
            pt_txtz.setS1phoneNo(personalauthen.getPersonPhoneNumber());
            pt_txtz.setS2money(withdrawals.getPrice().toString()+"元");
            pt_txtz.setS3date(DateUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
            messageTemplate.setPt_txtz(pt_txtz);
            sendMessageHandler(sortFieldList(messageTemplate.getPt_txtz().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getPt_txtz());
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //平台提现通知2
    @Async
    public void ptTxtz2(User user,String names,String phones,String moneys){
        try{
            QueryParam queryParam = new QueryParam("type","PT_TXTZ");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site+"/share/TX/all");
            messageTemplate.setFirst("提现申请通知");
            messageTemplate.setRemark("请及时处理");
            messageTemplate.setOpenID(user.getWeChatNo());
            PT_TXTZ pt_txtz = new PT_TXTZ();
           /* String name = names.substring(0,Math.min(50,names.length()-1));
            String phone = phones.substring(0,Math.min(50,phones.length()-1));
            String money = moneys.substring(0,Math.min(50,moneys.length()-1));*/
            pt_txtz.setS0nikeName(names);
            pt_txtz.setS1phoneNo(phones);
            pt_txtz.setS2money(moneys);
            pt_txtz.setS3date(DateUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
            messageTemplate.setPt_txtz(pt_txtz);
            sendMessageHandler(sortFieldList(messageTemplate.getPt_txtz().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getPt_txtz());
        }catch (Exception e){
            e.printStackTrace();
        }


    }

    //只需要工单参数
    public void tpGdxx2(WorkList workList){
        try {
            TxAdmin txAdmin = txAdminService.one(new QueryParam("id","1"));
            User userAdmin  = userService.get(txAdmin.getUserID());
            workList.setAuditor(userAdmin.getId());
            ptGdxx(userAdmin.getWeChatNo(),workList);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //只需要工单参数
    public void tpBrokerGdxx2(WorkList workList){
        try {
            TxAdmin txAdmin = txAdminService.one(new QueryParam("id","2"));
            User userAdmin  = userService.get(txAdmin.getUserID());
            workList.setAuditor(userAdmin.getId());
            ptGdxx(userAdmin.getWeChatNo(),workList);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //工单消息
    public void ptGdxx(String openID,WorkList workList){
        try{
            workListService.persistence(workList);
            QueryParam queryParam = new QueryParam("type","PT_GDXX");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site+"/share/GDSH/"+workList.getId());
            messageTemplate.setFirst("您有一笔工单消息");
            messageTemplate.setRemark("请及时处理");
            messageTemplate.setOpenID(openID);
            PT_GDXX pt_txtz = new PT_GDXX();
            pt_txtz.setS0code(workList.getCode());
            pt_txtz.setS1title(workList.getTitle());
            pt_txtz.setS2date(DateUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
            messageTemplate.setPt_gdxx(pt_txtz);
            sendMessageHandler(sortFieldList(messageTemplate.getPt_gdxx().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getPt_gdxx());
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //用户咨询
    public void ptYhzx(String openID,String name,String content){
        try{
            QueryParam queryParam = new QueryParam("type","PT_YHZX");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("您有一条咨询消息");
            messageTemplate.setRemark("请及时回复");
            messageTemplate.setOpenID(openID);
            PT_YHZX pt_txtz = new PT_YHZX();
            pt_txtz.setS0name(name);
            pt_txtz.setS1date(DateUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
            pt_txtz.setS2content(content);
            messageTemplate.setPt_yhzx(pt_txtz);
            sendMessageHandler(sortFieldList(messageTemplate.getPt_yhzx().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getPt_yhzx());
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //职位通知
    public void qzZwtz(String openID,User user,Position position ){
        try{
            QueryParam queryParam = new QueryParam("type","QZ_ZWTZ");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site+"/share/PD/"+position.getId());
            messageTemplate.setFirst(user.getMainName()+"发布了一个新职位，赶紧去围观一下吧");
            messageTemplate.setRemark("欢迎前来报名！如需退订职位推送，请在输入框回复“TD”，订阅请回复“DY”。");
            messageTemplate.setOpenID(openID);
            QZ_ZWTZ qz_zwtz = new QZ_ZWTZ();
            qz_zwtz.setS0compname("I Job兼职平台");
            qz_zwtz.setS1position(position.getTitle());
            qz_zwtz.setS2type(position.getHuntingtype().getName());
            qz_zwtz.setS3addr(position.getWorkPlace().getDetailedAddress());
            qz_zwtz.setS4salary(position.getDailySalary()+"元/天");
            messageTemplate.setQz_zwtz(qz_zwtz);
            sendMessageHandlerNoBroadcast(sortFieldList(messageTemplate.getQz_zwtz().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getQz_zwtz());
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    //版本更新
    public void txBbgx(String openID,Version version ){
        try{
            QueryParam queryParam = new QueryParam("type","PT_BBGX");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site+"/UeditorController/version");
            messageTemplate.setFirst("版本更新了");
            messageTemplate.setRemark("如需退订版本更新推送，请在输入框回复“TD”，订阅请回复“DY”。");
            messageTemplate.setOpenID(openID);
            PT_BBGX qz_zwtz = new PT_BBGX();
            qz_zwtz.setS0objectName("I Job兼职平台");
            qz_zwtz.setS1server("阿里云");
            qz_zwtz.setS2versionNo(version.getVersionNo());
            qz_zwtz.setS3status("已启动");
            messageTemplate.setPt_bbgx(qz_zwtz);
            sendMessageHandler(sortFieldList(messageTemplate.getPt_bbgx().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getPt_bbgx());
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    //违约赔付
    @Async
    public void zpWypf(String openID,Bondtransaction indemnity){
        try{
            QueryParam queryParam = new QueryParam("type","ZP_WYPF");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("您有一笔违约金赔付到账");
            messageTemplate.setRemark("谢谢您的使用");
            messageTemplate.setOpenID(openID);
            ZP_WYPF zp_wypf = new ZP_WYPF();
            zp_wypf.setS0date(DateUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
            zp_wypf.setS1money(indemnity.getPremiumMoney().toString()+"元");
            zp_wypf.setS2code(indemnity.getOrderNumber());
            messageTemplate.setZp_wypf(zp_wypf);
            sendMessageHandler(sortFieldList(messageTemplate.getZp_wypf().getClass().getDeclaredFields()),messageTemplate,messageTemplate.getZp_wypf());
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //审核结果通知
    public void ptShtz(String openID,String title ,String msg){
        try {
            QueryParam queryParam = new QueryParam("type", "PT_SHTZ");
            MessageTemplate messageTemplate = this.getDao().one(queryParam);
            messageTemplate.setUrl(DictCacheService.Site);
            messageTemplate.setFirst("您有一笔申请单审核了");
            messageTemplate.setRemark("谢谢您的使用");
            messageTemplate.setOpenID(openID);
            PT_SHTZ pt_shtz = new PT_SHTZ();
            pt_shtz.setS0title(title);
            pt_shtz.setS1errmsg(msg);
            messageTemplate.setPt_shtz(pt_shtz);
            sendMessageHandler(sortFieldList(messageTemplate.getPt_shtz().getClass().getDeclaredFields()), messageTemplate, messageTemplate.getPt_shtz());
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    private void sendMessageHandlerNoBroadcast(List<Field> fields ,MessageTemplate messageTemplate ,Object object)throws Exception{
        matchDateMap(fields,messageTemplate,object);
        TemplateTaskPanel templateTask =  addTemplateTask(messageTemplate);
        RedisUtil.pushTask(templateTask);
    }

    private void sendMessageHandler(List<Field> fields ,MessageTemplate messageTemplate ,Object object)throws Exception{
        matchDateMap(fields,messageTemplate,object);
        TemplateTaskPanel templateTask =  addTemplateTask(messageTemplate);
        RedisUtil.pushTaskAndBroadcast(templateTask);
    }

    private void getFirstAndEndMap(MessageTemplate messageTemplate){
        Map<String,String> fm = new HashMap<String,String>();
        fm.put("value",messageTemplate.getFirst());
        fm.put("color","#173177");
        messageTemplate.getData().put("first",fm);
        Map<String,String> mm = new HashMap<String,String>();
        mm.put("value",messageTemplate.getRemark());
        mm.put("color","#ff3b30");
        messageTemplate.getData().put("remark",mm);
    }

    private List<Field> sortFieldList(Field[] fields){
        List<Field> fieldList = new ArrayList<Field>(Arrays.asList(fields)); // 用来存放所有的方法
        Collections.sort(fieldList, (f1, f2) -> { // 这个比较的语法依赖于java 1.8
            return f1.getName().compareTo(f2.getName());
        });
        return fieldList;
    }

    private Map  sendMessage(String param)throws IJobException{
        String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+ DictCacheService.getAccessToken();
        return new Gson().fromJson(HttpUtils.post(url,param),HashMap.class);
    }

    private void  matchDateMap( List<Field> fieldList ,MessageTemplate messageTemplate,Object object)throws Exception{
        for(int i=0;i<fieldList.size();i++){
            Field field = fieldList.get(i);
            field.setAccessible(true);
            Map<String,String> m = new HashMap<String,String>();
            Object value = field.get(object);
            if(value==null){
                value = "";
            }
            m.put("value",value.toString());
            m.put("color","#173177");
            messageTemplate.getData().put("keyword"+(i+1),m);
        }
        getFirstAndEndMap(messageTemplate);
    }


    //通知所有人版本更新
    @Async
    public void noticeVersion(Version version){
        try{
            QueryParam queryParam  = new QueryParam();
            queryParam.put("isvalid",Boolean.TRUE);
            List<Follow> follows = followService.findList(queryParam);
            for(Follow follow : follows){
                this.txBbgx(follow.getOpenID(),version);
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }

}

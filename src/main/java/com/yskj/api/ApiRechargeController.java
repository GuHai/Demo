package com.yskj.api;

import com.yskj.models.*;
import com.yskj.models.auth.User;
import com.yskj.models.enums.Examine;
import com.yskj.service.*;
import com.yskj.service.auth.UserService;
import com.yskj.utils.DateUtils;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.Result;
import com.yskj.utils.SignUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/api/RechargeController")
public class ApiRechargeController {

    @Autowired
    private VoucherService voucherService ;

    @Autowired
    private InvoiceService invoiceService ;

    @Autowired
    private InvoiceDetailService invoiceDetailService ;

    @Autowired
    private RecipientsService recipientsService ;

    @Autowired
    private TxAdminService txAdminService ;

    @Autowired
    private UserService userService ;

    @Autowired
    private MessageTemplateService messageTemplateService ;

    @Autowired
    private RechargeService rechargeService ;

    @Autowired
    private WeChatService weChatService ;

    @Autowired
    private WxorderService wxorderService ;

    private final static Logger logger = LoggerFactory.getLogger(ApiSigninController.class);

    /**
     * 新增充值记录
     * @param voucher
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/addVoucher" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result addVoucher(@RequestBody Voucher voucher){
        Result result = new Result();
        try {
            voucher.setUserID(IJobSecurityUtils.getLoginUserId());
            voucher.setStatus(0);
            voucherService.persistenceAndChild(voucher);

            //推送给管理员
            QueryParam queryParam = new QueryParam("id","1");
            TxAdmin txAdmin = txAdminService.one(queryParam);
            User userAdmin  = userService.get(txAdmin.getUserID());
            WorkList workList = new WorkList();
            workList.updateType(Examine.Recharge);
            workList.setStatus(1);
            workList.setAuditor(txAdmin.getUserID());
            workList.setCallback("/api/RechargeController/voucherCallback");
            workList.setRefID(voucher.getId());
            workList.setUrl("/h5/qz/myjob/upload_voucher_check?data.voucher.id="+voucher.getId());
            messageTemplateService.ptGdxx(userAdmin.getWeChatNo(),workList);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙。");
        }
        return result ;
    }

    /**
     * 充值审核时 ，加载用户提交的数据。
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/upload_voucher_check/{id}" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result upload_voucher_check(@PathVariable String id){
        Result result = new Result();
        try {
            Voucher voucher = voucherService.upload_voucher_check(id);
            voucher.setMainName(((User)(userService.get(voucher.getUserID()))).getRealName());
            QueryParam queryParam = new QueryParam("userID",voucher.getUserID());
            Weixin weixin  =weChatService.one(queryParam);
            voucher.setWxID(weixin.getId());
            result.listData(voucher);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    /**
     * 充值的回调方法
     * @param workList 工单对象
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/voucherCallback" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result voucherCallback(@RequestBody WorkList workList){
        Result result = new Result();
        try {
            if(workList.getStatus()==2){ //通过
                result = voucherService.voucherCallback(workList);
            }else if(workList.getStatus()==3){
                Voucher voucher = voucherService.get(workList.getRefID());
                voucher.setStatus(2);
                voucherService.update(voucher);
                User user = userService.get(workList.getCreateBy());
                messageTemplateService.ptShtz(user.getWeChatNo(),"充值申请",workList.getMsg());
            }
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙。");
        }
        return result ;
    }

    /**
     * 获得历史充值记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getVoucherList" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result getVoucherList(){
        Result result = new Result();
        try {
            List<Map> list = voucherService.getVoucherList(IJobSecurityUtils.getLoginUserId());
            result.listData(list);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙。");
        }
        return result ;
    }

    /**
     * 获得历史充值记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getHistoryRechargeInfo" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result getHistoryRechargeInfo(){
        Result result = new Result();
        try {
            //查询发票主要信息
            QueryParam queryParam = new QueryParam();
            queryParam.put("userID",IJobSecurityUtils.getLoginUserId());
            queryParam.setOrderByClause(" order by i.createTime desc ");
            Invoice invoice = invoiceService.one(queryParam);
            if (invoice == null){
                invoice = new Invoice();
            }
            //查询发票详细信息
            queryParam.clear();
            queryParam.put("userID",IJobSecurityUtils.getLoginUserId());
            queryParam.setOrderByClause(" order by i.createTime desc ");
            InvoiceDetail invoiceDetail = invoiceDetailService.one(queryParam);
            if(invoiceDetail!=null){
                invoice.setInvoiceDetail(invoiceDetail);
            }
            //查询发票收件信息。
            queryParam.clear();
            queryParam.put("userID",IJobSecurityUtils.getLoginUserId());
            queryParam.setOrderByClause(" order by r.createTime desc ");
            Recipients recipients = recipientsService.one(queryParam);
            if(recipients!=null){
                invoice.setRecipients(recipients);
            }
            result.listData(invoice);
        }catch (SQLException sqlException){
            result.error("不能存在特殊字符！");
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙！");
        }
        return result ;
    }

    /**
     * 开发票
     * @param invoice
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/addInvoiceInfo" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result addInvoiceInfo(@RequestBody Invoice invoice){
        Result result = new Result();
        try {
            //新增发票数据
            invoice.setStatus(false);
            invoice.setUserID(IJobSecurityUtils.getLoginUserId());
            invoice.getInvoiceDetail().setUserID(IJobSecurityUtils.getLoginUserId());
            invoice.getRecipients().setUserID(IJobSecurityUtils.getLoginUserId());
            invoice.setOrderNumber("FP"+ DateUtils.getCurrTime()+ SignUtils.getRandomStringByLength(16));
            invoice.setPostage(new BigDecimal(15));
            List<String> list = invoice.getRechargeList();
            invoiceService.persistenceAndChild(invoice);

            //将发票数据和充值记录关联起来。
            QueryParam queryParam = new QueryParam();
            queryParam.in("id",list);
            queryParam.put("invoiceID",invoice.getId());
            rechargeService.updateRechargeList(queryParam);
            result.setData(invoice);
        }catch (SQLException sqlException){
            result.error("不能存在特殊字符！");
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("数据不能存在表情！");
        }
        return result ;
    }

    /**
     * 邮费支付完成回调
     * @param wxorderID
     * @return Result
     */
    @RequestMapping(value = "/postageCallback/{wxorderID}", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})
    public String postageCallback(@PathVariable String wxorderID, Model model){
        Result result = new Result();

        //调用之前还是要检查一下，不能你说修改为已交保证金就交吧
        Wxorder wxorder = null;
        try {
            wxorder = wxorderService.get(wxorderID);
            if(wxorder!=null){
                if(wxorder.getStatus()==3){
                    try {
                        invoiceService.postageCallback(wxorder);
                    } catch (Exception e) {
                        e.printStackTrace();
                        try {
                            weChatService.refundOrder(wxorderID);
                        } catch (Exception e1) {
                            e1.printStackTrace();
                        }
                    }
                }else{
                    model.addAttribute("result","报名回调失败，请联系管理员");
                    return "/h5/error";
                }
            }else{
                model.addAttribute("result","报名回调失败，请联系管理员");
                return "/h5/error";
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return "/h5/success";
    }

    /**
     * 审核时加载的发票页面数据。
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/submInvoice_check/{id}" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result submInvoice_check(@PathVariable String id){
        Result result = new Result();
        try {
            result.listData(invoiceService.submInvoice_check(id));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙！");
        }
        return result ;
    }

    /**
     * 开发票的回调方法。
     * @param workList
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/invoiceCallback" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result invoiceCallback(@RequestBody WorkList workList){
        Result result = new Result();
        try {
            if(workList.getStatus()==2){ //通过
                result = invoiceService.invoiceCallback(workList);
            }else if(workList.getStatus()==3){//不通过
                QueryParam queryParam = new QueryParam("invoice",workList.getRefID());
                rechargeService.callbackRecharge(queryParam);
                User user = userService.get(workList.getCreateBy());
                messageTemplateService.ptShtz(user.getWeChatNo(),"开具发票申请",workList.getMsg());
            }
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙。");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/getInvoiceHistoryInfoList/{invoiceID}" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result getInvoiceHistoryInfoList(@PathVariable String invoiceID){
        Result result = new Result();
            try {
                QueryParam queryParam = new QueryParam();
                queryParam.put("userID",IJobSecurityUtils.getLoginUserId());
                /*queryParam.put("status",true);*/
                if(invoiceID != null && !"".equals(invoiceID) && !"0".equals(invoiceID) ){
                    queryParam.put("id",invoiceID);
                }
                result.listData(invoiceService.getInvoiceHistoryInfoList(queryParam));
            }catch (Exception e){
                logger.error(e.getMessage());
                result.error("服务器繁忙!");
            }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/getRechargeListByInvoiceID/{invoiceID}" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result getRechargeListByInvoiceID(@PathVariable String invoiceID){
        Result result = new Result();
        try {
            QueryParam queryParam = new QueryParam();
            queryParam.put("userID",IJobSecurityUtils.getLoginUserId());
            queryParam.put("invoiceID",invoiceID);
            result.listData(rechargeService.getRechargeListByInvoiceID(queryParam));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙！");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/one" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result one (@RequestBody QueryParam queryParam){
        Result result = new Result();
        try {
            queryParam.put("userID",IJobSecurityUtils.getLoginUserId());
            result.listData(rechargeService.one(queryParam));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("服务器繁忙！");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/getVoucherInfo" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result getVoucherInfo(){
        Result result = new Result();
        try {
            QueryParam queryParam = new QueryParam("userID",IJobSecurityUtils.getLoginUserId());
            result.listData(voucherService.getVoucherInfo(queryParam));
        }catch (Exception e ){
            logger.error(e.getMessage());
            result.error("服务器繁忙!");
        }
        return result ;
    }

    /**
     * 银行卡卡号校验。
     * @param cardNo 银行卡卡号
     * @return {"bank":"CMB","validated":true,"cardType":"DC","key":"(卡号)","messages":[],"stat":"ok"}
     * 2017年5月22日 下午4:35:23
     */
    @ResponseBody
    @RequestMapping(value = "/getCardDetail/{cardNo}" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    public Result getCardDetail(@PathVariable String cardNo) {
        Result result = new Result();
        // 创建HttpClient实例
        String url = "https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?_input_charset=utf-8&cardNo=";
        url+=cardNo;
        url+="&cardBinCheck=true";
        StringBuilder sb = new StringBuilder();
        try {
            URL urlObject = new URL(url);
            URLConnection uc = urlObject.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream()));
            String inputLine = null;
            while ( (inputLine = in.readLine()) != null) {
                sb.append(inputLine);
            }
            in.close();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        result.setData(sb.toString());
        return result;
    }

    /**
     * 获得当前登录用户上一次充值的信息。
     * @return 查询结果对象。
     */
    @RequestMapping(value = "/getHistoryVoucherInfo" , method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result getHistoryVoucherInfo(){
        Result result = new Result();
            try {
                result.listData(voucherService.getHistoryVoucherInfo(IJobSecurityUtils.getLoginUserId()));
            }catch (Exception e){
                logger.error(e.getMessage());
                result.error("服务器繁忙。");
            }
        return result ;
    }


}

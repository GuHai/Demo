package com.yskj.api;import com.yskj.controller.base.BaseController;import com.yskj.models.*;import com.yskj.service.*;import com.yskj.utils.IJobSecurityUtils;import com.yskj.utils.Result;import org.apache.shiro.authz.annotation.RequiresPermissions;import org.slf4j.Logger;import org.slf4j.LoggerFactory;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Controller;import org.springframework.ui.Model;import org.springframework.web.bind.annotation.*;import javax.swing.*;import java.util.HashMap;import java.util.List;import java.util.Map;@Controller@RequestMapping(value = "/api/WithdrawalsController")public class ApiWithdrawalsController extends BaseController {    @Autowired    private WithdrawalsService withdrawalsService;    @Autowired    private BondtransactionService bondtransactionService;    @Autowired    private SettlementpersonService settlementpersonService;    @Autowired    private AccountService accountService;    private final static Logger logger = LoggerFactory.getLogger(ApiWithdrawalsController.class);    public WithdrawalsService getService() {        return this.withdrawalsService;    }    /**     * 页面     *     * @return String     */    @RequiresPermissions("Withdrawals")    @RequestMapping(value = "", method = RequestMethod.GET, produces = {"text/html; charset=utf-8"})    public String index(Model model) {        return "withdrawals";    }    /**     * 新增     *     * @param withdrawals     * @return Result     */    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result add(Withdrawals withdrawals) {        return super.add(withdrawals);    }    /**     * 删除     *     * @param withdrawals     * @return Result     */    @RequestMapping(value = "/delete", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result delete(Withdrawals withdrawals) {        return super.delete(withdrawals);    }    /**     * 修改     *     * @param withdrawals     * @return Result     */    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result update(Withdrawals withdrawals) {        return super.update(withdrawals);    }    /**     * 查询页面     *     * @param pageParam     * @return Result     */    @RequestMapping(value = "/findPage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findPage(@RequestBody PageParam pageParam) {        return super.findPage(pageParam);    }    /**     * 查询集合     *     * @return Result     */    @RequestMapping(value = "/findList", method = RequestMethod.GET, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findList(@RequestBody QueryParam queryParam) {        queryParam.put("presentParty", IJobSecurityUtils.getLoginUserId());        return super.findList(queryParam);    }    /**     * 模糊查询页面     *     * @param pageParam     * @return Result     */    @RequestMapping(value = "/findLikePage", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findLikePage(@RequestBody PageParam pageParam) {        return super.findLikePage(pageParam);    }    /**     * 查询集合，模糊查询     *     * @param queryParam     * @return Result     */    @RequestMapping(value = "/findLikeList", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result findLikeList(@RequestBody QueryParam queryParam) {        return super.findLikeList(queryParam);    }    /**     * 唯一查询     *     * @param queryParam     * @return Result     */    @RequestMapping(value = "/one", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result one(@RequestBody QueryParam queryParam) {        return super.one(queryParam);    }    /**     * 唯一查询通过ID     *     * @param code     * @return Result     */    @RequestMapping(value = "/get/{code}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result get(@PathVariable String code) {        Result result = new Result();        try{            QueryParam queryParam = new QueryParam();            queryParam.put("settlementOrderNumber",code);            result.listData(withdrawalsService.one(queryParam));        }catch (Exception e ){            logger.error(e.getMessage());            result.put("500","服务器数据异常，请联系客服部！");        }        return result;    }    /**     * 唯一查询通过ID     *     * @param code     * @return Result     */    @RequestMapping(value = "/getsxf/{code}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result getsxf(@PathVariable String code) {        Result result = new Result();        try{            QueryParam queryParam = new QueryParam();            queryParam.put("settlementOrderNumber",code);            Withdrawals withdrawals = withdrawalsService.one(queryParam);            queryParam.clear();            queryParam.put("orderNo",code);            queryParam.put("type",9);            Account account = accountService.one(queryParam);            withdrawals.setPrice(account.getMoney());            withdrawals.setRemarks(account.getMark());            result.listData(withdrawals);        }catch (Exception e ){            logger.error(e.getMessage());            result.put("500","服务器数据异常，请联系客服部！");        }        return result;    }   /* @RequestMapping(value = "/h5/mine/salaryCard", method = RequestMethod.GET)    public String salaryCard() {        Double userBond = bondtransactionService.getBondMoney(IJobSecurityUtils.getLoginUserId());        Double price = withdrawalsService.getPriceSum(IJobSecurityUtils.getLoginUserId());        Double returnBond = withdrawalsService.getReturnBond(IJobSecurityUtils.getLoginUserId());        Double settlementMoney = settlementpersonService.getSettlementMoney(IJobSecurityUtils.getLoginUserId());        if (userBond == null) {            userBond = 0.0;        }        if (price == null) {            price = 0.0;        }        if (returnBond == null) {            returnBond = 0.0;        }        if (settlementMoney == null) {            settlementMoney = 0.0;        }        Double balance = returnBond + settlementMoney - price;        IJobSecurityUtils.getSession().setAttribute("UserBond", userBond);        IJobSecurityUtils.getSession().setAttribute("Balance", balance);        return "/h5/qz/mine/salaryCard";    }*/    @RequestMapping(value = "/h5/mine/salaryCard_withdraw", method = RequestMethod.GET)    public String salaryCard_withdraw() {        return "h5/qz/mine/salaryCard_withdraw";    }    @RequestMapping(value = "/h5/mine/Bills", method = RequestMethod.GET)    public String bills() {        try {            QueryParam queryParam = new QueryParam("userID", IJobSecurityUtils.getLoginUserId());            IJobSecurityUtils.getSession().setAttribute("WithdrawalsList", withdrawalsService.findList(queryParam));            IJobSecurityUtils.getSession().setAttribute("SettlementPersonList", settlementpersonService.findList(queryParam));        } catch (Exception e) {            logger.error(e.getMessage());        }        return "/h5/qz/mine/Bills";    }    @RequestMapping(value = "/h5/mine/MyBills",method =RequestMethod.POST,produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result MyBills(@RequestBody QueryParam queryParam1){        Result result=new Result();        Map map=new HashMap();        try{            QueryParam queryParam = new QueryParam("userID", IJobSecurityUtils.getLoginUserId());            queryParam.setOrderByClause(" order by s.createTime desc ");            map.put("SettlementPersonList", settlementpersonService.findList(queryParam));            queryParam.clear();            queryParam.put("userID",IJobSecurityUtils.getLoginUserId());            queryParam.put("payerType",queryParam1.getCondition().get("payerType"));            queryParam.setOrderByClause(" order by b.updateTime desc ");            map.put("BondList",bondtransactionService.findList(queryParam));            queryParam.clear();            queryParam = new QueryParam("presentParty", IJobSecurityUtils.getLoginUserId());            queryParam.setOrderByClause(" order by w.createTime desc ");            map.put("WithdrawalsList",withdrawalsService.findList(queryParam));            result.listData(map);        }catch (Exception e ){            logger.error(e.getMessage());            result.put("500","服务器数据异常，请联系客服部！");        }        return result;    }    @RequestMapping(value = "/h5/mine/Bills_partyA", method = RequestMethod.GET)    public String bills_partyA() {        return "/h5/qz/mine/Bills_partyA";    }    @RequestMapping(value = "/getSurplusMoney",method =RequestMethod.POST,produces = {"application/json; charset=utf-8"})    @ResponseBody    public Result getSurplusMoney(){        Result result=new Result();        try{            Double sumMoney = new Double(5000);            Double money = withdrawalsService.getSurplusMoney(IJobSecurityUtils.getLoginUserId());            if(money==null){                money = new Double(0);            }            result.setData(sumMoney-money);        }catch (Exception e){            logger.error(e.getMessage());            result.error("未获得数据");        }        return result;    }}
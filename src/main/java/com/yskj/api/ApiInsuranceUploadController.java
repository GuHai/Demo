package com.yskj.api;

import com.yskj.models.*;
import com.yskj.models.excel.InsTest;
import com.yskj.models.excel.PayInfo;
import com.yskj.service.InsUploadDayService;
import com.yskj.service.InsUploadService;
import com.yskj.service.TxAdminService;
import com.yskj.service.base.DictCacheService;
import com.yskj.utils.DateUtils;
import com.yskj.utils.ExcelExportUtil;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.Result;
import com.yskj.utils.excel.WriteExcelUtil;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author:Administrator
 * @create 2019-01-18 10:41
 */
@Controller
@RequestMapping(value = "/api/ApiInsuranceUploadController")
public class ApiInsuranceUploadController {

    @Autowired
    private TxAdminService txAdminService;

    @Autowired
    private InsUploadDayService insUploadDayService;
    @Autowired
    private InsUploadService insUploadService;

    @RequestMapping(value = "/waituploadlist", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result waituploadlist(){
        Result result = new Result();
        QueryParam queryParam= new QueryParam();
        queryParam.put("createBy", IJobSecurityUtils.getLoginUserId());
        queryParam.put("status",Boolean.FALSE);
        queryParam.put("type",0);
        queryParam.setOrderByClause(" order by i.updateTime desc ");
        try {
            InsUpload insUpload = insUploadService.one(queryParam);
            if(insUpload!=null){
                queryParam.clear();
                queryParam.put("uploadID",insUpload.getId());
                List<InsUploadDay> insUploadDays = insUploadDayService.findList(queryParam);
                result.listData(insUploadDays);
                result.setInfodata(insUpload);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.error(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/uploadhistory", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result uploadhistory(){
        Result result = new Result();
        QueryParam queryParam= new QueryParam();
        queryParam.put("createBy", IJobSecurityUtils.getLoginUserId());
        queryParam.setOrderByClause(" order by i.updateTime desc ");
        try {
            List<InsUpload> insUploads = insUploadService.findList(queryParam);
            result.listData(insUploads);
        } catch (Exception e) {
            e.printStackTrace();
            result.error(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/uploadhistorydetail/{id}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result uploadhistorydetail(@PathVariable String id){
        Result result = new Result();
        try {
            QueryParam queryParam = new QueryParam("uploadID",id);
            List<InsUploadDay> insUploadDays = insUploadDayService.findList(queryParam);
            result.listData(insUploadDays);
            result.setInfodata(insUploadService.get(id));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }



    @RequestMapping(value = "/insuranceUpload", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result  insuranceUpload(@RequestParam("file") CommonsMultipartFile file) {
        Result result = new Result();
        try{
            InsUpload scanSettle =  insUploadService.insuranceUpload(file);
            result.setData(scanSettle);
        }catch (Exception e){
            e.printStackTrace();
            result.error(e.getMessage());
        }
        return result;

    }

    @RequestMapping(value = "/uploadInsurance", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result  uploadInsurance(@RequestBody InsUpload insUpload) {
        Result result = new Result();
        try{
            insUpload.setStatus(Boolean.TRUE);
            insUploadService.update(insUpload);
        }catch (Exception e){
            e.printStackTrace();
            result.error(e.getMessage());
        }
        return result;

    }

    @RequestMapping(value = "/general/{page}", method = RequestMethod.GET,produces = {"application/json; charset=utf-8"})
    public void general(@PathVariable Integer page, HttpServletResponse response){
        List<InsTest> payInfoList = null;
        try {
            payInfoList = insUploadService.general(page);
        } catch (Exception e) {
            e.printStackTrace();
        }
        ExcelExportUtil.export(response,payInfoList,"报名测试数据");
    }
    @RequestMapping(value = "/deleteInsuranceDay/{id}", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result  deleteInsuranceDay(@PathVariable String id) {
        Result result = new Result();
        try {
            InsUploadDay insUploadDay = insUploadDayService.get(id);
            if(insUploadDay!=null){
                insUploadDayService.delete(insUploadDay);
            }else{
                result.error("数据不存在");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.error(e.getMessage());
        }
        return result;
    }
    @RequestMapping(value = "/testpush", method = RequestMethod.POST, produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public void testpush(HttpServletResponse response){
        insUploadService.testpush();
    }

}

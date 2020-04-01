package com.yskj.api;

import com.yskj.controller.base.BaseController;
import com.yskj.models.*;
import com.yskj.models.excel.InsTest;
import com.yskj.models.excel.InsTest1;
import com.yskj.service.*;
import com.yskj.service.base.AbstractService;
import com.yskj.service.base.DictCacheService;
import com.yskj.utils.DateUtils;
import com.yskj.utils.IJobSecurityUtils;
import com.yskj.utils.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author:Administrator
 * @create 2019-01-11 11:23
 */
@Controller
@RequestMapping(value = "/api/InsuranceController")
public class ApiInsuranceController extends BaseController {

    private final static Logger logger = LoggerFactory.getLogger(ApiInformationController.class);

    @Autowired
    private InsProfessionTypeService insProfessionTypeService ;
    @Autowired
    private InsProfessionListService insProfessionListService ;
    @Autowired
    private PersonalauthenService personalauthenService ;
    @Autowired
    private InsPersonService insPersonService ;
    @Autowired
    private InsRecordService insRecordService ;
    @Autowired
    private InsRecordPersonService insRecordPersonService ;

    @Override
    public AbstractService getService() {
        return null;
    }

    @RequestMapping(value = "/shortTimeIndustry",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result shortTimeIndustry(){
        Result result = new Result();
            try {
                result.listData(insProfessionTypeService.shortTimeIndustry(IJobSecurityUtils.getLoginUserId()));
            }catch (Exception e){
                logger.error(e.getMessage());
                result.error("网络错误...");
            }
        return result ;
    }

    /**
     * 加载一二级菜单目录
     * @param queryParam
     * @return
     */
    @RequestMapping(value = "/findListByLevel",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result findListByLevel(@RequestBody QueryParam queryParam){
        Result result = new Result();
        try {
            if(queryParam.getCondition().get("firstMenu")!=null){
                List<InsProfessionList> list = new ArrayList<>();
                InsProfessionList insProfessionList = new InsProfessionList();
                insProfessionList.setName("最近选择");
                insProfessionList.setId("0");
                list.add(insProfessionList);
                list.addAll(insProfessionListService.findListByLevel(queryParam));
                result.listData(list);
            }else {
                result.listData(insProfessionListService.findListByLevel(queryParam));
            }
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误...");
        }
        return result ;
    }

    @RequestMapping(value = "/loadEndMenu",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result loadEndMenu(@RequestBody QueryParam queryParam){
        Result result = new Result();
        try {
            result.listData(insProfessionTypeService.findList(queryParam));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误...");
        }
        return result ;
    }

    @RequestMapping(value = "/loadInsuredWorkers",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result loadInsuredWorkers(@RequestBody PageParam pageParam){
        Result result = new Result();
        try {
            Map map = new HashMap<>();
            pageParam.put("userID",IJobSecurityUtils.getLoginUserId());
            List<InsPerson> personalauthens = personalauthenService.loadThreeDays(pageParam);
            initInsPerson(personalauthens,pageParam);
            List<InsPerson> insPersonList = insPersonService.loadAllUserInsured(pageParam);
            initInsPerson(insPersonList,pageParam);
            synchroData(personalauthens,insPersonList);
            map.put("loadThreeDays",personalauthens);
            map.put("loadAllUserInsured",insPersonList);
            map.put("userInfo",IJobSecurityUtils.getLoginUser());
            result.listData(map);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误...");
        }
        return result ;
    }

    /**
     * 同步工作类型数据。
     * @param insPeople
     * @param insPersonList
     */
    public void synchroData(List<InsPerson> insPeople,List<InsPerson> insPersonList){
        for (InsPerson insPerson : insPeople){
            for (InsPerson insPerson1 : insPersonList){
                if(insPerson.getCardID().equals(insPerson1.getCardID())&&!insPerson.getInsProfessionType().getId().equals(insPerson1.getInsProfessionType().getId())){
                    insPerson.setInsProfessionType(insPerson1.getInsProfessionType());
                }
            }
        }
    }

    /**
     * 初始化数据。
     * @param insPeople
     * @param pageParam
     * @throws Exception
     */
    public void initInsPerson(List<InsPerson> insPeople,PageParam pageParam) throws Exception{
        InsProfessionType insProfessionType = insProfessionTypeService.get(((HashMap)pageParam.getCondition().get("insProfessionType")).get("id").toString());
        for (InsPerson insPerson : insPeople){
            Integer temp = 0 ;
            if("1".equals(insPerson.getType())){
                insPerson.setInsProfessionType(insProfessionType);
            }else {
                QueryParam queryParam = new QueryParam();
                queryParam.put("personID",insPerson.getId());
                queryParam.put("recordID",pageParam.getCondition().get("insRecordID").toString());
                InsRecordPerson insRecordPerson = insRecordPersonService.getProfessionTypeMap(queryParam);
                if(insRecordPerson==null){
                    insPerson.setInsProfessionType(insProfessionType);
                }else{
                    if(insRecordPerson.getInsProfessionType()==null){
                        insPerson.setInsProfessionType(insProfessionType);
                    }else{
                        insPerson.setInsProfessionType(insRecordPerson.getInsProfessionType());
                    }
                }
            }
            if(insPerson.getCardID()!=null){
                temp = Integer.parseInt(insPerson.getCardID().substring(16,17));
            }
            if((temp%2)==0){
                insPerson.setSex(2);
            }else{
                insPerson.setSex(1);
            }
            if(pageParam.getCondition().get("insRecordPersonList")!=null){
                for(HashMap<String,Object> map : (List<HashMap<String,Object>>)pageParam.getCondition().get("insRecordPersonList")){
                    if(insPerson.getCardID().equals(((HashMap)map.get("insPerson")).get("cardID"))){
                        insPerson.setIsCheck("checked");
                    }
                }
            }
        }
    }

    @RequestMapping(value = "/loadInsInfo",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result loadInsInfo(@RequestBody QueryParam queryParam){
        Result result = new Result();
        try {
            queryParam.put("status",false);
            queryParam.put("createBy",IJobSecurityUtils.getLoginUserId());
            InsRecord insRecord = insRecordService.initRecordInfoMap(queryParam);
            if(insRecord==null){
                insRecord = new InsRecord();
                insRecord.setStatus(0);
                insRecord.setTypeID("1");
                insRecord.setFeeID("1");
                insRecordService.add(insRecord);
            }else {
                changeSex(insRecord);
            }
            result.setData(insRecord);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误...");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/saveRecord",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    public Result saveRecord(@RequestBody InsRecord insRecord){
        Result result = new Result();
        try {
            result = save(result,insRecord);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误...");
        }
        return result ;
    }

    @Transactional
    public Result save(Result result,InsRecord insRecord) throws Exception{
        insRecordService.update(insRecord);
        if(insRecord.getProfessionID()!=null){
            insRecord.setInsProfessionType(insProfessionTypeService.get(insRecord.getProfessionID()));
        }
        if(insRecord.getStatus()!=null&&insRecord.getStatus()==1){
            List<InsTest1> list = insPersonService.findAllInsPersonOfRecord(insRecord.getId());
            String[] filenames = new String[1];
            String datestr = DateUtils.format(new Date(), "yyyy-MM-dd");
            if(list==null){
                result.put("501","表格查询初始化出错...");
                return result;
            }else{
                for (InsTest1 insTest : list){
                    Integer year = Integer.parseInt(insTest.getCardID().substring(6,10));
                    SimpleDateFormat df = new SimpleDateFormat("yyyy");
                    Integer nowYear = Integer.parseInt(df.format(new Date()));
                    insTest.setAge(nowYear-year);
                    filenames[0] = datestr+insTest.getEnterprise()+"上传投保人员.xlsx";
                }
            }
            String filepath =  DictCacheService.UploadPath + File.separator + "iJob/file/insurance"  ;
            com.yskj.utils.excel.ExcelExportUtil.general(filepath,list, datestr+"上传投保人员");
            com.yskj.utils.excel.ExcelExportUtil.sendMailAndAtta("1593105152@qq.com", DateUtils.formatYMd(new Date())+"保险推送","",filenames,filepath);
        }
        result.setData(insRecord);
        return result;
    }

    @RequestMapping(value = "/saveOrUpdatePersonInfo",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    @ResponseBody
    public Result saveOrUpdatePersonInfo(@RequestBody InsPerson insPerson){
        Result result = new Result();
        try {
            InsRecordPerson insRecordPerson = new InsRecordPerson();
            QueryParam queryParam = new QueryParam();
            queryParam.put("cardID",insPerson.getCardID());
            InsPerson temp = insPersonService.one(queryParam);
            if(temp!=null){
                if(temp.getName().equals(insPerson.getName())){
                    queryParam.clear();
                    queryParam.put("personID",temp.getId());
                    queryParam.put("recordID",insPerson.getInsRecordID());
                    InsRecordPerson insRecordPerson1 = insRecordPersonService.one(queryParam);
                    if(insRecordPerson1!=null){
                        insRecordPersonService.physicalDelete(insRecordPerson1);
                    }
                    insRecordPerson.setPersonID(temp.getId());
                    insRecordPerson.setRecordID(insPerson.getInsRecordID());
                    insRecordPerson.setProfessionID(insPerson.getProfessionID());
                    insRecordPersonService.add(insRecordPerson);
                }else {
                    result.put("501","该身份证已经被认证...");
                    return result ;
                }
            }else{
                insPersonService.add(insPerson);
                insRecordPerson.setPersonID(insPerson.getId());
                insRecordPerson.setRecordID(insPerson.getInsRecordID());
                insRecordPerson.setProfessionID(insPerson.getProfessionID());
                insRecordPersonService.add(insRecordPerson);
            }
            queryParam.clear();
            queryParam.put("id",insRecordPerson.getId());
            insRecordPerson = insRecordPersonService.getInsDetailMap(queryParam);
            result.setData(insRecordPerson);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误...");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/saveInsRecordPersonList",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    public Result saveInsRecordPersonList(@RequestBody InsRecord insRecord){
        Result result = new Result();
        try {
            insRecordPersonService.saveInsRecordPersonList(insRecord.getInsRecordPersonList());
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误...");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/getInsRecordListMap",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    public Result getInsRecordListMap(){
        Result result = new Result();
        QueryParam queryParam = new QueryParam();
        try {
            queryParam.put("createBy",IJobSecurityUtils.getLoginUserId());
            queryParam.put("status",1);
            result.listData(insRecordService.getInsRecordListMap(queryParam));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误...");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/getInsRecordMap/{id}",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    public Result getInsRecordMap(@PathVariable String id){
        Result result = new Result();
        QueryParam queryParam = new QueryParam();
        try {
            queryParam.put("id",id);
            queryParam.put("createBy",IJobSecurityUtils.getLoginUserId());
            queryParam.put("status",1);
            InsRecord insRecord = insRecordService.getInsRecordMap(queryParam);
            changeSex(insRecord);
            result.listData(insRecord);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误...");
        }
        return result ;
    }

    public void changeSex(InsRecord insRecord){
        if(insRecord.getInsRecordPersonList()!=null){
            for (InsRecordPerson insRecordPerson : insRecord.getInsRecordPersonList()){
                Integer temp = 0 ;
                if(insRecordPerson.getInsPerson().getCardID()!=null){
                    temp = Integer.parseInt(insRecordPerson.getInsPerson().getCardID().substring(16,17));
                }
                if((temp%2)==0){
                    insRecordPerson.getInsPerson().setSex(2);
                }else{
                    insRecordPerson.getInsPerson().setSex(1);
                }
            }
        }
    }


    @ResponseBody
    @RequestMapping(value = "/getInsQZRecordListMap",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    public Result getInsQZRecordListMap(){
        Result result = new Result();
        QueryParam queryParam = new QueryParam();
        try {
            queryParam.put("userID",IJobSecurityUtils.getLoginUserId());
            Personalauthen personalauthen = personalauthenService.one(queryParam);
            queryParam.clear();
            if(personalauthen!=null){
                queryParam.put("cardID",personalauthen.getPersonIDCard());
                result.listData(insRecordService.getInsQZRecordListMap(queryParam));
            }
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误...");
        }
        return result ;
    }

    @ResponseBody
    @RequestMapping(value = "/findVocation",method = RequestMethod.POST ,produces = {"application/json; charset=utf-8"})
    public Result findVocation(@RequestBody QueryParam queryParam){
        Result result = new Result();
        try {
            result.listData(insProfessionTypeService.findLikeList(queryParam));
        }catch (Exception e){
            logger.error(e.getMessage());
            result.error("网络错误...");
        }
        return result;
    }

}

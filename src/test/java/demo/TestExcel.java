package demo;

import com.yskj.models.InsProfessionList;
import com.yskj.models.InsProfessionType;
import com.yskj.service.InsProfessionListService;
import com.yskj.service.InsProfessionTypeService;
import com.yskj.utils.StringUtils;
import com.yskj.utils.excel.ReadExcelUtil;
import org.apache.http.entity.ContentType;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;

/**
 * @author:Administrator
 * @create 2019-01-11 12:47
 */
//@RunWith(SpringJUnit4ClassRunner.class) // 整合
//@ContextConfiguration(locations={"classpath:/spring/*"}) // 加载配置
public class TestExcel {


    @Autowired
    InsProfessionListService insProfessionListService;
    @Autowired
    InsProfessionTypeService insProfessionTypeService;

    /*@Test
    public void test(){
        try {
            File file = new File("C:\\Users\\Administrator\\Desktop\\保险类型.xlsx");
            FileInputStream fileInputStream = new FileInputStream(file);
            MultipartFile multipartFile = new MockMultipartFile(file.getName(), file.getName(),
                    ContentType.APPLICATION_OCTET_STREAM.toString(), fileInputStream);
            List<String[]> list = ReadExcelUtil.readExcel((MultipartFile)multipartFile ,new String[]{"大分类","中分类","新类别代码","职业名称","意外风险等级"});


            InsProfessionList first=null;
            InsProfessionList second=null;
            String catelog1=null ;
            String catelog2=null;
            String code =null;
            String name=null;
            String level=null;
            for(String[] strs : list){
                if(StringUtils.isNotEmptyString(strs[0])){
                    if(strs[0].startsWith("第")){
                        catelog2 = strs[1];
                        code = strs[2];
                        name = strs[3];
                        level = strs[4];
                    }else{
                        catelog1 = strs[0];
                        if(first==null||!getLevel2(catelog1,2).equals(first.getLevel())){
                            first = new InsProfessionList();
                            first.setLevel(getLevel2(catelog1,2));
                            first.setName(getName(catelog1,2));
                            insProfessionListService.add(first);
                        }
                        if(StringUtils.isNotEmptyString(catelog2)){
                            second = new InsProfessionList();
                            second.setParentID(first.getId());
                            second.setName(getName(catelog2,4));
                            second.setLevel(getLevel2(catelog2,4));
                            insProfessionListService.add(second);
                            InsProfessionType insProfessionType = new InsProfessionType();
                            insProfessionType.setCode(code);
                            insProfessionType.setName(name);
                            insProfessionType.setProfessionID(second.getId());
                            try{
                                insProfessionType.setRisk(Integer.parseInt(level));
                            }catch (Exception e){e.printStackTrace();};
                            insProfessionTypeService.add(insProfessionType);
                        }
                    }
                }else{
                    code = strs[2];
                    name = strs[3];
                    level = strs[4];
                    InsProfessionType insProfessionType = new InsProfessionType();
                    insProfessionType.setCode(code);
                    insProfessionType.setName(name);
                    insProfessionType.setProfessionID(second.getId());
                    try{
                        insProfessionType.setRisk(Integer.parseInt(level));
                    }catch (Exception e){e.printStackTrace();};
                    insProfessionTypeService.add(insProfessionType);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }*/

    private String getName(String str ,Integer len){
        return str.substring(len,str.length());
    }
    private Integer getLevel2(String str ,Integer len){
        return Integer.parseInt(str.substring(0,len));
    }
    private  Integer getLevel(String str){
        String cnzh =  "一二三四五六七八";
        String[] cns = cnzh.split("");
        String first = str.substring(1,2);
        for(int i=0;i<cns.length;i++){
            if(cns[i].equals(first)){
                return i+1;
            }
        }
        return 0;
    }

}

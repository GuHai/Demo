package com.yskj.intercepter;

import com.yskj.service.base.DictCacheService;
import com.yskj.utils.StringUtils;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import java.io.*;

/**
 * 启动监听器
 *
 * @author:Administrator
 * @create 2018-05-18 12:30
 */
public class IjobListener extends ContextLoaderListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        System.out.println("---------------------启动前初始化-----------------------");
        //afterStartSpring();
        super.contextInitialized(event);
    }

    public void afterStartSpring(){
        System.out.println("-------读取数据库文件-------");
        FileReader fr = null;
        FileWriter fileWriter = null  ;
        BufferedReader br = null;
        try {
            fr = new FileReader("D://config/pjdbc.properties");
            br = new BufferedReader(fr);
            fileWriter  = new FileWriter(IjobListener.class.getClassLoader().getResource("jdbc.properties").getFile());
            String str ;
            while((str=br.readLine())!=null){
                fileWriter.write(str+"\n\r");
            }
            fileWriter.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
               br.close();
               fr.close();
               fileWriter.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}

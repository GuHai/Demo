package com.yskj.utils.excel;


import com.yskj.service.base.DictCacheService;
import org.apache.commons.mail.SimpleEmail;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Date;
import java.util.List;
import java.util.Properties;

/**
 * Created by zhouchuang on 2017/5/26.
 */
public class ExcelExportUtil {
    public static void export(HttpServletResponse resp, List list,String fileName){
        OutputStream out = null;
        try {
            String excelName = new String(fileName.getBytes("GB2312"), "ISO_8859_1");
            resp.addHeader("content-type", "application/shlnd.ms-excel;charset=utf-8");
            resp.addHeader("content-disposition", "attachment; filename=" + excelName + ".xlsx");
            XSSFWorkbook workbook = WriteExcelUtil.createExcel(list, fileName);
            out = resp.getOutputStream();
            workbook.write(out);
            out.flush();
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (null != out) {
                    out.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }

    public static void general(String path,List list ,String fileName){
        OutputStream os = null;
        try {
            XSSFWorkbook workbook = WriteExcelUtil.createExcel(list, fileName);
            File tempFile = new File(path);
            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            os = new FileOutputStream(tempFile+File.separator + fileName+".xlsx");
            workbook.write(os);
            os.flush();
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if (null != os) {
                    os.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void sendMailAndAtta(String to ,String title,String context,String[] filenames,String path)throws Exception{
        // 指定发送邮件的主机为 localhost
        String host = DictCacheService.EmailSendHost;
        String from  = DictCacheService.EmailAccount;

        // 获取系统属性
        Properties properties = System.getProperties();

        // 设置邮件服务器  25端口被阿里云封了，所以只能改成465端口
        /*properties.setProperty("mail.smtp.host", host);
        properties.put("mail.smtp.auth", "true");*/




        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.setProperty("mail.smtp.socketFactory.fallback", "false");
        properties.setProperty("mail.smtp.port", "465");
        properties.setProperty("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.auth", "true");

        // 获取默认的 Session 对象。
        Session session = Session.getDefaultInstance(properties,new Authenticator(){
            public PasswordAuthentication getPasswordAuthentication()
            {
                return new PasswordAuthentication(from, DictCacheService.EmailPassword); //发件人邮件用户名、密码
            }
        });

        try{
            // 创建默认的 MimeMessage 对象。
            MimeMessage message = new MimeMessage(session);

            // Set From: 头部头字段
            message.setFrom(new InternetAddress(from));

            // Set To: 头部头字段
            message.addRecipient(Message.RecipientType.TO,
                    new InternetAddress(to));

            // Set Subject: 头字段
            message.setSubject(title);

            // 创建消息部分
            BodyPart messageBodyPart = new MimeBodyPart();

            // 消息
            messageBodyPart.setText(context);

            // 创建多重消息
            Multipart multipart = new MimeMultipart();

            // 设置文本消息部分
            multipart.addBodyPart(messageBodyPart);

            // 附件部分

            for(String filename : filenames){
                messageBodyPart = new MimeBodyPart();
                DataSource source = new FileDataSource(path+File.separator+filename);
                messageBodyPart.setDataHandler(new DataHandler(source));
                messageBodyPart.setFileName(MimeUtility.encodeText(filename));
                multipart.addBodyPart(messageBodyPart);
            }

            // 发送完整消息
            message.setContent(multipart );

            //   发送消息
            Transport.send(message);
            System.out.println("Sent message successfully....");
        }catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }

}

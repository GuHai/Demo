package com.yskj.controller.base;

import com.yskj.models.Attachment;
import com.yskj.models.ResponseObj;
import com.yskj.service.AttachmentService;
import com.yskj.service.base.DictCacheService;
import com.yskj.utils.DateUtils;
import com.yskj.utils.GsonUtils;
import com.yskj.utils.IJobSecurityUtils;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.http.impl.io.IdentityInputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Date;

/**
 * 文件上传
 *
 * @author zhouchuang
 * @create 2018-01-15 22:15
 */
@Controller
@RequestMapping("/fileUpload")
public class FileUploadController {

    private ResponseObj responseObj;
    // 1：头像 2：证件 3：动态图片 4:验证码
    public static Integer Head = 1;
    public static Integer Cert = 2;
    public static Integer Photos = 3;
    public static Integer QRcode = 4;

    @Autowired
    private AttachmentService attachmentService;


    @RequestMapping(value = "/uploadImage"
            , method = RequestMethod.POST
            , produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object uploadImage(@RequestParam(required = false) MultipartFile file, HttpSession session, HttpServletRequest request) {

        Attachment attachment = new Attachment();
        String type = request.getParameter("type");
        String title = request.getParameter("title");
        String path = request.getParameter("path");
        String datestr = DateUtils.format(new Date(), "yyyy-MM-dd");
        String id = request.getParameter("id");
        String fileName = "";
        if (null == file || file.isEmpty()) {
            responseObj = new ResponseObj();
            responseObj.setCode(ResponseObj.FAILED);
            responseObj.setMsg("文件不能为空");
            return new GsonUtils().toJson(responseObj);
        }
        responseObj = new ResponseObj();
        responseObj.setCode(ResponseObj.OK);
        responseObj.setMsg("文件长度为：" + file.getSize());


        //如果是文件上传则用 uploadFile 如果是图片则用 uploadPic、
        /*try {
            fileName = getFileName(file);
            uploadPic(file,path,datestr,fileName);
            attachment.setDatestr(datestr);
            attachment.setName(fileName);
            attachment.setPath(path);
            attachment.setType(Integer.parseInt(type));
            attachment.setTitle(title);
            attachment.setId(id);
            //attachmentService.persistence(attachment);
            responseObj.setData(attachment);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new GsonUtils().toJson(attachment);*/


        File tempFile = new File(DictCacheService.UploadPath + File.separator + path + File.separator + datestr);
        if (!tempFile.exists()) {
            tempFile.mkdirs();
        }
        OutputStream os = null;
        InputStream is = null;
        try {
            //获取输出流
            String name = file.getOriginalFilename();
            fileName = new Date().getTime() + name.substring(name.lastIndexOf("."));
            os = new FileOutputStream(tempFile + File.separator + fileName);
            //获取输入流 CommonsMultipartFile 中可以直接得到文件的流
            is = file.getInputStream();
            int temp = 0;
            byte[] tempbytes = new byte[8 * 1024];
            //一个一个字节的读取并写入
            while ((temp = is.read(tempbytes)) != -1) {
                os.write(tempbytes, 0, temp);
            }
            os.flush();
           /* os.close();
            is.close();*/
            attachment.setDatestr(datestr);
            attachment.setName(fileName);
            attachment.setPath(path);
            attachment.setType(Integer.parseInt(type));
            attachment.setTitle(title);
            attachment.setId(id);
            //attachmentService.persistence(attachment);
            responseObj.setData(attachment);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            try {
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
                try {
                    is.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        }
        return new GsonUtils().toJson(attachment);

    }
    private void  uploadFile(MultipartFile file,String path,String datestr,String fileName) throws Exception{
        OutputStream os = null;
        InputStream is = null;
        try {
            File tempFile = new File(DictCacheService.UploadPath + File.separator + path + File.separator + datestr);
            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            //获取输出流
            String name = file.getOriginalFilename();
            os = new FileOutputStream(tempFile + File.separator + fileName);
            //获取输入流 CommonsMultipartFile 中可以直接得到文件的流
            is = file.getInputStream();
            int temp = 0;
            byte[] tempbytes = new byte[8 * 1024];
            //一个一个字节的读取并写入
            while ((temp = is.read(tempbytes)) != -1) {
                os.write(tempbytes, 0, temp);
            }
            os.flush();
           /* os.close();
            is.close();*/

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            try {
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
                try {
                    is.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        }
    }

    private void uploadPic(MultipartFile filetemplate,String path,String datestr,String fileName) throws Exception{
        File tempFile = new File(DictCacheService.UploadPath + File.separator + path + File.separator + datestr);
        if (!tempFile.exists()) {
            tempFile.mkdirs();
        }
        ImageIO.setUseCache(false);
        BufferedImage tag = compressPic(filetemplate);
        //FileOutputStream out = new FileOutputStream(tempFile + File.separator + fileName);
        //JPEGImageEncoder可适用于其他图片的类型的转换
      /*  JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
        encoder.encode(tag);
        out.close();*/
        ImageIO.write(tag, fileName.substring(fileName.lastIndexOf(".")+1),new File(tempFile + File.separator + fileName));
    }
    private String getFileName(MultipartFile file){
        String name = file.getOriginalFilename();
        return new Date().getTime() + name.substring(name.lastIndexOf("."));
    }

    private int outputWidth = 667;//输出图片宽度
    private int outputHeight = 375;//输出图片高度
    private BufferedImage compressPic(MultipartFile filetemplate)throws Exception{
        CommonsMultipartFile cf= (CommonsMultipartFile)filetemplate;
        DiskFileItem fi = (DiskFileItem)cf.getFileItem();
        File file = fi.getStoreLocation();
        Image img = ImageIO.read(file);
        if(img.getWidth(null) == -1){
            return null;
        }else{
            int newWidth;
            int newHeight;
            //判断是否等比缩放
            double rate = (double)img.getWidth(null)/(double)outputWidth;
            if(rate>1){
                newWidth = outputWidth;
                newHeight = ((Double)(img.getHeight(null)/rate)).intValue();
            }else{
                newWidth = img.getWidth(null);
                newHeight = img.getHeight(null);
            }


            /**
             *Image.SCALE_SMOOTH的缩略算法生成缩略图片的平滑度的优先级比速度高,生成的图片质量好但是速度慢
             *根据具体要求取舍时间或是质量
             */
            BufferedImage tag = new BufferedImage((int)newWidth,(int)newHeight,BufferedImage.TYPE_INT_RGB);
            tag.getGraphics().drawImage(img,0,0,newWidth,newHeight,null);
            return tag;
        }
    }


    public void saveFile(File file, String filePath, Integer type) {
        String datestr = DateUtils.format(new Date(), "yyyy-MM-dd");
        File tempFile = new File(DictCacheService.UploadPath + File.separator + filePath + File.separator + datestr);
        if (!tempFile.exists()) {
            tempFile.mkdirs();
        }
        OutputStream os = null;
        InputStream is = null;
        try {
            //获取输出流
            String name = file.getName();
            String fileName = new Date().getTime() + name.substring(name.lastIndexOf("."));
            os = new FileOutputStream(tempFile + File.separator + fileName);
            //获取输入流 CommonsMultipartFile 中可以直接得到文件的流
            is = new FileInputStream(file);
            int temp;
            //一个一个字节的读取并写入
            while ((temp = is.read()) != (-1)) {
                os.write(temp);
            }
            os.flush();
           /* os.close();
            is.close();*/
            Attachment attachment = new Attachment();
            attachment.setDatestr(datestr);
            attachment.setName(fileName);
            attachment.setPath(filePath);
            attachment.setType(type);
            attachmentService.persistence(attachment);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            try {
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
                try {
                    is.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        }
    }

}

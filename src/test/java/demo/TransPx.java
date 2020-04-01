package demo;

import com.yskj.utils.IJobUtils;
import com.yskj.utils.MD5Tools;
import com.yskj.utils.UUIDGenerator;
import org.junit.Test;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.RandomAccessFile;
import java.math.BigDecimal;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 转行less
 *
 * @author:Administrator
 * @create 2018-03-20 11:08
 */
public class TransPx {
    public static void main(String[] args) {
        String path = "E:\\yskj_ijob\\src\\main\\webapp\\static\\css";
        File file = new File(path);
        File[] fileList = file.listFiles();
        try {
            readLess(fileList);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void readLess(File[] files)throws Exception{
        for(File file: files){
            if(file.isDirectory()){
                readLess(file.listFiles());
            }else{
                if(file.getName().endsWith(".less")){
                    System.out.println("=================filename:"+file.getName());
                    RandomAccessFile raf = null;
                    raf = new RandomAccessFile(file, "rw");
                    String newPath = file.getPath().replace("css","css1");
                    System.out.println(newPath);
                    File newfile = new File(newPath);
                    if(!newfile.getParentFile().exists()){
                        newfile.getParentFile().mkdirs();
                    }
                    FileWriter fileWriter  = new FileWriter(newfile);
                    String line = null;
                    while ((line = raf.readLine()) != null) {
                        if(line.contains("px")){
                            String regex = "\\d+px";
                            Pattern p = Pattern.compile(regex);
                            Matcher m = p.matcher(line);
                            boolean flag = false;
                            while(m.find()) {
                                String  px  = m.group();
                                int val = Integer.parseInt(px.substring(0,px.indexOf("px")));
                                if(val>5){
                                    System.out.println(val);
                                    //String.format("%.2f", data)
                                    line = line.replace(px,String.format("%.3f",(val/37.5))+"rem");
                                    System.out.println(line);
                                }
                            }

                        }
                        fileWriter.write(line+"\n");
                    }
                    fileWriter.close();
                }
            }
        }
    }

    @Test
    public void testBigDeg(){
        String s = "12.01";
        BigDecimal a  = new BigDecimal(s);
        BigDecimal b = new BigDecimal( s );
        System.out.println(a.compareTo(b));


    }

    @Test
    public void getGeneal(){
        System.out.println(UUIDGenerator.getRandomString(16));
    }


    //983727a903823a9106a8dc16ac368207
    @Test
    public void testHash(){
        System.out.println(MD5Tools.getMD5Hash("payPassword", "123456"));
    }

    @Test
    public void systemName(){
        String os = System.getProperty("os.name");
        if(os.toLowerCase().startsWith("win")){
            System.out.println(os + " can't gunzip");
        }
    }


}

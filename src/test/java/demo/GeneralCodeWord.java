package demo;

import com.yskj.utils.StringUtils;
import org.junit.Test;

import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 生成代码根据
 *
 * @author:Administrator
 * @create 2018-06-26 11:24
 */
public class GeneralCodeWord {
    public static void main(String[] args) {
        String path = "E:\\yskj_ijob\\src\\main\\java\\com\\yskj\\service";
        File file = new File(path);
        File[] fileList = file.listFiles();
        try {
            readfile(fileList);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private static void readfile(File[] files)throws Exception{
        int i = 1;
        int j = 0;
        for(File file: files){
            j = 0;
            if(!file.isDirectory()){
                System.out.println((i++) + "."+file.getName());
                FileReader fileReader = new FileReader(file);
                BufferedReader bufferedReader =  new BufferedReader(fileReader);
                String str ;
                while ((str=bufferedReader.readLine())!=null &&  j<50  ){
                    if(StringUtils.isNotEmpty(str)){
                        j++;
                        System.out.println(str);
                    }
                }
                System.out.println();
                System.out.println();
            }

        }
    }
}

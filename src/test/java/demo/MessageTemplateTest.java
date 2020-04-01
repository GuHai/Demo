package demo;

import com.yskj.utils.HttpUtils;
import org.junit.Test;

import java.util.HashMap;

/**
 * 消息模板
 *
 * @author:Administrator
 * @create 2018-07-02 14:18
 */
public class MessageTemplateTest {
    String token = "11_dIof5NtvnzVTTsdiv0F_jWVqNohBr7w7BQqaOXVpOKcqORY65Yf50mcXW8YnCr8upEiGbBzhm6lKj62pr8Rg9B7XDhB-PqnKh-GGAzcGUyVP4uGmFBqcKJvhILICDFaAJANOQ";

    @Test
    public void industry() throws Exception{
        String url = "https://api.weixin.qq.com/cgi-bin/template/api_set_industry?access_token="+token;
        String param = " {\n" +
                "          \"industry_id1\":\"2\",\n" +
                "          \"industry_id2\":\"34\"\n" +
                "       }";
        String result =  HttpUtils.post(url,param);
        System.out.println(result);
    }

    @Test
    public void getIndustry(){
        String url = "https://api.weixin.qq.com/cgi-bin/template/get_industry?access_token="+token;
        System.out.println(HttpUtils.get(url));
    }

    @Test
    public void postTemplateID() throws Exception{

        /*xbsm  录取通知      4alIiQzG_pCHGoABl07CA3v5VgPKdhw093thDPMHqBM
                未录取通知    -Bmqo1lAd7rV0YH4vzQbPJvMiWgOY7ffXYxyVv-tMYw
                工资发放提醒  AEQSRnzs8lM6qkNKBv5YuUow5X3ktEkrDbBy5RFERgI
                今日工作提醒  zi27EqQOhalfKhzY5NQVGxDXuraOcnTial7r4nJ9jyY
                */
        String url = "https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token="+token;
        String param = " {\n" +
                "           \"template_id_short\":\"OPENTM208001365\"\n" +
                "       }";
        String result =  HttpUtils.post(url,param);
        System.out.println(result);
    }


    @Test
    public void getTemplate(){
        String url = "https://api.weixin.qq.com/cgi-bin/template/get_all_private_template?access_token="+token;
        System.out.println(HttpUtils.get(url));
    }
}

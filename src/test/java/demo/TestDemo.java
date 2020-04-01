package demo;

import ch.hsr.geohash.GeoHash;
import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;
import com.spatial4j.core.context.SpatialContext;
import com.spatial4j.core.distance.DistanceUtils;
import com.spatial4j.core.io.GeohashUtils;
import com.spatial4j.core.shape.Rectangle;
import com.yskj.models.InsRecordPerson;
import com.yskj.models.Intentiontype;
import com.yskj.utils.DateUtils;
import com.yskj.utils.IJobUtils;
import com.yskj.utils.MD5Tools;
import com.yskj.utils.UUIDGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.junit.Test;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * @author:Administrator
 * @create 2018-03-16 14:35
 */
public class TestDemo {

    @Test
    public void testRand(){
//        System.out.println(SignUtils.getRandomStringByLength(32));
        System.out.println(UUIDGenerator.getRandomString(32));
    }

    @Test
    public void getDate(){
        String date = "{\"2018\":{\"3\":{\"24\":true,\"25\":true,\"27\":true,\"28\":true,\"29\":true,\"30\":true,\"31\":true}}}";
        Gson gson = new Gson();
        HashMap map = gson.fromJson(date,HashMap.class);
        System.out.println(map);
        Date  now  =  new Date();
        Object year = map.get((now.getYear()+1900)+"");
        if(year!=null){
            Object month = ((LinkedTreeMap)year).get((now.getMonth()+1)+"");
            if(month!=null){
                Object day = ((LinkedTreeMap)month).get(now.getDate()+"");
                System.out.println(day);
            }
        }
    }


    @Test
    public void testBig(){
       BigDecimal b =  new BigDecimal(10/100D);
        System.out.println(b);
    }

    @Test
    public  void testDom4j()throws Exception{
        String xml  =  "<xml><ToUserName><![CDATA[gh_688a2d30218a]]></ToUserName><FromUserName><!" +
                "[CDATA[o56nM0qwFlJ8sG5LOlubnUb3ZR70]]></FromUserName><CreateTime>1523172856</Cre" +
                "ateTime><MsgType><![CDATA[event]]></MsgType><Event><![CDATA[subscribe]]></Event>" +
                "<EventKey><![CDATA[]]></EventKey></xml>";
        org.dom4j.Document doc = DocumentHelper.parseText(xml); // 将字符串转为XML
        Element rootElt = doc.getRootElement(); // 获取根节点
        Map<String,String> map = new HashMap<String,String>();
        List<Element> eleList = rootElt.elements();
        //递归遍历父节点下的所有子节点
        for(Element ele : eleList){
            map.put(ele.getName(),ele.getTextTrim());
        }
        System.out.println(map);
        System.out.println(new Date().getTime()/1000);
    }

    @Test
    public void trim(){
        String str = "<xml><ToUserName>< ![CDATA[toUser] ]></ToUserName><FromUserName>< ![CDATA[fromUser] ]></FromUserName><CreateTime>12345678</CreateTime><MsgType>< ![CDATA[news] ]></MsgType><ArticleCount>2</ArticleCount><Articles><item><Title>< ![CDATA[title1] ]></Title> <Description>< ![CDATA[description1] ]></Description><PicUrl>< ![CDATA[picurl] ]></PicUrl><Url>< ![CDATA[url] ]></Url></item><item><Title>< ![CDATA[title] ]></Title><Description>< ![CDATA[description] ]></Description><PicUrl>< ![CDATA[picurl] ]></PicUrl><Url>< ![CDATA[url] ]></Url></item></Articles></xml>";
        str = str.replaceAll("\\s","");
        System.out.println(str);
    }

    @Test
    public void trans(){
        String str = "鏄痌";
        try {
            System.out.println(new String(str.getBytes("gbk"),"utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }


    @Test
    public void bigDecimal(){
        BigDecimal bigDecimal = new BigDecimal(11.121);
        System.out.println(bigDecimal.setScale(2,BigDecimal.ROUND_HALF_UP));
    }

    @Test
    public void testreg(){
        String num = "123456";
        boolean regex = num.matches("^[0-9]{6}$");
        System.out.println(regex);
    }

    @Test
    public void testgetdate(){
        String str  = "430921198801177752";
        String date = str.substring(6,10)+"-"+str.substring(10,12)+"-"+str.substring(12,14);
        System.out.println(DateUtils.format(DateUtils.getDateFromString(date),"yyyy-MM-dd"));
    }

    @Test
    public void testpinyin(){
        String str = "Amin\uD83C\uDFFB\uD83C\uDFFB\uD83C\uDFFB";
        System.out.println(IJobUtils.toHanyuPinyinFirstChar(str));
    }

    @Test
    public void printlocaltion(){
        double lon = 116.312528, lat = 39.983733;
        GeoHash geoHash = GeoHash.withCharacterPrecision(lat, lon, 10);
// 当前
        System.out.println(geoHash.toBase32());
// N, NE, E, SE, S, SW, W, NW
        GeoHash[] adjacent = geoHash.getAdjacent();
        for (GeoHash hash : adjacent) {
            System.out.println(hash.toBase32());
        }
    }

    @Test
    public void printlan(){
        // 移动设备经纬度
        double lon = 116.312528, lat = 39.983733;
// 千米
        int radius = 1;

        SpatialContext geo = SpatialContext.GEO;
        Rectangle rectangle = geo.getDistCalc().calcBoxByDistFromPt(
                geo.makePoint(lon, lat), radius * DistanceUtils.KM_TO_DEG, geo, null);
        System.out.println(rectangle.getMinX() + "-" + rectangle.getMaxX());// 经度范围
        System.out.println(rectangle.getMinY() + "-" + rectangle.getMaxY());// 纬度范围
    }

    @Test
    public void printgeo(){
        //     uzurvzgrbxbp
        String geo  = GeohashUtils.encodeLatLon(116.412528, 39.883733,5);
        System.out.println(geo);
    }

    @Test
    public void printdist(){
        // 移动设备经纬度
        double lon1 = 117.3125333347639, lat1 = 38.98355521792821;
// 商户经纬度
        double lon2 = 116.312528, lat2 = 39.983733;

        SpatialContext geo = SpatialContext.GEO;
        double distance = geo.calcDistance(geo.makePoint(lon1, lat1), geo.makePoint(lon2, lat2))
                * DistanceUtils.DEG_TO_KM;
        System.out.println(distance);// KM
    }

    @Test
    public void testSub(){
        String addr  = "湖南省益阳市南县大通湖区检察院(大通湖大道北50米)";
        /*int s1 = addr.indexOf("市");
        int s2 = addr.indexOf("州");
        int s  = Math.min(s1,s2)==-1?Math.max(s1,s2):Math.min(s1,s2);
        int e1 = addr.indexOf("区",s);
        int e2 = addr.indexOf("县",s);

        int e  = Math.min(e1,e2)==-1?Math.max(e1,e2):Math.min(e1,e2);
        String name = addr.substring(s+1,e+1);
        System.out.println(name);*/
        System.out.println(IJobUtils.getDistrictByAddr(addr));
    }

    @Test
    public void testJoin(){
        List<String> list = new ArrayList<String>();
        list.add("1");
        list.add("2");
        list.add("3");
        System.out.println("'"+String.join("','",list)+"'");
    }

    @Test
    public void testMoney(){
        System.out.println(new BigDecimal(1.24).multiply(new BigDecimal(0.015)));
    }

    @Test
    public void testOUyang(){
        System.out.println(MD5Tools.getMD5Hash("o56nM0lHvSOrU7cjDnsC5fujjPys", "bushishiji"));;
    }

    @Test
    public void testLast(){
        String datetime = "{\"2018\":{\"6\":{\"28\":true,\"7\":true,\"9\":true,\"10\":true,\"11\":true,\"12\":true,\"14\":true,\"16\":true,\"25\":true,\"6\":true}}}";

        /*System.out.println(DateUtils.isLastWorkDay(datetime,new Date(new Date(2018-1900,5,27).getTime()+11111000)));

        Date now = new Date();
        System.out.println(new Date( now.getYear(),now.getMonth(),now.getDate()));*/
        System.out.println(DateUtils.isLastWorkDay("{\"2018\":{\"6\":{\"9\":true}}}",new Date()));

        if(DateUtils.isWorkDay("{\"2018\":{\"6\":{\"9\":true,\"10\":true}}}",new Date())){
            System.out.println("nibunengqiandao");
        }
    }

    @Test
    public void testMD5(){
        /*String acc = "o56nM0nvfTESxxwI44gz2f1UEHeA";
        String str = MD5Tools.MD5(acc+MD5Tools.MD5(acc));
        System.out.println(str);*/

        String dd = "0.0";
        System.out.println(Double.parseDouble(dd));
        System.out.println(0D==Double.parseDouble(dd));


        String response = "{\"subscribe\":0,\"openid\":\"ox51S0UWJ9Xoi1ad2YdCSw_OtFZY\",\"tagid_list\":[]}";
        Map<String,Object> map = new Gson().fromJson(response,HashMap.class);
        System.out.println(map.get("subscribe"));
        if(0D==Double.parseDouble(map.get("subscribe").toString())){
            System.out.println("'sss");
        }
    }

    @Test
    public void testw(){
        BigDecimal sxf = new BigDecimal(50.01).setScale(0,BigDecimal.ROUND_UP).divide(new BigDecimal(100)).setScale(2);
        if(sxf.compareTo(new BigDecimal(0.01))<0){
            sxf = new BigDecimal(0.01).setScale(2,BigDecimal.ROUND_HALF_UP);
        }
        System.out.println(sxf);


        System.out.println(new BigDecimal(0.01).setScale(2,BigDecimal.ROUND_HALF_UP));

        System.out.println(new BigDecimal(51.01).setScale(2,BigDecimal.ROUND_HALF_UP));
    }

    @Test
    public void testhex(){
        ByteSource salt = ByteSource.Util.bytes("admin");
        String newPs = new SimpleHash("MD5", "123456", salt, 1).toHex();
        System.out.println(newPs);
    }

    @Test
    public void testA2S(){
        Date d1 = new Date();
        Date d2 = new Date(d1.getTime()-24*3600000);
        List<Date> list = new ArrayList<Date>();
        list.add(d1);
        list.add(d2);
        System.out.println(DateUtils.getDateFromArr(list));
    }

    @Test
    public void testReg(){
        String str = "100d";
        System.out.println(str.replaceAll("\\d",""));
        Pattern p=Pattern.compile("^\\d+[h|d]$",Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(str);

        System.out.println(m.find());
//        System.out.println(str.matches("^\\d[h|d]$"));
    }

    @Test
    public void testHttp(){
        /*long s = new Date().getTime();
        HttpUtils.get("http://www.tmall.com");
        long e = new Date().getTime();
        System.out.println("over"+(e-s));*/
    }

    @Test
    public void testBigD(){
        Integer i = 1890;
        System.out.println(new BigDecimal(i).divide(new BigDecimal(100)));
    }

    @Test
    public void testHD5(){
        System.out.println(
                MD5Tools.getMD5Hash("7a9d7923434048efb2b5b9cee8cff9a0","123456")
        );
    }

    @Test
    public void testBig1(){
        BigDecimal a = new BigDecimal(2.12);
        System.out.println((int)(a.doubleValue()*100));
    }

    @Test
    public void testchar(){
        String str = "1507983451";
        char[] s = str.toCharArray();

    }

    @Test
    public void testAtt(){
        String str = "<xml>\n" +
                "<return_code><![CDATA[SUCCESS]]></return_code>\n" +
                "<return_msg><![CDATA[支付失败]]></return_msg>\n" +
                "<mch_appid><![CDATA[wxdfd5dbfc4e2053b2]]></mch_appid>\n" +
                "<mchid><![CDATA[1507983451]]></mchid>\n" +
                "<result_code><![CDATA[FAIL]]></result_code>\n" +
                "<err_code><![CDATA[NOTENOUGH]]></err_code>\n" +
                "<err_code_des><![CDATA[余额不足]]></err_code_des>\n" +
                "</xml>";
    }

    @Test
    public void testBig3(){
       Set<String> s = new HashSet<String>();
       s.add("a");
       s.add("b");
       s.add("c");
       s.add("b");

       BigDecimal bigDecimal= BigDecimal.TEN;

        System.out.println(bigDecimal.subtract(BigDecimal.ONE));
    }

    @Test
    public void test4() {
        String cmd = " identity -i3 -pLum_*#i-job#* ".trim();
        System.out.println(cmd.trim().matches("^identity\\s+-i[1-3]+\\s+-pLum_\\*#i-job#\\*$"));
        String pattern = "^identity\\s+-i(\\d+)\\s+-p.+$";

        // 创建 Pattern 对象
        Pattern r = Pattern.compile(pattern);

        // 现在创建 matcher 对象
        Matcher m = r.matcher(cmd);
        if (m.find()) {
            System.out.println("Found value: " + Integer.parseInt( m.group(1)));
        }
    }


    @Test
    public void updateDateNum(){
        String str = "{\"2018\":{\"8\":{\"1\":1,\"2\":1}}}";
        String newstr = DateUtils.updateDateNum(str,1);
        System.out.println(newstr);
    }

    @Test
    public void testgetsize(){
        String work = "{\"2018\":{\"8\":{\"3\":1,\"4\":1,\"5\":1}}}";
        String mywork = "{\"2018\":{\"8\":{\"3\":1,\"4\":1,\"5\":1}}}";
        System.out.println(DateUtils.updateDateNumByBeen(work,mywork,1));
    }

    @Test
    public void testDate(){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Date date = new Date();
        System.out.println(date);
        try {
            Thread.sleep(1000);
        }catch (Exception e){
            e.printStackTrace();
        }
        Date date1 = new Date();
        System.out.println(date1);
        System.out.println(date.getTime());
        //System.out.println(format.parse(date1.toString()));
    }

    @Test
    public void testBigDecimal(){
        BigDecimal a;
        BigDecimal b;
        a = new BigDecimal(3);
        b = new BigDecimal(81);
        System.out.print(a.divide(new BigDecimal(81), 2, RoundingMode.HALF_UP));
    }

    @Test
    public void testnull(){
     /*   Account account = new Account();
        System.out.println(Boolean.FALSE == account.getIsCheck());


        System.out.println(new BigDecimal("0.01"));*/


        List<Intentiontype> list = new ArrayList<Intentiontype>();
        Intentiontype inte1 = new Intentiontype();
        inte1.setHtID("MT");
        Intentiontype inte2 = new Intentiontype();
        inte2.setHtID("XS");
        Intentiontype inte3 = new Intentiontype();
        inte3.setHtID("DG");
        list.add(inte1);list.add(inte2);list.add(inte3);
        System.out.println(String.join("','",list.stream().map(inte->inte.getHtID()).collect(Collectors.toList())));
    }


    @Test
    public void test1(){

       /* String news = "\"{\\\"openID\\\":\\\"ox51S0UWJ9Xoi1ad2YdCSw_OtFZY\\\",\\\"data\\\":\\\"{\\\\\\\"keyword1\\\\\\\":{\\\\\\\"color\\\\\\\":\\\\\\\"#173177\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"测试MQ\\\\\\\"},\\\\\\\"keyword2\\\\\\\":{\\\\\\\"color\\\\\\\":\\\\\\\"#173177\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"测试MQ内容pklYBLxi\\\\\\\"},\\\\\\\"remark\\\\\\\":{\\\\\\\"color\\\\\\\":\\\\\\\"#ff3b30\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"\\\\\\\\n\\\\\\\\r谢谢您的使用\\\\\\\"},\\\\\\\"first\\\\\\\":{\\\\\\\"color\\\\\\\":\\\\\\\"#173177\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"您有一笔申请单审核了\\\\\\\\n\\\\\\\\r\\\\\\\"}}\\\",\\\"url\\\":\\\"www.jianzhipt.com\\\",\\\"templateID\\\":\\\"b5G0W6_BfLuYb_gaJwyI9kLzavKTkmJzBVPg-C3ew2s\\\",\\\"status\\\":0,\\\"times\\\":1}\"";
        System.out.println( StringEscapeUtils.unescapeJava(news));
        String str =  "{\"name\":\"jack\",\"age\":2}";
        System.out.println(str);
        System.out.println(new Gson().fromJson(StringEscapeUtils.unescapeJava(news),InsTemplateTaskPanel.class));*/
        System.out.println(new Date().hashCode());
    }

    @Test
    public void test2(){
        List<InsRecordPerson> list = new ArrayList<>();
        InsRecordPerson insRecordPerson = new InsRecordPerson();
        insRecordPerson.setPersonID("1");
        insRecordPerson.setRecordID("2");
        insRecordPerson.setProfessionID("1");

        InsRecordPerson insRecordPerson1 = new InsRecordPerson();
        insRecordPerson1.setPersonID("1");
        insRecordPerson1.setRecordID("2");
        insRecordPerson1.setProfessionID("1");

        list.add(insRecordPerson);
        list.add(insRecordPerson1);
        Set<InsRecordPerson> set = new HashSet(list);
        System.out.println(list.size());
        System.out.println(set.size());
    }


}

package demo;

import com.google.gson.Gson;
import com.spatial4j.core.context.SpatialContext;
import com.spatial4j.core.distance.DistanceUtils;
import com.yskj.dao.UserDao;
import com.yskj.models.*;
import com.yskj.models.auth.Permission;
import com.yskj.models.auth.Role;
import com.yskj.models.auth.User;
import com.yskj.models.excel.WeeklyIn;
import com.yskj.models.template.QZ_LQ;
import com.yskj.service.*;
import com.yskj.service.auth.PermissionService;
import com.yskj.service.auth.RoleService;
import com.yskj.service.auth.UserService;
import com.yskj.service.base.DictCacheService;
import com.yskj.utils.DateUtils;
import com.yskj.utils.HttpUtils;
import com.yskj.utils.IJobUtils;
import com.yskj.utils.MD5Tools;
import com.yskj.utils.excel.ExcelExportUtil;
import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.File;
import java.math.BigDecimal;
import java.time.Month;
import java.util.*;

/**
 * 新增数据
 *
 * @author:Administrator
 * @create 2018-05-15 10:57
 */
/*@RunWith(SpringJUnit4ClassRunner.class) // 整合
@ContextConfiguration(locations={"classpath:/spring/*"}) // 加载配置*/
public class TestData {
    @Autowired
    UserService userService;
    @Autowired
    WeChatService weChatService;
    @Autowired
    UserDao userDao;
    @Autowired
    MetroService metroService;
    @Autowired
    StationService stationService;
    @Autowired
    RoleService roleService;
    @Autowired
    PermissionService permissionService;
    @Autowired
    MessageTemplateService messageTemplateService;
    @Autowired
    PositionService positionService;
    @Autowired
    LocaltioninfoService localtioninfoService;
    @Autowired
    SettlementpersonService settlementpersonService;
    @Autowired
    BeenrecruitedService beenrecruitedService;

   /* @Test
    public void addPinyin(){
        QueryParam queryParam = new QueryParam();
        List<User> list   = null;
        try {
            list = userService.findList(queryParam);
        } catch (Exception e) {
            e.printStackTrace();
        }
        for(User user : list){
            try {
                user.setVersion(user.getVersion()+1);
                user.setPinyin(IJobUtils.toHanyuPinyinFirstChar(user.getNickName()));
            }catch (Exception e){
                e.printStackTrace();
            }
            userDao.update(user);
        }
    }*/

  /* @Test
    public void addMetro()throws Exception{
       String name = "一号线";
       String stations = "开福区政府站,马厂站,北辰三角洲站,开福寺站,文昌阁站,培元桥站,五一广场站,黄兴广场站,南门口站,侯家塘站,南湖路站,黄土岭站,涂家冲站,铁道学院站,友谊路站,省政府站,桂花坪站,大托站,中信广场站,尚双塘站";
       Metro metro = new Metro();
       metro.setName(name);
       metro.setCityID("430100");
       metro.setNum(stations.split(",").length);
       metroService.add(metro);
       int i=0;
        for( String stationname : stations.split(",")){

//            String json  = HttpUtils.get("http://apis.map.qq.com/ws/geocoder/v1/?address="+"长沙市"+stationname+"地铁站"+"&key=3U3BZ-5PDWX-HFP4N-Z7GPP-T3LSH-LABHS");
            String json = HttpUtils.get("http://apis.map.qq.com/ws/place/v1/suggestion/?region=长沙市&keyword="+stationname+"地铁站&key=3U3BZ-5PDWX-HFP4N-Z7GPP-T3LSH-LABHS");
            Map map  = new Gson().fromJson(json,Map.class);
            Map localtion = (Map)((Map)((List)map.get("data")).get(0)).get("location");
            Station station = new Station();
            station.setMetroID(metro.getId());
            station.setName(stationname);
            station.setSort(i++);
            station.setLat(new BigDecimal(localtion.get("lat").toString()));
            station.setLng(new BigDecimal(localtion.get("lng").toString()));
            stationService.add(station);
            Thread.sleep(500);
        }
   }*/

  /*@Test
    public void testEmoil(){
      String name = "创  \uD83D\uDE2C  ";
      User user = new User();
      user.setNickName(name);
      Weixin weixin = new Weixin() ;
      weixin.setNickname(name);
      try {
//          userService.add(user);
          weChatService.add(weixin);
      } catch (Exception e) {
          e.printStackTrace();
      }
  }*/


 /* @Test
    public void addRole ()throws Exception{


      Permission permission = new Permission();
      permission.setSort("0001");
      permission.setDepth(1);
      permission.setAlias("FinanceManager");
      permission.setName("财务管理");
      permission.setType(1);
      permission.setStatus(Boolean.TRUE);
      permissionService.add(permission);



      Permission permission1 = new Permission();
      permission1.setSort("0001001");
      permission1.setDepth(2);
      permission1.setAlias("WithdrawList");
      permission1.setName("提现列表");
      permission1.setType(1);
      permission1.setStatus(Boolean.TRUE);
      permission1.setParentId(permission.getId());
      permission1.setUrl("/WithdrawListController/list");
      permissionService.add(permission1);

      Permission permission2 = new Permission();
      permission2.setSort("0001001001");
      permission2.setDepth(3);
      permission2.setAlias("hasView");
      permission2.setName("查看");
      permission2.setType(2);
      permission2.setStatus(Boolean.TRUE);
      permission2.setParentId(permission1.getId());
      permission2.setUrl("/WithdrawListController/view");
      permissionService.add(permission2);

  }*/
/*
    @Test
    public void testPw(){
        try {
            Weixin weixin =  weChatService.get("1");
            System.out.println(MD5Tools.getMD5Hash("o56nM0nvfTESxxwI44gz2f1UEHeA",weixin.getNickname()));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }*/


   /* @Test
    public void testSendMsg()throws Exception{
        Position position = positionService.get("de9df976783c4164bdd76be86441d2e5");
        Localtioninfo localtioninfo = localtioninfoService.get("c8e9f41af6fb4b8f8a8d3a381fa5164b");
        Beenrecruited beenrecruited = beenrecruitedService.get("b1c6194d3f50425e8d4764cbd7b66c75");
        position.setWorkPlace(localtioninfo);
        Settlementperson settlementperson = settlementpersonService.get("2af62558010649cbba0d92f0aad5e709");
        User user = userService.get("06556a3bfd5342149ede28ddd581f9bb");
        messageTemplateService.zpCjs(position,user);
    }*/

  /* @Test
    public void testDouble(){
       BigDecimal a = BigDecimal.ZERO;
       System.out.println(a.doubleValue());
   }

   @Test
    public void testDistance(){
       double lon = Double.parseDouble("112.977295");
       double lat = Double.parseDouble("28.209108");
      *//* double tarlng = Double.parseDouble("112.9774");
       double tarlat = Double.parseDouble("28.209206");*//*

       double tarlng = Double.parseDouble("112.97184");
       double tarlat = Double.parseDouble("28.212736");
       SpatialContext geo = SpatialContext.GEO;
       double distance = geo.calcDistance(geo.makePoint(lon, lat),geo.makePoint(tarlng, tarlat))
               * DistanceUtils.DEG_TO_KM;
       System.out.println(distance);
   }*/

   /* @Autowired
    AccountService accountService;
    @Test
    public void testTaX()throws Exception{
        PartnerRebate partnerRebate = new PartnerRebate();
        partnerRebate.setFee(new BigDecimal(50));
        partnerRebate.setLayer(1);
        partnerRebate.setPartID("1");
        partnerRebate.setUpartID(1);
        partnerRebate.setShareUserID("bd9a994d89e4405e86666b52112581de");
        partnerRebate.setUserID("bd9a994d89e4405e86666b52112581de");
        partnerRebate.setOrderNumber("123");
        partnerRebate.setRemarks("测试合伙人奖励元");
        accountService.addPartnerShareRebate(partnerRebate);
    }*/

   @Test
    public void test(){
       BigDecimal b = new BigDecimal(0.001);
       System.out.println(b.setScale(2,BigDecimal.ROUND_UP));

       BigDecimal m = new BigDecimal(6/100.0).setScale(2,BigDecimal.ROUND_UP);
       System.out.println(m);

       BigDecimal a = new BigDecimal(1);
       System.out.println(a.add(new BigDecimal(2)));

       Set<String> set = new HashSet<String>();
       set.add("a");
       set.add("b");
       List<String> list = Arrays.asList(set.toArray(new String[]{}));

       List<String> nlist =new ArrayList<String>();
       nlist.add("c");
       nlist.add("d");
       String s = StringUtils.join(set,";" );
       System.out.println(s);


       String name = "长沙理工大学（金盆岭校区)";
       if(name.contains("(")||name.contains("（")){
           name  =  name.substring(0,Math.max(name.indexOf("("),name.indexOf("（")));
       }
       System.out.println(name);


       BigDecimal money = new BigDecimal(1.79);
       System.out.println(money.setScale(0,BigDecimal.ROUND_UP));
       BigDecimal sxf = money.multiply(new BigDecimal(0.6)).divide(new BigDecimal(100)).setScale(2,BigDecimal.ROUND_UP);
       System.out.println(sxf);


       System.out.println(MD5Tools.getMD5Hash("515582d925fb4ccbbf2d5877c1a87eb3","123456"));

       System.out.println( new BigDecimal("0.01").multiply(new BigDecimal(100)).setScale(0,BigDecimal.ROUND_UP));


       String str = "a50b4dfcab754ac4a9607e8d23f06e6c,\n" +
               "74296931ee824895a861d2217ac44904,\n" +
               "3a6bd12d40bc47819091def3bafaf1b0,\n" +
               "17d15075470f4d329deaa6d63f5e1cef,\n" +
               "855e0fc074f145a5a61ac347b46052db,\n" +
               "235bf2cb0ded41a2a862b27e55c0c389,\n" +
               "d1fe335f640e483da79467044e96249c,\n" +
               "09476945dcc644b48192a6da9c757e96,\n" +
               "3a20e9226486475d80c65522d78aa001,\n" +
               "3948fe08c5b44990ad77257e44c5cf47,\n" +
               "3d07801d772d4ee78f23fe06e693ba16,\n" +
               "12089b3e8a5e49139ce76b6a8fee47fa,\n" +
               "3a6bd12d40bc47819091def3bafaf1b0,\n" +
               "12089b3e8a5e49139ce76b6a8fee47fa,\n" +
               "e06a5ca25a2c4976894616bba3542736,\n" +
               "61123d2e74e94e7b9a2d4dec4ebeff1b,\n" +
               "8a675aaec33a425a99b0b3281579b2ec,\n" +
               "d1fe335f640e483da79467044e96249c,\n" +
               "278c7595c5d34e4ba36d82692585b57f,\n" +
               "7c39d51c34a64a4b949282c3047b1896,\n" +
               "3730f8fd49744d26bbe191e36033dd00,\n" +
               "e06a5ca25a2c4976894616bba3542736,\n" +
               "8a4fe3238671451da0c530396cd9bd44,\n" +
               "61123d2e74e94e7b9a2d4dec4ebeff1b,\n" +
               "28f04ae71dea46d9a03184a6e4e80d32,\n" +
               "235bf2cb0ded41a2a862b27e55c0c389,\n" +
               "28f04ae71dea46d9a03184a6e4e80d32,\n" +
               "f7bf8eed209e47a092d47d583993867b,\n" +
               "7c39d51c34a64a4b949282c3047b1896,\n" +
               "48a34c22947e4742a22dd16f79ead695,\n" +
               "81a5e3241a9540e8ab686e5de1809eb3,\n" +
               "c1b2a4aabb414c4bbfb2bb6ebfdd669b,\n" +
               "0b34fce95a5748c381f8c365c23fe6e5,\n" +
               "abe23e7df26e4bf98345367f6a21fca3,\n" +
               "b0db9bca8629414787f6266c336b7521,\n" +
               "3aadb8889c1c4f4a9c286acd4ecf6a89,\n" +
               "e66c79cfb56149bbba5cfc2d2e1e6c0d,\n" +
               "3aadb8889c1c4f4a9c286acd4ecf6a89,\n" +
               "3730f8fd49744d26bbe191e36033dd00,\n" +
               "c70bb9928aa947f68019c0b71cc5b419,\n" +
               "95a1f1b2b1c84a29ac259221292c69cf,\n" +
               "437eb5c10e2f4523ab32f8898942f8f4,\n" +
               "5a1024a78c5d4e5091d27437c6178f5d,\n" +
               "17d15075470f4d329deaa6d63f5e1cef,\n" +
               "55aaaf1ca325433d993e8f3b9d64be4c,\n" +
               "f42a59a7f82b45a8b2f22d21140cb39c,\n" +
               "743d64c9b46645b7a9b7b022f3cb7eee,28c513f095cd41dd8426cb8873295022,\n" +
               "354b59aff0a84f3ab85880ff2c179a0b,a55bfde67d024a96b4a5abccc22977c3,06cbe8b272e2474e9c1f1f8184f69e01,aa53496d0ba64efcb71de08c33c50fde,e0ce950481ac4fdeadb500268a2a2707,\n" +
               "e0ce950481ac4fdeadb500268a2a2707,4b64844b43fd4d5c831f9e0063ba2172,5997f2b1f18f4c68800994f1ee52ee43,52f4c2cffa2b4473bd973529f976e98a,\n" +
               "ceed0137b7d443c191b130fc733127a6,82e50ed7ec0c4891badf39d00a862eb4,3b187629ad86485eabfe0cc62e2246f5,\n" +
               "3b187629ad86485eabfe0cc62e2246f5,9e3c4179f11546da9d815d4155d5ab74,\n" +
               "e7bd150a004e45dab8d623c5b4d27bc1,eaff02105ee742dfba70d77eb2904381,\n" +
               "c2f39c2fcfba48fc9a56db3bbe4e7015,ff3ddc5378f74ab98b225477f2cb7e97,\n" +
               "0895b3fcd4104554899408c624f0edc6,3068367ce5a3400fb1d2d3cfdef0e392,\n" +
               "9e3c4179f11546da9d815d4155d5ab74,bb84e83ab8e04dcd80578700a7857db1,";
       System.out.println(Arrays.asList(str.split(",").length));
       System.out.println("\'"+StringUtils.join(Arrays.asList(str.replaceAll("\n","").split(",")),"','"));
   }
    private static String WEEK_PATH = "iJob/file/report/week";
    private static String MONTH_PATH = "iJob/file/report/month";

    @Autowired
    AccountService accountService;

   /* @Test
    public void testHistory()throws Exception{
        accountService.processHistoryData();
    }
    @Test
    public void testOrder()throws Exception{
        Date date  = new Date(new Date().getTime()-3600000*24);//获取上一个
        Integer day = DateUtils.countDaysInMonth(Month.of(date.getMonth()+1));
        day = 60;
        QueryParam queryParam = new QueryParam();
        queryParam.put("type",5);
        queryParam.put("isPass",Boolean.TRUE);
        queryParam.put("interval",day);
        List<Account> accounts = accountService.findList(queryParam);
        List<WeeklyIn> weeklyOuts = new  ArrayList<WeeklyIn>();
        for(Account account : accounts){
            if(com.yskj.utils.StringUtils.isNotEmpty(account.getAccID())){
                queryParam.clear();
                queryParam.put("accIds","'"+account.getAccID().replaceAll(",","','")+"abcdefg'");
                List<WeeklyIn> weeklyIns  =  accountService.weeklyReportForB(queryParam);
                for(WeeklyIn weeklyIn : weeklyIns){
                    if(com.yskj.utils.StringUtils.isNotEmpty(weeklyIn.getAccID()) && weeklyIn.getAccID().length()>50){//肯定是多个单了
                        String realmoeny = new Gson().fromJson(weeklyIn.getAccID(), HashMap.class).get(account.getId()).toString();
                        weeklyIn.setMoney(new BigDecimal(realmoeny));
                    }
                    weeklyIn.setTime(account.getUpdateTime());
                    weeklyOuts.add(weeklyIn);
                }
            }
        }
        List<WeeklyIn> weeklyIns = accountService.weeklyReportForA(new QueryParam("interval",day));
        String datestr = DateUtils.format(date, "yyyy-MM");
        String path =  DictCacheService.UploadPath + File.separator + MONTH_PATH  ;
        ExcelExportUtil.general(path,weeklyIns,datestr+"A");
        ExcelExportUtil.general(path,weeklyOuts,datestr+"B");
        String[] filenames = new String[2];
        filenames[0] = datestr+"A.xlsx";
        filenames[1] = datestr+"B.xlsx";
    }*/
   @Test
   public void generalpw(){
       System.out.println( MD5Tools.getMD5Hash("o56nM0nIYzKQG4-Bz1vgdX9hdEDw", MD5Tools.MD5("o56nM0nIYzKQG4-Bz1vgdX9hdEDw")));
   }

    @Test
    public void generalpaypw(){
        System.out.println(MD5Tools.getMD5Hash("payPassword", (String) "123456"));
    }


}

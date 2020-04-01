package com.yskj.utils;

import com.yskj.service.base.DictCacheService;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

/**
 * @author:Administrator
 * @create 2019-03-26 10:51
 */
public class WeixinUtil {

    /**
     *
     * 校验终端
     */
    public static boolean checkTerminal(HttpServletRequest request){
        boolean isMoblie = false;
        String[] mobileAgents = { "iphone", "android", "phone", "mobile", "wap", "netfront", "java", "opera mobi","opera mini","ucweb", "windows ce", "symbian", "series", "webos", "sony", "blackberry", "dopod",  "nokia", "samsung", "palmsource", "xda", "pieplus", "meizu", "midp", "cldc", "motorola", "foma", "docomo", "up.browser", "up.link", "blazer", "helio", "hosin", "huawei", "novarra", "coolpad", "webos",  "techfaith", "palmsource", "alcatel", "amoi", "ktouch", "nexian","ericsson", "philips", "sagem","wellcom", "bunjalloo", "maui","smartphone", "iemobile", "spice", "bird", "zte-", "longcos","pantech", "gionee", "portalmmm", "jig browser", "hiptop", "benq", "haier", "^lct", "320x320", "240x320", "176x220", "w3c ", "acs-", "alav", "alca", "amoi", "audi", "avan", "benq", "bird", "blac","blaz", "brew", "cell", "cldc", "cmd-", "dang", "doco", "eric", "hipt", "inno", "ipaq", "java", "jigs","kddi", "keji", "leno", "lg-c", "lg-d", "lg-g", "lge-", "maui", "maxo", "midp", "mits", "mmef", "mobi","mot-", "moto", "mwbp", "nec-", "newt", "noki", "oper", "palm", "pana", "pant", "phil", "play", "port","prox", "qwap", "sage", "sams", "sany", "sch-", "sec-", "send", "seri", "sgh-", "shar", "sie-", "siem","smal", "smar", "sony", "sph-", "symb", "t-mo", "teli", "tim-", "tosh", "tsm-", "upg1", "upsi", "vk-v","voda", "wap-", "wapa", "wapi", "wapp", "wapr", "webc", "winw", "winw", "xda", "xda-","Googlebot-Mobile" };
        String header = request.getHeader("User-Agent");
        if (header != null) {
            header = header.toLowerCase();
            for (String mobileAgent : mobileAgents) {
                if (header.indexOf(mobileAgent) >= 0) {
                    isMoblie = true;
                    break;
                }
            }
        }
        return isMoblie;
    }

    /**
     *
     * 校验是不是微信
     */
    public static boolean checkWeChat(HttpServletRequest request){
        String header = request.getHeader("User-Agent");
        if (header != null) {
            return header.indexOf("MicroMessenger")>=0;
        }
        return false;
    }



    public static String indexMain(Model model ,String menu,HttpServletRequest request){
        model.addAttribute("menu",menu);
        boolean isMoblie = checkTerminal(request);
        if(isMoblie){
            model.addAttribute("mylocaltion",IJobSecurityUtils.getLoginUser().getMylocaltion());
            model.addAttribute("site", DictCacheService.Site);
            model.addAttribute("GzhID",DictCacheService.GzhID);
            model.addAttribute("chatIP",DictCacheService.ChatServerIP);
            if("qz".equals(menu)){
                IJobSecurityUtils.getLoginUser().getInformation().setIdentityType(1);
            }else if("broker".equals(menu)){
                IJobSecurityUtils.getLoginUser().getInformation().setIdentityType(2);
            }else if("salary".equals(menu)){
                return "/h5/zp/paysalary/salaryIndex";
            }
            if (IJobSecurityUtils.getLoginUser().getInformation().getIdentityType() == null){
                model.addAttribute("id",IJobSecurityUtils.getLoginUser().getInformation().getId());
                model.addAttribute("version",IJobSecurityUtils.getLoginUser().getInformation().getVersion());
                return "/h5/choiceIdentity";
            }else  if(2==IJobSecurityUtils.getLoginUser().getInformation().getIdentityType()){
                return "/h5/zp/index";
            }else if(1==IJobSecurityUtils.getLoginUser().getInformation().getIdentityType()){
                return "/h5/qz/index";
            }else if(3==IJobSecurityUtils.getLoginUser().getInformation().getIdentityType()){
                return "/h5/gl/zpManager";
            }else if(4==IJobSecurityUtils.getLoginUser().getInformation().getIdentityType()){
                return "/h5/gl/qzManager";
            }else{
                return "/h5/qz/index";
            }
        }else{
            return "redirect:/loginMain";
        }
    }
}

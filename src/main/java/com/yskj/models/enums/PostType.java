package com.yskj.models.enums;

import java.lang.reflect.Method;
import java.util.*;

/**
 * 全职类别
 *
 * @author:Administrator
 * @create 2018-12-13 10:24
 */
public enum PostType {
    PUGONG("普工","PG"),CAOZUOGONG("操作工","CZG"),ZHUANGPEIGONG("装配工","ZPG"),ZHIJIANYUAN("质检员","ZJY"),FENGJIANYUAN("分拣员","FJY"),SALMIAOYUAN("扫描员","SMY"),DABAOYUAN("打包员","DBY"),WEIXIUYUAN("维修员","WXY"),JIGONG("技工","JG"),HANGONG("焊工","HG"),QIANGONG("钳工","QG"),DIANGONG("电工","DG"),CHANCHEGONG("铲车/叉车工","CCG"),MOJUGONG("铸造/注塑/模具工","MMG"),ZHUANGXIEYUAN("装卸员","ZXY"),BAOAN("保安","BA"),JIASHIYUAN("驾驶员","JSY"),TIEMOGONG("贴膜工","TMG"),BAOJIEYUAN("保洁员","BJY"),KUAIDIYUAN("快递员","KDY"),FUWUYUAN("服务员","FWY"),YINGYEYUAN("营业员","YYY"),SHIXISHENG("实习生","SXS"),QITA("其他","QT");
    private String name;
    private String value;
    private PostType(String name, String value) {
        this.name = name;
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public String getValue() {
        return value;
    }



    /**
     * 枚举转map结合value作为map的key,description作为map的value
     * @param enumT
     * @param methodNames
     * @return enum mapcolloction
     */
    public static <T> List<Map> EnumToMap(Class<T> enumT,
                                     String... methodNames) {
        List<Map> listMap = new ArrayList();
        Map<Object, String> enummap = new HashMap<Object, String>();
        if (!enumT.isEnum()) {
            listMap.add(enummap);
            return listMap;
        }
        T[] enums = enumT.getEnumConstants();
        if (enums == null || enums.length <= 0) {
            listMap.add(enummap);
            return listMap;
        }
        int count = methodNames.length;
        String valueMethod = "getValue"; //默认接口value方法
        String desMethod = "getName";//默认接口description方法
        if (count >= 1 && !"".equals(methodNames[0])) { //扩展方法
            valueMethod = methodNames[0];
        }
        if (count == 2 && !"".equals(methodNames[1])) {
            desMethod = methodNames[1];
        }
        for (int i = 0, len = enums.length; i < len; i++) {
            enummap = new HashMap<Object, String>();
            T tobj = enums[i];
            try {
                Object resultValue = getMethodValue(valueMethod, tobj); //获取value值
                if ("".equals(resultValue)) {
                    continue;
                }
                Object resultName = getMethodValue(desMethod, tobj); //获取description描述值
                if ("".equals(resultName)) { //如果描述不存在获取属性值
                    resultName = tobj;
                }
                enummap.put("value",resultValue.toString());
                enummap.put("name",resultName.toString());
                listMap.add(enummap);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return listMap;
    }

    /**
     * 根据反射，通过方法名称获取方法值，忽略大小写的
     * @param methodName
     * @param obj
     * @param args
     * @return return value
     */
    private static <T> Object getMethodValue(String methodName, T obj,
                                             Object... args) {
        Object resut = "";
        // boolean isHas = false;
        try {
            /********************************* start *****************************************/
            Method[] methods = obj.getClass().getMethods(); //获取方法数组，这里只要共有的方法
            if (methods.length <= 0) {
                return resut;
            }
            // String methodstr=Arrays.toString(obj.getClass().getMethods());
            // if(methodstr.indexOf(methodName)<0){ //只能粗略判断如果同时存在 getValue和getValues可能判断错误
            // return resut;
            // }
            // List<Method> methodNamelist=Arrays.asList(methods); //这样似乎还要循环取出名称
            Method method = null;
            for (int i = 0, len = methods.length; i < len; i++) {
                if (methods[i].getName().equalsIgnoreCase(methodName)) { //忽略大小写取方法
                    // isHas = true;
                    methodName = methods[i].getName(); //如果存在，则取出正确的方法名称
                    method = methods[i];
                    break;
                }
            }
            // if(!isHas){
            // return resut;
            // }
            /*************************** end ***********************************************/
            // Method method = obj.getClass().getDeclaredMethod(methodName); ///确定方法
            if (method == null) {
                return resut;
            }
            resut = method.invoke(obj, args); //方法执行
            if (resut == null) {
                resut = "";
            }
            return resut; //返回结果
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resut;
    }

    public static void main(String[] args) {
        System.out.println(PostType.BAOAN.name);
    }

}

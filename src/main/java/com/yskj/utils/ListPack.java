package com.yskj.utils;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * 简单的list分装
 *
 * @author:Administrator
 * @create 2018-03-04 14:16
 */
@Data
public class ListPack implements java.io.Serializable {
    public ListPack(){

    }
    private List list;
    public ListPack(Object object){
        if(object instanceof List){
            if(object!=null){
                list = (List)object;
            }
        }else{
            list = new ArrayList();
            list.add(object);
        }
    }
}

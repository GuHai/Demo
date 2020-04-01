package com.example.demo.type;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.lang.reflect.Constructor;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author:Administrator
 * @create 2018-12-27 16:02
 */
@Data
public class Message {

    private String groupID;
    private String type;
    private String userID;
    private Object context;
    private Date date;
    @JsonIgnore
    private Object user;
    @JsonIgnore
    private List<Map> userlist;
    @JsonIgnore
    private Long lastTime;
    @JsonIgnore
    private String name;

}

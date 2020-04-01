package com.example.demo.type;

import lombok.Data;

/**
 * @author:Administrator
 * @create 2018-12-27 15:52
 */
@Data
public class Catalog extends Message {
    private String groupID;
    private Integer count=0;
    private Boolean isGroup;
    private Message message;
}

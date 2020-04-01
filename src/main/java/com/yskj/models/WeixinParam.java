package com.yskj.models;

import lombok.Data;

/**
 * 微信的参数
 *
 * @author:Administrator
 * @create 2018-01-25 18:22
 */
@Data
public class WeixinParam {
    private String ToUserName;    //开发者微信号
    private String FromUserName;	//发送方帐号（一个OpenID）
    private String CreateTime;	    //消息创建时间 （整型）
    private String MsgType;	    //消息类型，event
    private String Event;	        //事件类型，subscribe(订阅)、unsubscribe(取消订阅)
    private String code;
    private String state;
}

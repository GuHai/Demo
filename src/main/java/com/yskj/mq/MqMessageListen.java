package com.yskj.mq;

import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

/**
 * mq消息监听
 *
 * @author:Administrator
 * @create 2018-12-11 15:10
 */
public class MqMessageListen implements MessageListener {
    public void onMessage(Message message) {
        System.out.println("监听==================监听");
        try {
            System.out.println(message);
            TextMessage tm = (TextMessage)(message);
            System.out.println(tm.getText());
        } catch (Exception e) {
            e.printStackTrace();

        }
    }
}

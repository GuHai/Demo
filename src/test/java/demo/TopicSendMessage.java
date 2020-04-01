package demo;

import lombok.Data;
import org.apache.xbean.spring.context.ClassPathXmlApplicationContext;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;
import javax.jms.TextMessage;

/**
 * 发送消息类
 *
 * @author:Administrator
 * @create 2018-12-11 15:12
 */
/*@RunWith(SpringJUnit4ClassRunner.class) // 整合
@ContextConfiguration(locations={"classpath:/spring/*"}) // 加载配置*/
public class TopicSendMessage {
    @Autowired
    JmsTemplate jmsTemplate;


    public void receive(){
        Message msg = jmsTemplate.receive();
        TextMessage tm = (TextMessage)msg;
        System.out.println("非监听------------------非监听");
        System.out.println(msg);
    }

    @Test
    public void test(){
        jmsTemplate.send(new MessageCreator() {
            public Message createMessage(Session session) throws JMSException {
                TextMessage msg = session.createTextMessage();
                msg.setText("发送数据++++++++++++发送数据");
                System.out.println("发送数据++++++++++++发送数据");
                return msg;
            }
        });
    }

}

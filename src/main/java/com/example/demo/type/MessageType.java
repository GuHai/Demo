package com.example.demo.type;


/**
 * @author:Administrator
 * @create 2019-01-24 15:22
 */
public enum MessageType {
    Position("职位"),Emoji("表情"),Location("位置"),Image("图片"),Video("视频"),Audio("音频");
    private String cn;

    public String getCn() {
        return cn;
    }

    public void setCn(String cn) {
        this.cn = cn;
    }

    private MessageType(String cn){
        this.cn = cn;
    }



    public static String getContent(Message message){
        for (MessageType e : MessageType.values()) {
            if(e.toString().equals(message.getType())){
                return e.getCn();
            }
        }
        return message.getContext().toString();
    }
}

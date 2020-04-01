package com.yskj.exception;

import lombok.Data;

/**
 * ijob的异常捕获
 *
 * @author:Administrator
 * @create 2018-03-28 11:13
 */
@Data
public class IJobException extends Exception {
    private String code ="000";
    public IJobException(String msg){
        super(msg);
    }

    public IJobException(String msg,String code){
        super(msg);
        this.code = code;
    }
}

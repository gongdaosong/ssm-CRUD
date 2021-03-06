package com.gds.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @Author 龚道松
 * @Date 2019/7/2 9:46
 * @Wersion 1.0
 **/
public class Msg {

    // 状态码 100-成功，200-失败
    private Integer code;
    // 提示信息
    private String msg;

    // 要返回给浏览器的数据
    private Map<String, Object> extend = new HashMap<String, Object>();


    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功！");
        return result;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败！");
        return result;
    }

    public Msg add(String key, Object value){

        this.getExtend().put(key,value);
        return this;
    }
    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}

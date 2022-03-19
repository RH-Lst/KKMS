package com.RH.utils;

import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component("ResultMap")
public class ResultMap<T> {

    private String message;		//异常信息
    private boolean status;		//状态
    private Object obj;			//一条数据
    private List<T> list = new ArrayList<T>();  //多条数据

    private long total;			//数据总条数

    private int page;			//当前页码
    private int limits;			//每页显示多少条数据

    private int code;

    private int authority;

    public int getAuthority() {
        return authority;
    }

    public void setAuthority(int authority) {
        this.authority = authority;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Object getObj() {
        return obj;
    }

    public void setObj(Object obj) {
        this.obj = obj;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getLimits() {
        return limits;
    }

    public void setLimits(int limits) {
        this.limits = limits;
    }
}

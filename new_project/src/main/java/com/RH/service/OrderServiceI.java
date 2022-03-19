package com.RH.service;

import com.RH.db.pojo.Order_Detils;
import com.RH.utils.ResultMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public interface OrderServiceI {

    void addCartItem(String jsonStr,String fid, HttpServletRequest request) ;

    public void getorder(HttpSession session);

    public List<Order_Detils> selectOrderByLimits();
}

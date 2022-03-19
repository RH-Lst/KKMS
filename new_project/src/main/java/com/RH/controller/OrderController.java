package com.RH.controller;

import com.RH.db.pojo.Order_Detils;
import com.RH.db.pojo.User;
import com.RH.service.OrderServiceI;
import com.RH.utils.ResultMap;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class OrderController {

    @Autowired
    private OrderServiceI orderServiceI;
    @Autowired
    private ResultMap resultMap;


    @RequestMapping("/orderInCart")
    public ResultMap addCartItem(String jsonStr,String fid, HttpServletRequest request) {
        try{
            orderServiceI.addCartItem(jsonStr,fid,request);
            resultMap.setStatus(true);
        }catch (Exception e){
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }

        return resultMap;
    }

    @RequestMapping("/getorder")
    public ResultMap getorder(HttpSession session) {
        try{
            orderServiceI.getorder(session);
            resultMap.setStatus(true);
        }catch (Exception e){
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }

        return resultMap;
    }


    @RequestMapping("/selectOrderByLimits")
    @ResponseBody
    public ResultMap selectOrderByLimits(int page,int limit){
        try{
            PageHelper.startPage(page, limit);//开启分页
            List<Order_Detils> list=orderServiceI.selectOrderByLimits();
            PageInfo<Order_Detils> pageInfo=new PageInfo<Order_Detils>(list);
            long total=pageInfo.getTotal();
            resultMap.setCode(0);
            resultMap.setList(list);
            resultMap.setTotal(total);
        }catch (Exception e){
            resultMap.setCode(1);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }

}

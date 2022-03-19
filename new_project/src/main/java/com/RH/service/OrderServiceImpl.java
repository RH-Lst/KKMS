package com.RH.service;

import com.RH.db.dao.FoodDao;
import com.RH.db.dao.OrderDao;
import com.RH.db.pojo.Order;
import com.RH.db.pojo.Order_Detils;
import com.RH.db.pojo.User;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderServiceI{


    @Autowired
    private OrderDao orderDao;

    @Override
    public void addCartItem(String jsonStr,String fid,HttpServletRequest request) {

        Order_Detils order_detils = JSON.parseObject(jsonStr, Order_Detils.class);

        int Intfid = Integer.parseInt(fid);
        order_detils.setFid(Intfid);

        Map<Order_Detils,Integer> map=(Map<Order_Detils,Integer>)request.getSession().getAttribute("orderlist");

        Integer count = null;
        if(map==null) {
            map=new HashMap<Order_Detils,Integer>();
            request.getSession().setAttribute("orderlist", map);
            int num = order_detils.getOrderNum();
            count=num;
        }else {
            //查看该菜品是否存在
            count=map.get(order_detils.getFid());
            //如果购物车没有该菜品
            if(count==null) {
                int num = order_detils.getOrderNum();
                count=num;
            }else {
                //如果有菜品数量++
                int num = order_detils.getOrderNum();
                count=count+num;
            }
        }

        map.put(order_detils,count);
        request.setAttribute("orderlist", map);//将map传到前台


        }

    @Override
    public void getorder(HttpSession session) {
        System.out.println("service");
        Map<Order_Detils,Integer> map= (Map<Order_Detils, Integer>) session.getAttribute("orderlist");

        double totalMoney=0;
        Order_Detils order_detils=new Order_Detils();
        Order order=new Order();

        int uid=0;
        String userName=null;
        for (Order_Detils data:map.keySet()) {
            uid=data.getUid();
            userName=data.getUserName();
        }


        order.setUid(uid);
        order.setUserName(userName);

        /*向数据库中插入order表，生成自增主键*/
        orderDao.insertOrder(order);

        int getoid=orderDao.selectLatestId().getOid();


        for (Order_Detils data:map.keySet()) {
            totalMoney=totalMoney+data.getFoodPrice()*data.getOrderNum();

            order_detils.setOid(getoid);
            order_detils.setFid(data.getFid());
            order_detils.setFoodName(data.getFoodName());
            order_detils.setFoodPrice(data.getFoodPrice());
            order_detils.setOrderNum(data.getOrderNum());

            /*获取订单id后，向数据库中添加订单详情*/
            int num=orderDao.insertOrderDetis(order_detils);
            if (num==0){
                throw new RuntimeException("新增订单详情失败！");
            }
        }

        order.setOid(getoid);
        order.setTotalMoney(totalMoney);

        int num=orderDao.updateOrder(order);

        ((Map<Order_Detils, Integer>) session.getAttribute("orderlist")).clear();

        if (num==0){
            throw new RuntimeException("更新订单金额失败！");
        }

    }

    @Override
    public List<Order_Detils> selectOrderByLimits() {

        List<Order_Detils> list=orderDao.selectOrderByLimits();

        if (list==null){
            throw new RuntimeException("当前无订单");
        }

        return list;
    }


}

package com.RH.db.dao;

import com.RH.db.pojo.Order;
import com.RH.db.pojo.Order_Detils;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderDao {

    public int insertOrder(Order order);

    public Order selectLatestId();

    public int insertOrderDetis(Order_Detils order_detils);

    public int updateOrder(Order order);

    List<Order_Detils> selectOrderByLimits();
}

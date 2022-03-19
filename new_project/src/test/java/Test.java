import com.RH.db.pojo.Order_Detils;

import java.util.ArrayList;
import java.util.List;

public class Test {

    public static void main(String[] args) {

        Order_Detils order_detils=new Order_Detils();
        order_detils.setFoodName("test");
        order_detils.setFoodPrice(1.21);
        order_detils.setOrderNum(5);

        Order_Detils order_detils1=new Order_Detils();
        order_detils1.setFoodName("test1");
        order_detils1.setFoodPrice(1.21);
        order_detils1.setOrderNum(51);

        List list=new ArrayList();
        list.add(order_detils);
        list.add(order_detils1);



        System.out.println(list);
    }
}

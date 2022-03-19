<%@ page import="java.util.Map" %>
<%@ page import="com.RH.db.pojo.Order_Detils" %><%--
  Created by IntelliJ IDEA.
  User: RH
  Date: 2021/8/9
  Time: 21:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css"  media="all">
    <script src="js/jquery.min.js"></script>

    <style type="text/css">
        .layui-table-cell{
            height:auto!important;
            white-space:normal;
        }

    </style>
</head>
<body>
<script src="layui/layui.js" charset="utf-8"></script>
<table align="center" class="layui-table" lay-even lay-skin="line" lay-size="lg">

    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>商品名称</th>
        <th>商品数量</th>
        <th>商品单价</th>
        <th>商品总价</th>
    </tr>
    </thead>
    <tbody>
    <%
        //获取购物车




        Map<Order_Detils,Integer> map= (Map<Order_Detils, Integer>) session.getAttribute("orderlist");
        //判断购物车是否为空
        if(map==null){

            out.print("<tr><td colspan='2'>未进行点单!</td></tr>");
        }else{
            //若不为空,遍历购物车

            double total=0;
            for(Order_Detils name :map.keySet()){
                total=total+name.getFoodPrice()*name.getOrderNum();
                out.print("<tr>");
                out.print("<td>");
                out.print(name.getFoodName());
                out.print("</td>");

                out.print("<td>");
                out.print(map.get(name));
                out.print("</td>");

                out.print("<td>");
                out.print(name.getFoodPrice());
                out.print("</td>");

                out.print("<td>");
                out.print(name.getFoodPrice()*name.getOrderNum());
                out.print("</td>");


            }
            out.print("</tr>");

            out.print("<tr>");

            out.print("<td>");
            out.print("</td>");

            out.print("<td>");
            out.print("</td>");

            out.print("<td>");
            out.print("</td>");

            out.print("<td>");
            out.print(total);
            out.print("</td>");

            out.print("</tr>");


        }

    %>
     </tbody>
</table>


<hr>
<center>
    <button class="layui-btn layui-btn-normal" onclick="sent()">提交订单 </button>
</center>

<script>
    function sent() {
            $.post('getorder',{},function(res){
            },"json");
        alert("提交成功!")
    }
</script>

</body>
</html>

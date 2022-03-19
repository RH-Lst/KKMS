<%--
  Created by IntelliJ IDEA.
  User: RH
  Date: 2021/8/10
  Time: 19:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户信息管理界面</title>
    <link rel="stylesheet" href="layui/css/layui.css"  media="all">


    <style type="text/css">
        .layui-table-cell{
            height:auto!important;
            white-space:normal;
        }

    </style>
</head>
<body>

<script src="layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述 JS 路径需要改成你本地的 -->
<%--显示表格，表格id为data_table--%>
<table class="layui-hide" id="data_table" lay-filter="UserFilter"></table>
<%--编辑菜单--%>
<script type="text/html" id="editBar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<script type="text/javascript">
    layui.use(['table','layer','jquery','form'], function() {
        var table = layui.table;
        var layer = layui.layer;
        var $ = layui.jquery;
        var form = layui.form;
        table.render({
            elem: '#data_table'
            , url: 'selectOrderByLimits'
            , toolbar: "#addBar"
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.message, //解析提示文本
                    "count": res.total, //解析数据长度
                    "data": res.list //解析数据列表
                };
            }
            , cols: [[
                {field: 'oid', title: '订单编号' ,sort: true},
                {field: 'uid', title: '用户编号' ,sort: true},
                {field: 'userName', title: '用户名'},
                {field: 'foodName', title: '菜品名称'},
                {field: 'foodPrice', title: '菜品价格'},
                {field: 'orderNum', title: '点购数'},
                {field:'totalMoney', title:"总价" ,sort: true}
            ]]
            , page: true	//开启分页
            , limits: [5, 10, 15, 20, 25, 30]	//自定义每页显示多少条数据
        });

    });
</script>



</body>
</html>

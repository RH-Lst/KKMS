<%--
  Created by IntelliJ IDEA.
  User: RH
  Date: 2021/8/9
  Time: 19:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购物车测试</title>
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
<table class="layui-hide" id="data_table" lay-filter="FoodFilter"></table>
<%--编辑菜单--%>
<script type="text/html" id="editBar">
    <a class="layui-btn layui-btn-xs" lay-event="order">订购</a>
</script>
<script type="text/javascript">
    layui.use(['table','layer','jquery','form'], function() {
        var table = layui.table;
        var layer = layui.layer;
        var $ = layui.jquery;
        var form = layui.form;
        table.render({
            elem: '#data_table'
            , url: 'selectAllFoodByLimits'
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
                {field: 'foodName', title: '菜品名称'},
                {field: 'foodType', title: '菜品类别'},
                {field: 'foodDescription', title: '菜品描述'},
                {field: 'foodPrice', title: '菜品价格'},
                {field:'foodImgPath', title:"菜品图片" ,templet: '<div><img src="{{ d.foodImgPath }}" style="width:50px; height:50px;"></div>'},
                {fixed: 'right', title: '操作', toolbar: '#editBar'}	//调用script定义得两个按钮
            ]]
            , page: true	//开启分页
            , limits: [5, 10, 15, 20, 25, 30]	//自定义每页显示多少条数据
        });

        table.on('tool(FoodFilter)', function(obj){//obj代表点击的这一行所有内容，包含两个按钮和数据
            var data = obj.data; //选中的哪一行数据
            var fid = data.fid;
            console.log(obj)
            if(obj.event === 'order'){//点击修改按钮

                layer.open({
                    type:1,
                    title:"请确认选择",
                    content: $("#editPanel").html(),//利用jquery选择器获取元素里面的html内容
                    area:['400px','600px'],
                    btn: ['提交', '重置', '取消'],
                    yes: function(index, layero){
                        var formObj = form.val("editFilter");	//这是js对象，无法发送给后台
                        var jsonStr = JSON.stringify(formObj);	//将js对象转换成json格式字符串

                        $.post('orderInCart',{jsonStr:jsonStr,fid:fid},function(res){

                        },"json");

                          layer.close(index);//关闭弹框
                    },btn2: function(index, layero){
                        form.val('editFilter',{//addFilter得值对应得是 form中带有class="layui-form"得元素上 lay-filter="addFilter"
                            foodName:data.foodName,
                            tid:data.tid,
                            foodDescription:data.foodDescription,
                            foodPrice:data.foodPrice,
                            orderNum:1
                        });
                        return false; //不关闭窗口
                    },btn3: function(index, layero){
                    },success: function(index, layero){
                        //打开修改按钮，显示的面板中应该有所有视频分类，并且默认选择当前视频的类别
                        //利用ajax请求数据，将数据动态写入到select标签中
                        $.ajaxSettings.async = false;//设置ajax为同步状态，只有ajax彻底执行结束，再加载其他内容
                        $.post('selectFoodType',{},function(result){
                            if(result.status){
                                var html = '';
                                var list = result.list;
                                for(var i = 0;i<list.length;i++){
                                    html+='<option value="'+list[i].tid+'">'+list[i].foodType+'</option>';
                                }
                                $("select").append(html);
                            }else{
                                layer.msg(result.message);
                            }
                        },"json");
                        form.val('editFilter',{//addFilter得值对应得是 form中带有class="layui-form"得元素上 lay-filter="addFilter"
                            foodName:data.foodName,
                            tid:data.tid,
                            foodDescription:data.foodDescription,
                            foodPrice:data.foodPrice
                        });
                        //当form表单中出现: 单选框、多选框、下拉菜单、文本域等组件时，是不会显示出来的
                        form.render();
                    }
                });


            }

        });


    });
</script>


<script type="text/html" id="editPanel">
    <form class="layui-form" lay-filter="editFilter">


        <div class="layui-form-item">
            <label class="layui-form-label">uid</label>
            <div class="layui-input-inline">
                <input type="text" name="uid"  class="layui-input" readonly="readonly" value="${sessionScope.user.uid}">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-inline">
                <input type="text" name="userName"  class="layui-input" readonly="readonly" value="${sessionScope.user.userName}">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">菜品名称</label>
            <div class="layui-input-inline">
                <input type="text" name="foodName"  class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜品类别</label>
            <div class="layui-input-inline">
                <select name="tid" lay-verify="required" readonly="readonly"></select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜品描述</label>
            <div class="layui-input-inline">
                <input type="text" name="foodDescription"  class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜品价格</label>
            <div class="layui-input-inline">
                <input type="text" name="foodPrice"  class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜品数量</label>
            <div class="layui-input-inline">
                <input type="text" name="orderNum"  class="layui-input" placeholder="请输入订购数量">
            </div>
        </div>
    </form>
</script>
</body>
</html>

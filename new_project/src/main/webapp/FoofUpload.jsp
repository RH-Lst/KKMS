<%--
  Created by IntelliJ IDEA.
  User: RH
  Date: 2021/8/8
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>菜品上传界面</title>
    <link rel="stylesheet" href="layui/css/layui.css"  media="all">
    <style>
        *{margin:0px;padding:0px;}
        form{
            width:80%;
            margin:30px auto;
        }
    </style>
</head>
<body>
    <script src="layui/layui.js" charset="utf-8"></script>
    <form class="layui-form" action="uploadFood"  method="post" enctype="multipart/form-data">
        <div class="layui-form-item">
            <label class="layui-form-label">菜品名称</label>
            <div class="layui-input-block">
                <input type="text" name="foodName" required  lay-verify="required" placeholder="请输入菜品名称" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">菜品描述</label>
            <div class="layui-input-block">
                <input type="text" name="foodDescription" required  lay-verify="required" placeholder="请输入菜品描述" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">价格</label>
            <div class="layui-input-block">
                <input type="text" name="foodPrice" required  lay-verify="required" placeholder="请输入价格" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">类别</label>
            <div class="layui-input-block">
                <select name="tid">
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜品图片</label>
            <div class="layui-input-block">
                <input type="file" name="ImgFile"class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <input class="layui-btn" type="submit" value="上传">
            </div>
        </div>
    </form>


    <script type="text/javascript">
        layui.use(['jquery','form'], function(){
            var $ = layui.jquery;
            var form = layui.form;

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

            form.render();
        });
    </script>

</body>
</html>

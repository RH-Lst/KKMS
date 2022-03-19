<%--
  Created by IntelliJ IDEA.
  User: RH
  Date: 2021/8/8
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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




<form class="layui-form" action="updateUserPerson" method="post" enctype="multipart/form-data" >
    <div class="layui-form-item">
        <label class="layui-form-label">uid</label>
        <div class="layui-input-block">
            <input type="text" name="uid" required  lay-verify="required"  autocomplete="off" class="layui-input" value="${sessionScope.user.uid}" readonly="readonly">
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="userName" required  lay-verify="required"  autocomplete="off" class="layui-input" value="${sessionScope.user.userName}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-block">
            <input type="text" name="userPsd" required  lay-verify="required"  autocomplete="off" class="layui-input" value="${sessionScope.user.userPsd}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">用户头像</label>
        <div class="layui-input-block">
            <input type="file" name="ImgFile"class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <input class="layui-btn" type="submit" value="确认修改" onclick="tologin()">
        </div>
    </div>
</form>


<script type="text/javascript">

    function tologin(){
        alert("修改成功，请重新登录！")

        window.top.location.href="login.jsp";//它表示，从最上层的窗口的地址栏发送请求


    }

    layui.use(['jquery','form'], function(){
        var $ = layui.jquery;
        var form = layui.form;

        form.render();
    });
</script>
</body>
</html>

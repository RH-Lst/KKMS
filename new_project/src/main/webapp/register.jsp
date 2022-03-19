<%--
  Created by IntelliJ IDEA.
  User: RH
  Date: 2021/8/9
  Time: 15:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录界面</title>
    <script src="js/jquery.min.js"></script>

    <link rel="stylesheet" href="css/stylecss.css">
    <link rel="stylesheet" href="layui/css/layui.css"  media="all">
</head>
<body background="images/bg.png">
<script src="layui/layui.js" charset="utf-8"></script>
<div style="position: absolute; top: 50%; left: 50%;transform: translate(-50%,-50%);width:400px;padding: 40px;background: rgba(0,0,0,.8);">
    <h2 style="margin:0 0 30px; padding: 0; color: #fff; text-align: center;">register</h2>

    <div class="layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label" style="color: white">用户名</label>
            <div class="layui-input-block">
                <input type="text" name="userName" required  lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input" style="width: 200px">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="color: white">密码</label>
            <div class="layui-input-inline">
                <input type="password" name="userPsd" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input" style="width: 200px">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label" style="color: white">性别</label>
            <div class="layui-input-block" style="color: white">
                <input type="radio" name="sex" value="男" title="男" checked>
                <input type="radio" name="sex" value="女" title="女">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" onclick="register()">提交</button>
            </div>
        </div>
    </div>

</div>


<script>

    function register(){
        var userName = $("input[name='userName']").val();
        var userPsd = $("input[name='userPsd']").val();
        var sex=$('input[name="sex"]:checked').val();
        $.ajax({
            url:"register",//请求地址，相当于form得action
            type:"post",//请求方式相当于form得method
            data:{//前端要给后台发送的数据
                userName:userName,
                userPsd:userPsd,
                sex:sex,
            },
            dataType:"json", //前后端交互数据的格式
            success:function(result){//result是后台传给前端得数据  result == ResultMap:status、message
                if(result.status == true){
                    alert("注册成功");
                    location.href = "login.jsp";
                }
                else{
                    alert(result.message);
                }
            }
        });
    }


    layui.use(['jquery','form'], function(){
        var $ = layui.jquery;
        var form = layui.form;

        form.render();

    });
</script>

</body>
</html>

<body>

</body>
</html>

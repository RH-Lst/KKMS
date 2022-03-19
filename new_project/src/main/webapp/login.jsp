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
</head>
<body background="images/bg.png">
<div class="box">
    <h2>Login</h2>

    <div class="inputBox">
        <input type="text" name="userName" placeholder="请输入用户名">
        <label>用户名</label>
    </div>
    <div class="inputBox">
        <input type="password" name="userPsd" placeholder="请输入密码">
        <label>密码</label>
    </div>
    <div class="inputBox">
        <input type="text" name="captcha" placeholder="请输入验证码">
        <img src="captcha" style="width:85px" onclick="reloadCaptcha()"/>
        <label>验证码</label>
    </div>

    <button onclick="login()">登陆</button><br>
    <div style="text-align: right;color: white">
        无账号？<a href="register.jsp">立即注册</a>
    </div>
</div>


<script>


    //点击图片重新刷新验证码
    function reloadCaptcha(){
        loadCaptcha();
    }
    //刷新验证码
    function loadCaptcha(){
        path = $("img").attr("src")+"?"+new Date().getTime();
        $("img").attr("src",path);
    }


    function login(){
        var userName = $("input[name='userName']").val();
        var userPsd = $("input[name='userPsd']").val();
        var captcha = $("input[name='captcha']").val();
        $.ajax({
            url:"login",//请求地址，相当于form得action
            type:"post",//请求方式相当于form得method
            data:{//前端要给后台发送的数据
                userName:userName,
                userPsd:userPsd,
                captcha:captcha
            },
            dataType:"json", //前后端交互数据的格式
            success:function(result){//result是后台传给前端得数据  result == ResultMap:status、message
                if(result.status == true && result.authority==0){
                    location.href = "index.jsp";
                }else if (result.status == true && result.authority==1){
                    location.href = "index1.jsp";
                }
                else if (result.status == true && result.authority==2){
                    location.href = "index2.jsp";
                }
                else{
                    loadCaptcha();//如果登陆失败，重新刷新验证码
                    alert(result.message);
                }
            }
        });
    }
</script>

</body>
</html>

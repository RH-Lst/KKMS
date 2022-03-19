<%--
  Created by IntelliJ IDEA.
  User: RH
  Date: 2021/8/8
  Time: 16:07
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

    <script type="text/html" id="addBar">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="add">创建新用户</button>
        </div>
    </script>

    <script type="text/javascript">
        layui.use(['table','layer','jquery','form'], function() {
            var table = layui.table;
            var layer = layui.layer;
            var $ = layui.jquery;
            var form = layui.form;
            table.render({
                elem: '#data_table'
                , url: 'selectAllUserByLimits'
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
                    {field: 'uid', title: 'uid' ,sort: true},
                    {field: 'userName', title: '用户名称'},
                    {field: 'sex', title: '性别'},
                    {field:'imgPath', title:"用户图片" ,templet: '<div><img src="{{ d.imgPath }}" style="width:50px; height:50px;"></div>'},
                    {fixed: 'right', title: '操作', toolbar: '#editBar'}	//调用script定义得两个按钮
                ]]
                , page: true	//开启分页
                , limits: [5, 10, 15, 20, 25, 30]	//自定义每页显示多少条数据
            });

            table.on('tool(UserFilter)', function(obj){//obj代表点击的这一行所有内容，包含两个按钮和数据
                var data = obj.data; //选中的哪一行数据
                var uid = data.uid;
                console.log(obj)
                if(obj.event === 'del'){//点击删除按钮
                    layer.confirm('是否删除该用户', function(index){
                        $.post('deleteUserById',{uid:uid},function(res){
                            if(res.status){
                                layer.close(index);//关闭弹框
                                //刷新表格
                                table.reload('data_table',{});
                            }else{
                                layer.msg(res.message);
                            }
                        },"json");
                    });
                } else if(obj.event === 'edit'){//点击修改按钮

                    layer.open({
                        type:1,
                        title:"编辑用户信息",
                        content: $("#editPanel").html(),//利用jquery选择器获取元素里面的html内容
                        area:['400px','600px'],
                        btn: ['提交', '重置', '取消'],
                        yes: function(index, layero){
                            var formObj = form.val("editFilter");	//这是js对象，无法发送给后台
                            var jsonStr = JSON.stringify(formObj);	//将js对象转换成json格式字符串

                            $.post('updateUserById',{uid:uid,jsonStr:jsonStr},function(res){
                                if(res.status){
                                    layer.close(index);//关闭弹框
                                    //刷新表格
                                    table.reload('data_table',{});
                                }else{
                                    layer.msg(res.message);
                                }
                            },"json");

                        },btn2: function(index, layero){
                            form.val('editFilter',{//addFilter得值对应得是 form中带有class="layui-form"得元素上 lay-filter="addFilter"
                                userName:data.userName,
                                sex:data.sex
                            });
                            return false; //不关闭窗口
                        },btn3: function(index, layero){
                        },success: function(index, layero){
                            //打开修改按钮，显示的面板中应该有所有视频分类，并且默认选择当前视频的类别
                            //利用ajax请求数据，将数据动态写入到select标签中

                            form.val('editFilter',{//addFilter得值对应得是 form中带有class="layui-form"得元素上 lay-filter="addFilter"
                                userName:data.userName,
                                sex:data.sex
                            });
                            //当form表单中出现: 单选框、多选框、下拉菜单、文本域等组件时，是不会显示出来的
                            form.render();
                        }
                    });


                }

            });


            table.on('toolbar(UserFilter)', function(obj){//obj代表点击的这一行所有内容，包含两个按钮和数据
                layer.open({
                    type:1,			//打开的是页面层
                    title:"创建新用户",
                    content: $("#addPanel").html(),//利用jquery选择器获取元素里面的html内容
                    area:['400px','400px'],
                    btn: ['提交', '重置', '取消'],
                    yes: function(index, layero){//提交按钮事件
                        var formObj = form.val("addFilter");	//这是js对象，无法发送给后台
                        var jsonStr = JSON.stringify(formObj);	//将js对象转换成json格式字符串
                        console.log(jsonStr);
                        //按钮【按钮一】的回调
                        $.post('insertUser',{jsonStr:jsonStr},function(res){
                            if(res.status){
                                layer.close(index);//关闭弹框
                                //刷新表格
                                table.reload('data_table',{});
                            }else{
                                layer.msg(res.message);
                            }
                        },"json");


                    },btn2: function(index, layero){//重置按钮事件

                        form.val('addFilter',{//addFilter对应带有class="layui-form"得标签中得lay-filter="addFilter"
                            country:'',
                            date:'',
                            type:''
                        });

                        form.render();
                        return false; //不关闭窗口
                    },btn3: function(index, layero){//取消按钮事件
                    },success: function(index, layero){//打开弹出层加载完内容后立即执行success方法
                        form.render();
                    }
                });

            });

        });
    </script>



    <script type="text/html" id="editPanel">
        <form class="layui-form" lay-filter="editFilter">
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-inline">
                    <input type="text" name="userName" placeholder="请输入用户名" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="radio" name="sex" value="男" title="男">
                    <input type="radio" name="sex" value="女" title="女">
                </div>
            </div>
        </form>
    </script>


    <script type="text/html" id="addPanel">
        <form class="layui-form" lay-filter="addFilter">
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-inline">
                    <input type="text" name="userName" placeholder="请输入用户名" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                    <input type="password" name="userPsd" placeholder="输入密码" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="radio" name="sex" value="男" title="男">
                    <input type="radio" name="sex" value="女" title="女">
                </div>
            </div>
        </form>
    </script>
</body>
</html>

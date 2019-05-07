<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>后台登录</title>
    <meta charset="UTF-8"/>
    <#include "common.ftl" />
    <link href="/static/plugins/admin/css/font.css" rel="stylesheet" />
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />
</head>
<body class="login-bg">
<div class="login layui-anim layui-anim-up">
    <div class="message">管理登录</div>
    <div id="darkbannerwrap"></div>
    <form method="post" class="layui-form" >
        <input name="username" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
        <hr class="hr15">
        <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
        <hr class="hr15">
        <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
        <hr class="hr20" >
    </form>
</div>
<script src="/static/plugins/admin/js/xadmin.js"></script>
<script src="/static/plugins/admin/js/cookie.js"></script>
<script>
    layui.use('form', function(){
        var form = layui.form;
        form.on('submit(login)', function(data){
            var field = data['field'];
            var username = field['username'];
            if (username.length < 6 || username.length > 20) {
                alertMsg("error", 300, "用户名或密码错误！");
                return false;
            }
            var password = field['password'];
            if (password.length < 6 || password.length > 20) {
                alertMsg("error", 300, "用户名或密码错误！");
                return false;
            }
            $.ajax({
                data : field,
                method : "POST",
                url : "/admin/login",
                dataType : "JSON",
                success : function (data) {
                    var code = data['code'];
                    if (code == 0) {
                        window.parent.location.reload();
                        window.location.href = "/admin/index";
                    } else {
                        alertMsg("error", 300, data['message']);
                    }
                }
            })
            return false;
        })
    })
</script>
</body>
</html>
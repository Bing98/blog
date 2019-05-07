<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>用户登录</title>
    <meta charset="UTF-8"/>
    <link href="/static/plugins/layui/css/layui.css" rel="stylesheet" />
    <link href="/static/plugins/jquery/lobibox.min.css" rel="stylesheet" />
    <style>
        .layui-form {
            width: 80%;
            margin: auto;
        }
        .layui-form-item {
            margin-top: 10px;
        }
    </style>
</head>
<body>

<form class="layui-form" method="post">
    <div class="layui-form-item">
        <label class="layui-form-label">用户名：</label>
        <div class="layui-input-block">
            <input type="text" name="username" required  lay-verify="required" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码：</label>
        <div class="layui-input-block">
            <input type="password" name="password" required lay-verify="required" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="login">登录</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script src="/static/plugins/jquery/jquery.js"></script>
<script src="/static/plugins/layui/layui.all.js"></script>
<script src="/static/plugins/jquery/lobibox.min.js"></script>
<script src="/static/js/utils.js"></script>
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
                url : "/login",
                dataType : "JSON",
                success : function (data) {
                    var code = data['code'];
                    if (code == 0) {
                        window.parent.location.reload();
                    } else {
                        alertMsg("error", 300, data['message']);
                    }
                }
            })
            return false;
        });
    });
</script>
</body>
</html>
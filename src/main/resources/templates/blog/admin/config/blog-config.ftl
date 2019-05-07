<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>博客设置</title>
    <meta charset="UTF-8"/>
    <#include "../common.ftl" />
    <link href="/static/css/admin.css" rel="stylesheet"/>
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />
    <link href="/static/plugins/jquery/jquery.contextMenu.css" rel="stylesheet" />
</head>
<style>
    .layui-form-label {
        width: 110px;
    }
</style>
<body>
<div class="x-nav">
    <span>博客设置</span>
</div>
<div class="x-body col-md-12">
    <div class="col-md-6" style="border-right: 1px solid #000">
        个性化设置：
        <div class="layui-form-item">
            <label class="layui-form-label">QQ:</label>
            <div class="layui-input-block">
                <input type="text" id="qq" value="${webSiteConfig['qq']}" placeholder="请输入QQ" class="layui-input" maxlength="10">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">微信:</label>
            <div class="layui-input-block">
                <input type="text" id="wechat" value="${webSiteConfig['wechat']}" placeholder="请输入微信" class="layui-input" maxlength="20">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">微博:</label>
            <div class="layui-input-block">
                <input type="text" id="weibo" value="${webSiteConfig['weibo']}" placeholder="请输入微博" class="layui-input" maxlength="30">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱:</label>
            <div class="layui-input-block">
                <input type="text" id="email" value="${webSiteConfig['email']}" placeholder="请输入邮箱" class="layui-input" maxlength="30">
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">页脚信息:</label>
            <div class="layui-input-block">
                <textarea id="footer" placeholder="页脚信息可使用html" class="layui-textarea">${webSiteConfig['footer']}</textarea>
            </div>
        </div>
        <button class="layui-btn" style="float: right" onclick="saveBase()">保存</button>
    </div>

    <div class="col-md-6">
        SEO设置：
        <div class="layui-form-item">
            <label class="layui-form-label">网站标题:</label>
            <div class="layui-input-block">
                <input type="text" id="title" value="${webSiteConfig['title']}" placeholder="请输入网站标题" class="layui-input" maxlength="30">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">网站描述:</label>
            <div class="layui-input-block">
                <input type="text" id="description" value="${webSiteConfig['description']}" placeholder="请输入网站描述" class="layui-input" maxlength="30">
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">搜索关键字:</label>
            <div class="layui-input-block">
                <textarea id="keyword" placeholder="请输入搜索关键字多个用,号隔开" class="layui-textarea">${webSiteConfig['keyword']}</textarea>
            </div>
        </div>
        <button class="layui-btn" style="float: right" onclick="saveSeo()">保存</button>
        <div class="layui-form-item">
            <label class="layui-form-label">网站图标:</label>
            <div class="layui-input-block">
                <button type="button" class="layui-btn" id="upload-image">
                    <i class="layui-icon">&#xe67c;</i>上传图片
                </button>
            </div>
        </div>

    </div>

</div>
<script src="/static/plugins/jquery/jquery.ui.position.js"></script>
<script src="/static/plugins/jquery/jquery.contextMenu.js"></script>
<script>
    function saveBase() {
        var footer = $("#footer").val();
        if (isEmpty(footer)) {
            alertMsg('error', 300, '页脚信息不能为空！');
            return;
        }
        var qq = $("#qq").val();
        var wechat = $("#wechat").val();
        var weibo = $("#weibo").val();
        var email = $("#email").val();
        $.ajax({
            url: '/admin/config/base',
            method: 'POST',
            data: {'footer' : footer, 'qq' : qq, 'wechat' : wechat,
                    'weibo' : weibo, 'email' : email},
            dataType: 'JSON',
            success: function (data) {
                var code = data['code'];
                if (code != 0) {
                    alertMsg('error', 300, data['message']);
                } else {
                    window.location.reload();
                }
            }
        });
    }

    function saveSeo() {
        var title = $("#title").val();
        if (isEmpty(title)) {
            alertMsg('error', 300, '标题不能为空！');
            return;
        }
        var description = $("#description").val();
        var keyword = $("#keyword").val();

        $.ajax({
            url: '/admin/config/seo',
            method: 'POST',
            data: {'title' : title, 'description' : description, 'keyword' : keyword},
            dataType: 'JSON',
            success: function (data) {
                var code = data['code'];
                if (code != 0) {
                    alertMsg('error', 300, data['message']);
                } else {
                    window.location.reload();
                }
            }
        });
    }

    layui.use('upload', function () {
        var upload = layui.upload;
        //执行实例
        var uploadInst = upload.render({
            elem: '#upload-image',
            url: '/admin/config/upload',
            accept: 'images',
            number: 1,
            size: 2048,
            done: function(res){
                var code = res['code'];
                if (code == 0) {
                    alertMsg("success", 300, "上传成功！");
                } else {
                    alertMsg("error", 300, "上传失败！");
                }
            }
            ,error: function(){
                alertMsg("error", 300, "上传失败！");
            }
        });
    });
</script>
</body>
</html>
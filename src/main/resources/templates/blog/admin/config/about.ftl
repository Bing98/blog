<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>关于我</title>
    <meta charset="UTF-8"/>
    <#include "../common.ftl" />
    <link href="/static/plugins/simplemde/simplemde.min.css" rel="stylesheet"/>
    <link href="/static/css/admin.css" rel="stylesheet"/>
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />
    <link href="/static/plugins/jquery/jquery.contextMenu.css" rel="stylesheet" />
    <style>
        .editor-toolbar {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="x-nav">
    <span>关于我</span>
</div>
<div class="x-body col-md-12">
    <textarea id="content"></textarea>
    <div style="float: right; margin-top: 10px">
        <button class="layui-btn" onclick="putAbout()">保存</button>
    </div>
</div>
</div>
<script src="/static/plugins/jquery/jquery.ui.position.js"></script>
<script src="/static/plugins/jquery/jquery.contextMenu.js"></script>
<script src="/static/plugins/simplemde/simplemde.min.js"></script>
<script src="/static/js/post.js"></script>
<script>
    $(function () {
        <#if aboutPost??>
            simplemde.value("${aboutPost['markDownContent']}");
        </#if>
    })

    function putAbout() {
        var markDown = simplemde.value();
        if (isEmpty(markDown)) {
            alertMsg("error", 300, "内容不能为空！");
            return;
        }
        var content = simplemde.markdown(markDown);
        $.ajax({
            url: "/admin/config/about",
            method: "POST",
            dataType: "JSON",
            data: {
                "content": content, "markDownContent": markDown
            },
            success: function (data) {
                var code = data['code'];
                if (code == 0) {
                    alertMsg("success", 300, "保存成功！");
                } else {
                    alertMsg("error", 300, data['message']);
                }

            }
        })
    }
</script>
</body>
</html>
    <!DOCTYPE html>
<html>
<head>
    <title>Links</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <#include "common.ftl" />
</head>
<body>
<style>
    #show-links {
        margin-top: 30px;
        padding: 30px;
    }

    .layui-form {
        border-top: 1px solid #000000;
    }

    #form-link {
        padding: 30px;
    }

    .layui-form-label {
        width: 86px;
    }

    #show-links span {
        border: 1px solid #ddd;
        padding: 10px;
        background-color: #FFFFFF;
    }
</style>
<#include "common/nav.ftl" />
<div class="content-body">
    <div class="container">
        <div class="row">
            <#include "common/live2d.ftl" />
            <main class="col-md-6">
                <h1 class="page-title">友情链接</h1>
                <div id="show-links">
                    <#list result as link>
                        <span><a href="${link['url']}" target="_blank" title="${link['description']}">${link['name']}</a></span>
                    </#list>
                </div>

                <form class="layui-form" id="form-link">
                    <div class="layui-form-item">
                        <label class="layui-form-label">网站名称</label>
                        <div class="layui-input-block">
                            <input type="text" name="name" required  lay-verify="required" placeholder="请输入网站名称" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">网站链接</label>
                        <div class="layui-input-block">
                            <input type="text" name="url" required  lay-verify="required" placeholder="请输入网站链接带上：http或https" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">网站描述</label>
                        <div class="layui-input-block">
                            <input type="text" name="description" placeholder="请输入网站描述" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">联系方式</label>
                        <div class="layui-input-block">
                            <input type="text" name="contact" placeholder="方便互相告知（最好提供邮箱）" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit="" lay-filter="put" style="background-color: #333333; float: right;">申请友链
                            </button>
                        </div>
                    </div>
                </form>
            </main>

            <#include "common/aside.ftl" />
        </div>
    </div>
</div>

<#include "common/footer.ftl" />

</body>
<script>
    layui.use('form', function () {
        var form = layui.form;
        form.on('submit(put)', function (data) {
            var field = data['field'];
            var name = field['name'];
            if (isEmpty(name)) {
                alert('请输入正确网站名称！');
                return false;
            }
            var url = field['url'];
            var urlReg = new RegExp('[a-zA-z]+://[^\\s]*');
            if (isEmpty(url) || !urlReg.test(url)) {
                alert('请输入正确网站链接！');
                return false;
            }
            $.ajax({
                url: '/link',
                method: 'POST',
                data: field,
                dataType: 'JSON',
                success: function (data) {
                    var code = data['code'];
                    if (code != 0) {
                        var msg = data['message'];
                        alert(msg);
                    } else {
                        alert('提交成功，等待审核！');
                        window.location.reload();
                    }
                }
            });

            return false;
        });
    });
</script>
</html>
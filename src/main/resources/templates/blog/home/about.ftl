<!DOCTYPE html>
<html>
<head>
    <title>About</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <#include "common.ftl" />
</head>
<style>
    #show-comment {
        margin-top: 30px;
        padding: 30px;
    }
    .head {
        color: #2B2B2B;
        font-weight: 500;
        font-size: 18px;
    }
    .show-commeont-content {
        border-bottom: 1px dashed #d3d3d3;
        padding-top: 25px;
    }
    .comment-content {
        margin: 1em;
        font-size: 0.9em;
    }

    .comment-content p {
        font-weight: 300;
        font-size: 15px;
    }
</style>
<body>

<#include "common/nav.ftl" />

<div class="content-body">
    <div class="container">
        <div class="row">
            <#include "common/live2d.ftl" />
            <main class="col-md-6">
                <h1 class="page-title">关于我</h1>
                <article class="post">
                    <div class="entry-content clearfix">
                        ${aboutPost['content']!"很懒！什么都没有写！"}
                    </div>
                </article>

                <div id="show-comment">
                    <h3>留言（共${aboutPost['commentCount']!"0"}条）：</h3>
                    <hr class="layui-bg-black">
                    <#if result??>
                        <#list result['list'] as comment>
                            <div class="show-commeont-content">
                                <span class="head" id="${comment['id']}"><a <#if comment['url'] != ''>href="${comment['url']}" target="_blank"</#if>>${comment['name']} 留言：</a></span>
                                <span style="float: right">
                                    <i class="icon ion-ios-world-outline"></i> ${comment['agent']}
                                    &nbsp;&nbsp;
                                    <i class="icon ion-ios-calendar-outline"></i> ${comment['createTime']?string('yyyy-MM-dd HH:mm')}
                                </span>
                                <div class="comment-content">
                                    <p>${comment['content']}</p>
                                </div>
                                <div style="margin-left: 95%; margin-bottom: 20px;">
                                    <a href="#comment" onclick="reply(${comment['id']}, '${comment['name']}')">回复</a>
                                </div>
                            </div>
                        </#list>
                    </#if>
                    <div id="page" style="text-align: center; margin-top: 30px;"></div>
                </div>

                <div id="comment" style="padding: 30px;">
                    <hr class="layui-bg-black">
                    <form class="layui-form">
                        <input name="pid" value="-1" hidden />
                        <input name="postId" value="${aboutPost['id']!}" hidden />
                        <input name="postTitle" value="${aboutPost['title']!}" hidden />
                        <div class="layui-form-item layui-form-text">
                            <label class="layui-form-label">留言板*</label>
                            <div class="layui-input-block">
                                <textarea placeholder="请输入内容" class="layui-textarea" style="resize: none;" rows="10"
                                          cols="50" name="content" required></textarea>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">名称*</label>
                            <div class="layui-input-block">
                                <input type="text" maxlength="16" name="name" autocomplete="off" placeholder="请输入名称"
                                       class="layui-input" required>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱*</label>
                            <div class="layui-input-block">
                                <input type="text" maxlength="320" name="email" autocomplete="off" placeholder="请输入邮箱"
                                       class="layui-input" required>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">URL</label>
                            <div class="layui-input-block">
                                <input type="text" maxlength="70" name="url" autocomplete="off" placeholder="请输入个人网站"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <#if aboutPost['id']??>
                                    <button class="layui-btn" lay-submit="" lay-filter="put"
                                            style="background-color: #333333; float: right;">提交
                                    </button>
                                </#if>
                            </div>
                        </div>
                    </form>
                </div>
            </main>

            <#include "common/aside.ftl" />
        </div>
    </div>
</div>

<#include "common/footer.ftl" />

<script>
    layui.use('laypage', function(){
        var laypage = layui.laypage;
        laypage.render({
            elem: 'page',
            limit: 10,
            count: ${result['total']},
            curr: ${result['pageNum']},
            theme: '#000000',
            prev: '<em>←</em>',
            next: '<em>→</em>',
            jump: function(obj, first){
                var page = obj.curr;
                var size = obj.limit;
                //首次不执行
                if(!first){
                    window.location.href = "/about?page=" + page + "&size=" + size;
                }
            }
        });
    });

    layui.use('form', function () {
        var form = layui.form;
        form.on('submit(put)', function (data) {
            var field = data['field'];
            var content = field['content'];
            if (isEmpty(content)) {
                return false;
            }
            var name = field['name'];
            if (isEmpty(name)) {
                return false;
            }
            var email = field['email'];
            if (isEmpty(email)) {
                return false;
            }
            var emailReg = new RegExp('[\\w!#$%&\'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&\'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?');
            if (!emailReg.test(email)) {
                alert('请输入正确邮箱！');
                return false;
            }
            var url = field['url'];
            var urlReg = new RegExp('[a-zA-z]+://[^\\s]*');
            if (!isEmpty(url) && !urlReg.test(url)) {
                alert('请输入正确URL！');
                return false;
            }
            var pid = field['pid'];
            var userAgent = getUserAgent();
            var postId = field['postId'];
            var postTitle = field['postTitle'];
            $.ajax({
                url: '/comment',
                method: 'POST',
                data: {
                    'content': content, 'name': name, 'email': email, 'postId': postId,
                    'agent': userAgent, 'url': url, 'pid' : pid, 'postTitle' : postTitle
                },
                dataType: 'JSON',
                success: function (data) {
                    var code = data['code'];
                    if (code != 0) {
                        var msg = data['message'];
                        alert(msg)
                    } else {
                        alert('留言成功！审核通过后显示！');
                        window.location.reload();
                    }
                }
            })
            return false;
        });
    });

    function getUserAgent() {
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
        var isOpera = userAgent.indexOf("Opera") > -1;
        if (isOpera) {
            return "Opera"
        }
        ; //判断是否Opera浏览器
        if (userAgent.indexOf("Firefox") > -1) {
            return "Firefox";
        } //判断是否Firefox浏览器
        if (userAgent.indexOf("Chrome") > -1) {
            return "Chrome";
        }
        if (userAgent.indexOf("Safari") > -1) {
            return "Safari";
        } //判断是否Safari浏览器
        if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
            return "IE";
        }
        ; //判断是否IE浏览器
        return "other";
    }

    function reply(id, name) {
        $("textarea").val('@' + name + ' ');
        $("input[name=pid]").val(id);
    }

</script>
</body>
</html>
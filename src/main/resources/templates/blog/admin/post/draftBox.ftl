<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>草稿箱</title>
    <meta charset="UTF-8"/>
    <#include "../common.ftl" />
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />
</head>
<body>
<div class="x-nav">
    <span>草稿箱</span>
</div>
<div class="x-body">
    <div>
        <button class="layui-btn layui-btn-danger" id="deleteAll"><i class="layui-icon"></i>删除</button>
        <button class="layui-btn" id="updateStatus" status="1"><i class="layui-icon layui-icon-release"></i>发布</button>
        <span class="x-right" style="line-height:40px">共有：${result['total']} 篇文章</span>
    </div>
    <table class="layui-table x-admin">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th>标题</th>
            <th>作者</th>
            <th>浏览</th>
            <th>评论</th>
            <th>喜欢</th>
            <th>创建时间</th>
            <th>修改时间</th>
            <th>操作</th></tr>
        </thead>
        <tbody>
        <#list result['list'] as post>
            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id="${post['id']}"><i class="layui-icon"></i></div>
                </td>
                <td>${post['title']}</td>
                <td>${post['author']}</td>
                <td>${post['viewCount']}</td>
                <td>${post['commentCount']}</td>
                <td>${post['likeCount']}</td>
                <td>${post['createTime']?string('yyyy.MM.dd HH:mm')}</td>
                <td>${post['updateTime']?string('yyyy.MM.dd HH:mm')}</td>
                <td class="td-manage">
                    <a title="编辑" href="/admin/post/writer?id=${post['id']}">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <a title="删除" href="#" onclick="delPost(${post['id']})">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </#list>
        </tbody>
    </table>
    <div id="page" style="text-align: center;"></div>
</div>
<script src="/static/js/post.draft.js"></script>
<script>
    layui.use('laypage', function(){
        var laypage = layui.laypage;
        laypage.render({
            elem: 'page',
            limit: 10,
            count: ${result['total']},
            curr: ${result['pageNum']},
            jump: function(obj, first){
                var page = obj.curr;
                var size = obj.limit;
                //首次不执行
                if(!first){
                    window.location.href = "/admin/post/draftBox?page=" + page + "&size=" + size;
                }
            }
        });
    });
</script>
</body>
</html>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>轮播图管理</title>
    <meta charset="UTF-8"/>
    <#include "../common.ftl" />
    <link href="/static/css/admin.css" rel="stylesheet"/>
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />
    <link href="/static/plugins/jquery/jquery.contextMenu.css" rel="stylesheet" />
</head>
<style>
</style>
<body>
<div class="x-nav">
    <span>轮播图管理</span>
</div>
<div class="x-body col-md-12">
    <button class="layui-btn" id="add"><i class="layui-icon layui-icon-add-1"></i>添加</button>
    <table class="layui-table x-admin">
        <thead>
        <tr>
            <th>轮播图片</th>
            <th>文章</th>
            <th>排序</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <#list bannerList as banner>
            <tr>
                <td>
                    <img style="max-width: 300px; max-height: 300px;" src="${banner['imagePath']}" />
                </td>
                <td>
                    ${banner['postTitle']}
                </td>
                <td>
                    ${banner['sort']}
                </td>
                <td>
                    <a title="编辑" href="#" onclick="editImage(${banner['id']})">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <a title="删除" href="#" onclick="deleteBanner(${banner['id']})">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </#list>
        </tbody>
    </table>
</div>
<script>
    function editImage(id) {
        layer.open({
            type: 2,
            title: '添加轮播图',
            area: ['55%', '90%'],
            content: '/admin/image/addBanner?id=' + id
        })
    }

    $("#add").click(function () {
        layer.open({
            type: 2,
            title: '添加轮播图',
            area: ['55%', '90%'],
            content: '/admin/image/addBanner'
        })
    })

    function deleteBanner(id) {
        Lobibox.confirm({
            msg: '确定删除吗？',
            title: '提示',
            iconClass: false,
            callback: function($this, type, ev) {
                if (type == 'yes') {
                    $.ajax({
                        url: "/admin/image/deleteBanner?id=" + id,
                        method: "GET",
                        dataType : "JSON",
                        success: function (data) {
                            responseMsg(data);
                        }
                    })
                }
            }
        });
    }
</script>
</body>
</html>
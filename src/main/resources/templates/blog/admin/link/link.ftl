<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>友链管理</title>
    <meta charset="UTF-8"/>
    <#include "../common.ftl" />
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />
    <style>
        #show label {
            line-height: 35px;
            height: 35px;
            font-size: 12px;
            margin: 0px 10px 10px 0px;
            padding: 0px 5px 0px 5px;
            cursor: pointer;
            border: 1px solid #ebebeb;
            background-color: #FFFFFF;
        }
        #show input {
            opacity: 0;
        }
        .red {
            color: red;
            border: 1px solid red !important;
        }
    </style>
</head>
<body>
<div class="x-nav">
    <span>友链管理</span>
</div>
<div class="x-body">
    <button class="layui-btn layui-btn-danger" onclick="deleteLink('')"><i class="layui-icon"></i>删除</button>
    <button class="layui-btn" onclick="updateStatus('')"><i class="layui-icon layui-icon-release"></i>审核</button>
    <div id="show" style="display: inline-block">
        <label id="seleCheck1"><input type="radio" name="seleCheck" value="1"><span style="margin-right: 10px;">显示未审核</span></label>
        <label id="seleCheck2"><input type="radio" name="seleCheck" value="2"><span style="margin-right: 10px;">显示已审核</span></label>
        <label id="seleCheck3"><input type="radio" name="seleCheck" value="3"><span style="margin-right: 10px;">显示全部</span></label>
    </div>

    <table class="layui-table x-admin">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th>网站名称</th>
            <th>网站链接</th>
            <th>网站描述</th>
            <th>联系方式</th>
            <th>状态</th>
            <th>申请时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <#list linkList as link>
            <tr>
                <td>
                    <#if link['status'] == 1>
                        <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id="${link['id']}"><i class="layui-icon"></i></div>
                    </#if>
                </td>
                <td>${link['name']}</td>
                <td>${link['url']}</td>
                <td>${link['description']!""}</td>
                <td>${link['contact']!""}</td>
                <td>
                    <#if link['status'] == 1>
                        未审核
                    <#else >
                        已审核
                    </#if>
                </td>
                <td>${link['createTime']?string('yyyy-MM-dd HH:mm:ss')}</td>
                <td>
                    <#if link['status'] == 1>
                        <a title="审核" href="#" onclick="updateStatus(${link['id']})">
                            <i class="layui-icon">&#xe609;</i>
                        </a>
                    </#if>
                    <a title="删除" href="#" onclick="deleteLink(${link['id']})">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </#list>
        </tbody>
    </table>
</div>
<script src="/static/js/post.draft.js"></script>
<script>
    $(function () {
        var showType = ${Request['showType']};
        $("#seleCheck" + showType).addClass('red');
        $("input[value=" + showType + "]").attr("checked", "");
    })

    $("input[name=seleCheck]").click(function () {
        var showType = $("input[name='seleCheck']:checked").val();
        window.location.href = "/admin/link?showType=" + showType;
    })

    function updateStatus(ids) {
        if (ids == "" || ids.length < 1) {
            ids = tableCheck.getData();
        }
        if (ids == "" || ids.length < 1) {
            alertMsg('error', 300, '请选择友链！');
            return;
        }

        $.ajax({
            url: "/admin/link/updateStatus?ids=" + ids,
            method: "GET",
            dataType: "JSON",
            success: function (data) {
                responseMsg(data);
            }
        })

    }

    function deleteLink(ids) {
        if (ids == "" || ids.length < 1) {
            ids = tableCheck.getData();
        }
        if (ids == "" || ids.length < 1) {
            alertMsg('error', 300, '请选择友链！');
            return;
        }

        Lobibox.confirm({
            msg: '确定删除吗？',
            title: '提示',
            iconClass: false,
            callback: function($this, type, ev) {
                if (type == 'yes') {
                    $.ajax({
                        url: "/admin/link/delete?ids=" + ids,
                        method: "GET",
                        dataType: "JSON",
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

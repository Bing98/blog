<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>评论管理</title>
    <meta charset="UTF-8"/>
    <#include "../common.ftl" />
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />
    <style>
        .layui-btn a {
            text-decoration: none;
            color: #FFFFFF;
        }
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
    <span>评论管理</span>
</div>
<div class="x-body">
    <div>
        <div style="display: inline-block; width: 200px;">
            <select id="selectPost" style="height: 40px;">
                <option value="-1"></option>
                <#list postList as post>
                    <option value="${post['id']}" <#if post['id'] == Request['postId']!-1>selected</#if>>${post['title']}</option>
                </#list>
            </select>
        </div>
        <button class="layui-btn layui-btn-danger" onclick="deleteComment('');"><i class="layui-icon"></i>删除</button>
        <button class="layui-btn" onclick="updateStatusComment('')"><i class="layui-icon layui-icon-release"></i>审核</button>

        <div id="show" style="display: inline-block">
            <label id="seleCheck1"><input type="radio" name="seleCheck" value="1"><span style="margin-right: 10px;">显示已审核</span></label>
            <label id="seleCheck2"><input type="radio" name="seleCheck" value="2"><span style="margin-right: 10px;">显示未审核</span></label>
            <label id="seleCheck3"><input type="radio" name="seleCheck" value="3"><span style="margin-right: 10px;">显示全部</span></label>
        </div>
        <span class="x-right" style="line-height:40px">共有：${result['total']}条留言</span>

        <table class="layui-table x-admin">
            <thead>
                <tr>
                    <th>
                        <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
                    </th>
                    <th>名称</th>
                    <th>邮箱</th>
                    <th>个人网站</th>
                    <th>内容</th>
                    <th>所属文章</th>
                    <th>IP</th>
                    <th>客户端</th>
                    <th>状态</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
            <#list result['list']! as c>
                <tr>
                    <td>
                        <#if c['status'] == 2>
                            <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id="${c['id']}"><i class="layui-icon"></i></div>
                        </#if>
                    </td>
                    <td>
                        ${c['name']}
                    </td>
                    <td>
                        ${c['email']}
                    </td>
                    <td>
                        ${c['url']}
                    </td>
                    <td width="30%">
                        ${c['content']}
                    </td>
                    <td>
                        ${c['postTitle']}
                    </td>
                    <td>
                        ${c['ip']}
                    </td>
                    <td>
                        ${c['agent']}
                    </td>
                    <td>
                        <#if c['status'] == 1>
                            已审核
                        <#else>
                            未审核
                        </#if>
                    </td>
                    <td>
                        ${c['createTime']?string('yyyy-MM-dd HH:mm:ss')}
                    </td>
                    <td>
                    <#if c['status'] == 2>
                        <a title="审核" href="#" onclick="updateStatusComment(${c['id']})">
                            <i class="layui-icon">&#xe609;</i>
                        </a>
                    </#if>
                        <a title="删除" href="#" onclick="deleteComment(${c['id']})">
                            <i class="layui-icon">&#xe640;</i>
                        </a>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
        <div id="page" style="text-align: center;"></div>
    </div>
</div>
<script src="/static/js/post.draft.js"></script>
<script>
    $(function () {
        var showType = ${Request['showType']};
        $("#seleCheck" + showType).addClass('red');
        $("input[value=" + showType + "]").attr("checked", "");
    })

    function deleteComment(id) {
        if (id == "" || id.length < 1) {
            id = tableCheck.getData();
        }
        if (id == "" || id.length < 1) {
            alertMsg('error', 300, '请选择留言！');
            return;
        }
        Lobibox.confirm({
            msg: '确定删除吗？',
            title: '提示',
            iconClass: false,
            callback: function($this, type, ev) {
                if (type == 'yes') {
                    $.ajax({
                        url: "/admin/comment/delete?ids=" + id,
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

    function updateStatusComment(id) {
        if (id == "" || id.length < 1) {
            id = tableCheck.getData();
        }
        if (id == "" || id.length < 1) {
            alertMsg('error', 300, '请选择留言！');
            return;
        }
        $.ajax({
            url: "/admin/comment/updateStatus?ids=" + id,
            method: "GET",
            dataType: "JSON",
            success: function (data) {
                responseMsg(data);
            }
        })
    }

    $("input[name=seleCheck]").click(function () {
        var postId = $("#selectPost").val();
        var showType = $("input[name='seleCheck']:checked").val();
        window.location.href = "/admin/comment?id=" + postId + "&showType=" + showType;
    })
    
    $("#selectPost").change(function () {
        var postId = $("#selectPost").val();
        var showType = $("input[name='seleCheck']:checked").val();
        window.location.href = "/admin/comment?id=" + postId + "&showType=" + showType;
    })

    layui.use('laypage', function(){
        var laypage = layui.laypage;
        laypage.render({
            elem: 'page',
            limit: 10,
            count: ${result['total']},
            curr: ${result['pageNum']},
            jump: function(obj, first){
                var postId = $("#selectPost").val();
                var showType = $("input[name='seleCheck']:checked").val();
                var page = obj.curr;
                var size = obj.limit;
                //首次不执行
                if(!first){
                    window.location.href = "/admin/comment?page=" + page + "&size=" + size + "&id=" + postId + "&showType=" + showType;
                }
            }
        });
    });
</script>
</body>
</html>

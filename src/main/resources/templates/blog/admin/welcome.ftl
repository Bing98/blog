<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>welcome</title>
    <meta charset="UTF-8"/>
    <#include "common.ftl" />
    <link href="/static/plugins/admin/css/font.css" rel="stylesheet" />
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />
</head>
<body>

<div class="x-body">
    <blockquote class="layui-elem-quote">欢迎管理员：
        <span class="x-red">${Session['superName']}</span>！当前时间：<span id="time"></span>
    </blockquote>
    <fieldset class="layui-elem-field">
        <legend>数据统计</legend>
        <div class="layui-field-box">
            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-body">
                        <div class="layui-carousel x-admin-carousel x-admin-backlog" lay-anim="" lay-indicator="inside" lay-arrow="none" style="width: 100%; height: 90px;">
                            <div carousel-item="">
                                <ul class="layui-row layui-col-space10 layui-this">
                                    <li class="layui-col-xs2">
                                        <a href="/admin/post" class="x-admin-backlog-body">
                                            <h3>文章数</h3>
                                            <p>
                                                <cite>${postCount}</cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="/admin/comment" class="x-admin-backlog-body">
                                            <h3>评论数</h3>
                                            <p>
                                                <cite>${comentCount}</cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="/admin/category" class="x-admin-backlog-body">
                                            <h3>分类数</h3>
                                            <p>
                                                <cite>${categoryCount}</cite></p>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs2">
                                        <a href="/admin/tag" class="x-admin-backlog-body">
                                            <h3>标签数</h3>
                                            <p>
                                                <cite>${tagCount}</cite></p>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </fieldset>

    <fieldset class="layui-elem-field">
        <legend>系统日志</legend>
        <div class="layui-field-box">
            <table class="layui-table">
                <tbody>
                    <tr>
                        <th>操作内容</th>
                        <th>操作时间</th>
                        <th>ip地址</th>
                    </tr>
                    <#list result['list'] as log>
                        <tr>
                            <td>${log['content']}</td>
                            <td>${log['createTime']?string('yyyy.MM.dd HH:mm')}</td>
                            <td>${log['ip']}</td>
                        </tr>
                    </#list>
                </tbody>
            </table>
            <div id="page" style="text-align: center;"></div>
        </div>
    </fieldset>

    <fieldset class="layui-elem-field">
        <legend>系统信息</legend>
        <div class="layui-field-box">
            <table class="layui-table">
                <tbody>
                <tr>
                    <th>服务器地址</th>
                    <td>${systemInfo['ip']}</td>
                </tr>
                <tr>
                    <th>操作系统</th>
                    <td>${systemInfo['os']}</td>
                </tr>
                <tr>
                    <th>工作目录</th>
                    <td>${systemInfo['userDir']}</td>
                </tr>
                <tr>
                    <th>Java版本</th>
                    <td>${systemInfo['version']}</td>
                </tr>
                <tr>
                    <th>线程总数量</th>
                    <td>${systemInfo['threadNum']}</td>
                </tr>
                <tr>
                    <th>JVM总内存空间</th>
                    <td>${systemInfo['vmTotal']}</td>
                </tr>
                <tr>
                    <th>JVM已使用内存空间</th>
                    <td>${systemInfo['vmUse']}</td>
                </tr>
                <tr>
                    <th>Java安装目录</th>
                    <td>${systemInfo['javaHome']}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
</div>

<script src="/static/plugins/admin/js/xadmin.js"></script>
<script src="/static/plugins/admin/js/cookie.js"></script>
<script>
    var time = getNowTime();
    $("#time").text(time);

    setInterval(function () {
        var time = getNowTime();
        $("#time").text(time);
    }, 1000);

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
                    window.location.href = "/admin/welcome?page=" + page + "&size=" + size;
                }
            }
        });
    });

</script>
</body>
</html>
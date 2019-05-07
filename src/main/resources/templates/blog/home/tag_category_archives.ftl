<!DOCTYPE html>
<html>
<head>
    <title>${type}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <#include "common.ftl" />
</head>
<body>

<#include "common/nav.ftl" />

<div class="content-body">
    <div class="container">
        <div class="row">
            <#include "common/live2d.ftl" />
            <main class="col-md-6">
                <ul class="layui-timeline">
                    <li class="layui-timeline-item">
                        <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
                        <div class="layui-timeline-content layui-text">
                            <h3 class="layui-timeline-title">${Request.name!""}</h3>
                            <br>
                            <#list result as post>
                                <p>
                                    <a href="/detail?id=${post['id']}" style="text-decoration: none; color: #333;">${post['title']}</a>
                                </p>
                                <br>
                            </#list>
                        </div>
                    </li>
                </ul>
            </main>

            <#include "common/aside.ftl" />
        </div>
    </div>
</div>

<#include "common/footer.ftl" />

</body>
</html>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>文章发布</title>
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
    <span><#if post??>文章编辑<#else >文章发布</#if></span>
</div>
<div class="x-body col-md-9">
    <div>
        <input type="text" class="layui-input" placeholder="请输入文章标题" id="title" maxlength="20"/>
    </div>
    <textarea id="content"><#if post??>${post['markDownContent']}</#if></textarea>
    <div style="float: right; margin-top: 10px">
        <#if post??>
            <button class="layui-btn" onclick="update(${post['id']}, 1)">保存</button>
            <button class="layui-btn layui-btn-primary" onclick="update(${post['id']}, 2)">保存草稿</button>
            <#else >
                <button class="layui-btn" onclick="put(1)">发布</button>
                <button class="layui-btn layui-btn-primary" onclick="put(2)">保存草稿</button>
        </#if>
    </div>
</div>
<div class="x-body col-md-3">
    <xblock class="box" style="height: 50%">
        <h3 class="box-title">分类</h3>
        <hr class="layui-bg-black">
        <div id="category">
            <#list categoryList as category>
                <a class="category edit
                <#if post?? && post['categoryes']?? && post['categoryes']?seq_contains(category)>
                    check
                </#if>"
                      id="${category['id']}" type="category" title="${category['description']}" onclick="choose(this)">${category['name']}</a>
            </#list>
        </div>
        <hr class="layui-bg-black">
        <div class="add">
            <form class="box-footer layui-form">
                <input type="text" name="name" class="layui-input" required placeholder="请输入分类" />
                <input type="text" name="description" class="layui-input" placeholder="请输入描述" />
                <button style="float: right" class="layui-btn layui-btn-sm" lay-filter="category" lay-submit>保存</button>
            </form>
        </div>
    </xblock>
    <xblock class="box">
        <h3 class="box-title">标签</h3>
        <hr class="layui-bg-black">
        <div id="tag">
            <#list tagList as tag>
                <a class="tag edit
                <#if post?? && post['tags']?? && post['tags']?seq_contains(tag)>
                    check
                </#if>"
                      id="${tag['id']}" type="tag" title="${tag['description']}" onclick="choose(this)">${tag['name']}</a>
            </#list>
        </div>
        <hr class="layui-bg-black">
        <div class="add">
            <form class="box-footer layui-form">
                <input type="text" name="name" class="layui-input" required placeholder="请输入标签" />
                <input type="text" name="description" class="layui-input" placeholder="请输入描述" />
                <button style="float: right" class="layui-btn layui-btn-sm" lay-filter="tag" lay-submit>保存</button>
            </form>
        </div>
    </xblock>
</div>
<script src="/static/plugins/jquery/jquery.ui.position.js"></script>
<script src="/static/plugins/jquery/jquery.contextMenu.js"></script>
<script src="/static/plugins/simplemde/simplemde.min.js"></script>
<script src="/static/js/post.js"></script>
<script src="/static/js/post.common.js"></script>
<script src="/static/js/tag.category.js"></script>
<script>
    <#if post??>
            window.localStorage.setItem("title", "${post['title']}");
    </#if>
</script>
</body>
</html>
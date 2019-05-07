<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>标签管理</title>
    <meta charset="UTF-8"/>
    <#include "../common.ftl" />
    <link href="/static/plugins/simplemde/simplemde.min.css" rel="stylesheet"/>
    <link href="/static/css/admin.css" rel="stylesheet"/>
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />
    <link href="/static/plugins/jquery/jquery.contextMenu.css" rel="stylesheet" />
</head>
<body>
<div class="x-nav">
    <span>标签管理</span>
</div>
<div class="x-body col-md-5">
    <xblock class="box">
        <h3 class="box-title"><#if tag??>修改标签<#else>添加标签</#if></h3>
        <hr class="layui-bg-black">
        <div class="add">
            <form class="layui-form">
                <div class="layui-form-item">
                    <label class="layui-form-label">标签*</label>
                    <div class="layui-input-block">
                        <input type="text" name="name" data-container="body" placeholder="请输入标签" autocomplete="off" value="<#if tag??>${tag['name']}</#if>" required class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">描述</label>
                    <div class="layui-input-block">
                        <input type="text" name="description" placeholder="请输入描述" autocomplete="off" value="<#if tag??>${tag['description']}</#if>" class="layui-input">
                    </div>
                    <#if tag??>
                        <input type="hidden" name="id" value="${tag['id']}" />
                    </#if>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="1" class="layui-btn" lay-submit lay-filter="tag" style="float: right;"><#if tag??>修改<#else>添加</#if></button>
                    </div>
                </div>
            </form>
        </div>
    </xblock>
</div>
<div class="x-body col-md-7">
    <xblock class="box">
        <h3 class="box-title">所有标签</h3>
        <hr class="layui-bg-black">
        <#list list as tag>
            <a class="tag edit" href="#" type="tag" id="${tag['id']}" title="${tag['description']}">${tag['name']}(${tag['postNumber']})</a>
        </#list>
    </xblock>
</div>
<script src="/static/plugins/jquery/jquery.ui.position.js"></script>
<script src="/static/plugins/jquery/jquery.contextMenu.js"></script>
<script src="/static/js/tag.category.js"></script>
<script src="/static/js/post.common.js"></script>
</body>
</html>
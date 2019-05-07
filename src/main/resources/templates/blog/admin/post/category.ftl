<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>分类管理</title>
    <meta charset="UTF-8"/>
    <#include "../common.ftl" />
    <link href="/static/plugins/simplemde/simplemde.min.css" rel="stylesheet"/>
    <link href="/static/css/admin.css" rel="stylesheet"/>
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />
    <link href="/static/plugins/jquery/jquery.contextMenu.css" rel="stylesheet" />
</head>
<body>
<div class="x-nav">
    <span>分类管理</span>
</div>
<div class="x-body col-md-5">
    <xblock class="box">
        <h3 class="box-title"><#if category??>修改分类<#else>添加分类</#if></h3>
        <hr class="layui-bg-black">
        <div class="add">
            <form class="layui-form">
                <div class="layui-form-item">
                    <label class="layui-form-label">分类*</label>
                    <div class="layui-input-block">
                        <input type="text" name="name" placeholder="请输入分类" value="<#if category??>${category['name']}</#if>" autocomplete="off" required class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">描述</label>
                    <div class="layui-input-block">
                        <input type="text" name="description" placeholder="请输入描述" value="<#if category??>${category['description']}</#if>" autocomplete="off" class="layui-input">
                    </div>
                    <#if category??>
                        <input type="hidden" name="id" value="${category['id']}" />
                    </#if>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="1" class="layui-btn" lay-submit lay-filter="category" style="float: right;"><#if category??>修改<#else>添加</#if></button>
                    </div>
                </div>
            </form>
        </div>
    </xblock>
</div>
<div class="x-body col-md-7">
    <xblock class="box">
        <h3 class="box-title">所有分类</h3>
        <hr class="layui-bg-black">
        <#list list as category>
            <a id="${category['id']}" type="category" class="category edit" href="#" title="${category['description']}">${category['name']}(${category['postNumber']})</a>
        </#list>
    </xblock>
</div>
<script src="/static/plugins/jquery/jquery.ui.position.js"></script>
<script src="/static/plugins/jquery/jquery.contextMenu.js"></script>
<script src="/static/js/post.common.js"></script>
<script src="/static/js/tag.category.js"></script>
</body>
</html>
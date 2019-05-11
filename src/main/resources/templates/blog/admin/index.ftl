<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>博客管理</title>
    <meta charset="UTF-8"/>
    <#include "common.ftl" />
    <link href="/static/plugins/admin/css/font.css" rel="stylesheet" />
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />

</head>
<body>
<div class="container">
    <div class="logo"><a href="/">后台管理</a></div>
    <div class="left_open">
        <i title="展开左侧栏" class="iconfont">&#xe699;</i>
    </div>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item to-index"><a href="javascript:;">${Session['superName']}</a></li>
        <li class="layui-nav-item to-index"><a href="javascript:;" onclick="Lobibox.confirm({msg: '确定登出吗？',title: '提示',iconClass: false,callback: function($this, type, ev) {if (type == 'yes') {window.location.href = '/admin/logout '}}});">登出</a></li>
        <li class="layui-nav-item to-index"><a href="/index">前台首页</a></li>
    </ul>

</div>
<div class="left-nav">
    <div id="side-nav">
        <ul id="nav">
            <li>
                <a href="javascript:;">
                    <i class="fa fa-book"></i>
                    <cite>文章</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="#" onclick="switchPage('/admin/post', -1)">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>文章管理</cite>
                        </a>
                    </li >
                    <li>
                        <a href="#" onclick="switchPage('/admin/post/writer', -2)">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>文章发布</cite>
                        </a>
                    </li >
                    <li>
                        <a href="#" onclick="switchPage('/admin/post/draftBox', -5)">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>草稿箱</cite>
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="fa fa-link"></i>
                    <cite>友链</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="#" onclick="switchPage('/admin/link', -9)">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>友链管理</cite>
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="fa fa-comment"></i>
                    <cite>评论</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="#" onclick="switchPage('/admin/comment', -6)">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>评论管理</cite>
                        </a>
                    </li >
                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="fa fa-comment"></i>
                    <cite>标签</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="#" onclick="switchPage('/admin/tag', -4)">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>标签管理</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="fa fa-comment"></i>
                    <cite>分类</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="#" onclick="switchPage('/admin/category', -3)">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>分类管理</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="fa fa-image"></i>
                    <cite>图片</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="#" onclick="switchPage('/admin/image', -10)">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>图片管理</cite>
                        </a>
                    </li >
                </ul>
                <ul class="sub-menu">
                    <li>
                        <a href="#" onclick="switchPage('/admin/image/banner', -11)">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>轮播图管理</cite>
                        </a>
                    </li >
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="fa fa-cog"></i>
                    <cite>设置</cite>
                    <i class="iconfont nav_right">&#xe697;</i>
                </a>
                <ul class="sub-menu">
                    <li>
                        <a href="#" onclick="switchPage('/admin/config', -8)">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>博客设置</cite>
                        </a>
                    </li>
                    <li>
                        <a href="#" onclick="switchPage('/admin/config/about', -7)">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>关于我</cite>
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</div>
<div class="page-content">
    <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
        <ul class="layui-tab-title">
            <li class="home" onclick="switchPage('/admin/welcome', 0)"><i class="layui-icon">&#xe68e;</i>我的桌面</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='/admin/welcome' frameborder="0" scrolling="yes" class="x-iframe" id="show"></iframe>
            </div>
        </div>
        <div id="tab_show"></div>
    </div>
</div>
<div class="page-content-bg"></div>
<div class="footer">
    <div class="copyright">Copyright ©2019 All Rights Reserved</div>
</div>
<script src="/static/plugins/admin/js/xadmin.js"></script>
<script src="/static/plugins/admin/js/cookie.js"></script>
</body>
</html>
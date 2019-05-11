<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <!-- meta -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <#include "common.ftl" />
</head>
<style>
    #searchform button span {
        font-size: 30px;
    }
</style>
<body>

<div class="container">
    <header id="site-header">
        <div class="row">
            <div class="col-md-4 col-sm-5 col-xs-8">
                <div class="logo">
                    <h2><a href="/index"><b id="title">${webSiteConfig['title']}</b></a></h2>
                </div>
            </div>

            <div class="col-md-8 col-sm-7 col-xs-4">
                <form role="search" method="get" id="searchform" action="/search">
                    <input name="keyword" type="search" placeholder="Search" required value="${Request['keyword']!""}">
                    <button type="submit" lay-filter="search"><span class="ion-ios-search-strong"></span></button>
                </form>
            </div>
        </div>
    </header>
</div>

<div class="content-body">
    <div class="container">
        <div class="row">
            <#include "common/live2d.ftl" />
            <main class="col-md-6">
                <#list result['list'] as post>
                    <article class="post">
                        <header class="entry-header">
                            <h1 class="entry-title">
                                <a href="single.html">${post['title']}</a>
                            </h1>
                            <div class="entry-meta">
                                <span class="post-date"><a href="#">${post['createTime']?string("yyyy-MM-dd HH:mm")}</a></span>

                                <span class="post-author"><a href="#">${post['author']}</a></span>

                                <span class="post-comments"><a href="#">${post['commentCount']} 条留言</a></span>

                                <span class="comments-link"><a href="#">${post['viewCount']} 次查看</a></span>
                            </div>
                        </header>
                        <div class="entry-content clearfix">
                            <div class="show-content">${post['content']}</div>
                            <div class="read-more cl-effect-14">
                                <a href="/detail?id=${post['id']}" class="more-link">Read more<span class="meta-nav">→</span></a>
                            </div>
                        </div>
                    </article>
                </#list>
                <div id="page" style="text-align: center; margin-top: 30px;"></div>
            </main>

            <#include "common/aside.ftl" />
        </div>
    </div>
</div>

<#include "common/footer.ftl" />

<script>
    layui.use('laypage', function(){
        var laypage = layui.laypage;
        laypage.render({
            elem: 'page',
            limit: 10,
            count: ${result['total']},
            curr: ${result['pageNum']},
            theme: '#000000',
            prev: '<em>←</em>',
            next: '<em>→</em>',
            jump: function(obj, first){
                var page = obj.curr;
                var size = obj.limit;
                //首次不执行
                if(!first){
                    window.location.href = "/index?page=" + page + "&size=" + size;
                }
            }
        });
    });
</script>
</body>
</html>
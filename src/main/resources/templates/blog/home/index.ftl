<!DOCTYPE html>
<html>
<head>
	<title>${webSiteConfig['title']}</title>
	<!-- meta -->
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<#include "common.ftl" />
	<style>
		#slide {
			width: 100%;
			height: 380px;
			margin: auto;
			margin-bottom: 30px;
		}

		img {
			width: 917px;
			height: 380px;
		}
	</style>
</head>

<body>

<#include "common/nav.ftl" />
<div class="content-body">
	<div class="container">
		<div class="row">
			<#include "common/live2d.ftl" />
			<main class="col-md-6">
				<#if (bannerList?size > 0)>
					<div id="slide">
						<div>
							<#list bannerList as banner>
								<a href="/detail?id=${banner['postId']}" target="_blank"><img src="${banner['imagePath']}" alt="${banner['postTitle']}"></a>
							</#list>
						</div>
					</div>
				</#if>
				<#list result['list'] as post>
					<article class="post">
						<header class="entry-header">
							<h1 class="entry-title">
								<a href="/detail?id=${post['id']}">${post['title']}</a>
							</h1>
							<div class="entry-meta">
								<span class="post-author"><a href="#"><i class="layui-icon layui-icon-username"></i>${post['author']}</a></span>
								<span class="post-date"><a href="#"><i class="layui-icon layui-icon-date"></i>${post['createTime']?string("yyyy-MM-dd HH:mm")}</a></span>
								<span class="post-comments"><a href="#"><i class="layui-icon layui-icon-dialogue"></i>${post['commentCount']} 条留言</a></span>
								<span class="comments-link"><a href="#"><i class="layui-icon layui-icon-log"></i>${post['viewCount']} 次查看</a></span>
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

<script src="/static/js/roomSlider.js"></script>
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

	$(function () {
		var roomSlider = new RoomSlider('slide')
	})
</script>
</body>
</html>
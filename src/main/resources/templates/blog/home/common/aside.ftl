<aside class="col-md-4">
    <div class="widget widget-recent-posts">
        <h3 class="widget-title">最近文章</h3>
        <ul>
            <#list recentPost as post>
                <#if post['status'] != 3>
                    <li>
                        <a href="/detail?id=${post['id']}">${post['title']}</a>
                    </li>
                </#if>
            </#list>
        </ul>
    </div>

    <div class="widget widget-archives">
        <h3 class="widget-title">归档</h3>
        <ul>
            <#list year as date>
                <li>
                    <a href="/archives?date=${date}">${date}</a>
                </li>
            </#list>
        </ul>
    </div>

    <div class="widget widget-category">
        <h3 class="widget-title">分类</h3>
        <ul>
            <#list categoryList as c>
                <li>
                    <a href="/category?name=${c['name']}" title="${c['description']}">${c['name']}(${c['postNumber']})</a>
                </li>
            </#list>
        </ul>
    </div>

    <div class="widget widget-tag">
        <h3 class="widget-title">标签</h3>
        <ul>
            <#list tagList as tag>
                <li>
                    <a href="/tag?name=${tag['name']}" title="${tag['description']}">${tag['name']}(${tag['postNumber']})</a>
                </li>
            </#list>
        </ul>
    </div>

    <div class="widget">
        <h3 class="widget-title">联系我</h3>
        <ul>
            <li style="margin-bottom: 10px;">
                <i class="layui-icon">&#xe676;</i>
                <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&site=qq&menu=yes&uin=${webSiteConfig['qq']}">${webSiteConfig['qq']}</a>
            </li>
            <li style="margin-bottom: 10px;">
                <i class="layui-icon">&#xe677;</i>
                <a href="#">${webSiteConfig['wechat']}</a>
            </li>
            <li style="margin-bottom: 5px;">
                <i class="layui-icon">&#xe675;</i>
                <a target="_blank" href="http://weibo.com/${webSiteConfig['weibo']}">${webSiteConfig['weibo']}</a>
            </li>
            <li>
                <i class="icon ion-email" style="font-size: 19px;"></i>
                <a href="mailto:${webSiteConfig['email']}">${webSiteConfig['email']}</a>
            </li>
        </ul>
    </div>

</aside>
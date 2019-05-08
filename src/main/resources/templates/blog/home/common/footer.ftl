<footer id="site-footer">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <p class="copyright">
                    ${webSiteConfig['footer']}
                </p>
            </div>
        </div>
    </div>
</footer>

<div class="overlay overlay-hugeinc">
    <button type="button" class="overlay-close"><span class="ion-ios-close-empty"></span></button>
    <nav>
        <ul>
            <li><a href="/index">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Links</a></li>
        </ul>
    </nav>
</div>

<script src="/static/plugins/home/js/script.js"></script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?b4de8f0e36a80610fa05ad550d0da578";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
<script type="text/javascript">
    var message_Path = '/static/plugins/live2d/'
    var home_Path = 'http://127.0.0.1:8080/'
</script>
<script type="text/javascript" src="/static/plugins/live2d/js/live2d.js"></script>
<script type="text/javascript" src="/static/plugins/live2d/js/message.js"></script>
<script type="text/javascript">
    //loadlive2d("live2d", "/static/plugins/live2d/model/lfqy/2.json");
    loadlive2d("live2d", "/static/plugins/live2d/model/xm/13.json");
    //loadlive2d("live2d", "/static/plugins/live2d/model/tia/model.json");
</script>

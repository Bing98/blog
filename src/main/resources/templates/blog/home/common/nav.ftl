<div class="container">
    <header id="site-header">
        <div class="row" style="width: 68%; margin: auto;">
            <div class="col-md-4 col-sm-5 col-xs-8">
                <div class="logo">
                    <h2><a href="/index"><b>${webSiteConfig['title']}</b></a></h2>
                </div>
            </div>
            <div class="col-md-8 col-sm-7 col-xs-4">
                <nav class="main-nav" role="navigation">
                    <div class="navbar-header">
                        <button type="button" id="trigger-overlay" class="navbar-toggle">
                            <span class="ion-navicon"></span>
                        </button>
                    </div>

                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="cl-effect-11"><a href="/index" data-hover="Home">Home</a></li>
                            <li class="cl-effect-11"><a href="/about" data-hover="About">About</a></li>
                            <li class="cl-effect-11"><a href="/link" data-hover="Links">Links</a></li>
                        </ul>
                    </div><!-- /.navbar-collapse -->
                </nav>
                <div id="header-search-box">
                    <a id="search-menu" href="#"><span id="search-icon" class="ion-ios-search-strong"></span></a>
                    <div id="search-form" class="search-form">
                        <form role="search" method="get" id="searchform" action="/search">
                            <input name="keyword" type="search" placeholder="Search" required>
                            <button type="submit" lay-filter="search"><span class="ion-ios-search-strong"></span></button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </header>
</div>
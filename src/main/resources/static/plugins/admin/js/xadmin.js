$(function () {
    var pageCookic = {
        "0" : "/admin/welcome",
        "-1" : "/admin/post",
        "-2" : "/admin/post/writer",
        "-3" : "/admin/category",
        "-4" : "/admin/tag",
        "-5" : "/admin/post/draftBox",
        "-6" : "/admin/comment",
        "-7" : "/admin/config/about",
        "-8" : "/admin/config",
        "-9" : "/admin/link",
        "-10" : "/admin/image",
        "-11" : "/admin/image/slider"
    };

    tableCheck = {
        init: function () {
            $(".x-admin .layui-form-checkbox").click(function (event) {
                if ($(this).hasClass('layui-form-checked')) {
                    $(this).removeClass('layui-form-checked');
                    if ($(this).hasClass('header')) {
                        $(".x-admin .layui-form-checkbox").removeClass('layui-form-checked');
                    }
                } else {
                    $(this).addClass('layui-form-checked');
                    if ($(this).hasClass('header')) {
                        $(".x-admin .layui-form-checkbox").addClass('layui-form-checked');
                    }
                }

            });
        },
        getData: function () {
            var obj = $(".x-admin .layui-form-checked").not('.header');
            var arr = [];
            obj.each(function (index, el) {
                arr.push(obj.eq(index).attr('data-id'));
            });
            return arr;
        }
    }
    $('.container .left_open i').click(function(event) {
        if($('.left-nav').css('left')=='0px'){
            $('.left-nav').animate({left: '-221px'}, 100);
            $('.page-content').animate({left: '0px'}, 100);
            $('.page-content-bg').hide();
        }else{
            $('.left-nav').animate({left: '0px'}, 100);
            $('.page-content').animate({left: '221px'}, 100);
            if($(window).width()<768){
                $('.page-content-bg').show();
            }
        }
    });
    //左侧菜单效果
    $('.left-nav #nav').on('click', 'li', function (event) {
        var index = $('.left-nav #nav li').index($(this));
        if ($(this).children('.sub-menu').length) {
            if ($(this).hasClass('open')) {
                if ($(this).parent().hasClass('sub-menu')) {
                    deleteCookie('left_menu_son');
                } else {
                    deleteCookie('left_menu_father');
                }
                $(this).removeClass('open');
                $(this).find('.nav_right').html('&#xe697;');
                $(this).children('.sub-menu').stop().slideUp();
                $(this).siblings().children('.sub-menu').slideUp();
            } else {
                if ($(this).parent().hasClass('sub-menu')) {
                    setCookie('left_menu_son', index);
                } else {
                    setCookie('left_menu_father', index);
                }
                $(this).addClass('open');
                $(this).children('a').find('.nav_right').html('&#xe6a6;');
                $(this).children('.sub-menu').stop().slideDown();
                $(this).siblings().children('.sub-menu').stop().slideUp();
                $(this).siblings().find('.nav_right').html('&#xe697;');
                $(this).siblings().removeClass('open');
            }
        } else {
            var url = $(this).children('a').attr('_href');
            var title = $(this).find('cite').html();
            var is_refresh = $(this).attr('date-refresh') ? true : false;
            for (var i = 0; i < $('.x-iframe').length; i++) {
                if ($('.x-iframe').eq(i).attr('tab-id') == index + 1) {
                    tab.tabChange(index + 1);
                    event.stopPropagation();
                    if (is_refresh)
                        $('.x-iframe').eq(i).attr("src", $('.x-iframe').eq(i).attr('src'));
                    return;
                }
            };
            if (getCookie('tab_list')) {
                tab_list = getCookie('tab_list').split(',');
            } else {
                tab_list = [];
            }
            var is_exist = false;
            for (var i in tab_list) {
                if (tab_list[i] == index)
                    is_exist = true;
            }
            if (!is_exist) {
                tab_list.push(index);
            }
            setCookie('tab_list', tab_list);
        }
        event.stopPropagation();
    })
    // 左侧菜单记忆功能
    if (getCookie('left_menu_father') != null) {
        $('.left-nav #nav li').eq(getCookie('left_menu_father')).click();
    }
    if (getCookie('left_menu_son') != null) {
        var index = getCookie('left_menu_son');
        $("#show").attr("src", pageCookic[index]);
    }
})

function x_admin_father_reload() {
    parent.location.reload();
}

function switchPage(page, cookieNum) {
    $("#show").attr("src", page);
    setCookie("left_menu_son", cookieNum);
}


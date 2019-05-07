$(function() {
    NProgress.start();
    $(window).load(function () {
        NProgress.done();
    });
});

$(window).scroll( function() {
    $("#wrapper-navigation").addClass('show');

    if ($(document).scrollTop() <= 0){
        $("#wrapper-navigation").removeClass('show');
    }
});

$("#register").click(function () {
    layer.open({
        type: 2,
        area: ['500px', '500px'],
        title: '用户注册',
        skil: 'layui-layer-molv',
        content: '/register'
    });
})

$("#login").click(function () {
    layer.open({
        type: 2,
        area: ['500px', '300px'],
        title: '用户登录',
        skil: 'layui-layer-molv',
        content: '/login'
    });
})
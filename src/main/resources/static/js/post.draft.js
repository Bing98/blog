$(function () {
    layui.use(['form', 'element'],
        function () {
            layer = layui.layer;
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
                    var ids = "";
                    obj.each(function (index, el) {
                        ids += obj.eq(index).attr('data-id') + ",";
                    });
                    return ids;
                }
            }
            tableCheck.init();
        })
})

$("input[name=seleCheck]").click(function (event) {
    var id = $(this).val();
    for (var i = 1; i <= 3; i++) {
        var ele = $("#seleCheck" + i);
        if (i == id) {
            ele.addClass('red');
        } else {
            ele.removeClass('red');
        }
    }

});

$("#updateStatus").click(function () {
    var id = tableCheck.getData();
    if (id == "" || id.length < 1) {
        alertMsg('error', 300, '请选择文章！');
        return;
    }
    var status = $("#updateStatus").attr("status");
    $.ajax({
        url: "/admin/post/updateStatus?status=" +status + "&id=" + id,
        method: "GET",
        dataType: "JSON",
        success: function (data) {
            responseMsg(data);
        }
    })
})

$("#deleteAll").click(function () {
    var ids = tableCheck.getData();
    if (ids == "" || ids.length < 1) {
        alertMsg('error', 300, '请选择文章！');
        return;
    }

    delPost(ids);
})

function delPost(id) {
    Lobibox.confirm({
        msg: '确定删除吗？',
        title: '提示',
        iconClass: false,
        callback: function($this, type, ev) {
            if (type == 'yes') {
                $.ajax({
                    url: "/admin/post?id=" + id,
                    method: "DELETE",
                    dataType : "JSON",
                    success: function (data) {
                        responseMsg(data);
                    }
                })
            }
        }
    });
}
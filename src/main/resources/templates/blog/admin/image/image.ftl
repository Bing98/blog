<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>图片管理</title>
    <meta charset="UTF-8"/>
    <meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
    <#include "../common.ftl" />
    <link href="/static/css/admin.css" rel="stylesheet"/>
    <link href="/static/plugins/admin/css/xadmin.css" rel="stylesheet" />
    <link href="/static/plugins/jquery/jquery.contextMenu.css" rel="stylesheet" />
</head>
<style>
    #upload-image {
        margin: 20px 0;
        height: 400px;
        border: 2px dashed #FFFFFF;
        line-height: 400px;
        text-align: center;
        font-size: 30px;
    }

    img {
        margin-right: 20px;
    }

    .cz {
        border: 1px solid #000000;
        padding: 10px;
    }

    .cz:hover {
        cursor: pointer;
    }
</style>
<body>
<div class="x-nav">
    <span>图片管理</span>
</div>
<div class="x-body col-md-12">
    <div id="upload-image">
        将图片拖拽到这来！
    </div>
    <div id="show-image">
        <#list imageList as image >
            <div style="display: inline-block;">
                <img style="max-width: 300px; max-height: 300px;" src="${image['path']}" />
                <div style="width: 150px; margin: auto">
                    <p style="margin-top: 20px;">
                        <span class="cz" onclick="lookImage('${image['path']}')">查看</span>
                        <span class="cz" onclick="deleteImage('${image['id']}', '${image['name']}')">删除</span>
                    </p>
                </div>
            </div>
        </#list>
    </div>
</div>
</body>
<script>
    $(function () {
        //阻止浏览器默认行。
        $(document).on({
            dragleave:function(e){    //拖离
                e.preventDefault();
            },
            drop:function(e){  //拖后放
                e.preventDefault();
            },
            dragenter:function(e){    //拖进
                e.preventDefault();
            },
            dragover:function(e){    //拖来拖去
                e.preventDefault();
            }
        });

        var box = document.getElementById('upload-image'); //拖拽区域
        box.addEventListener("drop",function(e){
            e.preventDefault(); //取消默认浏览器拖拽效果
            var fileList = e.dataTransfer.files; //获取文件对象
            //检测是否是拖拽文件到页面的操作
            if(fileList.length == 0){
                return false;
            }
            //检测文件是不是图片
            if(fileList[0].type.indexOf('image') === -1){
                alertMsg('error', 300, '拖的不是图片！');
                return false;
            }
            var maxSize = 1024 * 1024 * 2;
            var size = fileList[0].size;
            if (size > maxSize) {
                alertMsg('error', 300, '图片大小超过2M！');
                return false;
            }
            var data = new FormData()
            data.append('file', fileList[0])
            $.ajax({
                url: "/admin/image",
                method: "POST",
                data: data,
                dataType: "JSON",
                cache: false,
                processData: false,
                contentType: false,
                success: function (data) {
                    responseMsg(data);
                }
            })
        })
    });

    function lookImage(path) {
        if (isEmpty(path)) {
            alertMsg('error', 300, '路径为空！');
            return;
        }
        layer.open({
            type: 2,
            title: '图片',
            area: ['80%', '80%'],
            content: 'http://' + window.location.host + path
        });
    }

    function deleteImage(id, name) {
        if (isEmpty(id) || isEmpty(name)) {
            alertMsg('error', 300, '操作失败！');
            return;
        }
        Lobibox.confirm({
            msg: '确定删除吗？',
            title: '提示',
            iconClass: false,
            callback: function($this, type, ev) {
                if (type == 'yes') {
                    $.ajax({
                        url: "/admin/image/delete?id=" + id + "&name=" + name,
                        method: "GET",
                        dataType : "JSON",
                        success: function (data) {
                            responseMsg(data);
                        }
                    })
                }
            }
        });

    }
</script>
</html>
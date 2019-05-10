<link href="/static/plugins/layui/css/layui.css" rel="stylesheet" />
<script src="/static/plugins/jquery/jquery.js"></script>

<style>
    img:hover {
        cursor: pointer;
    }

    .check {
        border: 1px solid red;
    }

    p {
        margin: 10px 0 10px 0;
    }
</style>
<div style="margin: 30px;">
    <p>排序：</p>
    <select id="index" style="padding: 8px; width: 50%">
            <option value="1" <#if banner?? && banner['sort'] == 1>
                selected
            </#if>
            >
                1
            </option>
            <option value="2" <#if banner?? && banner['sort'] == 2>
            selected
                    </#if>>
                2
            </option>
            <option value="3" <#if banner?? && banner['sort'] == 3>
            selected
                    </#if>>
                3
            </option>
            <option value="4" <#if banner?? && banner['sort'] == 4>
            selected
                    </#if>>
                4
            </option>
            <option value="5" <#if banner?? && banner['sort'] == 5>
            selected
                    </#if>>
                5
            </option>
    </select>

    <p>选择文章：</p>
    <select id="post" style="padding: 8px; width: 50%">
        <#list postList as post>
            <option
                    <#if banner?? && banner['postId'] == post['id']>
                        selected
                    </#if>
                    value="${post['id']}">${post['title']}
            </option>
        </#list>
    </select>

    <p>选择图片：</p>
    <#list imageList as image >
        <div style="display: inline-block;">
            <img <#if banner?? && banner['imageId'] == image['id']>
                    class="check"
            </#if>
                    id="${image['id']}" style="max-width: 300px; max-height: 300px;" src="${image['path']}" onclick="checkImage(this)" />
        </div>
    </#list>
    <br>
    <#if banner??>
        <button class="layui-btn" id="save" style="margin-top: 20px;"><i class="layui-icon layui-icon-edit"></i>修改</button>
        <#else >
        <button class="layui-btn" id="save" style="margin-top: 20px;"><i class="layui-icon layui-icon-add-1"></i>添加</button>
    </#if>
</div>

<script>
    function checkImage(imgEle) {
        var imgArray = $('img');
        for (var i = 0; i < imgArray.length; i++) {
            var temp = imgArray.eq(i);
            temp.removeClass('check');
        }

        $(imgEle).addClass('check');
    }

    $("#save").click(function () {
        var post = $('#post').val();
        var index = $('#index').val();
        var image = '';
        var imageId = '';
        var imgArray = $('img');
        for (var i = 0; i < imgArray.length; i++) {
            var temp = imgArray.eq(i);
            if (temp.hasClass('check')) {
                image = temp;
                imageId = temp.attr('id')
            }
        }

        if (imageId == '') {
            return;
        }

        var postTitle = $('option[value=' + post + ']').text();
        var imagePath = image.attr('src');
        var id = "";
        <#if banner??>
        id = ${banner['id']}
        </#if>

        $.ajax({
            url: '/admin/image/saveBanner',
            method: "POST",
            dataType: "JSON",
            data: {'postId' : post, 'sort' : index, 'imageId' : imageId,
                    'postTitle' : postTitle, 'imagePath' : imagePath, 'id' : id},
            success: function (data) {
                var code = data['code'];
                if (code != 0) {

                } else {
                    window.parent.location.reload();
                }
            }
        })
    });
</script>
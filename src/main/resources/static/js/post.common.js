layui.use('form', function(){
    var form = layui.form;
    form.on('submit(category)', function(data){
        var isUpdate = data['elem']['innerText'] == "修改";
        var isSave = data['elem']['innerText'] == "添加";
        var field = data['field'];
        var name = field['name'];
        var description = field['description'];
        if (isEmpty(name)) {
            alertMsg("error", 300, "分类名称不能为空！");
            return;
        }
        var url = "/admin/category";
        if (isUpdate) {
            url = "/admin/category/update"
        }
        $.ajax({
            url : url,
            method : "POST",
            data : field,
            dataType : "JSON",
            success : function (data) {
                var id = data['data'];
                var code = data['code'];
                if (code != 0) {
                    alertMsg("error", 300, data['message']);
                } else {
                    if (isSave) {
                        window.location.reload();
                    } else {
                        $("#category").append(cEle.replace("!@#$%^&*", name)
                            .replace("$##%#!!@55", "category")
                            .replace("%@#awdw)(*^", id)
                            .replace("DWDPADO((@#@#", description));
                    }
                }
            }
        })
        return false;
    })

    form.on('submit(tag)', function(data){
        var isUpdate = data['elem']['innerText'] == "修改";
        var isSave = data['elem']['innerText'] == "添加";
        var field = data['field'];
        var name = field['name'];
        var description = field['description'];
        if (isEmpty(name)) {
            alertMsg("error", 300, "标签名称不能为空！");
            return;
        }
        var url = "/admin/tag";
        if (isUpdate) {
            url = "/admin/tag/update";
        }
        $.ajax({
            url : url,
            method : "POST",
            data : field,
            dataType : "JSON",
            success : function (data) {
                var id = data['data'];
                var code = data['code'];
                if (code != 0) {
                    alertMsg("error", 300, data['message']);
                } else {
                    if (isSave) {
                        window.location.reload();
                    } else {
                        $("#tag").append(tagEle.replace("!@#$%^&*", name)
                            .replace("$##%#!!@55", "tag")
                            .replace("%@#awdw)(*^", id)
                            .replace("DWDPADO((@#@#", description));
                    }
                }
            }
        })
        return false;
    })
})

var tagEle = '<a class="tag edit check" title="DWDPADO((@#@#" type="$##%#!!@55" id="%@#awdw)(*^" onclick="choose(this)" style="margin-left: 2px;">!@#$%^&*</a>';
var cEle = '<a class="category edit check" title="DWDPADO((@#@#" type="$##%#!!@55" id="%@#awdw)(*^" onclick="choose(this)" style="margin-left: 2px;">!@#$%^&*</a>';
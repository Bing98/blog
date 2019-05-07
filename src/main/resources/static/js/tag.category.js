$(function(){
    $.contextMenu({
        selector: '.edit',
        items: {
            "edit": {name: "编辑", callback : function(key, opt) {
                var elem = opt['$trigger'];
                var id = elem.attr('id');
                var data = {"name" : elem['name'], "description" : elem['description']}
                var editType = elem.attr('type');
                if ("tag" == editType) {
                    window.location.href = "/admin/tag?id=" + id;
                } else {
                    window.location.href = "/admin/category?id=" + id;
                }
            }},
            "delete": {name: "删除", callback : function(key, opt) {
                    var elem = opt['$trigger'];
                    var id = elem.attr('id');
                    var delType = elem.attr('type');
                    Lobibox.confirm({
                        msg: '确定要删除吗？',
                        title: '提示',
                        iconClass: false,
                        callback: function($this, type, ev) {
                            if ('yes' == type) {
                                if ("tag" == delType) {
                                    deleteTagOrCategory("/admin/tag?id=" + id);
                                } else {
                                    deleteTagOrCategory("/admin/category?id=" + id);
                                }
                            }
                        }
                    });
                }
            }
        }
    });
});

function deleteTagOrCategory(url, data) {
    $.ajax({
        url : url,
        method : "DELETE",
        success : function (data) {
            window.location.reload();
        }
    })
}
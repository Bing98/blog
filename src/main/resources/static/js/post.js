var simplemde = new SimpleMDE({
    autosave: {
        enabled: true,
        uniqueId: "MyUniqueID",
        delay: 1000
    },
    status: ["autosave", "lines", "words"],
    spellChecker: false,
    element: document.getElementById("content"),
    promptURLs: true,
    toolbar: [
        "bold", "italic", "strikethrough", "heading", "code", "quote", "unordered-list",
        "ordered-list", "clean-block", "link", "image", "table", "horizontal-rule", "preview"
    ]
});

function choose(element) {
    if (!$(element).hasClass("check")) {
        $(element).addClass("check");
    } else {
        $(element).removeClass("check");
    }
};

$("#title").change(function () {
    var title = $("#title").val();
    window.localStorage.setItem("title", title);
})

$(function () {
    var titile = window.localStorage.getItem("title");
    $("#title").val(titile);
})

function update(id, status) {
    var title = $("#title").val();
    if (isEmpty(title)) {
        alertMsg("error", 300, "标题不能为空！");
        return;
    }
    var checkCategory = getTagOrCateogry("category");
    var checkTag = getTagOrCateogry("tag");
    var markDown = simplemde.value();
    var content = simplemde.markdown(markDown);
    $.ajax({
        url : "/admin/post/update",
        method : "POST",
        dataType : "JSON",
        data : {"id" : id, "title" : title, "content" : content, "markDownContent" : markDown,
            "tag" : JSON.stringify(checkTag), "category" : JSON.stringify(checkCategory),
            "status" : status},
        success : function (data) {
            var code = data['code'];
            if (code == 0) {
                if (status == 1) {
                    alertMsg("success", 300, "保存成功！");
                } else {
                    alertMsg("success", 300, "保存草稿成功！");
                }
                $("#title").val("");
                window.localStorage.removeItem("title");
                simplemde.value("");
                setTimeout(function () {
                    window.location.href = "/admin/post/writer";
                }, 3000);
            } else {
                alertMsg("error", 300, data['message']);
            }
        }
    })
}

function put(status) {
    var title = $("#title").val();
    if (isEmpty(title)) {
        alertMsg("error", 300, "标题不能为空！");
        return;
    }
    var checkCategory = getTagOrCateogry("category");
    var checkTag = getTagOrCateogry("tag");
    var markDown = simplemde.value();
    var content = simplemde.markdown(markDown);
    $.ajax({
        url : "/admin/post",
        method : "POST",
        dataType : "JSON",
        data : {"title" : title, "content" : content, "markDownContent" : markDown,
                "tag" : JSON.stringify(checkTag), "category" : JSON.stringify(checkCategory),
                "status" : status},
        success : function (data) {
            var code = data['code'];
            if (code == 0) {
                if (status == 1) {
                    alertMsg("success", 300, "发布成功！");
                } else {
                    alertMsg("success", 300, "保存草稿成功！");
                }
                $("#title").val("");
                window.localStorage.removeItem("title");
                simplemde.value("");
                setTimeout(function () {
                    window.location.href = "/admin/post/writer";
                }, 3000);
            } else {
                alertMsg("error", 300, data['message']);
            }
        }
    })
}

function getTagOrCateogry(type) {
    var check = $("#" + type + "> .check");
    var array = new Array();
    for (var i = 0; i < check.length; i++) {
        var text = check.eq(i).text();
        array.push(text);
    }

    return array;
}
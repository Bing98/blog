function alertMsg(type, width, msg) {
    Lobibox.notify(type, {
        sound: false,
        position: "top left",
        width: width,
        delay: 2000,
        iconClass: false,
        msg: msg
    });
}

function isEmpty(str) {
    if (str.replace(/(^s*)|(s*$)/g, "").length == 0) {
        return true;
    }

    return false;
}

function responseMsg(data) {
    var code = data['code'];
    if (code == 0) {
        window.location.reload();
    } else {
        alertMsg("error", 300, data['message']);
    }
}

function getNowTime() {
    var now = new Date();

    var year = now.getFullYear();       //年
    var month = now.getMonth() + 1;     //月
    var day = now.getDate();            //日

    var hh = now.getHours();            //时
    var mm = now.getMinutes();          //分
    var ss = now.getSeconds();           //秒

    var clock = year + "-";

    if(month < 10) {
        clock += "0";
    }

    clock += month + "-";

    if(day < 10) {
        clock += "0";
    }

    clock += day + " ";

    if(hh < 10) {
        clock += "0";
    }

    clock += hh + ":";
    if (mm < 10) {
        clock += '0';
    }
    clock += mm + ":";

    if (ss < 10) {
        clock += '0'
    };
    clock += ss;

    return clock;
}
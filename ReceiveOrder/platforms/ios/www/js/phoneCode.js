var timeall = 60;      //点击再次发送的时间（秒）
var timedestory = 5*60*1000 //五分钟
$(function () {

    setInterval("gettimeleft()", 1000);
    //获取验证码
    $(".code-btn").click(function () {

        var tel = $("#user-phone").val();

        if (tel == "") {
            alert("手机号码不能为空！");
            $("#user-phone").focus();
            return;
        }
        if (!tel.C_Mobile()) {
            alert("手机号码格式有误！");
            $("#user-phone").focus();            
            return;
        }
        $(this).attr("disabled", "disabled");
        $(this).attr("u", "2");
        $.ajax({
            type: 'post',
            url: "http://10.2.0.152:8099/api/Reserved/PostSendSecurityCode",
            data: {
                QueueToken: $.session.get("token"),
                CusPhone: tel
            },
            cache: false,
            success: function (results) {
                var resultObj = JSON.parse(results);
                console.log(resultObj);
                if (resultObj.Flag) {
                    $.session.set("phone-code", resultObj.Code);
                    $.session.set("phone-code-lost", resultObj.Code);
                    setInterval(function() {
                        $.session.set("phone-code","");
                    }, timedestory);
                } else {
                    alert("下发验证码失败，请重试！");
                    $.session.set("phone-code", "");
                    $(".code-btn").attr("u", "1");
                    $(".code-btn").attr("disabled", "");
                    return false;
                }
            }
        });
    });
});
function gettimeleft() {
    if ($(".code-btn").attr("u") == 2) {
        if (timeall == 0) {
            $(".code-btn").text("重获短信");
            $(".code-btn").removeAttr("disabled");
            $(".code-btn").attr("u", "1");
            timeall = 60;
            return false;
        }
        timeall--;
        $(".code-btn").text(timeall + "秒后再获");
    }
}
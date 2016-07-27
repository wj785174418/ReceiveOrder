$.Common = {};
$.Common.siteUrl="http://xfwg.nnwg121.com/queue";
(function () {
    var _this = $.Common;
    $.extend(_this, {

        //获取url地址中的参数方法
        GetUrlParam: function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            //解码url(有中文时，必须要解码)
            var url = decodeURI(window.location.search);
            //得到参数值
            var r = url.substr(1).match(reg);
            if (r != null)
                //解密参数
                return unescape(r[2]);
            return null;
        },

        //前端规则:
        //1.请求地址以 siteUrl 为应用根目录
        //2.webapi地址:/api/{controller}/{action}
        //3.请求参数类型：dataType: "json"
        //4.请求参数：data: { username: 'admin', pwd: '123456' }使用对象模式
        //beforeSend: function (request) {
        //    request.setRequestHeader("Authorization", "admin12345678");
        //},
        PostAjax: function (jsondata, url, callback, obj) {

            $.ajax({
                type: 'post',
                dataType: "json",
                data: jsondata,
                url: $.Common.siteUrl+url,
                //beforeSend: function (request) {
                //    request.setRequestHeader("Authorization", token);
                //},
                success: function (response) {
					var resultObj = JSON.parse(response);
					if(resultObj.Flag)
						callback(resultObj.ResultObj);	
					else{
                        if(obj){
						  var s = obj.html().substring(0,obj.html().length - 1);
						  obj.removeAttr("disabled").html(s);
                        }
						alert("错误信息:"+resultObj.Message);
					}
                },
                error: function (XmlHttpRequest, textStatus, errorThrown) {
                    //debugger
                    alert("您的网络信号不稳定，请刷新重试！");
                    if(obj){
                        var s = obj.html().substring(0,obj.html().length - 1);
					   obj.removeAttr("disabled").html(s);   
                    }
                }
            });
        },

        //Ajax的get方式请求
        GetAjax: function (jsondata, url, callback, obj) {
            $.ajax({
                type: 'get',
                dataType: "json",
				data: jsondata,
                url: $.Common.siteUrl+url,
                success: function (response) {
                    var resultObj = JSON.parse(response);
					if(resultObj.Flag)
						callback(resultObj.ResultObj);
					else{
                        if(obj){
						var s = obj.html().substring(0,obj.html().length - 1);
						obj.removeAttr("disabled").html(s);
						}
						alert("错误信息:"+resultObj.Message);
					}
                },
                error: function (XmlHttpRequest, textStatus, errorThrown) {
                    alert("您的网络信号不稳定，请刷新重试！");
                    if(obj){
                        var s = obj.html().substring(0,obj.html().length - 1);
					obj.removeAttr("disabled").html(s);   
                    }
                }
            });
        },
    })
})(jQuery);

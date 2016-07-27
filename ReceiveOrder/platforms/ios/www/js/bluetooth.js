(function ($) {
    $.bluetooth =
    {
        _address: null,
        _bluetoothConfigUrl: "bluetooth.html",
        _isconnected: function (resultFun) {
            var address = GetCache("bluetootheAddress");
            if (address) {
                bluetoothle.isConnected(function (pars) {
                    resultFun(pars.isConnected);

                },
                function (pars) {
                                
                     resultFun(false);
                },
                { "address": address });
 }else{
 resultFun(false);}
 
        },
        _initBluetooth: function (resultFunc) {

            bluetoothle.isInitialized(function (pars) {
                if (pars.isInitialized) {
                    resultFunc(true);
                } else {
                    //判断蓝牙是否开启
                    bluetoothle.initialize(function (pars2) {
                                            // alert(pars2.status)
                        if (pars2.status == "enabled") {
                            resultFunc(true);
                        } else {
                            resultFunc(false);
                        }
                    },
                        {
                            "request": true,
                            "statusReceiver": true
                        });
                }
            });
        },
        _connect: function (resultFunc) {
 var me=this;
            this._initBluetooth(function (initStatus) {
                  //alert("初始化蓝牙")
                if (initStatus) {
                    var address = GetCache("bluetootheAddress");
                    if (address) {
                        me._isconnected(function (result) {
                            if (result == false) {
                                bluetoothle.connect(function (pars) {
                                    if (pars.status == "connected") {
                                        resultFunc(true);
                                    }
                                },
                                    function (pars) {
                                        resultFunc(false);
                                    }
                                    ,
                                    { "address": address }
                                    );
                            }
                            else {
                                resultFunc(true);
                            }
                        });
                    }

                }

            });
        },
        _disconver: function (resultFunc) {
            var address = GetCache("bluetootheAddress");
 
            if (address) {
                bluetoothle.isDiscovered(function (pars) {
                  
                    if (false==pars.isDiscovered) {
                  
                     bluetoothle.discover(function (pars1) {
                          
                            if (pars1.status == "discovered") {
                                resultFunc(true);
                            } else {
                                resultFunc(false);
                            }
                        },
                         function (err) { alert("打印失败！失败原因：" + err.message); resultFunc(false) },
                            { "address": address });

                    } else {
                        resultFunc(true)
                    };

                },
                    function (pars) {
                        bluetoothle.discover(function (pars1) {
                            if (pars1.status == "discovered") {
                                resultFunc(true);
                            } else {
                                resultFunc(false);
                            }
                        });
                    },
                    { "address": address });
            }else{alert(222)}
        },
        Conect: function (resultFunc) {
            var me=this;
           
                    var address = GetCache("bluetootheAddress");
                              
                    if (address) {
                        me._connect(function (conPars) {
                                 //   alert("连接蓝牙！")
                            if (conPars) {
                                resultFunc(true, "蓝牙连接成功！");
                            } else {
                                resultFunc(false,"蓝牙连接失败,请重新选择蓝牙打印机！");
                              //  document.location = this._bluetoothConfigUrl+"?url="+document.location;
                            }
                        });
                    } else {
                          resultFunc(false,"蓝牙连接失败,请重新选择蓝牙打印机！");   
                        //document.location = this._bluetoothConfigUrl+"?url="+document.location;
                       
                    }               

        },
        SendMessage: function (resultFunc, number, prevNumber, shopName, type) {
            var me=this;
            this.Conect(function (isSuc, message) {
                var address =GetCache("bluetootheAddress");
               
                if (isSuc) {
                    
                        me._disconver(function(result){
                                      
                                 //     alert("扫描蓝牙！")
                    if(result){
                    bluetoothle.writeTitle(function (pars) {
                                        
                                      
                        if (pars.status == "written") {
                            resultFunc(true);
                        } else {
                            resultFunc(false);
                        }
                    }, function (err) { alert("打印失败！失败原因：" + err.message); resultFunc(false) }
                        , {
                            number: number,
                            address: address,
                            prevNumber: prevNumber,
                            shopName: shopName,
                            type: type
                        });
                                      }else{resultFun(false,"查询失败！")}})
                }
                        else {
                        resultFunc(false,message);
                        }
            });

        }

    }

})(jQuery);

 function SetCache(key, value) {
    //var base64 = new Base64();
    //username = base64.encode(username);
    //userpassword = base64.decode(userpassword);
    if (window.localStorage) {
        var storage = window.localStorage;
        storage[key] = value;
          } else {
        setCookie(key, value);
    }
}
 function GetCache(key) {
    var value = "";
    if (window.localStorage) {
        var storage = window.localStorage;
        value = storage[key];
    }
    else
    {
        value = getCookie(key);
    }
    
    return value;
}
 
 
 function setCookie(name, value) {
    var Days = 365;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
}
 //读取cookies
 function getCookie(name) {
    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
    if (arr = document.cookie.match(reg)) return unescape(arr[2]);
    else return null;
}
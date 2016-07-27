
//重新为String构造一个方法,去掉前后的空格
String.prototype.C_Trim = function () {
    //  用正则表达式将前后空格
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

//检查数据是否为空，如果为空，则提示相应的内容
String.prototype.C_CheckEmpty = function () {
    if (this.C_Trim().length == 0) {
        return false;
    }
    else {
        return true;
    }
}

//检测一个字符串是否为指定长度的小数
String.prototype.C_CheckDecimal = function (maxDigit) {
    //校验通过
    if (this.C_IsDecimal(maxDigit)) {
        return true;
    }
    else {
        return false;
    }
}

//检测是否为电子邮件
String.prototype.C_Mail = function () {
    var Reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,9}){1,2})$/;
    //var Reg = /^([\w-\.]+)+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]{2})+$/;
    return Reg.test(this);
}

//检测是否为手机号码
String.prototype.C_Mobile = function () {
    var reg = /^(13[0-9]|14[5|7]|15[0-9]|17[0|6|7|8]|18[0-9])\d{8}$/;
    var reg0 = /^13\d{5,9}$/;
    var reg1 = /^15\d{5,9}$/;
    var reg2 = /^0\d{11}$/;
    var reg3 = /^18\d{5,9}$/;

    var my = false;

    if (reg.test(this)) my = true;
    //    if (reg0.test(this)) my = true;
    //    if (reg1.test(this)) my = true;
    //    if (reg2.test(this)) my = true;
    //    if (reg3.test(this)) my = true;

    return my;
}

//检测是否为固定电话号码
String.prototype.C_Telephone = function () {
    var reg0 = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;

    var my = false;
    if (reg0.test(this)) my = true;
    return my;
}

//检测是否为手机或者固定号码
String.prototype.C_Mobile_Tel = function () {
    var reg0 = /^(([0\+]\d{2,3})?(0\d{2,3}))(\d{7,8})(-(\d{3,}))?$/;
    var reg1 = /^(13[0-9]|14[5|7]|15[0-9]|17[6|7|8]|18[0-9])\d{8}$/;
    var my = false;
    if (reg0.test(this) || reg1.test(this)) my = true;
    return my;
}


//检测一个字符串是否为指定长度的小数,不能是负数
String.prototype.C_IsDecimal = function (maxDigit) {
    var Reg = new RegExp("^\\d+(\\.\\d{1," + maxDigit + "})?$", "i");
    return Reg.test(this);
}

//检测是否为英文和字母组成
String.prototype.C_LetterAndNumeric = function () {
    var Reg = /^[A-Za-z0-9]+$/;
    return Reg.test(this);
}

//检测单一个字符串是否为数字
String.prototype.C_IsNumeric = function () {
    var Reg = /^[0-9]+$/;
    return Reg.test(this);
}

//监测一个字符串是否是数值，包含正负数和小数
String.prototype.C_IsNumericEx = function () {
    var Reg = /^(-?\d+)(\.\d+)?$/;
    return Reg.test(this);
}

String.prototype.C_IsPosdInt = function() {
    var Reg = /^\+?[1-9][0-9]*$/;
    return Reg.test(this);
}

//检测字符串是否为有效的数字
String.prototype.C_IsInt = function () {
    // 判断单一字符
    if (this.length == 1) {
        var Reg = /^[0-9]+$/;
        return Reg.test(this);
    }

    var Reg = /^[1-9][0-9]*$/;
    return Reg.test(this);
}

//检测是否为身份证号码
String.prototype.C_IdentityCard = function () {
    var idcard = this;
    var Errors = new Array(
    "True",
    "身份证号码位数不对!",
    "身份证号码出生日期超出范围或含有非法字符!",
    "身份证号码校验错误!",
    "身份证地区非法!"
    );
    var area = { 11: "北京", 12: "天津", 13: "河北", 14: "山西", 15: "内蒙古", 21: "辽宁", 22: "吉林", 23: "黑龙江", 31: "上海", 32: "江苏", 33: "浙江", 34: "安徽", 35: "福建", 36: "江西", 37: "山东", 41: "河南", 42: "湖北", 43: "湖南", 44: "广东", 45: "广西", 46: "海南", 50: "重庆", 51: "四川", 52: "贵州", 53: "云南", 54: "西藏", 61: "陕西", 62: "甘肃", 63: "青海", 64: "宁夏", 65: "新疆", 71: "台湾", 81: "香港", 82: "澳门", 91: "国外" }
    var idcard, Y, JYM;
    var S, M;
    var idcard_array = new Array();
    idcard_array = idcard.split("");
    //地区检验，只检验了省市自治区，没有检验出市县合法性(待完善)
    if (area[parseInt(idcard.substr(0, 2))] == null) return Errors[4];
    //身份号码位数及格式检验 
    switch (idcard.length) {
        case 15:
            if ((parseInt(idcard.substr(6, 2)) + 1900) % 4 == 0 || ((parseInt(idcard.substr(6, 2)) + 1900) % 100 == 0 && (parseInt(idcard.substr(6, 2)) + 1900) % 4 == 0)) {
                ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$/; //测试出生日期的合法性 
            }
            else {
                ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$/; //测试出生日期的合法性 
            }
            if (ereg.test(idcard)) return Errors[0];
            else return Errors[2];
            break;
        case 18:
            //18位身份号码检测 
            //出生日期的合法性检查 
            //闰年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9])) 
            //平年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8])) 
            if (parseInt(idcard.substr(6, 4)) % 4 == 0 || (parseInt(idcard.substr(6, 4)) % 100 == 0 && parseInt(idcard.substr(6, 4)) % 4 == 0)) {
                ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/; //闰年出生日期的合法性正则表达式 
            } else {
                ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/; //平年出生日期的合法性正则表达式 
            }
            if (ereg.test(idcard)) {//测试出生日期的合法性 
                //计算校验位 
                S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7
    + (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9
    + (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10
    + (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5
    + (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8
    + (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4
    + (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2
    + parseInt(idcard_array[7]) * 1
    + parseInt(idcard_array[8]) * 6
    + parseInt(idcard_array[9]) * 3;
                Y = S % 11;
                M = "F";
                JYM = "10X98765432";
                M = JYM.substr(Y, 1); //判断校验位 
                if (M == idcard_array[17]) return Errors[0]; //检测ID的校验位 
                else return Errors[3];
            }
            else return Errors[2];
            break;
        default:
            return Errors[1];
            break;
    }
}

//检测是否为IP地址
String.prototype.C_IPAddress = function () {
    var Reg = /\d+\.\d+\.\d+\.\d+/;
    return Reg.test(this);
}

//检测是否为国内的电话号码
String.prototype.C_ChinesePhone = function () {
    var Reg = /(\(\d{3}\)|\d{3}-)?\d{8}/;
    return Reg.test(this);
}

// 查看是否是全角输入
function IsQuanjiao(obj) {
    var str = obj.value;
    if (str.length > 0) {
        for (var i = str.length - 1; i >= 0; i--) {
            unicode = str.charCodeAt(i);
            if (unicode > 65280 && unicode < 65375) {
                return true;
                obj.value = str.substr(0, i);
            }
        }
    }
}

//根据valid设置文本框的CSS样式
function SetTextBox(obj, valid) {
    if (valid == true)
        obj.className = "TextBox_OK";
    else
        obj.className = "TextBox_No";
    return valid;
}


// 将指定的字符替换成一个新的字符（全部替换）
function strReplace(strOld, strNew) {
    return this.replace(/strOld/ig, strNew)
}

/**
* 将数值四舍五入(保留2位小数)后格式化成金额形式
*
* @param num 数值(Number或者String)
* @return 金额格式的字符串,如'1,234,567.45'
* @type String
* (num/100)可以改保留的位数
*/
function formatCurrency(num) {
    num = num.toString().replace(/\$|\,/g, '');
    if (isNaN(num))
        num = "0";
    var sign = (num == (num = Math.abs(num)));
    num = Math.floor(num * 100 + 0.50000000001);
    var cents = num % 100;
    num = Math.floor(num / 100).toString();
    if (cents < 10)
        cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3) ; i++)
        num = num.substring(0, num.length - (4 * i + 3)) + ',' +
       num.substring(num.length - (4 * i + 3));
    return (((sign) ? '' : '-') + num + '.' + cents);
}


function ChangeDateFormat(str) {
    var date = eval('new ' + str.substr(1, str.length - 2));
    var fmt = "yyyy-MM-dd hh:mm:ss";
    var o = {
        "M+": date.getMonth() + 1, //月份        
        "d+": date.getDate(), //日        
        "h+": date.getHours() == 0 ? 12 : date.getHours(), //小时        
        "H+": date.getHours(), //小时        
        "m+": date.getMinutes(), //分        
        "s+": date.getSeconds(), //秒        
        "q+": Math.floor((date.getMonth() + 3) / 3), //季度        
        "S": date.getMilliseconds() //毫秒        
    };
    var week = {
        "0": "\u65e5",
        "1": "\u4e00",
        "2": "\u4e8c",
        "3": "\u4e09",
        "4": "\u56db",
        "5": "\u4e94",
        "6": "\u516d"
    };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    if (/(E+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "\u661f\u671f" : "\u5468") : "") + week[date.getDay() + ""]);
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
}

/*
功能：过滤不安全字符，用于防SQL注入
说明：1.如果返回true，说明包括不安全字符;否则，不包括。
2.不安全字符有待于进一步完善
*/
function checkstring(scrid) {
    var result = new Boolean(false);
    var str = document.getElementById(scrid).value;
    str = str.replace("－", "-");
    var SQLstring = "'|-|and|exec|insert|select|delete|update|count|%|maste|truncate|declare|<html>|<script>|<a>";
    var splitArray = SQLstring.split("|");
    if (str != "") {
        for (var i = 0; i < splitArray.length; i++) {
            if (str.toLowerCase().search(splitArray[i]) != -1) {
                alert("您填写了不安全字符:[" + splitArray[i].toString() + "]");
                result = true;
                break;
            }
        }
    }
    else {
        alert('填写信息为空，请重新填写!')
        result = true;
    }
    return result;

}

// 获取当前URL参数的值
function Request(strName) {
    var strHref = document.URL.toLowerCase();
    // 判断URL格式
    if (strHref.indexOf("?") == -1 || strHref.indexOf(strName) == -1) {
        return null;
    }

    var intPos = strHref.indexOf("?");
    var strRight = strHref.substr(intPos + 1);

    var arrTmp = strRight.split("&");
    for (var i = 0; i < arrTmp.length; i++) {
        var arrTemp = arrTmp[i].split("=");

        if (arrTemp[0].toUpperCase() == strName.toUpperCase()) return arrTemp[1];
    }
    return "";
}


//js获取cookie
function getCook(sname) {
    // 如果没有COOKIES
    if (document.cookie == "") {
        return "";
    }

    var acookie = document.cookie.split(";");
    //获取单个cookies
    for (var i = 0; i < acookie.length; i++) {
        var arr = acookie[i].split("=");
        if (sname == arr[0].C_Trim()) {
            return arr[1];
        }
    }

    return "";
}

String.prototype.C_IsDate = function () {
    var iaMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var iaDate = new Array(3)
    var year, month, day

    //if (arguments.length != 1) return false
    iaDate = this.toString().split("-")
    if (iaDate.length != 3) return false
    if (iaDate[1].length > 2 || iaDate[2].length > 2) return false

    year = parseFloat(iaDate[0])
    month = parseFloat(iaDate[1])
    day = parseFloat(iaDate[2])

    if (year < 1900 || year > 2100) return false
    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1] = 29;
    if (month < 1 || month > 12) return false
    if (day < 1 || day > iaMonthDays[month - 1]) return false
    return true
}

String.prototype.trim = function () {
    return this.replace(/(^\s*)|(\s*$)/g, "").replace(/(^[&nbsp;]*)|([&nbsp;]*$)/g, "");
}
//---------------------------------------------------  
// 日期格式化  
// 格式 YYYY/yyyy/YY/yy 表示年份  
// MM/M 月份  
// W/w 星期  
// dd/DD/d/D 日期  
// hh/HH/h/H 时间  
// mm/m 分钟  
// ss/SS/s/S 秒  
//---------------------------------------------------  
Date.prototype.format = function (formatStr) {
    var str = formatStr;
    var Week = ['日', '一', '二', '三', '四', '五', '六'];

    str = str.replace(/yyyy|YYYY/, this.getFullYear());
    str = str.replace(/yy|YY/, (this.getYear() % 100) > 9 ? (this.getYear() % 100).toString() : '0' + (this.getYear() % 100));

    str = str.replace(/MM/, this.getMonth() > 9 ? this.getMonth().toString() : '0' + this.getMonth());
    str = str.replace(/M/g, this.getMonth());

    str = str.replace(/w|W/g, Week[this.getDay()]);

    str = str.replace(/dd|DD/, this.getDate() > 9 ? this.getDate().toString() : '0' + this.getDate());
    str = str.replace(/d|D/g, this.getDate());

    str = str.replace(/hh|HH/, this.getHours() > 9 ? this.getHours().toString() : '0' + this.getHours());
    str = str.replace(/h|H/g, this.getHours());
    str = str.replace(/mm/, this.getMinutes() > 9 ? this.getMinutes().toString() : '0' + this.getMinutes());
    str = str.replace(/m/g, this.getMinutes());

    str = str.replace(/ss|SS/, this.getSeconds() > 9 ? this.getSeconds().toString() : '0' + this.getSeconds());
    str = str.replace(/s|S/g, this.getSeconds());

    return str;
}



//+---------------------------------------------------  
//| 日期计算  
//+---------------------------------------------------  
Date.prototype.dateAdd = function (strInterval, Number) {
    var dtTmp = this;
    switch (strInterval) {
        case 's': return new Date(Date.parse(dtTmp) + (1000 * Number));
        case 'n': return new Date(Date.parse(dtTmp) + (60000 * Number));
        case 'h': return new Date(Date.parse(dtTmp) + (3600000 * Number));
        case 'd': return new Date(Date.parse(dtTmp) + (86400000 * Number));
        case 'w': return new Date(Date.parse(dtTmp) + ((86400000 * 7) * Number));
        case 'q': return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number * 3, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
        case 'm': return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
        case 'y': return new Date((dtTmp.getFullYear() + Number), dtTmp.getMonth(), dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
    }
}

//+---------------------------------------------------  
//| 比较日期差 dtEnd 格式为日期型或者有效日期格式字符串  
//+---------------------------------------------------  
Date.prototype.dateDiff = function (strInterval, dtEnd) {
    var dtStart = this;
    if (typeof dtEnd == 'string')//如果是字符串转换为日期型  
    {
        dtEnd = StringToDate(dtEnd);
    }
    switch (strInterval) {
        case 's': return parseInt((dtEnd - dtStart) / 1000);
        case 'n': return parseInt((dtEnd - dtStart) / 60000);
        case 'h': return parseInt((dtEnd - dtStart) / 3600000);
        case 'd': return parseInt((dtEnd - dtStart) / 86400000);
        case 'w': return parseInt((dtEnd - dtStart) / (86400000 * 7));
        case 'm': return (dtEnd.getMonth() + 1) + ((dtEnd.getFullYear() - dtStart.getFullYear()) * 12) - (dtStart.getMonth() + 1);
        case 'y': return dtEnd.getFullYear() - dtStart.getFullYear();
    }
}



//+---------------------------------------------------  
//| 把日期分割成数组  
//+---------------------------------------------------  
Date.prototype.toArray = function () {
    var myDate = this;
    var myArray = Array();
    myArray[0] = myDate.getFullYear();
    myArray[1] = myDate.getMonth();
    myArray[2] = myDate.getDate();
    myArray[3] = myDate.getHours();
    myArray[4] = myDate.getMinutes();
    myArray[5] = myDate.getSeconds();
    return myArray;
}

//+---------------------------------------------------  
//| 取得日期数据信息  
//| 参数 interval 表示数据类型  
//| y 年 m月 d日 w星期 ww周 h时 n分 s秒  
//+---------------------------------------------------  
Date.prototype.datePart = function (interval) {
    var myDate = this;
    var partStr = '';
    var Week = ['日', '一', '二', '三', '四', '五', '六'];
    switch (interval) {
        case 'y': partStr = myDate.getFullYear(); break;
        case 'm': partStr = myDate.getMonth() + 1; break;
        case 'd': partStr = myDate.getDate(); break;
        case 'w': partStr = Week[myDate.getDay()]; break;
        case 'ww': partStr = myDate.weekNumOfYear(); break;
        case 'h': partStr = myDate.getHours(); break;
        case 'n': partStr = myDate.getMinutes(); break;
        case 's': partStr = myDate.getSeconds(); break;
    }
    return partStr;
}

//+---------------------------------------------------  
//| 取得当前日期所在月的最大天数  
//+---------------------------------------------------  
Date.prototype.maxDayOfDate = function () {
    var myDate = this;
    var ary = myDate.toArray();
    var date1 = (new Date(ary[0], ary[1] + 1, 1));
    var date2 = date1.dateAdd(1, 'm', 1);
    var result = dateDiff(date1.Format('yyyy-MM-dd'), date2.Format('yyyy-MM-dd'));
    return result;
}
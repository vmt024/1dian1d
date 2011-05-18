(function($){
    $.fn.validationEngineLanguage = function(){
    };
    $.validationEngineLanguage = {
        newLang: function(){
            $.validationEngineLanguage.allRules = {
                "required": { // Add your regex rules here, you can take telephone as an example
                    "regex": "none",
                    "alertText": "* 此处不能留空",
                    "alertTextCheckboxMultiple": "* 请选择至少一个选项",
                    "alertTextCheckboxe": "* 请选择至少一个选项"
                },
                "minSize": {
                    "regex": "none",
                    "alertText": "* 请至少填写 ",
                    "alertText2": " 个字符"
                },
                "maxSize": {
                    "regex": "none",
                    "alertText": "* 请不要填写多于 ",
                    "alertText2": " 个字符"
                },
                "min": {
                    "regex": "none",
                    "alertText": "* 最小值是 "
                },
                "max": {
                    "regex": "none",
                    "alertText": "* 最大值是 "
                },
                "past": {
                    "regex": "none",
                    "alertText": "* 必须为过去的时间 "
                },
                "future": {
                    "regex": "none",
                    "alertText": "* 必须为未来的时间 "
                },
                "maxCheckbox": {
                    "regex": "none",
                    "alertText": "* 已经选择了过多的选项"
                },
                "minCheckbox": {
                    "regex": "none",
                    "alertText": "* 请至少选择 ",
                    "alertText2": " 个选项"
                },
                "equals": {
                    "regex": "none",
                    "alertText": "* 您填写了不相同密码"
                },
                "phone": {
                    // credit: jquery.h5validate.js / orefalo
                    "regex": /^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/,
                    "alertText": "* 电话号码的格式不正确"
                },
                "email": {
                    // Simplified, was not working in the Iphone browser
                    "regex": /^([A-Za-z0-9_\-\.\'])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,6})$/,
                    "alertText": "* 电子邮件地址的格式不正确"
                },
                "integer": {
                    "regex": /^[\-\+]?\d+$/,
                    "alertText": "* 请填写一个整数"
                },
                "number": {
                    // Number, including positive, negative, and floating decimal. credit: orefalo
                    "regex": /^[\-\+]?(([0-9]+)([\.,]([0-9]+))?|([\.,]([0-9]+))?)$/,
                    "alertText": "* 请填写一个数值"
                },
                "date": {
                    "regex": /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$/,
                    "alertText": "* 请填写正确的日期格式, 例如： 2010-12-25 （年-月-日）"
                },
                "ipv4": {
                    "regex": /^((([01]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))[.]){3}(([0-1]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))$/,
                    "alertText": "* 请填写正确的IP地址，例如： 192.168.1.1"
                },
                "url": {
                    "regex": /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/,
                    "alertText": "* 请输入正确的网络链接"
                },
                "onlyNumberSp": {
                    "regex": /^[0-9\ ]+$/,
                    "alertText": "* 这里只能填写数字"
                },
                "onlyLetterSp": {
                    "regex": /^[a-zA-Z\ \']+$/,
                    "alertText": "* 这里只能填写英文字母"
                },
                "onlyLetterNumber": {
                    "regex": /^[0-9a-zA-Z]+$/,
                    "alertText": "* 这里只能填写英文字母和数字"
                }
            };
            
        }
    };
    $.validationEngineLanguage.newLang();
})(jQuery);

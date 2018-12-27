/* 此方法只会查找所有有设定 type="text" 的input 文本框 基于jQuery + Bootstrap 
chenjun 2017-10-12
*/
$(document).ready(function () {
    var inputs = $("input[type='text']");
    inputs.each(function () {
        //clear: both 去除上一个空间的
        $(this).after("<span class=\"input-text-clearbtn glyphicon glyphicon-remove\" style=\"clear:both; vertical-align:middle;margin-left:-20px;color:#bfbcbc;\"></span>");

    });
    inputs.on("change keyup focusin", function () {
        if ($(this).val().length > 0) {
            $(this).nextUntil("", "span.input-text-clearbtn").show();
        }
        else {
            $(this).nextUntil("", "span.input-text-clearbtn").hide("");
        }
    });
    $(".input-text-clearbtn").on("click", function () {
        var input = $(this).prevUntil("", "input[type='text']")
        if (!input.attr("readonly") && !input.attr("disabled")) {
            input.val("");//清空文本框的值
            $(this).hide();//隐藏X
            input.focus();//让文本框获取焦点
        }
    });
});
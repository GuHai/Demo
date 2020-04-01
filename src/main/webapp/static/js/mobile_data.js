/**
 * Created by Administrator on 2017/9/22.
 */
/**
 * 移动端日历（浏览器打开请F12打开手机模拟器）
 *
 * 本日历可选择单个日期，也可选择两个或多个日期；默认可选单个日期；如需多选；可根据句中注释选择相应；
 * 日历纯手写；未加触摸事件；如需可自行添加，然后将 next() 和 prev() 方法对应相应事件；
 * @param   year,y,nian  年
 * @param   month,m,yue  月
 * @param   day          日
 * @param   td_time      当前时间戳
 * @param   week         本月1号周几
 * @param   days         本月天数
 * @param   dayw         上月天数
 * 好好好先生
 * 2017-9-22
 */
//日历开始
var isinit = false;
$(function () {
    // dateRenderInit();
});

function datt(nian, yue, ri) {

//    计算本月1号是周几；
    var week = new Date(nian + '-'+ (yue<10?'0':'')+ yue + '-01').getDay();

//计算本月有多少天；
    var days = new Date(nian, yue, 0).getDate();
//计算上月有多少天；
    var dayw = new Date(nian, yue - 1, 0).getDate();

//将日历填回页面；拿出节假日
    var html = '';
    for (var i = 1; i <= days; i++) {
        var time = new Date(nian, yue, i).getTime();
        if (yue + '-' + i == '1-1') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '2-14') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '3-8') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '4-1') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '5-1') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '6-1') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '7-1') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '8-1') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '9-10') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '10-1') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '11-11') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '12-24') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else if (yue + '-' + i == '12-25') {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        } else {
            html += "<li data-jr=" + yue + "-" + i + " data-id=" + time + " data-date=" + nian + "-" + yue + "-" + i + "><span>" + i + "</span></li>"
        }
    }
    $('.date ul').html(html);
//获取当前日期的时间戳；
   /* var ym = new Date().getFullYear();
    var mm = new Date().getMonth() + 1;
    var dm = new Date().getDate();
    var td_time = new Date(ym, mm, dm).getTime();*/

// 日历里面时间戳跟当前时间戳比较；大于等于 可点击；小于不可点击；日期默认单选
    var canEdit = $("section[class='date']").eq(0).data("editable") || false;
    for (var k = 0; k < days; k++) {
        var tt_time = $('.date ul li').eq(k).attr('data-id');
        var num = 0;
        //判断是否是周六或周日；添加特殊样式
        var wk = new Date($('.date ul li').eq(k).attr('data-date')).getDay();
        if (wk == 6 || wk == 0) {
            $('.date ul li').eq(k).addClass('act_wk')
        }
        // if (tt_time >= td_time) {
            //判断是否能更改
            if (canEdit) {
                $('.date ul li').eq(k).click(function () {
                    var _this = $(this);
                    //选择开始日期
                    _this.toggleClass('act_date');
                    // _this.siblings('li').removeClass('act_date');
                    var dr = _this.attr('data-date');
                    //抛出点击事件，后面程序如果需要可以监听此事件
                    $('.date').trigger('dateClickEvent', [$(this).hasClass("act_date"), dr]);
                });
            }
        // } else {
        //     $('.date ul li').eq(k).addClass('no_date').removeClass('act_date');
        //
        // }
    }

//计算前面空格键；
    var html2 = '';
    for (var j = dayw - week + 1; j <= dayw; j++) {
        html2 += "<li class='no_date'>" + j + "</li>";
    }
    $('.date ul li').eq(0).before(html2);

//计算后面空格键；
    var html3 = '';
    for (var x = 1; x < 43 - days - week; x++) {
        html3 += "<li class='no_date'>" + x + "</li>";
    }
    $('.date ul li').eq(days + week - 1).after(html3);

    $('.date').trigger('completionEvent');
}

//找出节假日；


//下一月；
function next() {
    var y = $('.year').text();
    var m = $('.month').text();
    if (m == 12) {
        y++;
        m = 1;
    } else {
        m++;
    }
    $('.year').text(y);
    $('.month').text(m);
    datt(y, m, '')
}

//上一月；
function prev() {
    var y = $('.year').text();
    var m = $('.month').text();
    if (m == 1) {
        y--;
        m = 12;
    } else {
        m--;
    }
    $('.year').text(y);
    $('.month').text(m);
    datt(y, m, '')
}


function dateRenderInit(arr) {
    if(isinit==false){
        isinit = true;
        var date = new Date();            //定义一个日期对象；
        var year = date.getFullYear();    //获取当前年份；
        var month = date.getMonth() + 1;    //获取当前月份；
        var day = date.getDate();         //获取当前日期；

        if(arr){
            var flag= false;
            for(var i in arr){
                var date = arr[i];
                if(date.split("-")[0]>=year && date.split("-")[1]>=month && date.split("-")[2]>day){
                    var step = date.split("-")[1] - month;
                    month += step;
                    if(month>12){
                        year++;
                        month =  month%12;
                    }else if(month<0){
                        year --;
                        month = (12+month)%12;
                    }
                    flag = true;
                    break;
                }
            }
            if(flag==false){
                year  = date.split("-")[0];
                month = date.split("-")[1];
            }
        }
        //回填数据
        $('.year').text(year);
        $('.month').text(month);
        datt(year, month, '');
        //下一月；
        $('.next').unbind().click(function () {
            next();
        });

        //上一月；
        $('.prev').unbind().click(function () {
            prev();
        });

        //返回本月；
        $('.tomon').click(function () {
            datt(year, month, '');
            $('.year').text(year);
            $('.month').text(month);
        });
    }
}

//时间类型相关插件
(function ($) {

    $.fn.selectDate = function (arr, color) {
        /*var now = new Date();
        var ym = now.getFullYear();
        var mm = now.getMonth() + 1;
        var dm = now.getDate();
        var td_time = new Date(ym, mm, dm).getTime();*/


        color = color || 'act_date';
        for (index in arr) {
            $(this).find("li[data-date='" + arr[index] + "']").addClass(color);
            /*var timearr = arr[index].split("-");
            var c_time = new Date(timearr[0],timearr[1],timearr[2]).getTime();
            if(c_time<td_time){
                arr.splice(index, 1);
            }*/
        }

    };
    //在原来基础上追加，只能控制以前选过的
    $.fn.containDate = function (arr, arr1, color, color1) {
        color = color || 'act_date';
        color1 = color1 || 'select_date';
        var canEdit = $("section[class='date']").eq(0).data("editable") || false;
        //不管怎么样，移除掉所有事件
        $(".date li").unbind();   //删除空间内的事件
        for (index in arr) {
            $(this).find("li[data-date='" + arr[index] + "']").addClass(color);
            if(canEdit){
                $(this).find("li[data-date='" + arr[index] + "']").click(function (e) {
                    var _this = $(this);
                    //选择开始日期
                    _this.toggleClass(color + ' ' + color1);
                    // _this.siblings('li').removeClass('act_date');
                    var dr = _this.attr('data-date');
                    //抛出点击事件，后面程序如果需要可以监听此事件
                    $('.date').trigger('dateClickEvent', [$(this).hasClass(color1), dr]);
                });
            }

        }

        for (index in arr1) {
            $(this).find("li[data-date='" + arr1[index] + "']").toggleClass(color + ' ' + color1);
        }
    };


    $.fn.remainder=function(arr,edit){
        edit = edit|| false;
        for (index in arr) {
            var num = arr[index].num;
            $(this).find("li[data-date='" + arr[index].date + "']").find("em").remove();
            $(this).find("li[data-date='" + arr[index].date + "']").find("span").after("<em>"+(num>0?(dict.DateDict.Lack+num):dict.DateDict.Full)+"</em>");
            if(edit==false){
                if(num<1){
                    $(this).find("li[data-date='" + arr[index].date + "']").unbind();
                }
            }

        };
    };
})(jQuery);
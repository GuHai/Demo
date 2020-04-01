<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>基础信息</title>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.picker.min.css">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/chooseResume_edit.css?version=4">
    <script src="/ijob/lib/jquery-2.2.3.js"></script>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <script src="/ijob/lib/mui/js/mui.picker.min.js"></script>
    <script src="/ijob/static/js/attachment.js"></script>
    <script src="/ijob/static/js/ijob.js"></script>
    <script src="/ijob/lib/template.js"></script>
    <script src="/ijob/static/js/templateUtils.js"></script>
</head>
<body>
<div class="wrap" id="wrap"></div>

<script type="text/html" id="getResume">
    <div class="main">
        <ul class="selectList">
            <li class="info_avatar">
                <input type="hidden" id="resumeId" name="id" value="{{Resume.id}}">
                <input type="hidden" id="version" name="version" value="{{Resume.version}}">
                <a href="javascript:void(0);">
                    <span class="">头像</span>
                    <span class="info_avatar_img">
                        <img id="myhead" class="attachment" data-name="attachment" data-type="Head"
                             data-id="{{Resume.resumeHeadImg}}"
                             src="/ijob/upload/{{Resume.imgPath}}" alt=""
                             onerror="this.src='{{Resume.imgPath}}';this.onerror=null" >
                    </span>
                </a>
            </li>
            <li class="info_name">
                <a href="javascript:void(0);">
                    <span class="">姓名</span>
                    <span class="info_name_modify" name="resumeName">
                        <input maxlength="5" style="text-align: right;padding-right: 0px;" type="text" id="resumeName"
                               oninput="if(value.length>11)value=value.slice(0,15)"
                               value="{{Resume.resumeName}}" name="resumeName" placeholder="请输入姓名">
                       </span>
                </a>
            </li>
            <%--<li class="info_card">
                <a href="javascript:void(0);">
                    <span class="">身份证号</span>
                    <span class="info_card_modify" name="IDCard" id="IDCard"><shiro:principal
                    property="IDCard" defaultValue=""/></span>
                </a>
            </li>--%>
            <li class="info_gender">
                <a href="javascript:void(0);">
                    <span class="">性别</span>
                    <span class="info_gender_radio">
                        <div class="radios mui-input-row mui-radio mui-left">
                            <input name="sex" id="man" onclick="changeSex(1)" value="1" type="radio"
                                   {{Resume.sex== 1 ? checked='checked' : ''}}><span>男</span>
                        </div>
                        <div class="radios mui-input-row mui-radio mui-left">
                            <input name="sex" id="woman" onclick="changeSex(2)" value="2" type="radio"
                                   {{Resume.sex== 2 ? checked='checked' : ''}}><span>女</span>
                         </div>
                    </span>
                </a>
            </li>
            <li class="info_email">
                <a href="javascript:void(0);">
                    <span class="title">年龄</span>
                    <span class="info_email_input">
                          <input  type="number" name="age" id="age" value="{{Resume.age}}" maxlength="2" placeholder="填写年龄(岁)">
                    </span>
                </a>
            </li>
            <li class="info_email">
                <a href="javascript:void(0);">
                    <span class="title">手机号</span>
                    <span class="info_email_input">
                          <input id="contactNumber"  type="number" value="{{Resume.phoneNumber}}" name="contactNumber" placeholder="填写手机号码" maxlength="11">
                    </span>
                </a>
            </li>
            <%--<li class="info_email">
                <a href="javascript:void(0);">
                    <span class="title">学校</span>
                    <span class="info_email_input">
                          <input id="graschool" style="text-align: right" type="text" name="graschool"
                                 value="{{Resume.educationalList && Resume.educationalList[0].schoolName}}"
                                 placeholder="请填写学校名称" maxlength="20">
                    </span>
                </a>
            </li>--%>
            <li class="title">
                <h3>以下为选填项</h3>
            </li>
            <li class="select-education" id="educationSelect1"
                educationId="{{Resume.educationalList && Resume.educationalList[0].id}}"
                educationVersion="{{Resume.educationalList && Resume.educationalList[0].version}}">
                <a href="javascript:void(0);">
                    <span class="title">学历</span>
                    <input type="hidden" name="educationLeavl" id="education2"
                           value="{{(Resume.educationalList && Resume.educationalList[0].educationLeavl) || 6}}"/>
                    <span class="education1">
                        <span id="xueli">{{(Resume.educationalList && Resume.educationalList[0].education) || '本科'}}</span>
                        <i class="iconfont icon-arrow-right"></i>
                    </span>
                </a>
            </li>
            <li class="info_height">
                <a href="javascript:void(0);">
                    <span class="">身高</span>
                    <span class="info_height_input">
                        <input style="text-align: right" type="number" id="height" name="height"
                               value="{{Resume.height}}" placeholder="请输入身高"
                               oninput="if(value.length>3)value=value.slice(0,3)" onblur="heightAndWeight(this)">cm
                    </span>
                </a>
            </li>
            <li class="info_weight">
                <a href="javascript:void(0);">
                    <span class="">体重</span>
                    <span class="info_weight_input">
                          <input style="text-align: right" type="number" id="weight"
                                 value="{{Resume.weight}}" name="weight" placeholder="请输入体重"
                                 oninput="if(value.length>3)value=value.slice(0,3)" onblur="heightAndWeight(this)">kg
                    </span>
                </a>
            </li>
            <%--<li class="info_marriage" id="marriagepicker">
                <a href="javascript:void(0);">
                    <span class="">婚姻状况</span>
                    <span class="info_marriage_sel">
                        <span id="marriage" marriage="{{Resume.marriage}}">
                            {{if Resume.marriage == 2}}
                                已婚未育
                            {{else if Resume.marriage == 3}}
                                已婚已育
                            {{else}}
                                未婚
                            {{/if}}
                        </span>
                        <i class="iconfont icon-arrow-right"></i>
                    </span>
                </a>
            </li>
            <li class="info_weight">
                <a href="javascript:void(0)">
                    <span class="">手机号</span>
                    <span class="info_weight_input">
                        <input style="text-align: right;padding-right: 0px;" type="number" id="phoneNumber"
                               oninput="if(value.length>11)value=value.slice(0,11)"
                               value="{{Resume.phoneNumber}}" name="phoneNumber" placeholder="请输入手机号码">
                    </span>
                </a>
            </li>
            <li class="info_email">
                <a href="javascript:void(0);">
                    <span class="">邮箱</span>
                    <span class="info_email_input">
                          <input style="text-align: right" type="email"
                                 pattern="^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$" id="email"
                                 name="email" value="{{Resume.email}}" placeholder="请输入邮箱">
                    </span>
                </a>
            </li>
            <li class="info_email">
                <a href="javascript:void(0);">
                    <span class="">现居住地</span>
                    <span class="info_email_input">
                          <input style="text-align: right" type="text" id="residence" name="residence"
                                 value="{{Resume.residence}}" placeholder="请输入现居地址" maxlength="20">
                    </span>
                </a>
            </li>--%>
        </ul>
    </div>
    <div class="save" onclick="saveResumeInfo()" data-url="/ijob/api/ResumeController/add">
        保存
    </div>
</script>
<div id="homepage"></div>
</body>
</html>

<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    function heightAndWeight(arg){
        var temp = arg.value + "";
        var tempArr = temp.split(".");
        if(tempArr.length>1){
            arg.value = tempArr[0] + tempArr[1].slice(0,2);
        }
    }

    //选择学历
    //学历 1,小学,2,初中,3,高中,4,中专,5,大专,6,本科,7,研究生,8博士
    var picker1 = new mui.PopPicker();
    picker1.setData([{
        text: '小学',
        value: '1'
    }, {
        text: '初中',
        value: '2'
    }, {
        text: '高中',
        value: '3'
    }, {
        text: '中专',
        value: '4'
    }, {
        text: '大专',
        value: '5'
    }, {
        text: '本科',
        value: '6'
    }, {
        text: '研究生',
        value: '7'
    }, {
        text: '博士',
        value: '8'
    }]);
    var schoolLevel = 6 ;
    $(document).on('tap', "#educationSelect1", function (event) {
        picker1.show(function (items) {
            $("#xueli").html(items[0].text);
            $("#education1").val(items[0].value);
            $("#education2").val(items[0].value);
            schoolLevel = items[0].value;
            //返回 false 可以阻止选择框的关闭
            //return false;
        });
    });


    //默认没有更改图片，用来判断是否删除 attachment 属性，没更图片不需要 attachment 属性
    var flag = true;
    //图片，主要为了缓存到session中，看是否改变，如果没改变会报错
    var tempAttachment;

    $(function () {
        //初始化
        var tempResume;
        //渲染
        if (ijob.storage.get("Resume.id") == 0) {
            tempResume = {};
        } else {
            // Ajax 请求渲染
            $.ajax({
                url: "/ijob/api/ResumeController/get/" + ijob.storage.get("Resume.id"),
                type: "POST",
                async:false,
                dataType: "json",
                data: {"pageSize": "10", "currentPage": "1"},
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (result) {
                    if (result.code == '200') {
                        tempResume = result.data;
                    } else {
                        tempResume = {};
                    }
                }
            });
        }

        //template 渲染
        var data = {
            Resume: tempResume
        };
        var html = template("getResume", data);
        document.getElementById('wrap').innerHTML = html;


        if (tempResume.attachment && tempResume.attachment.absolutelyPath != 'null\\null\\null') {
            $("#myhead").prop("src", "/ijob/upload/" + template.absolutelyPath(tempResume.attachment));
        } else {
            $("#myhead").prop("src", ijob.storage.get('userHeadImg'));
        }


        //姓名
        if (!$("#resumeName").val()) {
            if ('<shiro:principal property="realName" defaultValue=""/>' != 'null') {
                $("#resumeName").val('<shiro:principal property="realName" defaultValue=""/>');
            }
        }

        //电话号码
        if (!$("#phoneNumber").val()) {
            $("#phoneNumber").val('<shiro:principal property="phoneNumber" defaultValue=""/>');
        }
        tempAttachment = tempResume.attachment;




    });

    //    $.init();
    var picker = new mui.PopPicker();
    picker.setData([{
        text: '未婚',
        value: '1'
    }, {
        text: '已婚未育',
        value: '2'
    }, {
        text: '已婚已育',
        value: '3'
    }]);
    $(document).on('tap', "#marriagepicker", function (event) {
        picker.show(function (items) {
            $("#marriage").html(items[0].text);
            $("#marriage").attr("marriage",items[0].value);
            //返回 false 可以阻止选择框的关闭
            //return false;
        });
    });


    function changeSex(sex) {
        if (sex == 1) {
            $("#woman").removeAttr("checked");
        } else {
            $("#man").removeAttr("checked");
        }
    }


    function saveResumeInfo() {
        var phoneReg = /^[1][3,4,5,6,7,8,9][0-9]{9}$/;
        if (!$.trim($("#resumeName").val())) {
            mui.alert("请输入姓名");
        }
        /*else if (!$("input[name='sex']:checked").val()) {
            mui.alert("请选择性别");
        } */
        /*else if (!$("#graschool").val()) {
            mui.alert("请填写学校");
        }*//* else if (!$("#education2").val()) {
            mui.alert("请选择学历");
        } */else if ($("#age").val() == null ||$("#age").val() ==""){
            mui.alert("填写年龄");
        }else if ($("#contactNumber").val() == null ||$("#contactNumber").val() ==""){
            mui.alert("请输入手机号码");
        }else if(!phoneReg.test($("#contactNumber").val())){
            mui.alert('手机号码格式错误！');
        }else if($('#contactNumber').val().length != 11) {
            mui.alert('手机号码不能小于或大于11位数！');
        }else {
            var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
            var isok = true;
            if ($("#email").val()) {
                isok = reg.test($("#email").val());
            }
            reg = /^[1][3,4,5,7,8,9][0-9]{9}$/;
            var isPhoneNumber = reg.test($("#phoneNumber").val());
            if (!isok) {
                mui.alert("邮箱格式不正确，请重新输入！");
                $("#email").val("")
            }
            /*else if (!isPhoneNumber) {
                mui.alert("手机号码格式不正确，请重新输入！");
                $("#phoneNumber").val("");
            } */
            else {
                var resume = {
                    "id": $("#resumeId").val(),
                    "version": $("#version").val(),
                    "resumeTitle": $.trim($("#resumeName").val()) + '的简历',
                    "resumeName": $.trim($("#resumeName").val()),
                    "sex": $("input[name='sex']:checked").val(),
                    "age":$("#age").val(),
                    "height": $("#height").val(),
                    "weight": $("#weight").val(),
                    "marriage": $("#marriage").attr("marriage"),
                    "email": $("#email").val(),
                    "residence": $("#residence").val(),
                    "phoneNumber":$("#contactNumber").val(),
                    "schoolLevel":schoolLevel,
                    // "deleted": false,
                    "isDefault": true,
                    "educationalList": [{
                        "id":$('#educationSelect1').attr('educationId') || undefined,
                        "version":$('#educationSelect1').attr('educationVersion') || undefined,
                        "educationLeavl": $("#education2").val(),
                        "education": $("#xueli").text(),
                        "schoolName": $("#graschool").val(),
                        "isDeleted": false
                    }],
                    "attachment": {
                        "datestr": $("input[name='attachment.datestr']").val(),
                        "path": $("input[name='attachment.path']").val(),
                        "name": $("input[name='attachment.name']").val(),
                        "type": $("input[name='attachment.type']").val(),
                        "version": $("input[name='attachment.version']").val(),
                        "id": $("input[name='attachment.id']").val(),
                        "deleted": $("input[name='attachment.isDeleted']").val()
                    }
                };

                if ($("#resumeId").val()) {
                    //后台会自动修改，不会把空的 attachment 赋值到里面去
                    if (flag) {
                        delete resume.attachment;
                    }
                    $(".save").data("url", "/ijob/api/ResumeController/update");
                    $(".save").btPost(resume, function (data) {
                        if (data.code == 200) {
                            history.go(-1);
                        }else if(data.code == 401){
                            mui.alert(data.msg);
                        } else {
                            mui.alert("修改失败！");
                        }
                    });
                } else {
                    //如果没上传图片就用原来的
                    if (flag) {
                        resume.attachment = tempAttachment;
                    }
                    $(".save").btPost(resume, function (data) {
                        if (data.code == 200) {
                            history.go(-1);
                        }else if(data.code == 401){
                            mui.alert(data.msg);
                        } else {
                            mui.alert("添加失败！");
                        }
                    });
                }
            }
        }
    }


</script>
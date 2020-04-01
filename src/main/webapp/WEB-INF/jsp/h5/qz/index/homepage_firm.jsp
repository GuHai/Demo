<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>${OtherUserInfomation.workNumber==null?'工作号':OtherUserInfomation.workNumber}</title>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/index/homepage_firm.css?version=4">
    <link rel="stylesheet" href="/ijob/css/mine/chooseResume_add.css">
    <script src="/ijob/lib/jquery-2.2.3.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/static/js/ijob.js"></script>
    <script src="/ijob/static/js/dict.js"></script>
    <script src="/ijob/static/js/attachment.js"></script>
    <script type='text/javascript' src='/ijob/static/js/slide.js'></script>
    <script src="/ijob/static/js/ijobbase.js"></script>
    <style>
        .QR{
            font-size: 0.6rem!important;
            bottom: 0.8rem;
            right: 0.5rem;
            position: absolute;
            color: #fff!important;
            text-shadow: 0px 1px 0px #666
        }
    </style>
    <script>
        (function ($) {
            window.addEventListener('pageshow', function (e) {
                // 通过persisted属性判断是否存在 BF Cache
                if (e.persisted) {
                    location.reload();
                }
            });
        })(mui);
    </script>
</head>
<body>
<div class="wrap">
    <div class="cut_bg">
        <c:if test="${editInformation==true}">
            <c:if test="${OtherUserInfomation!=null}">
                <div class="pic_box">
                    <img id="myhead" class="attachment" data-name="bgp" data-type="Head"
                         data-id="${OtherUserInfomation.bgpID}"
                         src="/ijob/upload/${OtherUserInfomation.bgp.absolutelyPath}" alt=""
                         onerror="this.src='/ijob/static/images/workslide.png';this.onerror=null">
                    <div class="linear-gradient">
                        <div class="follow">
                            <a onclick="ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/toQrcode'})" >
                                <span class="iconfont icon-erweima"></span>
                            </a>
                        </div>
                    </div>
                    <c:if test="${editInformation!=null&&MyManagerWorkList!=null}">
                        <div class="switch-content-box">
                            <a href="javascript:void(0);" class="switch-btns" onClick="toswitch()">切换工作号
                                <span class="icon">
                                    <em></em>
                                    <i></i>
                                </span>
                               <%-- <span class="arrow-1"><em></em><i></i></span>
                                <span class="arrow-2"><em></em><i></i></span>--%>
                            </a>
                        </div>
                    </c:if>
                </div>
            </c:if>
            <c:if test="${OtherUserInfomation==null}">
                <div class="pic_box">
                    <img id="myhead" class="attachment" data-name="bgp" data-type="Head"
                         data-id="${WorkNumberSchool.background}"
                         src="/ijob/upload/${WorkNumberSchool.bgImage.getAbsolutelyPath()}" alt=""
                         onerror="this.src='/ijob/static/images/workslide.png';this.onerror=null">
                    <div class="linear-gradient">
                        <a onclick="ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/toQrcode',data:{id:'${WorkNumberSchool.id}'}})"><span class="iconfont icon-erweima"></span></a>
                    </div>
                    <c:if test="${editInformation!=null&&MyManagerWorkList!=null}">
                        <div class="switch-content-box">
                            <a href="javascript:void(0);" class="switch-btns" onClick="toswitch()">切换工作号
                                <span class="icon">
                                    <em></em>
                                    <i></i>
                                </span>
                                    <%-- <span class="arrow-1"><em></em><i></i></span>
                                     <span class="arrow-2"><em></em><i></i></span>--%>
                            </a>
                        </div>
                    </c:if>
                </div>
            </c:if>
            <div class="btns"><a href="javascript:void(0);" onclick="changePicHandler();">点击更换背景<i
                    class="iconfont icon-arrow-right"></i></a></div>
        </c:if>
        <c:if test="${editInformation==null}">
            <div class="pic_box">
                <c:if test="${OtherUserInfomation!=null}">
                <img src="/ijob/upload/${OtherUserInfomation.bgp.absolutelyPath}"
                     onerror="this.src='/ijob/static/images/workslide.png';this.onerror=null">
                </c:if>
                <c:if test="${OtherUserInfomation==null}">
                    <img src="/ijob/upload/${WorkNumberSchool.bgImage.getAbsolutelyPath()}"
                         onerror="this.src='/ijob/static/images/workslide.png';this.onerror=null">
                </c:if>
                <div class="linear-gradient">
                    <div class="follow"><%--al_follow 已关注--%>
                        <c:if test="${isAttention==true}">
                            <a href="javascript:void(0)" data-url="/ijob/api/InformationController/isAttention/${id}/delete" onclick="isAttention(this)" class="btns al_btns">已关注</a>
                        </c:if>
                        <c:if test="${isAttention!=true}">
                            <a href="javascript:void(0)" data-url="/ijob/api/InformationController/isAttention/${id}/add" onclick="isAttention(this)" class="btns">关注</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:if>
        <%--个人信息--%>
        <div class="perInform" style="width: 70%" >
            <div class="box-area">
                <div class="photo">
                    <c:if test="${OtherUserInfomation!=null}">
                        <img class="pic_toux" src="${OtherUser.imgPath}" onerror="this.src='${OtherUserInfomation.weixinHeadImgUrl}'"
                             alt=""/>
                    </c:if>
                    <c:if test="${OtherUserInfomation==null}">
                        <img class="pic_toux" src="/ijob/upload/${WorkNumberSchool.hdImage.getAbsolutelyPath()}" onerror="this.src='/ijob/static/images/workslide.png'"
                             alt="">
                    </c:if>
                </div>
                <div class="list-item">
                    <%--<div class="name">
                        <c:if test="${OtherUserInfomation!=null}">
                            ${(OtherUserInfomation.workNumber==null?'无工作号':OtherUserInfomation.workNumber)==''?'无工作号':(OtherUserInfomation.workNumber==null?'无工作号':OtherUserInfomation.workNumber)}
                        </c:if>
                        <c:if test="${OtherUserInfomation==null}">
                            ${WorkNumberSchool.name}
                        </c:if>
                    </div>--%>

                    <div class="count">
                        <div class="left">
                            <div class="name">
                                <c:if test="${OtherUserInfomation!=null}">
                                    ${(OtherUserInfomation.workNumber==null?'无工作号':OtherUserInfomation.workNumber)==''?'无工作号':(OtherUserInfomation.workNumber==null?'无工作号':OtherUserInfomation.workNumber)}
                                </c:if>
                                <c:if test="${OtherUserInfomation==null}">
                                    ${WorkNumberSchool.name}
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="count">
                        <div class="left">
                            <c:if test="${OtherUserInfomation!=null}">
                                ${OtherUser.realName==null?OtherUser.nickName:OtherUser.realName}
                            </c:if>
                            <a href="javascript:void(0);" onclick="ijob.storage.set('workID','${OrtherID}');ijob.gotoPage({path:'/h5/qz/mine/myFans'})"><span><span class="iconfont icon-ziyuan"></span><i>${attentionCount}</i></span></a>
                            <c:if test="${OtherUserInfomation==null}">
                                <a href="javascript:void(0);" onclick="ijob.storage.set('workID','${WorkNumberSchool.id}');ijob.gotoPage({path:'/h5/qz/myjob/history_job'})"><span class="margt"><span class="iconfont icon-jianzhi1"></span> <i>${historyPositionSize}</i></span></a>
                            </c:if>
                            <c:if test="${OtherUserInfomation!=null}">
                                <a href="javascript:void(0);" onclick="ijob.storage.set('userID','${OrtherID}');ijob.gotoPage({path:'/h5/qz/myjob/history_job'})"><span class="margt"><span class="iconfont icon-jianzhi1"></span> <i>${historyPositionSize}</i></span></a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="synopsis-box">
        <c:if test="${OtherUserInfomation==null}">
            <div class="abstract"<c:if test="${WorkNumberSchool.brief!=null}"> onclick="ijob.storage.set('edit','${editInformation}');ijob.storage.set('workNumberID','${WorkNumberSchool.id}');ijob.gotoPage({path:'/h5/qz/index/SubmitIntroduction'})"</c:if>>
                <c:if test="${WorkNumberSchool.brief==null}">
                    <c:if test="${editInformation==null}">
                        他暂未填写简介哦~
                    </c:if>
                    <c:if test="${editInformation==true}">
                        请填写简介
                    </c:if>
                </c:if>
                <c:if test="${WorkNumberSchool.brief!=null}">
                    ${WorkNumberSchool.brief}
                </c:if>
            </div>
        </c:if>
        <c:if test="${OtherUserInfomation!=null}">
            <div class="abstract"<c:if test="${OtherUserInfomation.brief!=null}"> onclick="ijob.storage.set('edit','${editInformation}');ijob.gotoPage({path:'/h5/qz/index/SubmitIntroduction'})"</c:if>>
                <c:if test="${OtherUserInfomation.brief!=null}">
                    ${OtherUserInfomation.brief}
                </c:if>
                <c:if test="${OtherUserInfomation.brief==null}">
                    <c:if test="${editInformation==null}">
                        他暂未填写简介哦~
                    </c:if>
                    <c:if test="${editInformation==true}">
                        请填写简介
                    </c:if>
                </c:if>
            </div>
        </c:if>
    </div>
    <div class="audited-box">
        <c:if test="${DSHPositionSize!=0&&OtherUserInfomation==null&&editInformation==true}">
            <a href="javascript:void(0);" onclick="ijob.storage.set('workID','${WorkNumberSchool.id}');ijob.gotoPage({path:'/h5/qz/myjob/check_pending'})"><i>${DSHPositionSize}</i>个职位待审核<span class="iconfont icon-arrow-right"></span></a>
        </c:if>
    </div>
    <%--<div class="contentBox">
        <img class="pic_toux" src="${OtherUser.imgPath}" onerror="this.src='${OtherUserInfomation.weixinHeadImgUrl}'"
             alt="">
        <div class="contentRight">
            <div class="con_div1">
                <div class="l_flex">
                    <span>工作号：</span>
                    <span>${OtherUserInfomation.workNumber==null?'':OtherUserInfomation.workNumber}</span>
                </div>
                <div class="r_flex">
                    <span>粉丝:${attentionCount}</span>
                </div>
            </div>
            <div class="con_div2">
                公司名：${OtherUserEnterpriseauthen.enterpriseName}
            </div>
            <p class="con_p">管理员：${OtherUserEnterpriseauthen.adminName}</p>
            <c:if test="${editInformation==true}">
                <div class="edit_btns">
                    编辑
                </div>
            </c:if>
            <c:if test="${editInformation==null}">
                <div class="con_div3" id="follow" data-url="/ijob/api/AttentionController/update">
                    <c:choose>
                        <c:when test="${isAttention}">
                            已关注
                        </c:when>
                        <c:otherwise>
                            关注
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>
    </div>--%>
    <%--<ul class="tabList">
        <li><span class="active">招聘</span></li>
        <li><span>简介</span></li>
    </ul>--%>

    <div class="tabContent">
        <div class="tab_job">
            <c:if test="${empty OtherUserPosition}">
                <div class="list-container">
                    <p class="con_p" style="text-align: center;padding-bottom: 0.267rem;"> 暂未发布其他职位信息</p>
                </div>
            </c:if>
            <c:forEach items="${OtherUserPosition}" var="position">
                <div class="list-container">
                <c:choose>
                    <c:when test="${position.userID != OtherUser.id}">
                        <div class="boxlist"
                             onclick="ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.forwardUser=${OtherUser.id}&data.position.id=${position.id}&shareObj.title=${position.title}&shareObj.salary=${position.dailySalary}&shareObj.city=${position.workPlace.city.cityName}'})">
                    </c:when>
                    <c:otherwise>
                        <div class="boxlist"
                             onclick="ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.position.id=${position.id}&shareObj.title=${position.title}&shareObj.salary=${position.dailySalary}&shareObj.city=${position.workPlace.city.cityName}'})">
                    </c:otherwise>
                </c:choose>
                            <div class="list-title">
                                <span class="title-content">
                                    <c:choose>
                                        <c:when test="${position.userID != OtherUser.id}">
                                            <span class="forwardName">转</span>
                                        </c:when>
                                    </c:choose>
                                    ${position.title}
                                </span>
                                <span class="titel-note"></span>
                            </div>
                            <div class="list-content">
                                <div class="content-tit" style="background-color: ${position.huntingtype.codeGrade}"
                                     id="workTypeColor">${position.huntingtype != null ? position.huntingtype.name: "其他"}</div>
                                <div class="content-msg">
                                    <div class="content-msg1">
                                    <span class="content-msg1-lf"><i
                                            class="iconfont icon-shizhong"></i><fmt:formatDate
                                            value="${position.recruitStartTime}" pattern="MM月dd日"/> - <fmt:formatDate
                                            value="${position.recruitEndTime}" pattern="MM月dd日"/></span>
                                        <span class="content-msg1-rt"><fmt:formatNumber type="number"
                                                                                        value="${position.dailySalary}"
                                                                                        maxFractionDigits="0"/>元/天</span>
                                    </div>
                                    <div class="content-msg2">
                                    <span class="content-msg2-lf">
                                        <c:choose>
                                            <c:when test="${position.sexRequirements == 3}">
                                                只限女生
                                            </c:when>
                                            <c:when test="${position.sexRequirements == 1}">
                                                只限男生
                                            </c:when>
                                            <c:when test="${position.sexRequirements == 2}">
                                                男女不限
                                            </c:when>
                                            <c:when test="${position.sexRequirements == null}">
                                                男女不限
                                            </c:when>
                                        </c:choose>
                                        &nbsp;<span
                                            class="line"></span>&nbsp;<%--${position.beenRecruitedSum}/--%>${position.personNumDay}人/天</span>
                                        <span class="content-msg2-rt">
                                    <c:choose>
                                        <c:when test="${position.settlement == 1}">
                                            日结
                                        </c:when>
                                        <c:when test="${position.settlement == 2}">
                                            周结
                                        </c:when>
                                        <c:when test="${position.settlement == 3}">
                                            月结
                                        </c:when>
                                        <c:when test="${position.settlement == 4}">
                                            完工结算
                                        </c:when>
                                    </c:choose>
                                </span>
                                    </div>
                                    <div class="content-msg3">
                                        <span class="content-msg3-lf">${position.workPlace == null ? '未知':position.workPlace.city.cityName}&nbsp; ${position.workPlace.distance}km</span>
                                        <c:choose>
                                            <c:when test="${position.userID == OtherUser.id}">
                                                <span class="content-msg3-rt">${OtherUserInfomation.workNumber!=null?OtherUserInfomation.workNumber:OtherUser.nickName}</span>
                                            </c:when>
                                            <c:when test="${position.userID != OtherUser.id}">
                                                <span class="content-msg3-rt">${position.publish.workNumber!=null?position.publish.workNumber:'无工作号'}</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="list-share">
                            <form id="${position.id}" style="display: none">
                                <input type="hidden" name="title" value="${position.title}">
                                <c:choose>
                                    <c:when test="${position.forwardID != null}">
                                        <input type="hidden" name="id" value="${position.forwardID}-">
                                    </c:when>
                                    <c:when test="${position.forwardID == null}">
                                        <input type="hidden" name="id" value="${position.id}">
                                    </c:when>
                                </c:choose>
                                <input type="hidden" name="date" value="<fmt:formatDate value="${position.recruitStartTime}" pattern="MM月dd日"/>-<fmt:formatDate value="${position.recruitEndTime}" pattern="MM月dd日"/>">
                                <input type="hidden" name="salary" value="${position.dailySalary}">
                                <input type="hidden" name="city" value="${position.workPlace.city.cityName}">
                                <input type="hidden" name="name" value="${position.huntingtype.name}">
                                <input type="hidden" name="shareUser" value="<shiro:principal property="id"/>">
                            </form>
                            <c:choose>
                                <c:when test="${position.hasRedPacketForward != null||position.hasRedPacket != null}">
                                    <div class="title envelopes">分享职位和同学一起瓜分红包</div><%--envelopes有红包显示，没有显示内容为“喊上同学一起做兼职”--%>
                                </c:when>
                                <c:when test="${position.hasRedPacketForward == null&&position.hasRedPacket == null}">
                                    <div class="title envelopes" style="color: #999;">喊上同学一起做兼职</div><%--envelopes有红包显示，没有显示内容为“喊上同学一起做兼职”--%>
                                </c:when>
                            </c:choose>
                            <div class="btns"><a href="javascript:void(0);" class="share" data-index="${position.id}" ><span class="iconfont icon-fenxiang"></span>&nbsp;分享</a></div>
                        </div>

                </div>
            </c:forEach>
            <div style="clear: both;content: '';height: 1.8rem;"></div>
            <c:if test="${editInformation != true}">
                <div class="footer_fixed">
                    <a href="javascript:void(0);">
                        <div class="btn"
                             onclick="toChat({userID:'${userID}',toUserID:'${OtherUser.id}'})">咨询
                        </div>
                    </a>
                </div>
            </c:if>
        </div>
        <div class="tab_js">
            <div class="text_resume">
                <c:if test="${editInformation==true}">
                    <textarea class="textarea" id="brief" onfocus="if(value.trim()=='请填写简介……'){value=''}" onblur="if (value.trim() ==''){value='请填写简介……'}"><c:if test="${OtherUserInfomation.brief == null || OtherUserInfomation.brief == ''}">请填写简介……</c:if>${OtherUserInfomation.brief}</textarea>
                    <div class="private_footer_fixed">
                        <a href="javascript:void(0);">
                            <div class="btn" onclick="saveBirf(this)" data-id="${OtherUserInfomation.id}"
                                 data-version="${OtherUserInfomation.version}"
                                 data-url="/ijob/api/InformationController/update">保存
                            </div>
                        </a>
                    </div>
                </c:if>
                <c:if test="${editInformation==null}">
                    ${OtherUserInfomation.brief}
                </c:if>
            </div>
            <%--<div class="tab_js_img">
                <p>营业执照</p>
                <img class="pic_yingye" onerror="this.src='/ijob/static/images/banner1@2x.png';this.onerror=null"
                     src="/ijob/upload/${OtherUserEnterpriseauthen.yyAttachment.absolutelyPath}"
                     data-id="${OtherUserEnterpriseauthen.licenseTreatment}" alt="">
            </div>
            <div class="clearfix" style="height: 1.12rem;clear: both;content: '';"></div>--%>
        </div>
    </div>
    <%--<div class="footer_fixed">--%>
    <%--<a href="javascript:void(0);"><div class="btn" onclick="ijob.gotoPage({path:'/h5/information/chat?touser.id=${OtherUser.id}'})">咨询</div></a>--%>
    <%--</div>--%>
    <%--分享--%>
    <div class="share-content" style="display: none">
        <div class="popup-backdrop">
            <div class="descript"><span class="rotate"><span class="iconfont icon-dianji1"></span></span>点击进行分享</div>
            <div class="arrowhead">
                <img src="/ijob/static/images/arrowhead.png"/>
            </div>
            <%--<div class="posi">
                <p>好友通过你的分享做此兼职</p>
                <p>你可以获得<span>1元/小时</span>的提成</p>
            </div>--%>
        </div>
    </div>
    <%--切换工作号--%>

    <div class="switch-popup-backdrop">
        <div class="switch-content-box">
            <a href="javascript:void(0);" class="switch-btns switch_btn">
                切换工作号
                <span class="icon"><em></em><i></i></span>
            </a>
        </div>
        <div class="switch-box">
            <%--<div class="work-list">
                <p class="txt">当前</p>
                <div class="name curr">长沙大学</div>&lt;%&ndash;curr当前选择的工作号&ndash;%&gt;
            </div>--%>
            <div class="work-list">
                <p class="txt">我的工作号</p>
                <c:if test="${OtherUserInfomation == null}">
                    <div class="name shcoolWork" data-id="${myInfo.userID}">
                        ${(myInfo.workNumber==null?OtherUser.nickName:myInfo.workNumber)==''?OtherUser.nickName:(myInfo.workNumber==null?OtherUser.nickName:myInfo.workNumber)}
                    </div>
                </c:if>
                <c:if test="${OtherUserInfomation != null}">
                    <div class="name curr" data-id="${myInfo.userID}">
                        ${(OtherUserInfomation.workNumber==null?OtherUser.nickName:OtherUserInfomation.workNumber)==''?OtherUser.nickName:(OtherUserInfomation.workNumber==null?OtherUser.nickName:OtherUserInfomation.workNumber)}
                    </div>
                </c:if>
            </div>
            <div class="work-list">
                <p class="txt">我管理的工作号</p>
                <c:forEach items="${MyManagerWorkList}" var="workNumber">
                    <c:if test="${OrtherID == workNumber.id}">
                        <div class="name curr" data-id="${workNumber.id}">${workNumber.name}</div>
                    </c:if>
                    <c:if test="${OrtherID != workNumber.id}">
                        <div class="name shcoolWork" data-id="${workNumber.id}">${workNumber.name}</div>
                    </c:if>
                </c:forEach>
                <%--<div class="name border-bottom curr">长沙大学</div>&lt;%&ndash;border-bottom 管理多个公众号&ndash;%&gt;
                <div class="name">涉外经济学院</div>--%>
            </div>
            <div class="tips">没有更多工作号了哦~</div>
        </div>
    </div>

     <%--返回首页--%>
    <div id="homepage"></div>
</div>
</div>
</body>
</html>
<%--<script src="/ijob/lib/jquery-2.2.3.js"></script>--%>
<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
<script>
    function toChat(obj) {
        if(!obj.toUserID){
            mui.toast("对象不存在");
        }else{
            var chat = ijob.storage.get("chat")||{};
            chat.toUserID = obj.toUserID;
            chat.positionName = obj.positionName;
            chat.positionID = obj.positionID;
            ijob.storage.set("chat",chat);
            ijob.gotoPage({path:'/h5/information/chat'});
        }
    }



    ijob.storage.set('brief',"\""+$(".abstract").text()+"\"");
    $(".shcoolWork").click(function(){
        if('${OrtherID}' != $(this).data("id")){
            ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/'+ijob.location.get().lng+'/'+ijob.location.get().lat+'/'+$(this).data("id") });
        }
    })
    $("#homepage").freshPage({path:"/h5/homepage"});
    ijobbase.checkSubscribe();
    // $(".tab_job span[name='salary']").each(function(i,item){
    //     var salary =$(item).text();
    //     var money = salary.substring(0,salary.indexOf('.'));
    //     $(item).text(money+"元/天");
    // });
    var slide = null;
    // 分享
    $("body").on('click','.share',function(){
        $(".share-content").show();
        slide = new Slide($(".wrap"),$(".share-content"),".popup-backdrop");
        slide.disTouch();
        console.log($("#"+$(this).data("index")).serializeObjectJson());
        initShare($("#"+$(this).data("index")).serializeObjectJson());
    });
    // 点击空白处隐藏选项
    $("body>*").on('click', function (e) {
        if ($(e.target).hasClass('share-content')) {
            $(".share-content").hide();
            slide.ableTouch();
        }
    });
    $(".share_content .cancel a").click(function () {
        $(".share_content").hide();
        slide.ableTouch();
    });

    /*切换工作号*/
    $("body>*").on('click', function (e) {
        if ($(e.target).hasClass('switch-popup-backdrop')) {
            $(".switch-popup-backdrop").removeClass("modal-active");
            $(".switchbg").remove();
        }
    });
    function toswitch(){
        $(".switch-popup-backdrop").addClass("modal-active");
        if($(".switchbg").length>0){
            $(".switchbg").addClass("switchbg-active");
        }else{
            $("body").append('<div class="switchbg"></div>');
            $(".switchbg").addClass("switchbg-active");
        }
        $(".switch_btn").click(function(){
            $(".switch-popup-backdrop").removeClass("modal-active");
            setTimeout(function(){
                $(".switchbg-active").removeClass("switchbg-active");
                $(".switchbg").remove();
            },300);
        })
    }
    function initShare(shareObj){
        var title= "【I Job兼职】"+shareObj.title;
        var desc="待遇："+shareObj.salary+"元/天"+"\n"+"地点："+shareObj.city+"\n时间："+shareObj.date;
        // var link="http://www.jianzhipt.cn";
        var link="${site}/share/PD/"+shareObj.id + "/" + shareObj.shareUser;
        var tempType = shareObj.name;;
        var imgUrl="";
        if(tempType=="保安"||tempType=="代理"||tempType=="帮工"||tempType=="调研"){
            imgUrl="${site}/static/images/shareLogo1.png";
        }else if(tempType=="分拣"||tempType=="打包"||tempType=="盘点员"){
            imgUrl="${site}/static/images/shareLogo2.png";
        }else if(tempType=="服务员"||tempType=="送餐员"){
            imgUrl="${site}/static/images/shareLogo3.png";
        }else if(tempType=="话务员"||tempType=="推广"){
            imgUrl="${site}/static/images/shareLogo4.png";
        }else if(tempType=="家教"){
            imgUrl="${site}/static/images/shareLogo5.png";
        }else if(tempType=="礼仪"||tempType=="模特"||tempType=="演员"||tempType=="主持人"){
            imgUrl="${site}/static/images/shareLogo6.png";
        }else if(tempType=="派单"||tempType=="设计"||tempType=="其他"){
            imgUrl="${site}/static/images/shareLogo7.png";
        }else if(tempType=="收银员"||tempType=="销售"||tempType=="促销"||tempType=="导购"){
            imgUrl="${site}/static/images/shareLogo8.png";
        }else if(tempType=="助理"||tempType=="编辑"||tempType=="翻译"){
            imgUrl="${site}/static/images/shareLogo9.png";
        }else{
            imgUrl="${site}/static/images/sharelogo.png";
        }
        $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
            wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: data.data.appId, // 必填，公众号的唯一标识
                timestamp: data.data.timestamp, // 必填，生成签名的时间戳
                nonceStr: data.data.noncestr, // 必填，生成签名的随机串
                signature: data.data.signature,// 必填，签名
                jsApiList: ["onMenuShareAppMessage","onMenuShareTimeline","onMenuShareQQ","onMenuShareQZone","onMenuShareWeibo"] // 必填，需要使用的JS接口列表
            });
        })

        wx.ready(function () {

            var params = {
                title: title, // 分享标题
                desc: desc, // 分享描述
                link: link, // 分享链接
                imgUrl: imgUrl, // 分享图标
                success: function () {
                    // 用户确认分享后执行的回调函数
                },
                cancel: function () {
                    // 用户取消分享后执行的回调函数
                }
            };

            //获取“分享给朋友”按钮点击状态及自定义分享内容接口
            wx.onMenuShareAppMessage(params);
            //获取“分享到朋友圈”按钮点击状态及自定义分享内容接口
            wx.onMenuShareTimeline(params);
            //分享到QQ
            wx.onMenuShareQQ(params);
            //分享到QQ空间
            wx.onMenuShareQZone(params);
            //分享到腾讯微博
            wx.onMenuShareWeibo(params);
        });
        wx.error(function(res){
            mui.alert("错误信息"+JSON.stringify(res));
        });
    }
    ijob.storage.set("forwardUser",null);
    function changePicHandler() {
        $("#myhead").trigger('click');
    }

    $(".edit_btns").click(function () {
        window.location.href = "/ijob/api/InformationController/h5/mine/basicInfo";
    });
    <c:if test="${editInformation==true}">

    function saveBirf(arg) {
        var brief = $("#brief").val();
        if (brief != "" && brief != null && brief.indexOf("请填写简介") == -1) {
            var params = {
                "id": $(arg).data("id"),
                "version": $(arg).data("version"),
                "brief": $("#brief").val()
            };
            $(arg).btPost(params, function (data) {
                if (data.code == 200) {
                    var version = parseInt($(arg).data("version"));
                    $(arg).data("version", version + 1);
                    mui.toast("保存成功");
                } else if (data.code == 500) {
                    mui.toast("保存失败");
                }
            });
        }
    }

    </c:if>
    //初始化时显示是否关注
    $(function () {
        if ('${isAttention}'.toString() === "true") {
            $("#follow").text("已关注");
        } else {
            $("#follow").text("关注");
        }

        <c:if test="${editInformation==true}">
        try {
            $("#myhead").attachment();
        }catch (err){
            localtion.reload();
        }

        $("#myhead").on("uploadCompletionEvent", function () {
            var attachment = {
                "datestr": $("input[name='bgp.datestr']").val(),
                "path": $("input[name='bgp.path']").val(),
                "name": $("input[name='bgp.name']").val(),
                "type": $("input[name='bgp.type']").val(),
                "version": $("input[name='bgp.version']").val(),
                "id": $("input[name='bgp.id']").val(),
                "isDeleted": $("input[name='bgp.isDeleted']").val()
            };
            var obj = {
                "bgp": attachment,
                "id": "${OtherUserInfomation.id}",
                "version": "${OtherUserInfomation.version}"
            };
            $.ajax({
                url: "/ijob/api/InformationController/changeBgp",
                type: "POST",
                dataType: 'json',
                async: false,
                contentType: 'application/json',
                data: JSON.stringify(obj),
                success: function (data) {
                    mui.toast("保存背景图片成功");
                },
                error: function (e) {
                    mui.toast("保存图片错误");
                },
                complete: function () {

                }
            });
        });
        </c:if>

        // 判断是否填写简历
        var txt = $(".text_resume").html();
        if( txt == 0 || txt == null ){
            $(".text_resume").append("<p style='text-align: center;margin-top:0.5rem;'>对方暂未填写简介！ </p>");
        }
    });


    $(".tabList>li").on("click", function () {
        var nub = $(this).index();
        $(this).children().addClass("active").parent().siblings("li").children().removeClass("active");
        $(".tabContent>div").eq(nub).show().siblings().hide();
    });

    function isAttention(arg){
        $(arg).btPost(null,function(result){
            if(result.code==200){
                location.reload();
            }
        });
    }
    ijob.storage.set("workID",null);
    ijob.storage.set("userID",null);
    ijob.storage.set("data.id",null)

</script>

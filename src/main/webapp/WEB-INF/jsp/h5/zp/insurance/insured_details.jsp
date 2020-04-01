<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/1/8
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>保险详情</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/insurance/insurance.css?version=4">
</head>
<body>
<div class="insured-details">
    <div class="index-hd">
        <div class="list-box">
            <ul>
                <li onclick="ijob.gotoPage({path:'/h5/zp/insurance/insured_details'})">
                    <div class="img">
                        <img src="/ijob/static/images/insurance.png"/>
                    </div>
                    <div class="txt">
                        <div class="title">
                            <span class="tit">分时工伤</span>
                            <span class="money">58元/月</span>
                        </div>
                        <div class="tips">
                            <span>企业和职工劳动安全的保护伞</span>
                            <span class="details">最高保额80万元</span>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <section>
        <%--面向群体--%>
        <div class="group-oriented main-list-box">
            <div class="title">面向群体</div>
            <div class="details">
                <p>已经达到法定退休年龄的人员；在校学生实习；在异地有参保，不愿意在当地参保的外来务工人员；其他单位内退、停薪留职、放长假、待岗人员</p>
                <p>兼职、小时工等灵活用工的人员；季节性、短期性用工的人员；因各种原因无法或不能为其缴纳社会保险的群体</p>
                <p>新入职员工试用期内未参加社保的企事业单位；流动性较大未参加社保的企事业单位；关注员工非工伤意外的企事业单位</p>
            </div>
        </div>
        <%--保障范围--%>
        <div class="protection main-list-box">
            <div class="title">保障范围</div>
            <div class="details">
                <p>在工作时间和工作场所内，因工作原因受到事故伤害</p>
                <p>工作时间前后在工作场所内，从事与工作有关的预备性或者收尾性工作受到事故伤害</p>
                <p>在工作时间和工作场所内，因履行工作职责受到暴力等意外伤害</p>
                <p>在上下班途中，受到非本人主要责任的交通事故或者城市轨道交通、客运轮渡、火车事故伤害的</p>
                <p>在工作时间和工作岗位，突发疾病死亡或者在48小时之内经抢救无效死亡</p>
                <p>在抢险救灾等维护国家利益、公共利益活动中受到伤害</p>
                <p>原在军队服役因战、因公负伤致残，已取得革命伤残军人证，到用人单位后旧伤复发</p>
                <p>在非工作时间，工作场所，非工作原因受到的意外伤害</p>
            </div>
        </div>
        <%--保险特点--%>
        <div class="protection main-list-box">
            <div class="title">保险特点</div>
            <div class="details">
                <p><em>转嫁用工风险</em>——应由企业承担的赔偿，保障范围内将风险转嫁给保险公司</p>
                <p><em>赔款直接支付给公司帐户</em>——传统员工险作为员工福利，赔款支付给员工个人账上，即使赔付也转嫁不了用工风险，《分时工伤》理赔款赔付给投保企业</p>
                <p><em>提高员工福利</em>——保险健全，员工自然满意，凝聚力更强，吸引力更强</p>
                <p>赔偿项目包括<em>死亡、等级伤残、医疗费、误工费、住院补贴</em></p>
                <p>工伤保险诊疗目录范围之内，在赔付额度内，除去<em>免赔100%赔付</em>——传统员工险打折赔付</p>
            </div>
        </div>
        <div class="business">
            <p>阳光人寿保险股份有限公司湖南分公司</p>
            <p>国信联合保险经纪有限公司·湘才人力资源·联合推出</p>
        </div>
    </section>
    <div class="clearfix" style="height: 1.6rem;content:'';clear: both"></div>
    <div class="foot-flex">
        <a href="tel:0731-84131208" class="consult-btns">
            <span class="iconfont icon-dadianhua"></span>
            <p>电话咨询</p>
        </a>
        <a href="javascript:void(0);" class="upload-btns" onclick="ijob.gotoPage({path:'/h5/zp/insurance/uploadList?insured.type=1'})">上传名单</a>
    </div>
</div>
</body>
</html>

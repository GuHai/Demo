<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/1/10
  Time: 15:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>理赔细则</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/insurance/insurance.css?version=4">
    <style>
        body{
            background-color: #dceafa;
        }
    </style>
</head>
<body>
<div class="page-claim-rules">
    <div class="rules-list">
        <div class="main-content process">
            <div class="title">
                <h3>待遇申报流程</h3>
            </div>
            <div class="details">
                <img src="/ijob/static/images/rules_process.png">
            </div>
        </div>
        <div class="main-content prepareData">
            <div class="title">
                <h3>出险报案准备资料</h3>
            </div>
            <div class="details">
                <p>事故报告（写明事故经过，伤者送往哪个医院，诊断为什么伤情)</p>
                <p>本人手持身份证照片一张，受伤部位照片一张</p>
            </div>
        </div>
        <div class="main-content treatment">
            <div class="title">
                <h3>治疗结束（理赔所需资料）</h3>
            </div>
            <div class="details">
                <p>全部治疗完毕，若一年后拆除钢板的可将第一批治疗费用先提报，如需评残的二次治疗结束后评残。</p>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th class="left">事故报告</th>
                            <th>电子版</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="left">照片</td>
                            <td>面部和身份证同框一张<br/>受伤部位一张</td>
                        </tr>
                        <tr>
                            <td class="left">诊断证明</td>
                            <td>医院盖章原件</td>
                        </tr>
                        <tr>
                            <td class="left">身份证复印件</td>
                            <td>正反面复印在同一页</td>
                        </tr>
                        <tr>
                            <td class="left">门诊病历</td>
                            <td>原件</td>
                        </tr>
                        <tr>
                            <td class="left">门诊发票</td>
                            <td>正规卫生医疗机构税票<br/>医院盖章原件</td>
                        </tr>
                        <tr>
                            <td class="left">影像报告(CT/X光/放射)</td>
                            <td>原件</td>
                        </tr>
                        <tr>
                            <td class="left">开药处方笺</td>
                            <td>原件，手写或机打(医院盖章)</td>
                        </tr>
                        <tr>
                            <td class="left">住院病例</td>
                            <td>住院的病例内需有体温单(医院盖章)</td>
                        </tr>
                        <tr>
                            <td class="left">住院发票</td>
                            <td>正规卫生医疗机构税票(医院盖章)</td>
                        </tr>
                        <tr>
                            <td class="left">住院费用总清单(用药清单)</td>
                            <td>医院盖章</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="main-content injury">
            <div class="title">
                <h3>属于交通事故的工伤或意外伤害需要提供</h3>
            </div>
            <div class="details">
                <p>交通部门出具的《交通事故责任认定书》</p>
                <p>对方赔付的，提供交警部门出具的《赔偿调解协议书》或《法院判决书》及第三方支付凭证</p>
                <p>若出险员工驾驶机动车的，需提供驾驶证和行驶证复印件。</p>
                <p>医疗费第三方赔付过的不能重新申请理赔。</p>
            </div>
        </div>
        <div class="main-content death">
            <div class="title">
                <h3>涉及死亡的提供</h3>
            </div>
            <div class="details">
                <p>医学死亡证明、火化证明（未火化的提供居委会土葬证明）和派出所销户证明（原件）</p>
                <p>用工单位出具的详细的、经甲方确认的事故经过报告（原件必须加盖公章）</p>
                <p>员工在医院时的抢救记录、病历、诊断证明(原件）</p>
                <p>出险员工及其近亲属的身份证复印件、户口本索引表复印件，不在一个户口本的亲属需提供村委会开具的亲属关系证明(原件)。</p>
            </div>
        </div>
        <div class="main-content deformity">
            <div class="title">
                <h3>评残</h3>
            </div>
            <div class="details">
                <p>人社局劳动能力等级鉴定或司法鉴定机构评残。如需司法鉴定机构鉴定伤残等级的，需要在治疗结束康复后 180 后天评残，以出院时间为准，180 天内司法鉴定评残的不予受理，需 180 天后重新评定。</p>
            </div>
        </div>
    </div>
    <div class="cleafix" style="height: 2rem;"></div>
    <div class="foot-flex">
        <a href="javascript:void(0);" class="reback" onclick=history.back()>返回</a>
    </div>
</div>
</body>
</html>

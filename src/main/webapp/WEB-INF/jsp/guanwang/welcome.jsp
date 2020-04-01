<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/29
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"   import="com.yskj.service.base.DictCacheService"%>
<div class="row">
    <div style="cursor: pointer;" class="col-md-3 stretch-card grid-margin" onclick="loadPageByUrl('guanwang/salary?data.againID=all');">
        <div class="card bg-gradient-danger card-img-holder text-white">
            <div class="card-body">
                <img  src="/ijob/static/website/images/member/circle.svg" class="card-img-absolute" alt="circle-image" />
                <h4 class="font-weight-normal mb-3">批量发工资</h4>
                <h2 class="mb-5"></h2>
                <h6 class="card-text"></h6>
            </div>
        </div>
    </div>
    <div style="cursor: pointer;" class="col-md-3 stretch-card grid-margin" onclick="loadPageByUrl('guanwang/insuranceList?insupload.id=');">
        <div class="card bg-gradient-info card-img-holder text-white">
            <div class="card-body">
                <img  src="/ijob/static/website/images/member/circle.svg" class="card-img-absolute" alt="circle-image" />
                <h4 class="font-weight-normal mb-3">保险</h4>
                <h2 class="mb-5"></h2>
                <h6 class="card-text"></h6>
            </div>
        </div>
    </div>
    <div style="cursor: pointer;" class="col-md-3 stretch-card grid-margin">
        <div class="card bg-gradient-success card-img-holder text-white">
            <div class="card-body">
                <img src="/ijob/static/website/images/member/circle.svg" class="card-img-absolute" alt="circle-image" />
                <h4 class="font-weight-normal mb-3">敬请期待</h4>
                <h2 class="mb-5"></h2>
                <h6 class="card-text"></h6>
            </div>
        </div>
    </div>
    <div class="col-md-3 stretch-card grid-margin"   style="cursor: pointer;" >
        <div class="card bg-gradient-primary card-img-holder text-white">
            <div class="card-body">
                <img src="/ijob/static/website/images/member/circle.svg" class="card-img-absolute" alt="circle-image" />
                <h4 class="font-weight-normal mb-3">敬请期待</h4>
                <h2 class="mb-5"></h2>
                <h6 class="card-text"></h6>
            </div>
        </div>
    </div>
</div>

$(function () {

        // 下一步
       /* $(".nextbtns").click(function () {
            // 在校生
            if($("#st_radio").prop("checked") == true){
                if($("#Myschool").val()==null||$("#Myschool").val()==""||$("#Myschool").val()==undefined ){
                    mui.alert("请输入学校名称");
                }else {
                    ijob.gotoPage({path:'/h5/job_intension'})
                }
            }else if($("#so_radio").prop("checked") == true){//非学生
                if($("#NearSchool").val()==null||$("#NearSchool").val()==""||$("#NearSchool").val()==undefined ){
                    mui.alert("请输入母校或附近学校");
                }else {
                    ijob.gotoPage({path:'/h5/job_intension'})
                }
            }

        });*/
        /*学校搜索显示信息选择*/
        $("#Myschool").keyup(function(){
            if($("#Myschool").val() != null ||$("#Myschool").val()!=""||$("#Myschool").val()!=undefined){
                $(".search-list").show();
                var dis = $(".search-list").css("display");
                if(dis == "block"){
                    $(".search-list li").click(function (e) {
                        $(this).each(function () {
                            var _this = $(this);
                            $("#Myschool").val(_this.attr('data-value'));
                            $(".search-list").hide();
                        })
                    });
                }
            }
        });

        // 是否关注公众号
        /*$(".school-list li").click(function () {
            $(this).find(".follow .btns").each(function(){
                var _this = this ;
                if($(this).hasClass("Alreadybtns")){
                    var btnArray = ['否', '是'];
                    mui.confirm('确认取消关注？', '', btnArray, function (e) {
                        if (e.index == 0) {
                            $(_this).addClass("Alreadybtns");
                        }else {
                            $(_this).removeClass("Alreadybtns");
                        }
                    });
                }else {
                    var btnArray = ['否', '是'];
                    mui.confirm('确认关注？', '', btnArray, function (e) {
                        if (e.index == 1) {
                            $(_this).addClass("Alreadybtns");
                        }
                    });
                }

            });
        })*/
        $(".gotohome").click(function () {
            ijob.gotoPage({url:"/indexMain"});
        });

    })
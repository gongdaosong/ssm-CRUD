
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>主页</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!--引入jquery-->
    <script type="text/javascript" src="${APP_PATH}/static/jQuery/jquery-1.11.3min.js"></script>
    <!--引入样式-->
    <link href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 员工更新的模态框 -->
<div class="modal fade" id="empupdatemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工更新</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <!--部门列表 -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAndmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工新增</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <!--部门列表 -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!--搭建显示页面 -->
<div class="container">
    <!--标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary" id="emp_and_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--分页 -->
    <div class="row">
        <!-- 分页信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!-- 分页条信息-->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord,cuurentPage;
    // 页面加载以后直接发送ajax请求，要到分页数据

    $(function () {
       to_page(1);
    });

    // 抽取出来的ajax请求
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //console.log(result);
                //1,解析并显示员工数据
                build_emps_table(result);
                //2，解析并显示分页数据
                build_page_info(result);
                // 3，解析显示分页条数据
                build_page_nav(result);
            }
        });
    };
    //1,添加显示员工数据方法
    function build_emps_table(result) {
        // 清空表格
        $("#emps_table tbody").empty();

        var emps = result.extend.pageinfo.list;
        $.each(emps, function (index, item) {
            // alert(item.empName);
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" ").append("编辑");
            // 添加自定义属性

            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" ").append("删除");
            // 添加自定义属性
            delBtn.attr("del-id",item.empId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }
    // 解析显示分页信息
    function build_page_info(result) {
        //  取值之前先清空
        $("#page_info_area").empty();

        $("#page_info_area").append("当前第"+result.extend.pageinfo.pageNum+"页,总共"+
            result.extend.pageinfo.pages+"页，总共"+
            result.extend.pageinfo.total+"条记录");
        totalRecord = result.extend.pageinfo.total;
        cuurentPage = result.extend.pageinfo.pageNum;
    }
    // 解析显示分页条信息
    function build_page_nav(result) {
        // 清空数据
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination")

        // 构建
        var firstpageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prepageLi = $("<li></li>").append($("<a></a>").append($("<span ></span>").append("&laquo;")));
        if(result.extend.pageinfo.hasPreviousPage == false){
            firstpageLi.addClass("disabled");
            prepageLi.addClass("disabled");
        } else {
            // 为元素添加点击事件
            firstpageLi.click(function () {
                to_page(1);
            });
            prepageLi.click(function () {
                to_page(result.extend.pageinfo.pageNum-1);
            });

        }

        // 构建
        var nextpageLi = $("<li></li>").append($("<a></a>").append($("<span ></span>").append("&raquo;")));
        var lastpageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageinfo.hasNextPage == false){
            nextpageLi.addClass("disabled");
            lastpageLi.addClass("disabled");
        } else{
            // 为元素添加点击事件
            nextpageLi.click(function () {
                to_page(result.extend.pageinfo.pageNum+1);
            });
            lastpageLi.click(function () {
                to_page(result.extend.pageinfo.pages);
            });

        }

        // 添加首页跟前一页
        ul.append(firstpageLi).append(prepageLi);
        // 1,2,3,4页码号
        $.each(result.extend.pageinfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageinfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextpageLi).append(lastpageLi);

        // 把navy加入到ul
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    // 清空表单所有内容及样式
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
     //   $(ele).find("#dept_add_select").text("");
    }

    // 点击新增按钮，弹出模态框
    $("#emp_and_modal_btn").click(function () {

        // 清空表单数据(dom对象才有的方法)(表单完整重置，包括样式和数据)
        reset_form("#empAndmodal form");
        // 发送ajax请求，查出部门信息，显示在下拉列表中
            getDepts("#dept_add_select");

        $("#empAndmodal").modal({
            backdrop:"static"
        });
    });
    // 查部门信息并显示在下拉列表中
    function getDepts(ele) {
        // 清空下拉列表
        $(ele).empty();
        $.ajax({
           url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
              //  console.log(result);
              //  $("#dept_add_select").modal
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                })
            }
        });
    }

    // 显示校验结果的显示信息
    function show_validata_msg(ele, status, msg) {

        // 清空当前元素校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        if("success"== status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if("error"== status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    // 表单验证
    function validate_and_form() {
        // 1,拿到校验的数据，使用正则
        var empName = $("#empName_add_input").val();
        var reqName = /(^[a-zA-Z0-9]{6,16}$)|(^[\u4e00-\u9fa5]{2,5})/;
        if(!reqName.test(empName)){
            show_validata_msg("#empName_add_input","error","用户名可以是2到5位的中文或6到16位的英文数字组合");
            return false;
        }else{
            show_validata_msg("#empName_add_input","success"," ");
        }

        var email = $("#email_add_input").val();
        var reqemail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if(!reqemail.test(email)){
            show_validata_msg("#email_add_input","error","邮箱格式错误");
            return false;
        } else{
            show_validata_msg("#email_add_input","success"," ");
        }
        return true;
    }

    // 检查用户名是否可用
    $("#empName_add_input").change(function () {

        //测试
             var empName  = $(this).val();
        // 发送ajax请求校验用户名是否可用
        $.ajax({
            url:"${APP_PATH}/checkUser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if(result.code == 100){
                    show_validata_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validata_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });
    // 点击保存员工
    $("#emp_save_btn").click(function () {
        // 模态框中填写表单提交服务器
        // 校验用户名，email
       if (!validate_and_form()){
            return false;
       }

       // 检查用户名是否可用
        if($(this).attr("ajax-va")=="error"){
            return false;
        }

        // 发送ajax请求保存员工

        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAndmodal form").serialize(),
            success:function (result) {
                // 还需要判断
                if(result.code == 100){
                // 关闭模态框
                $("#empAndmodal").modal("hide");
                // 来到最后一页，显示保存数据
                to_page(totalRecord);
               // alert(result.msg);

                } else{
                  //  console.log(result);
                    // 有哪个字段的粗偶信息就显示哪个字段
                  //  alert(result.extend.errorFields.email);
                  //  alert(result.extend.errorFields.empName);
                    if(undefined != result.extend.errorFields.email){
                        show_validata_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        show_validata_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    // 获取员工信息
    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
              //  console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empupdatemodal input[name=gender]").val([empData.gender]);
                $("#dept_update_select").val([empData.dId]);
            }
        });
    }

    // 点击更新按钮，更新员工
    $("#emp_update_btn").click(function () {

        // 验证邮箱，校验邮箱是否合法
        var email = $("#email_update_input").val();
        var reqemail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if(!reqemail.test(email)){
            show_validata_msg("#email_update_input","error","邮箱格式错误");
            return false;
        } else{
            show_validata_msg("#email_update_input","success"," ");
        }
        // 发送ajax请求更新保存员工数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empupdatemodal form").serialize(),
            success:function (result) {
              //  alert(result.msg);
              //关闭模态框
                $("#empupdatemodal").modal("hide");
              //跳转到修改页面并保存数据
                to_page(cuurentPage);
            }
        });
    });
    // 给编辑按钮添加绑定事件
    $(document).on("click",".edit_btn",function () {

        //1， 发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#dept_update_select");
        //2， 查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        // 3，把员工id传给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
       //4，点击编辑按钮，弹出模态框
        $("#empupdatemodal").modal({
            backdrop:"static"
        });
    });

    // 给删除按钮绑定事件
    $(document).on("click",".delete_btn",function () {
        //弹出确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
    //    alert($(this).parents("tr").find("td:eq(2)").text());
        if(confirm("确认删除【"+empName+"】吗?")){
            // 确认，发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //跳转到本页面并保存数据
                    to_page(cuurentPage);
                }
            });

        }
    });

    // 完成全选/全不选功能
    $("#check_all").click(function () {
    //   alert($(this).prop("checked"));
       $(".check_item").prop("checked",$(this).prop("checked"));
    });
    // 为check_item复选框添加绑定事件
    $(document).on("click",".check_item",function () {
        //判断当前选中的元素是否5个
       // alert($(".check_item:checked").length);
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    });
    // 为全部删除按钮绑定点击事件(批量删除)
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        //
        $.each($(".check_item:checked"),function () {
        empNames +=$(this).parents("tr").find("td:eq(2)").text()+",";
        del_idstr +=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empNames = empNames.substring(0,empNames.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确认删除【"+empNames+"】吗？")){
            // 确认删除，发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(cuurentPage);
                }
            });

        }
    });
</script>
</body>
</html>

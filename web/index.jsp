<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/17
  Time: 16:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>Title</title>
	<%
		pageContext.setAttribute("APP_PATH", request.getContextPath());
	%>

	<%-- 引入jQuery --%>
	<script src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
	<%-- 引入BootStrap样式文件 --%>
	<link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
	<div class="page-header">
		<h1>SSM-CRUD</h1>
	</div>
	<div class="pull-right">
		<button type="button" class="btn btn-primary" data-toggle="modal" id="emp_add_modal_btn" data-target="#emp_add_modal">Add</button>
	</div>
	<table class="table table-hover" id="emps_table">
		<thead>
		<tr>
			<th>ID</th>
			<th>Username</th>
			<th>Gender</th>
			<th>Email</th>
			<th>Department</th>
			<th>Operation</th>
		</tr>
		</thead>
		<tbody >
		</tbody>
	</table>
	<div id="page_information"></div>
	<div class="row">
		<div class="pull-right">
			<nav aria-label="Page navigation" id="page_nav">
			</nav>
		</div>
	</div>

	<div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog" aria-labelledby="emp_add_Modal_Label">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="emp_add_Modal_Label">Add Employee</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="emps_form">
						<div class="form-group">
							<label for="inputUsername" class="col-sm-2 control-label">Username</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputUsername" placeholder="Please Enter Username" name="empName">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="inputEmail" placeholder="Please Enter Email" name="email">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline">
									<input type="radio" name="gender" value="F" checked>
									男
								</label>
								<label class="radio-inline">
									<input type="radio" name="gender" value="M">
									女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">DeptName</label>
							<div class="col-sm-4">
								<select class="form-control " name="dId" id="dId"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="emps_save_btn">Save changes</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="emp_edit_modal" tabindex="-1" role="dialog" aria-labelledby="emp_edit_Modal_Label">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="emp_edit_Modal_Label">Edit Employee</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="emps_edit_form">
						<input type="hidden" name="_method" value="PUT">
						<div class="form-group">
							<label for="inputUsername_edit" class="col-sm-2 control-label">Username</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputUsername_edit" placeholder="Please Enter Username" name="empName">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail_edit" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="inputEmail_edit" placeholder="Please Enter Email" name="email">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline">
									<input type="radio" name="gender" value="F" checked>
									男
								</label>
								<label class="radio-inline">
									<input type="radio" name="gender" value="M">
									女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">DeptName</label>
							<div class="col-sm-4">
								<select class="form-control " name="dId" id="dId_edit"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="emp_change_btn">Save changes</button>
				</div>
			</div>
		</div>
	</div>
</div>


<script>


    $(function(){

	    var totalRecord;
	    var pagenum;
	    var empId;
	    toPage(1);

	    // 跳转到指定页码
	    function toPage(pagenum) {
            $.ajax({
                url: "${APP_PATH}/emps",
                data: "pagenumber=" + pagenum,
                type: "GET",
                success: function (result) {
                    render_emp_table(result);
                    render_page_inform(result);
                    render_page_nav(result);
                }
            });
        }

        // 渲染表格
	    function render_emp_table(result) {
	        $("#emps_table tbody").empty();
	       var emps = result.extend.pageInfo.list;
	       $.each(emps, function(index, item){
	           var empIdTd = $("<td></td>").append(item.empId);
               var empNameTd = $("<td></td>").append(item.empName);
               var genderTd= $("<td></td>").append(item.gender == "F" ? "男": "女");
               var emailTd= $("<td></td>").append(item.email);
               var deptNameTd = $("<td></td>").append(item.department.deptName);
               var delete_btn = $("<button></button>").addClass("btn btn-danger emp_delete_btn").append("Delete").attr("type", "button");
               var edit_btn = $("<button></button>").addClass("btn bg-primary").append("Edit").attr("type", "button").attr("data-target", "#emp_edit_modal").attr("data-toggle", "modal");

               // 发送删除请求
               delete_btn.bind("click", function () {
	              $.ajax({
		              url: "${APP_PATH}/emps/"+item.empId,
		              type: "POST",
		              data: {_method:"DELETE"},
		              success: function (result) {
			              console.log(result);
			              toPage(pagenum);
                      }
	              }) ;
               });

               // 编辑员工 提交
               edit_btn.bind("click", function () {
                   empId = item.empId;
                   getDepts("dId_edit", item.department.deptId);
                   $("#inputUsername_edit").val(item.empName);
                   $("#inputEmail_edit").val(item.email);
                   var radios = $("#emp_edit_modal input:radio");
                   console.log(radios);
                   if(item.gender == "F"){
                       $(radios[0]).attr("checked", true);
                       $(radios[1]).removeAttr("checked");
                   } else {
                       $(radios[1]).attr("checked", true);
                       $(radios[0]).removeAttr("checked");
                   }
               });



               var operationTd = $("<td></td>").append(edit_btn).append(" ").append(delete_btn);
		       $("<tr></tr>").append(empIdTd)
			       .append(empNameTd)
			       .append(genderTd)
                   .append(emailTd)
			       .append(deptNameTd)
                   .append(operationTd)
			       .appendTo("#emps_table tbody");
	       });

       }

       // 渲染页码信息
		function render_page_inform(result) {
	        $("#page_information").empty();
            var information = result.extend.pageInfo;
            var str = "当前页数:" + information.pageNum + " 总页数:" + information.pages + " 记录总数:" + information.total;
            $("<p></p>").append(str)
	            .appendTo("#page_information");

            totalRecord = information.total;
        }

        // 渲染页码条
        function render_page_nav(result) {
	        $("#page_nav").empty();
			var page_nav = result.extend.pageInfo.navigatepageNums;
			pagenum = result.extend.pageInfo.pageNum;
			var total = result.extend.pageInfo.total;

			var ul = $("<ul></ul>").addClass("pagination");
			var firstPage = $("<li></li>").append($("<a></a>").append("First").attr("href", "#"));
			var lastPage = $("<li></li>").append($("<a></a>").append("Last").attr("href", "#"));
			var prev = $("<li></li>").append($("<a></a>").append("<<").attr("href", "#"));
			var next = $("<li></li>").append($("<a></a>").append(">>").attr("href", "#"));

			if(result.extend.pageInfo.isFirstPage == false){
				firstPage.bind("click", function () {
				  toPage(1);
				});
			}

            if(result.extend.pageInfo.isLastPage == false){
                lastPage.bind("click", function () {
                    toPage(result.extend.pageInfo.pages);
                });
            }

			if(result.extend.pageInfo.hasPreviousPage == true){
				prev.bind("click", function () {
				    toPage(pagenum - 1);
				});
			}

            if(result.extend.pageInfo.hasNextPage == true){
                next.bind("click", function () {
                    toPage(pagenum + 1);
                });
            }

			ul.append(firstPage);
			ul.append(prev);

           $.each(page_nav, function (index, item) {
               var a = $("<a></a>").append(item).attr("href", "#");
               a.bind("click", function(){
                   toPage(item);
               });
               if(item == pagenum) {
                   var page = $("<li></li>").append(a).addClass("active");
               } else {
                   var page = $("<li></li>").append(a);
               }
               ul.append(page);
           });
	       if(pagenum != total) {
               ul.append(next);
           }
           ul.append(lastPage);
           ul.appendTo("#page_nav");
       }

       // 添加员工模态框单机事件
		$("#emp_add_modal_btn").bind("click", function () {
			getDepts("dId");
		});

	    // 获取部门信息, 并渲染
	    function getDepts(idName, dId) {
		    $.ajax({
			   url: "${APP_PATH}/depts",
			   type: "GET",
			   success: function (result) {
			       $("#" + idName).empty();
				   console.log(result);
				   var depts = result.extend.depts;
				   $.each(depts, function (index, item) {
                      var option =  $("<option></option>").attr("value", item.deptId).append(item.deptName);
                      if(dId == item.deptId) {
                          option.attr("selected","selected");
                      }
                      option.appendTo("#" + idName);
                   });
               }
		    });
        }

        // 验证表单数据
        function validate_add_form() {
			var empName = $("#inputUsername").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
            if(!regName.test(empName)) {
                alert("用户名错误！");
                return false;
            }
            var email = $("#inputEmail").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)) {
                alert("邮箱格式错误！");
                return false;
            }
            return true;
        }

        // 保存员工信息
        $("#emps_save_btn").bind("click", function(event) {
            //校验表单数据数据
            if(!validate_add_form()) {
                return false;
            }
            // 得到表单数据
            var data = $("#emps_form").serialize();
            console.log(data);

            // 发送请求保存
            $.ajax({
	            url: "${APP_PATH}/emps",
	            type: "POST",
	            data: data,
	            success: function(result) {
	                console.log(result);
	                $("#emp_add_modal").modal("hide");
	                toPage(totalRecord);
	            }
            });
        });

		$("#emp_change_btn").bind("click", function (event) {
		    var data = $("#emps_edit_form").serialize();
            $.ajax({
                url: "${APP_PATH}/emps/" + empId,
                type: "POST",
                data: data,
                success: function (result) {
                    console.log(result);
                    $("#emp_edit_modal").modal("hide");
                    toPage(pagenum);
                }
            });
        });
	});
</script>

</body>
</html>

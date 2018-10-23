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
			<button type="button" class="btn btn-primary">Add</button>
		</div>
		<table class="table table-hover">
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
			<tbody>
			<c:forEach var="i" items="${pageInfo.list}">
			<tr>
				<td>${i.empId}</td>
				<td>${i.empName}</td>
				<td>${i.gender == "M"?"女":"男"}</td>
				<td>${i.email}</td>
				<td>${i.department.deptName}</td>
				<td>
					<button type="button" class="btn bg-primary">Edit</button>
					<button type="button" class="btn btn-danger">Delete</button>
				</td>
			</tr>
			</c:forEach>

			</tbody>
		</table>
		<p>当前页数:${pageInfo.pageNum} 总页数:${pageInfo.pages} 记录总数:${pageInfo.total}</p>
		<div class="row">
			<div class="pull-right">
				<nav aria-label="Page navigation">
					<ul class="pagination">

						<c:if test="${pageInfo.pageNum == 1}">
							<li>
								<a>
									<span aria-hidden="true">First</span>
								</a>
							</li>
						</c:if>
						<c:if test="${pageInfo.pageNum != 1}">
							<li>
								<a href="/emps?pagenumber=1">
									<span aria-hidden="true">First</span>
								</a>
							</li>
							<li>
								<a href="/emps?pagenumber=${pageInfo.pageNum - 1}" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a>
							</li>
						</c:if>
						<c:forEach items="${pageInfo.navigatepageNums}" var="pagenumber">
							<li class="${pageInfo.pageNum == pagenumber ? "active": ""}"><a href="/emps?pagenumber=${pagenumber}">${pagenumber}</a></li>
						</c:forEach>
						<%--<li class=${pageInfo.pageNum + 1 > pageInfo.pages ? "disabled": ""} >--%>
							<%--<a href="/emps?pagenumber=${pageInfo.pageNum + 1 > pageInfo.pages ? pageInfo.pages: pageInfo.pageNum + 1}" aria-label="Next">--%>
								<%--<span aria-hidden="true">&raquo;</span>--%>
							<%--</a>--%>
						<%--</li>--%>
						<c:if test="${pageInfo.pageNum == pageInfo.pages}">
							<li>
								<a>
									<span aria-hidden="true">Last</span>
								</a>
							</li>
						</c:if>
						<c:if test="${pageInfo.pageNum != pageInfo.pages}">
							<li>
								<a href="/emps?pagenumber=${pageInfo.pageNum + 1}" aria-label="Next">
									<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
							<li>
								<a href="/emps?pagenumber=${pageInfo.pages}">
									<span aria-hidden="true">Last</span>
								</a>
							</li>
						</c:if>

					</ul>
				</nav>
			</div>

		</div>



	</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>

<style type="text/css">
	#Main{
		min-height:896px;
	}
	#ulMenu li{
		padding: 10px;
		margin-top: 100px
	}
</style>

<div id="Main" class="container">
	<h1>근태조회</h1>
	<div class="row">
	<div id="Menu" class="col-md-2">
		<ul id="ulMenu" class="list-inline">
			<li class="list-group-item d-flex justify-content-between align-items-center"><a href="#">개인출퇴근조회<span class="badge badge-primary badge-pill">14</span></a></li>
			<li class="list-group-item d-flex justify-content-between align-items-center"><a href="#">부서출근조회</a></li>
			<li class="list-group-item d-flex justify-content-between align-items-center"><a href="#">개인연차현황</a></li>
		</ul>
	</div>
	<div id="content" class="col-md-8">
		<form name="frmCommute" action="<c:url value='/commute/commute.do'/>" method="post">
			<table id="tblCommute" class="table table-hover">
				<colgroup>
					<col style="width:15%;" />
					<col style="width:15%;" />
					<col style="width:15%;" />
					<col style="width:20%;" />
					<col style="width:20%;" />		
					<col style="width:15%;" />		
				</colgroup>
				<thead>
					<tr>
						<th>사원이름</th>
						<th>부서</th>
						<th>직급</th>
						<th>출근시간</th>
						<th>퇴근시간</th>
						<th>근무상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>2</td>
						<td>3</td>
						<td>4</td>
						<td>5</td>
						<td>6</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	</div>
</div>

<c:import url="../inc/bottom.jsp"/>



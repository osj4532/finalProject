<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>

<div id="Main">
	<h1>근태조회</h1>
	<div id="Menu">
		<ul id="ulMenu">
			<a href="#"><li>개인출퇴근조회</li></a>
			<a href="#"><li>부서출근조회</li></a>
			<a href="#"><li>개인연차현황</li></a>
		</ul>
	</div>
	<div id="content">
		<form name="frmCommute" action="<c:url value='/commute/commute.do'/>" method="post">
			<table id="tblCommute">
				<thead>
					<tr>
						<th></th>
					</tr>
				</thead>
			</table>
		</form>
	</div>
</div>

<c:import url="../inc/bottom.jsp"/>



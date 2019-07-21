<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<style>
	.wraper1{
		margin-top: 100px;
	}
</style>

<div class="container">
	<div class="wraper1 panel">
		<h3>개인 주소록</h3>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>이름</th>
					<th>회사명</th>
					<th>연락처</th>
					<th>이메일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>테스터</td>
					<td>(주)테스터</td>
					<td>010-1234-4567</td>
					<td>test@naver.com</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<%@ include file="../inc/bottom.jsp"%>
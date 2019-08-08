<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
 	$(function(){
		$(".scdtable").find('td').click(function(){
			location.href="<c:url value='/scheduler/scheduler.do'/>";
		});  
	});
</script> 
<table class="table">
	<thead>
		<tr>
			<th> 스케줄 제목 </th>
			<th> 스케줄 내용</th>
			<th> 시작일 </th>
			<th> 종료일 </th> 
		</tr>
	</thead>
	<tbody class="scdtable">
	   
	<c:if test="${empty scList}">
		<tr><td>최근 스케줄 없습니다.</td></tr>
	</c:if> 
	<c:if test="${!empty scList}">
	<c:forEach var="vo"  items="${scList}">
		<tr> 
		<td>${vo.scdTitle } </td>
		<td>${vo.scdContent } </td>
		<td>${vo.scdStart } </td>
		<td>${vo.scdEnd } </td> 
		</tr> 
	</c:forEach>
	</c:if>
	</tbody>
</table> 
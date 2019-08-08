<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
 	$(function(){
		$(".restable").find('td').click(function(){
			location.href="<c:url value='/useResource/useResList.do'/>";
		});  
	});
</script> 
<table class="table"> 

	<thead> 
		<tr>
			<th>자원명</th>
			<th>승인 여부</th>
			<th> 대여 시작일 </th>
			<th> 대여 종료일 </th> 
		</tr>
	</thead>
	<tbody class="restable">
	
	<c:if test="${empty ulist}">
		<tr><td>최근 신청 자원이 없습니다.</td></tr>
	</c:if> 
	<c:if test="${!empty ulist}">
	<c:forEach var="vo"  items="${ulist}">
		<tr>
		<td>${vo.resName } </td>
		<c:if test="${vo.apprFlag=='Y'}">
		<td style="color: ">승인 </td>
		</c:if>
		<c:if test="${vo.apprFlag!='Y'}">
		<td>검토중 </td>
		</c:if>
		<td>${vo.useRegdate } </td>
		<td>${vo.returnRegdate } </td>
		</tr>
	</c:forEach>
	</c:if>
	</tbody>
</table> 
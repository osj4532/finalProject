<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="table">
	<thead>
		<tr>
			<th>자원명</th>
			<th>승인 여부</th>
		</tr>
	</thead>
	<tbody>
	
	<c:if test="${empty ulist}">
		<tr><td>보낸 메일이 없습니다.</td></tr>
	</c:if>
	<c:if test="${!empty ulist}">
	<c:forEach var="vo"  items="${ulist}">
		<tr>
		<td>${vo.resName } </td>
		<c:if test="${vo.apprFlag=='Y'}">
		<td>승인 </td>
		</c:if>
		<c:if test="${vo.apprFlag!='Y'}">
		<td>검토중 </td>
		</c:if>
		</tr>
	</c:forEach>
	</c:if>
	</tbody>
</table> 
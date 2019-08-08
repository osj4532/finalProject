<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardTopIns</title>
</head>
<body> 
<c:forEach var="bdVo" items="${bdLlist}">
	<c:if test="${sessionScope.ranksNo >= bdVo.ranksNo}">
	<li><a href="<c:url value='/Board/BoardList.do?bdlistNo=${bdVo.bdlistNo }'/>"><i class="fas fa-chalkboard"></i>${bdVo.bdlistName}</a></li>
	</c:if> 
</c:forEach> 
</body>
</html> 
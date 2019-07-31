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
	<li><a href="<c:url value='/Board/BoardList.do?bdlistNo=${bdVo.bdlistNo }'/>">${bdVo.bdlistName}</a></li>
</c:forEach> 
</body>
</html> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>

<style type="text/css">
#Main{
		min-height: 900px;
	}
	.row{
		margin-top: 50px;
	}
	#info{
		min-height: 200px;
		background-color: white;
		min-width: 300px;
	}
	#info2{
		min-height: 200px;
		background-color: black;
		min-width: 300px;
	}
</style>
<section id="main-content">
	<section class="wrapper">
	<h3><i class="fas fa-users"></i>My Page</h3>
	<div class="row">
		<div class="col-lg-2" id="info">
					<c:if test="${!empty sessionScope.fileName }">
		          <p class="centered"><a href="<c:url value='/member/memberMypage.do'/>"><img src="<c:url value='/member_file/${sessionScope.fileName}'/>" class="img-circle" width="80"></a></p>
		        	</c:if>
		        	<c:if test="${empty sessionScope.fileName }">
		          <p class="centered"><a href="<c:url value='/member/memberMypage.do'/>"><img src="<c:url value='/member_file/user.png'/>" class="img-circle" width="80"></a></p>
		        	</c:if>
		          <h5 class="centered">${sessionScope.memName }</h5>
		          <button class="btn btn-info centered" id="btnDetail">상세정보</button>
		</div>
		<div class="col-lg-8" id="info2">
			hi
		</div>
	</div>
	</section>
</section>
<c:import url="../inc/bottom.jsp"/>
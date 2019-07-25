<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>
<style>
#Main {
	min-height: 856px;
}

#ulMenu li {
	padding: 10px;
	margin-top: 50px;
	min-width: 185px;
}

#Menu {
	min-height: 775px;
	background-color: white;
}

#Main>h1 {
	margin-top: 70px;
}

#title h2 {
	text-align: center;
	background-color: white;
}

#content {
	min-height: 775px;
	background-color: white;
	min-width: 900px;
}
#editWebhard{
	margin-top: 500px;
}
</style>
<div id="Main" class="container">
	<h1>웹 하 드</h1>
	<div class="row">
		<div id="Menu" class="col-md-2">
			<ul id="ulMenu" class="list-inline">
				<a href="#" onclick="select('indWork')"><li class="list-group-item d-flex justify-content-between align-items-center">사내 웹하드</li></a>
				<a href="#" onclick="select('indHoly')"><li class="list-group-item d-flex justify-content-between align-items-center">개인 웹하드</li></a>
			</ul>
		</div>
		<div id="content" class="col-md-8">
			<div id="title" class="col-md-8"></div>
			
			<div id="page"></div>
		</div>
	</div>
</div>
<c:import url="../inc/bottom.jsp"/>
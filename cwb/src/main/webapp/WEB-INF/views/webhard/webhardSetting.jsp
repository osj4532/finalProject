<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>
<script type="text/javascript" src="<c:url value='/resources/lib/bootstrap/js/bootstrap.js'/>"></script>
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
			<div class="list-group" id="list-tab" role="tablist">
				<a class="list-group-item list-group-item-action active" id="list-home-list" data-toggle="list" href="#list-home" role="tab" aria-controls="home">Home</a>
			      <a class="list-group-item list-group-item-action" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile">Profile</a>
			      <a class="list-group-item list-group-item-action" id="list-messages-list" data-toggle="list" href="#list-messages" role="tab" aria-controls="messages">Messages</a>
			      <a class="list-group-item list-group-item-action" id="list-settings-list" data-toggle="list" href="#list-settings" role="tab" aria-controls="settings">Settings</a>
			    </div>
		</div>
		
		<div id="content" class="col-md-8">
			<div id="title" class="col-md-8"></div>
			<div class="col-md-8">
    <div class="tab-content" id="nav-tabContent">
      <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">...</div>
      <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">...</div>
      <div class="tab-pane fade" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">...</div>
      <div class="tab-pane fade" id="list-settings" role="tabpanel" aria-labelledby="list-settings-list">...</div>
    </div>
  </div>
			<div id="page"></div>
		</div>
	</div>
</div>
<c:import url="../inc/bottom.jsp"/>
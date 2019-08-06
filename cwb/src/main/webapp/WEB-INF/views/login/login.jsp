<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<style type="text/css">
	label.checkbox {
    	padding-left: 20px;
	}
</style>
<head>
  <title>CWB login</title>

  <!-- Favicons -->
  <link href="<c:url value='/resources/img/favicon.png" rel="icon'/>">
  <link href="<c:url value='/resources/img/apple-touch-icon.png" rel="apple-touch-icon'/>">

  <!-- Bootstrap core CSS -->
  <link href="<c:url value='/resources/lib/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet">
  <!--external css-->
  <link href="<c:url value='/resources/lib/font-awesome/css/font-awesome.css'/>" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="<c:url value='/resources/css/style.css'/>" rel="stylesheet">
  <link href="<c:url value='/resources/css/style-responsive.css'/>" rel="stylesheet">
  
  
  <!-- =======================================================
    Template Name: Dashio
    Template URL: https://templatemag.com/dashio-bootstrap-admin-template/
    Author: TemplateMag.com
    License: https://templatemag.com/license/
  ======================================================= -->
</head>

<body>
  <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
  <div id="login-page">
    <div class="container">
      <form class="form-login" action="<c:url value='/login/login.do'/>" method="post">
        <h2 class="form-login-heading">sign in now</h2>
        <div class="login-wrap">
          <input type="text" name = "memId" class="form-control" placeholder="User ID" autofocus
          	value="${cookie.ck_memid.value }">
          <br>
          <input type="password" name="memPwd" class="form-control" placeholder="Password">
          <label class="checkbox">
            <input type="checkbox" value="remember-me" id="rememberId" name="rememberId" 
            	<c:if test="${!empty cookie.ck_memid.value }">
            		checked="checked"
            	</c:if>
            > Remember me
            <span class="pull-right">
            <a data-toggle="modal" href="login.jsp#myModal"> Forgot Password?</a>
            </span>
            </label>
          <button class="btn btn-theme btn-block" type="submit"><i class="fa fa-lock"></i> SIGN IN</button>
        </div>
        <!-- Modal -->
        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">비밀번호를 잊어버리셨나요?</h4>
              </div>
              <div class="modal-body">
                <p>당신의 아이디를 입력 하세요.</p>
                <input id="id" type="text" placeholder="ID" autocomplete="off" class="form-control placeholder-no-fix">
              </div>
              <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-default" type="button">취소</button>
                <button id="findPwd" class="btn btn-theme" type="button">보내기</button>
              </div>
            </div>
          </div>
        </div>
        <!-- modal -->
      </form>
    </div>
  </div>
  <!-- js placed at the end of the document so the pages load faster -->
  <script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
  <script src="<c:url value='/resources/lib/bootstrap/js/bootstrap.min.js'/>"></script>
  <!--BACKSTRETCH-->
  <!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
  <script type="text/javascript" src="<c:url value='/resources/lib/jquery.backstretch.min.js'/>"></script>
  <script>
    $.backstretch("img/login-bg.jpg", {
      speed: 500
    });
    
    $(function(){
    	$('#findPwd').click(function(){
    		event.preventDefault();
    		
    		let id = $('input#id').val();
    		if(id.length == 0){
    			alert("id를 입력해주세요.");
    		}else{
    			location.href="<c:url value='/member/changePwd.do'/>?memId="+id;
    		}
    	});
    });
  </script>
</body>

</html>

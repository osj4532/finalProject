<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일전송 완료 페이지</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">

  <!-- Bootstrap core CSS -->
<link href="<c:url value='/resources/lib/bootstrap/css/bootstrap.min1.css'/>"  rel="stylesheet">
<style type="text/css">
	.wraper{
		margin: 0 auto;
		width: 700px;
		margin-top: 80px;
	}

	.imgDiv{
		font-size: 8em;
		color:rgb(255,76,46);
	}
	
	.align-center{
		text-align: center;
	}
	
	.closeBtn{
		width : 250px;
		height: 80px;
		font-size: 1.2em;
		background: rgb(51,51,51);
		color:white;
		font-weight:bold;
		margin-top: 30px;
		border: 1px solid rgb(51,51,51);
	}
</style>
</head>
<body>
<div class="wraper">
	<div class="imgDiv align-center">
		<i class="fas fa-check"></i>
	</div>
	<div class="titleDiv align-center">
		<h1>메일 발송 완료!</h1>
	</div>
	<div class="commentDiv align-center">
		<p>메일 발송이 완료 되었습니다. 보내신 메일은 보낸 메일함에서 확인 하실수 있습니다.
		보낸 메일이 없을 경우 새로 고침을 해주세요</p>
	</div>
	<hr>
	<div class="btnDiv align-center">
		<button class="closeBtn" onclick="top.window.close()">닫기</button>
	</div>
</div>
</body>
</html>
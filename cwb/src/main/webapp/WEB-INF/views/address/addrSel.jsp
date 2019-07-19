<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
  <link href="<c:url value='/resources/lib/bootstrap/css/bootstrap.min1.css'/>"  rel="stylesheet">
  <style type="text/css">
  	.container-1{
  		width:300px;
  		vertical-align: middle;
  		white-space: nowrap;
  		position: relative;
  	}
  	
  	.container-1 input#addrSearch{
  		width:300px;
  		height: 50px;
  		background: #F2F2F2;
  		border: none;
  		font-size: 10pt;
  		float: left;
  		color:#63717f;
  		padding-left: 45px;
  		-webkit-border-radius: 5px;
  		-moz-border-radius: 5px;
  		border-radius: 5px;
  	}
  	
  	.container-1 input#search::-webkit-input-placeholder {
   		color: #65737e;
	}
 
	.container-1 input#search:-moz-placeholder { /* Firefox 18- */
	   color: #65737e;  
	}
	 
	.container-1 input#search::-moz-placeholder {  /* Firefox 19+ */
	   color: #65737e;  
	}
	 
	.container-1 input#search:-ms-input-placeholder {  
	   color: #65737e;  
	}
	
	.container-1 .icon{
	  position: absolute;
	  top: 40%;
	  margin-left: 17px;
	  margin-top: 14px;
	  z-index: 1;
	  color: #4f5b66;
	}
	
	.container-1 input#search:focus, .container-1 input#search:active{
	    outline:none;
	    background: #ffffff;
	    border: 1px solid gray;
	    border-bottom: 2px solid gray;
	  }
	
	.topnav{
		position: relative;
		height: 60px;
		vertical-align: middle;
	}
	
	.header{
		font-size: 2em;
		position: absolute;
		top:8px;
	}
	
	.box{
		position: absolute;
  		width: 300px;
  		height: 50px;
  		left:230px;
  		top:5px;
  	}
  	
  	.title i{
  		color:blue;
  		font-size: 1.2em;
  		margin-right: 10px;
  	}
  	
  	.close{
  		position: absolute;
  		left:550px;
  		top:9px;
  		height: 40px;
  		font-size: 40px;
  		
  		border: none;
  		background-color: transparent;
  		
  		cursor: pointer;
  	}
  	
  	.close{
  		outline: none;
  	}
  	
  	.addrMenu{
  		overflow: hidden;
  	}
  	
  	.addrCheck{
  		float: left;
  		width:200px;
  	}
  	
  	.addrKind{
  		float: left;
  		width:200px;
  	}
  	
  	input[type=checkbox]{
		width:30px;
		height: 30px;
  	}
  </style>
</head>
<body>



<div class="topnav">
	<div class="header">
		<span class="title"><i class="fas fa-user-circle"></i>연락처 선택</span>
	</div>
	<div class="box">
		<div class="container-1">
			<span class="icon"><i class="fa fa-search"></i></span>
			<input type="search" id="addrSearch" placeholder="연락처 검색">
		</div>
	</div>
	<button type="button" class="close" aria-label="Close">
          <span aria-hidden="true">&times;</span>
    </button>
</div>

<div class="addrMenu">
	<div class="addrCheck">
		<input type="checkbox" id="chkAll">
		<span>전체 선택</span>
	</div>
	<div class="addrKind">
		<select class="form-control">
			<option>사내 주소록</option>
			<option>개인 주소록</option>
		</select>
	</div>
</div>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('.close').click(function(){
			//창 닫기
		});
		
		$('#addrSearch').keyup(function(){
			//ajax로 검색 결과 보여주기
		});
	});
</script>

</body>
</html>
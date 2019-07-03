<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../inc/top.jsp" />

<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
    <style>
      #wraper1{
      	background: lightgray;
      	padding: 20px;
		min-height:750px;
		overflow: hidden;
		padding-top: 100px;
      }
      
      .content{
      	background: white;
      	min-height:600px;
      	z-index:1;
      }
	
	#typeDiv{
		width:100%;
		min-height:570px;
		overflow:hidden;
	}
	
	#typeDiv #tDiv1{
		float:left;
		width:29%;
		border-right: 1px solid silver;
		min-height: 600px;
	}
	
	#typeDiv #tDiv2{
		float:left;
		width:69%;
		border-left: 1px solid silver;
		min-height: 600px;
	}
	
	#typeBtn{
		margin-left: 15px;
	}
	
    </style>
</head>
<body>
    <div class="container" id="wraper1">
      <div class="row">
        <div class="col panel">
          <h1>문서관리</h1>
            <ul class="nav nav-tabs">
              <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#qwe">문서종류등록</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#asd">문서양식등록</a>
              </li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane fade show active content" id="qwe">
                <div id="typeDiv">
                	<div id="tDiv1">
                		<h3>문서종류</h3>
                		
                		<ul class="list-group">
                			<li class="list-group-item"><i class="far fa-file-alt fa-lg"></i> test</li>
                			<li class="list-group-item"><i class="far fa-file-alt fa-lg"></i> test</li>
                		</ul>
                	</div>
                	<div id="tDiv2">
                		<h3>문서종류등록</h3>
                		<form name="typeForm" method="post" action="">
                			<div class="form-group col-md-4">
                				<label for="typeName">문서 종류 이름</label>
                				<input type="text" name="typeName" class="form-control form-control-lg">
                			</div>
                			<button type="submit" id="typeBtn" class="btn btn-info">등록하기</button>
                		</form>
                	</div>
                </div>
              </div>
              <div class="tab-pane fade content" id="asd">
                <p>Nunc vitae turpis id nibh sodales commodo et non augue. Proin fringilla ex nunc. Integer tincidunt risus ut facilisis tristique.</p>
              </div>
            </div>
        </div>
      </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	
    <c:import url="../inc/bottom.jsp"/>
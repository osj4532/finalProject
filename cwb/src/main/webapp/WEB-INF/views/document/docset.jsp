<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../inc/top.jsp" />

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
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
      
	.nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
   		color: white;
    	background-color: rgb(38,123,204);
    	border-color: #dee2e6 #dee2e6 #fff;
	}
      
    .nav-link{
    	background: skyblue;
		color:white;
	}
      
    .nav-link:hover{
    	color:white;
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
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id ornare libero. Vivamus iaculis, justo vel mattis pharetra, nisi ligula varius nisl, sit amet mollis tortor ligula vitae nisi.</p>
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
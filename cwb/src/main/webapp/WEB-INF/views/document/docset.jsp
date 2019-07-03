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
	
	div[id^=tDiv]{
		padding:5px 30px;
	}
	
	#typeDiv #tDiv1, #typeDiv #tDiv3, #typeDiv #tDiv4{
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
	
	#typeDiv #tDiv3 li{
		color:gray;
	}
	
	#typeDiv #tDiv3 li:hover{
		background-color: rgb(38,123,204);
		color:white;
		
	}
	
	#typeDiv #tDiv4{
		border-left: 1px solid silver;
	}
	
	#typeDiv #tDiv5{
		float:left;
		width:40%;
		border-left: 1px solid silver;
		min-height: 600px;
	}
	
	table th, table td{
		text-align: center;
	}
	
	thead.thead-dark{
		background: #000;
		color:#fff;
	}
	
	@media(max-width:1200px){
		#typeDiv #tDiv3{
			width: 100%;
			float: none;
			min-height: 200px;
			border-bottom: 1px solid silver;
		}
		#typeDiv #tDiv4{
			width: 100%;
			float: none;
			min-height: 200px;
			border-bottom: 1px solid silver;
		}
		#typeDiv #tDiv5{
			width: 100%;
			float: none;
			min-height: 200px;
			border-bottom: 1px solid silver;
		}
		
		
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
                			<div class="form-group">
                				<label for="typeName">문서 종류 이름</label>
                				<input type="text" name="typeName" class="form-control form-control-lg">
                			</div>
                			<div>
                				<button type="submit" id="typeBtn" class="btn btn-info">등록하기</button>
                			</div>
                		</form>
                	</div>
                </div>
              </div>
              <div class="tab-pane fade content" id="asd">
                <div id="typeDiv">
                	<div id="tDiv3">
                		<h3>문서종류</h3>
                		<ul class="list-group">
                			<a href="#"><li class="list-group-item"><i class="far fa-file-alt fa-lg"></i> testType1</li></a>
                			<a href="#"><li class="list-group-item"><i class="far fa-file-alt fa-lg"></i> testType2</li></a>
                		</ul>
                	</div>
                	<div id="tDiv4">
                		<h3>문서양식종류</h3>
                		<table id="memList" class="table">
						<thead class="thead-dark">
							<tr>
								<th>선택</th>
								<th>문서종류</th>
								<th>양식이름</th>
								<th>보기권한</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input type="checkbox" name="sel" value="${map['MEM_NO'] }">
								</td>
								<td>testType1</td>
								<td>testForm1</td>
								<td>팀장이상</td>
							</tr>
						</tbody>
					</table>
                	</div>
                	
                	<div id="tDiv5">
                		<h3>문서양식등록</h3>
                		<form name="docForm">
                			<div class="form-group col-4">
                				<label for="ranksNo">문서종류</label>
                				<select class="form-control" id="ranksNo" name="ranksNo">
                					<option>선택해주세요.</option>
                				</select>
                			</div>
                			<div class="form-group col-4">
                				<label for="formName">양식 이름</label>
                				<input type="text" name="formName" class="form-control form-control-lg">
                			</div>
                			<div class="form-group col-4">
                				<label for="ranksNo">보기권한</label>
                				<select class="form-control" id="ranksNo" name="ranksNo">
                					<option>선택해주세요.</option>
                				</select>
                			</div>
                			<div>
                				<button type="submit" id="typeBtn" class="btn btn-info">등록하기</button>
                			</div>
                		</form>
                	</div>
                </div>
              </div>
            </div>
        </div>
      </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	
    <c:import url="../inc/bottom.jsp"/>
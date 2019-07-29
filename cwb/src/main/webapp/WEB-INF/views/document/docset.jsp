<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../inc/top.jsp" />

<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"> -->
    <style>
      #wraper1{
      	background: lightgray;
      	padding: 20px;
		overflow: hidden;
		padding-top: 70px;
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
	
	#typeDiv #tDiv1, #typeDiv #tDiv3{
		float:left;
		width:20%;
		border-right: 1px solid silver;
		min-height: 600px;
	}
	
	#typeDiv #tDiv4{
		float:left;
		width:41%;
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
		width:38%;
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
	
	span#error1{
		color:red;
	}
	
	#tDiv1 li:hover{
		background: rgb(38,123,204);
		color:#FFF;
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

<c:set var="typeNo" value="0"/>

<body>
    <div class="container" id="wraper1">
      <div class="row wraper2">
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
                			<c:forEach var="map" items="${typeList }">
                				<a onclick="selectType('${map['TYPE_NAME']}')">
                					<li class="list-group-item">
                						<i class="far fa-file-alt fa-lg"></i> 
                						${map['TYPE_NAME'] }
                					</li>
                				</a>
                			</c:forEach>
                		</ul>
                	</div>
                	<div id="tDiv2">
                		<h3>문서종류등록</h3>
                		<form name="typeForm" method="post" action="<c:url value="/document/docTypeIn.do"/>">
                			<div class="form-group">
                				<label for="typeName">문서 종류 이름</label>
                				<input type="text" name="typeName" class="form-control form-control-lg">
                				<span id="error1">문서 종류 이름을 입력해 주세요.</span>
                			</div>
                			<div>
                				<button type="submit" id="typeBtn" class="btn btn-info">등록하기</button>
                				<button type="button" id="typeDel" class="btn btn-danger">삭제하기</button>
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
                			<c:forEach var="map" items="${typeList }">
                				<li class="list-group-item">
                					<i class="far fa-file-alt fa-lg"></i> 
                					${map['TYPE_NAME'] }
                				</li>
                			</c:forEach>
                		</ul>
                	</div>
                	<div id="tDiv4">
                		<h3>문서양식종류</h3>
                		<table id="memList" class="table table-hover">
						<thead class="thead-dark">
							<tr>
								<th>선택</th>
								<th>문서종류</th>
								<th>양식이름</th>
								<th>보기권한</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="map" items="${formList }">
								<tr>
									<td>
										<input type="checkbox" name="sel" value="${map['FORM_NO'] }">
									</td>
									<td>${map['TYPE_NAME'] }</td>
									<td>${map['FORM_NAME'] }</td>
									<td>${map['RANKS_NAME'] }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<form name="formDelfrm" method="post" action="<c:url value="/document/docFormDel.do"/>">
						<input type="hidden" name="selForm">
					</form>
					<div class="text-center">
						<button id="formDel" class="btn btn-danger">삭제하기</button>
					</div>
                	</div>
                	
                	<div id="tDiv5">
                		<h3>문서양식등록</h3>
                		<form name="docForm" method="post" action="<c:url value='/document/docFormIn.do'/>">
                			<div class="form-group col-4">
                				<label for="ranksNo">문서종류</label>
                				<select class="form-control" id="typeNo" name="typeNo">
                					<option value="0">선택해주세요.</option>
                					<c:forEach var="map" items="${typeList }">
                						<option value="${map['TYPE_NO'] }">${map['TYPE_NAME'] }</option>
                					</c:forEach>
                				</select>
                			</div>
                			<div class="form-group col-4">
                				<label for="formName">양식 이름</label>
                				<input type="text" name="formName" class="form-control form-control-lg">
                			</div>
                			<div class="form-group col-4">
                				<label for="ranksNo">보기권한</label>
                				<select class="form-control" id="ranksNo" name="ranksNo">
                					<option value="0">선택해주세요.</option>
                					<c:forEach var="vo" items="${rankList }">
                						<option value="${vo.ranksNo }">${vo.ranksName }</option>
                					</c:forEach>
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
	<script type="text/javascript">
		function selectType(typeName){
			$('input[name=typeName]').val(typeName);
		}
	
		$(function(){
			var isDel = false;
			$('span#error1').hide();
			
			$('#typeDel').click(function(){
				isDel = confirm('삭제하시겠습니까?');
				if(isDel){
					$('form[name=typeForm]').attr("action","<c:url value='/document/docTypeDel.do'/>");
					$('form[name=typeForm]').submit();
				}
			});
			
			$('form[name=typeForm]').submit(function(){
				var typeNames = new Array;
				<c:forEach var="map" items="${typeList}">
					typeNames.push("${map['TYPE_NAME']}");
				</c:forEach>
				
				
				if($('input[name=typeName]').val() == ''){
					$('span#error1').html("문서 종류 이름을 입력해 주세요.");
					$('span#error1').show();
					return false;
				}else{
						
					if(!isDel){
						var isDuple = false;
						
						$('form[name=typeForm]').attr("action","<c:url value='/document/docTypeIn.do'/>");
						
						for(var i = 0; i < typeNames.length; i++){
							if(typeNames[i] == $('input[name=typeName]').val()){
								isDuple = true;
								break;
							}
						}
						
						if(isDuple){
							$('span#error1').html("같은 이름의 문서 종류가 있습니다.");
							$('span#error1').show();
							return false;
						}else{
							$('span#error1').hide();
						}
					}
				}
			});
			
			//=======================================================================
			//문서 양식 스크립트
			var selForm = [];
			$('#formDel').click(function(){
				$('input[name=sel]:checked').each(function(idx,item){
					selForm.push($(this).val());
				});
				
				if(selForm.length == 0){
					alert("삭제할 양식을 선택해주세요.");
				}else{
					$('input[name=selForm]').val(selForm);
					$('form[name=formDelfrm]').submit();
				}
			});
			
			$('form[name=docForm]').submit(function(){
				if($('form[name=docForm] #typeNo').val() == 0){
					alert('양식 종류를 선택해주세요.');
					return false;
				}else if($('form[name=docForm] input[name=formName]').val() == ''){
					alert("양식 이름을 입력해주세요");
					return false;
				}else if($('form[name=docForm] #ranksNo').val() == 0){
					alert("문서보안등급을 선택해주세요.");
					return false;
				}
			});
			
		});
	</script>
	
	
    <c:import url="../inc/bottom.jsp"/>
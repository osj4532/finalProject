<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<c:import url="../inc/top.jsp"></c:import>

<style type="text/css">
ul, #docType {
  list-style-type: none;
}

#docType {
  margin: 0;
  padding: 0;
}

.box {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.box::before {
  content: "\2610";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.check-box::before {
  content: "\2611"; 
  color: dodgerblue;
}

.nested {
  display: none;
}

.active {
  display: block;
}

#wraper1{
	overflow: hidden;
	margin: 0 auto;
	margin-top: 80px;
}

#selInfo1, #selInfo2{
	float: left;
	border: 1px solid silver;
	height: 600px;
	margin-right: 10px;
	overflow:auto;
}

tabel th{
	text-align: cetner;
}

#btnline{
	margin-top: 5px;
}


</style>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
</head>
<body>

<div class="container panel">
	<form name="frm1" action="<c:url value='/document/docSel.do'/>" method="post">
	<div class="row" id="wraper1">
		
		<div id="selInfo1" class="col-sm-4 col-md-4">
			<h3>결재양식</h3>
			<hr>
			<ul id="docType">
				<c:forEach var="typeMap" items="${docTypeList}">
				
					<li>
			  			<span class="box">
			  	 			<i class="fas fa-folder" name="ficon"></i>${typeMap['TYPE_NAME'] }
			  			</span>
				
						<ul class="nested">
							<c:forEach var="formMap" items="${docFormList}">
								<c:if test="${typeMap['TYPE_NO'] == formMap['TYPE_NO'] }">
									<li>
										<span id="tree">&#9507;</span>
										<a id="inputInfo" onclick="getFormInfo(${formMap['FORM_NO']})"
										> ${formMap['FORM_NAME'] }</a>
									</li>
								</c:if>
							</c:forEach>
						
						</ul>
			  		</li>
				</c:forEach>
			</ul>
		</div>
		
		<div id="selInfo2" class="col-sm-6">
			<h3>상세정보</h3>
			<hr>
				<input type="hidden" name="formNo">
				<div class="form-group">
					<label>문서종류</label>
					<input name="doc" type="text" class="form-control" readonly="readonly">
				</div>
				<div class="form-group">
					<label>문서양식종류</label>
					<input name="form" type="text" class="form-control" readonly="readonly">
				</div>
				<div class="form-group">
					<label>양식보안등급</label>
					<input name="ranks" type="text" class="form-control" readonly="readonly">
				</div>
				<div class="form-group">
					<label>결재라인지정</label>
					<select class="form-control" id="lineSel" name="regNo">
						<option value="0">선택하세요</option>
						<c:forEach var="vo" items="${lineList }">
							<option value="${vo.regNo }" 
								<c:if test="${vo.regNo == param.regNo }">
									selected="selected"
								</c:if>
							>${vo.regName }</option>
						</c:forEach>
						
					</select>
					<a id="btnline" class="btn btn-info btn-sm">결재라인등록</a>
				</div>
				<div>
					<table id="regMem" class="table table">
						
					</table>
				</div>
			</div>
		</div>
		<br>
		<input type="submit" class="btn btn-primary btn-lg" value="확인">
		<a class="btn btn-danger btn-lg" href="<c:url value='/document/docSel.do'/>">취소</a>
	</form>
</div>

<script src="http://code.jquery.com/jquery-3.4.1.min.js" type="text/javascript"></script>
<script src="<c:url value='/resources/lib/bootstrap/js/bootstrap1.min.js'/>"></script>
<script type="text/javascript">

$(function(){
	var toggler = $('.box');
	var folders = $('i[name=ficon]');
	
	$(toggler).each(function(idx, item){
		$(this).click(function(){
			$(this).next().toggleClass("active");
			$(this).toggleClass("check-box");
			
			if($(folders[idx]).attr("class") == "fas fa-folder"){
		    	$(folders[idx]).attr("class", "fas fa-folder-open");
			  }else{
				  $(folders[idx]).attr("class", "fas fa-folder");
			  } 
		});
	});
	
	$('#btnline').click(function(){
		location.href="<c:url value='/line/linereg.do'/>";
	});
	
	$('#lineSel').change(function(){
		$.ajax({
			url:"<c:url value='/document/docSelLine.do'/>",
			type:"post",
			data:{"regNo":$('#lineSel').val()},
			dataType:"json",
			success:function(data){
				
				let table = $('#regMem');
				table.html("<tr><th>부서</th><th>직책</th><th>이름</th></tr>");
				
				
				

				
				for(let i = 0; i < data.length; i++){
					let map = data[i];
					let trEl = $("<tr></tr>");
					let tdEl1 = $("<td></td>").html(map['DEPT_NAME']);
					let tdEl2 = $("<td></td>").html(map['POS_NAME']);
					let tdEl3 = $("<td></td>").html(map['MEM_NAME']);
					
					trEl.append(tdEl1);
					trEl.append(tdEl2);
					trEl.append(tdEl3);
					
					table.append(trEl);
				}
			},
			error:function(xhr, status, error){
				alert("에러 발생!!\n"+status+" : "+error);
			}
		});
	});
	
	$('form[name=frm1]').submit(function(){
		if($('input[name=doc]').val() == ''){
			alert("양식을 선택해 주세요");
			return false;
		}else if($('select[name=regNo]').val() == 0){
			alert("결재라인을 선택해주세요");
			return false;
		}
	});
	
});

function getFormInfo(formNo){
	$.ajax({
		url:"<c:url value='/document/docSelForm.do'/>",
		type:"post",
		data:{"formNo":formNo},
		dataType:"json",
		success:function(data){
			$('input[name=formNo]').val(data['FORM_NO']);
			$('input[name=doc]').val(data['TYPE_NAME']);
			$('input[name=form]').val(data['FORM_NAME']);
			$('input[name=ranks]').val(data['RANKS_NAME']);
		},
		error:function(xhr, status, error){
			alert("에러 발생!!\n"+status+" : "+error);
		}
	});
}

</script>

<c:import url="../inc/bottom.jsp"></c:import>
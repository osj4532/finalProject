<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="../inc/top.jsp"></c:import>

<style type="text/css">
	
	#wraper1{
		padding: 20px;
		min-height:750px;
		padding-top: 100px;
	}
	
	#inner1{
		overflow:hidden;
	}
	
	#inner1 #info1, #inner1 #info2{
		height:150px;
	}
	
	#inner1 #info1{
		float:left;
		min-width: 210px;
	}
	
	#inner1 #info1 th{
		width:50px;
	}
	
	#inner1 #info2{
		float:right;
	}
	
	#inner1 #info2 th{
		width: 30px;
	}
	
	#inner1 #info2 td{
		min-width: 90px;
	}
	
	#title{
		text-align: center;
		letter-spacing: 10px;
		font-size: 1.2em;
	}
	
	table{
		text-align: center;
	}
	
	table th{
		text-align: center;
	}
	
	.align-left{
		text-align: left;
	}
	
	.align-right{
		text-align: right;
	}
	
</style>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
</head>
<body>
<div id="wraper1" class="container panel">
	<div id="title">
		<h1>${formInfo['FORM_NAME'] }</h1>
	</div>
	<div id="inner1">
		<table border="1px solid black" id="info1">
			<tr>
				<th>기안자</th>
				<td>${member['MEM_NAME'] }</td>
			</tr>
			<tr>
				<th>부서</th>
				<td>${member['DEPT_NAME'] }</td>
			</tr>
			<tr>
				<th>직책</th>
				<td>${member['POS_NAME'] }</td>
			</tr>
			<tr>
				<th>기안일</th>
				<td><fmt:formatDate value="${cfVo.cfRegdate }" pattern="yyyy-MM-dd (E)"/></td>
			</tr>
		</table>
		<table border="1px solid black" id="info2">
			<tr>
				<th rowspan="3">결재</th>
				<c:forEach var="map" items="${clList }">
					<td>${map['MEM_NAME'] }</td>
				</c:forEach>
					
			</tr>
			<tr>
				<c:forEach var="map" items="${clList }">
					<td style="height: 60%">사인</td>
				</c:forEach>
				
			</tr>
			<tr>
				<c:forEach var="map" items="${clList }">
					<td>
						
					</td>
				</c:forEach>
			
				
			</tr>
		</table>
	</div>
	<br>
	<table class="table table-sm table-bordered">
		<tr>
			<th>문서 종류</th>
			<td>${formInfo['TYPE_NAME'] }</td>
			<th>문서 양식 종류</th>
			<td>${formInfo['FORM_NAME'] }</td>
			<th>양식 보안 등급</th>
			<td>${formInfo['RANKS_NAME'] }</td>
		</tr>
	</table>
	
	<br>
	<form name="frm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="formNo" value="${formInfo['FORM_NO']}">
		<input type="hidden" name="memNo" value="${member['MEM_NO'] }">
		<input type="hidden" name="deptNo" value="${member['DEPT_NO'] }">
		<input type="hidden" name="regNo" value="${clList[0]['REG_NO'] }">
		<input type="hidden" name="cfNo" value="${cfVo.cfNo }">
		<table class="table">
			<tr>
				<th scope="col">
					<label for="cfTitle">제목</label>
				</th>
				<td>
					<input class="form-control" type="text" name="cfTitle" value="${cfVo.cfTitle }">
				</td>
			</tr>
			
			<tr>
				<td colspan="2" class="align-left">
					<textarea id="summernote" name="cfContent">${cfVo.cfContent }</textarea>
					<span style="color:green;">※ 파일 삭제버튼을 누르면 취소를 눌러도 복구되지 않습니다.</span>
				</td>
			</tr>
			<tr>
				<th><label for="fileName">첨부 된 파일</label></th>
				<td id="fileList"></td>
			</tr>
			<tr>
				<th><label for="fileName">첨부 파일</label></th>
				<td><input class="form-control" type="file" multiple="multiple" name="fileName"></td>
			</tr>
		</table>
		<hr>
	</form>
		<div>
			<button id="save" class="btn btn-info">결재요청</button>
			<c:if test="${cfVo.cfTmpstorage=='Y' }">
				<button id="tmpSave" class="btn btn-warning">문서임시저장</button>
			</c:if>
			<button id="cancel" class="btn btn-danger">취소</button>
		</div>
</div>

<c:import url="../inc/bottom.jsp"></c:import>
<script type="text/javascript" src="<c:url value="/resources/summernote/summernote.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/summernote/lang/summernote-ko-KR.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    $('#summernote').summernote({
	    	height:500,
	    	lang: 'ko-KR',
	    	fontNames: ['돋움','휴먼모음T','궁서','휴먼옛체' ]
	    });
	});
	
	
	$(function(){
		$.showFile(${cfVo.cfNo });
		
		
		$('#tmpSave').click(function(){
			if($('input[name=cfTitle]').val() == ""){
				alert("제목을 입력해 주세요.");
				
			}else{
				$('form[name=frm]').attr("action","<c:url value='/document/docTmp.do'/>");
				$('form[name=frm]').submit();
			}
		});
		
		
		$('#save').click(function(){
			
			if($('input[name=cfTitle]').val() == ""){
				alert("제목을 입력해 주세요.");
				
			}else{
				$('form[name=frm]').attr("action","<c:url value='/document/docEdit.do'/>");
				$('form[name=frm]').submit();
			}
		});
		
		
		$('#cancel').click(function(){
			var check = confirm("현재 내용은 저장되지 않습니다. 화면을 나가시겠습니까?");
			if(check){
				location.href="<c:url value='/document/docList.do'/>";
			}
		});
	});
	
	$.showFile = function(cfNo){
		console.log("파일목록 보여주기");
		$.ajax({
			url:"<c:url value='/document/docFileSel.do'/>",
			type:"post",
			data: {"cfNo":cfNo },
			dataType:"json",
			success:function(res){
				$('#fileList').html('');
				
				if(res.length == 0){
					$('#fileList').append("첨부된 파일이 없습니다.");
				}
				
				$.each(res, function(idx, item){
					
					let originalFileName = item.fileOriginalName;
					let fileSize = item.fileSize;
					let fileName = item.fileName;
					
					let pEl = $('<p></p>').html(originalFileName+"["+fileSize+"B]");
					let iEl = $('<i></i>');
					
					$(iEl).attr('class',"fas fa-trash-alt");
					$(iEl).attr('onclick',"delFile('"+fileName+"',"+cfNo+")");
					
					pEl.append(iEl);
					
					$('#fileList').append(pEl);
					$('#fileList').css('text-align','right');
					
				});
			},
			error:function(jqXHP, status, error){
				alert("에러 발생!!\n"+status+" : "+error);
			}
		});
	};
	
	function delFile(fileName,cfNo){
		$.ajax({
			url:"<c:url value='/document/docFileDel.do'/>",
			type:"post",
			data: {"fileName":fileName, "cfNo": cfNo},
			dataType:"json",
			success:function(res){
				if(res != 1){
					alert("파일 제거 실패!");
				}
			},
			error:function(jqXHP, status, error){
				alert("에러 발생!!\n"+status+" : "+error);
			}
		});
		$.showFile(${cfVo.cfNo });
		event.preventDefault();
	};
	
</script>




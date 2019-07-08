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
</style>
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
				<td><fmt:formatDate value="${today }" pattern="yyyy-MM-dd (E)"/></td>
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
						<button type="button" class="btn btn-info btn-sm" disabled="disabled">결재</button>
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
	
	<table class="table">
		<tr>
			<th scope="col">
				<label for="cfTitle">제목</label>
			</th>
			<td>
				<input class="form-control" type="text" name="cfTitle">
			</td>
		</tr>
		<tr>
			<td colspan="2">	
				<textarea id="cfContent" class="form-control" rows="25"></textarea>
			</td>
		</tr>
		<tr>
			<th><label for="fileName">첨부파일</label></th>
			<td>
				<input type="file" multiple="multiple" name="fileName">
			</td>
		</tr>
	</table>
	<hr>
	<div>
		<button id="save" class="btn btn-info">결재요청</button>
		<button class="btn btn-warning">임시저장</button>
		<button class="btn btn-danger">취소</button>
	</div>
</div>

<script type="text/javascript" src="<c:url value="/resources/lib/HuskyEZCreator.js"/>"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	var oEditors = [];
	
	$(function(){
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "cfContent",
			sSkinURI: "<c:url value='/resources/lib/SmartEditor2Skin.html'/>",
			htParams:{
				bUseToolbar : true,
				bUseVerticalResizer : true,
				bUseModeChanger : true,
				fOnBeforeUnload : function(){

	            }
			},
			
			fOnAppLoad : function(){
	              oEditors.getById["ir1"].exec("PASTE_HTML", [""]);
	          },
	          fCreator: "createSEditor2"
		});
		
		/* $("#save").click(function(){
	          oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	          $("#frm").submit();
	     }); */
	});
	
</script>


<c:import url="../inc/bottom.jsp"></c:import>
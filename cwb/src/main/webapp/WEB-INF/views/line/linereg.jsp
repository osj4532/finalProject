<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    

<c:import url="../inc/top.jsp"/>


<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"> -->

<style type="text/css">
	#wraper1{
		padding: 20px;
		min-height:750px;
		overflow: hidden;
		padding-top: 100px;
		padding-left: 50px;
	}
	
	a{
		text-decoration: none;
	}
	
	div[id^=div]{
		border: 1px solid black;
		background-color: white;
	}
	
	#div1{
		/* width: 150px; */
		min-height:600px;
		text-align: center;
		float: left;
	}
	
	#div1 li:hover{
		background-color: blue;
		color:white;
		
	}
	
	#div2{
		/* width:500px; */
		min-height:600px;
		text-align: center;
		float: left;
	}
	
	table{
		/* width:350px; */
		width:100%;
	}
	
	table th{
		text-align: center;
	}
</style>

<script type="text/javascript" src="<c:url value="/resources/lib/jquery/jquery.min.js"/>"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	var tmpArr = [];
	var selArr = [];

	<c:if test="${!empty selMemberList}">
		<c:forEach var="map" items="${selMemberList}">
			selArr.push("${map['MEM_NO']}");
		</c:forEach>
	</c:if>
	
	$(function(){
		$('input[type=button]').click(function(){
			$('input[name=sel]:checked').each(function(){
				tmpArr.push($(this).val());
			});
			
			for(var i = 0; i < tmpArr.length; i++){
				selArr.push(tmpArr[i]);
			}
			
			tmpArr = [];
			sear('${memberList[0]["DEPT_NO"]}');
		});
		
		
		$('form[name=lineRegForm]').submit(function(){
			$('input[name=sel]:checked').each(function(){
				selArr.push($(this).val());
			});
			
			$('#selArr').val(selArr);
			var lineName = prompt("결제라인 이름 등록");
			if(lineName == null){
				event.preventDefault();
			}
			$('#lineName').val(lineName);
		});
		
	});

	function sear(deptNo){
		$('form[name=tmpFrm]').find('input[name=selArr]').val(selArr);
		$('form[name=tmpFrm]').find('input[name=deptNo]').val(deptNo);
		$('form[name=tmpFrm]').submit();
	}
	
	function delSel(item, deptNo){
		selArr.splice(selArr.indexOf(item),1);
		sear(deptNo);
		event.preventDefault();
	}
</script>
</head>
<body>

<form name="tmpFrm" action="<c:url value="/line/linereg.do"/>" method="post">
	<input type="hidden" name="selArr">
	<input type="hidden" name="deptNo">
	
</form>

<div id="wraper1" class="container">
	<h1>결재라인 등록</h1>
	<div class="row">
		<div id="div1" class="col-sm-3 col-md-3">
			<h2>부서목록</h2>
			<ul id="departList" class="list-group">
				<c:forEach var="vo" items="${deptList}">
					<a href="#" onclick="sear(${vo.deptNo})"><li class="list-group-item">${vo.deptName }</li></a>
				</c:forEach>
			</ul>
		</div>
			<div id="div2" class="col-sm-8">
				<h2>부서별 사원 목록</h2>
				
				<form name="lineRegForm" action="<c:url value="/line/lineproc.do"/>" method="post">
					<input type="hidden" id="selArr" name="selArr">
					<input type="hidden" id="lineName" name="lineName">
					<table id="memList" class="table table-hover">
						<thead class="thead-dark">
							<tr>
								<th>선택</th>
								<th>부서</th>
								<th>직급</th>
								<th>이름</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${!empty memberList }">
								<c:forEach var="map" items="${memberList}">
									<tr>
										<td>
											<input type="checkbox" name="sel" value="${map['MEM_NO'] }">
										</td>
										<td>${map['DEPT_NAME'] }</td>
										<td>${map['POS_NAME']}</td>
										<td>${map['MEM_NAME'] }</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<br>
					<input type="button" class="btn btn-success" value="추가하기">
					<br>
					<br>
					<hr>
					<h3>결재라인 사원 목록</h3>
					<table id="selItem" class="table">
						<thead class="thead-dark">
							<tr>
								<th>순서</th>
								<th>부서</th>
								<th>직급</th>
								<th>이름</th>
								<th>지우기</th>
							</tr>
						</thead>
						<c:if test="${!empty selMemberList }">
							<c:forEach var="i" begin="1" end="${fn:length(selMemberList) }">
								<c:set var="map" value="${selMemberList[i-1] }"/>
								<tr>
									<td>${i }</td>
									<td>${map['DEPT_NAME']}</td>
									<td>${map['POS_NAME']}</td>
									<td>${map['MEM_NAME'] }</td>
									<td><button class="btn btn-danger" onclick="delSel('${map['MEM_NO']}','${map['DEPT_NO']}')">지우기</button></td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
					<input type="submit" class="btn btn-primary" value="등록하기">
				</form>
			</div>
	</div>
</div>

<c:import url="../inc/bottom.jsp"></c:import>
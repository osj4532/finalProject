<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>
<c:set var="mypage" value="useJs"/>
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/js/paging.js'/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
			$.send(1);
	});
	
	$.send=function(curPage){
		$('input[name=currentPage]').val(curPage);
		$.ajax({
			url:"<c:url value='/commute/comPage.do'/>",
			type:"post",
			data:$("form[name=frmPage]").serialize(),
			dataType:"json",
			success:function(res){
				if(res != null){
					makePage(res);
				}
			},
			error:function(xhr, status, error){
				alert(status+":"+error);
			}
		});
	}
	
	function makePage(res){
		$('#divPage').html("");
		var totalCount=$(res).find("totalCount").text();
		
		var p_recordCount=10, p_blockSize=10;
		var p_curPage = $('input[name=currentPage]').val();
		
		pagination(p_curPage, p_recordCount, p_blockSize, totalCount);
		
		$.pageSetting();
		
	}
	$.pageSetting=function(){
		if(firstPage>1){
			var anchor=$('<a href="#"></a>')
			.html("<img src='<c:url value='/resources/img/first.JPG'/>' alt='이전블럭으로 이동'>")
			.attr("onclick", "$.send("+(firstPage-1)+")");
			
			$("#page").html(anchor);
		}
		
		for(var i=firstPage;i<=lastPage;i++){
			if(i==currentPage){
				var spanEl = $("<span style='color:blue;font-size:1em'></span>")
				.html(i);
				$('#page').append(spanEl);
			}else{
				var anchor = $("<a href='#'></a>").html("["+i+"]")
				.attr("onclick", "$.send("+i+")");
				$('#page').append(anchor);
			}
		}
		
		if(lastPage<totalPage){
			var anchor=$("<a href='#'></a>")
			.html("<img src='<c:url value='/resources/img/last.JPG'/>' alt='다음블럭으로 이동'>")
			.attr("onclick", "$.send("+(lastPage+1)+")");
			$('#page').append(anchor);
		}
	}
	
	
	function select(menu){
		$('input[name=menu]').val(menu);
		$('form[name=frmMenu]').submit();
	}
</script>
<style type="text/css">
	#Main{
		min-height:896px;
	}
	#ulMenu li{
		padding: 10px;
		margin-top: 50px;
		min-width: 180px;
	}
	#Menu{
		min-height: 890px;
		background-color: white;
	}
	#content{
		min-height: 890px;
		background-color: white;
	}
</style>

<div id="Main" class="container">
	<h1>근태조회</h1>
	<div class="row">
	<div id="Menu" class="col-md-2">
		<ul id="ulMenu" class="list-inline">
			<a href="#" onclick="select('indWork')"><li class="list-group-item d-flex justify-content-between align-items-center">개인출퇴근조회<span class="badge badge-primary badge-pill">14</span></li></a>
			<a href="#" onclick="select('indHoly')"><li class="list-group-item d-flex justify-content-between align-items-center">개인연차조회</li></a>
			<a href="#" onclick="select('depAssiduity')"><li class="list-group-item d-flex justify-content-between align-items-center">(팀장)부서근태조회</li></a>
			<a href="#" onclick="select('depAssi')"><li class="list-group-item d-flex justify-content-between align-items-center">(관리자)부서별근태조회</li></a>
			<a href="#" onclick="select('allAssiduity')"><li class="list-group-item d-flex justify-content-between align-items-center">(관리자)전체근태조회</li></a>
			<a href="#" onclick="select('allHoly')"><li class="list-group-item d-flex justify-content-between align-items-center">(관리자)전체연차조회</li></a>
		</ul>
	</div>
	<div id="content" class="col-md-8">
	<div id="title" class="col-md-8">
		<h1 style="text-align: center;background-color: white;">${title }</h1>
	</div>
	<!-- 메뉴 선택을 위한 form -->
	<form name="frmMenu" method="post" action="<c:url value='/commute/commute.do'/>">
		<input type="hidden" name="menu">	
	</form>
	<!-- 메뉴 선택을 위한 form 끝 -->
	<form name="frmPage" method="post" action="<c:url value='/commute/commute.do'/>">
		<input type="hidden" name="currentPage" value="1">	
		<input type="hidden" name="countPerPage" value="10">	
		
	</form>
		<form name="frmCommute" action="<c:url value='/commute/commute.do'/>" method="post">
			<table id="tblCommute" class="table table-hover">
				<!-- 전체근태, 개인 출퇴근조회, 부서근태조회 -->
				<c:if test="${param.menu == 'allAssiduity' || param.menu == 'indWork' || param.menu == 'depAssiduity'}">
				<colgroup>
					<col style="width:10%;" />
					<col style="width:15%;" />
					<col style="width:10%;" />
					<col style="width:15%;" />
					<col style="width:20%;" />
					<col style="width:20%;" />		
					<col style="width:10%;" />		
				</colgroup>
				<thead>
					<tr>
						<th>사원번호</th>
						<th>사원이름</th>
						<th>부서</th>
						<th>직급</th>
						<th>출근시간</th>
						<th>퇴근시간</th>
						<th>근무상태</th>
					</tr>
				</thead>
				<tbody>
					<!-- 반복시작 -->
					<c:if test="${empty list }">
						<tr>
							<td colspan="7" class="align_center">데이터가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty list }">
						<c:forEach var="map" items="${list }">
						<tr>
							<td>${map['MEMNO'] }</td>
							<td>${map['MEMNAME'] }</td>
							<td>${map['DEPTNAME'] }</td>
							<td>${map['POSNAME'] }</td>
							<td>${map['COMINDATE'] }</td>
							<td>${map['COMOUTDATE'] }</td>
							<td>${map['COMSTATUS'] }</td>
						</tr>
						<!-- 반복끝 -->
						</c:forEach>
					</c:if>
				</c:if>
				<!-- 전체근태, 개인 출퇴근조회, 부서근태조회 끝 -->
				
				<!-- 개인연차, 전체연차 조회 -->
				<c:if test="${param.menu == 'indHoly' || param.menu == 'allHoly' }">
				<colgroup>
					<col style="width:15%;" />
					<col style="width:15%;" />
					<col style="width:15%;" />
					<col style="width:15%;" />
					<col style="width:20%;" />
					<col style="width:20%;" />		
				</colgroup>
				<thead>
					<tr>
						<th>사원번호</th>
						<th>사원이름</th>
						<th>부서</th>
						<th>직급</th>
						<th>총연차</th>
						<th>사용연차</th>
					</tr>
				</thead>
				<tbody>
					<!-- 반복시작 -->
					<c:if test="${empty list }">
						<tr>
							<td colspan="6" class="align_center">데이터가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty list }">
						<c:forEach var="map" items="${list }">
						<tr>
							<td>${map['MEM_NO'] }</td>
							<td>${map['MEM_NAME'] }</td>
							<td>${map['DEPT_NAME'] }</td>
							<td>${map['POS_NAME'] }</td>
							<td>${map['MEM_HOLIDAY'] }</td>
							<td>${map['MEM_USEHOLIDAY'] }</td>
						</tr>
						<!-- 반복끝 -->
						</c:forEach>
					</c:if>
				
				</c:if>
				<!-- 개인연차, 전체연차 조회 끝 -->
				
				<!-- 부서별 근태 조회 -->
				<c:if test="${param.menu == 'depAssi' }">
				<colgroup>
					<col style="width:50%;" />
					<col style="width:50%;" />
				</colgroup>
				<thead>
					<tr>
						<th>부서</th>
						<th>총출근인원</th>
					</tr>
				</thead>
				<tbody>
					<!-- 반복시작 -->
					<c:if test="${empty list }">
						<tr>
							<td colspan="2" class="align_center">데이터가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty list }">
						<c:forEach var="map" items="${list }">
						<tr>
							<td>${map[''] }</td>
							<td>${map[''] }</td>
						</tr>
						<!-- 반복끝 -->
						</c:forEach>
					</c:if>
				
				</c:if>
				<!-- 부서별 근태조회 끝 -->
				
				</tbody>
			</table>
		</form>
		<div id="page"></div>
	</div>
	</div>
</div>

<c:import url="../inc/bottom.jsp"/>



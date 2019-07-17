<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>
<c:set var="mypage" value="useJs"/>
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/js/paging.js'/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
		showPage();
	});
	
	function showPage(){
		$('input[name=currentPage]').val();
		$.ajax({
			url:"<c:url value='/commute/comPage.do'/>",
			type:"post",
			data:$("form[name=frmPage]").serialize(),
			dataType:"json",
			success:function(res){
				if(res != null){
					makeList(res);
				}
			},
			error:function(xhr, status, error){
				alert(status+":"+error);
			}
		});
	}
	
	function setTitle(){
		var title = $('<h2></h2>');
		title.html($(title));	
		$('#title').html(title);
	}
	
	function makeList(res){
		var colgroup = $('colgroup');
		var thead = $('thead');
		var tbody = $('tbody');
		
		colgroup.html("");		
		thead.html("");
		tbody.html("");
		
		
		//전체근태, 개인 출퇴근조회, 부서근태조회
		if(menu == 'allAssiduity' || menu == 'indWork' || menu == 'depAssiduity'){
			var colstyleEl1 = $('<col style="width:10%;"/>');
			var colstyleEl2 = $('<col style="width:15%;"/>');
			var colstyleEl3 = $('<col style="width:10%;"/>');
			var colstyleEl4 = $('<col style="width:15%;"/>');
			var colstyleEl5 = $('<col style="width:20%;"/>');
			var colstyleEl6 = $('<col style="width:20%;"/>');
			var colstyleEl7 = $('<col style="width:10%;"/>');
			
			colgroup.append(colstyleEl1);
			colgroup.append(colstyleEl2);
			colgroup.append(colstyleEl3);
			colgroup.append(colstyleEl4);
			colgroup.append(colstyleEl5);
			colgroup.append(colstyleEl6);
			colgroup.append(colstyleEl7);
			
			var trEl = $('<tr></tr>');
			
			var thEl1 = $('<th></th>').html("사원번호");
			var thEl2 = $('<th></th>').html("사원이름");
			var thEl3 = $('<th></th>').html("부서");
			var thEl4 = $('<th></th>').html("직급");
			var thEl5 = $('<th></th>').html("출근시간");
			var thEl6 = $('<th></th>').html("퇴근시간");
			var thEl7 = $('<th></th>').html("근무상태");
			
			trEl.append(thEl1);
			trEl.append(thEl2);
			trEl.append(thEl3);
			trEl.append(thEl4);
			trEl.append(thEl5);
			trEl.append(thEl6);
			trEl.append(thEl7);
			
			thead.append(trEl);
			
			
			if(list.length < 1){
				var trEl = $('<tr></tr>');
				var tdEl = $('<td colspan="7"></td>').html("데이터가 없습니다.");
				
				trEl.append(tdEl);
				tbody.append(trEl);
			}
			for(var i=1;i<res.length;i++){
				var map = res[i];
				
				var trEl = $('<tr></tr>');
				var tdEl1 = $('<td></td>').html(map['MEMNO']);
				var tdEl2 = $('<td></td>').html(map['MEMNAME']);
				var tdEl3 = $('<td></td>').html(map['DEPTNAME']);
				var tdEl4 = $('<td></td>').html(map['POSNAME']);
				var tdEl5 = $('<td></td>').html(map['COMINDATE']);
				var tdEl6 = $('<td></td>').html(map['COMOUTDATE']);
				var tdEl7 = $('<td></td>').html(map['COMSTATUS']);
				
				trEl.append(tdEl1);
				trEl.append(tdEl2);
				trEl.append(tdEl3);
				trEl.append(tdEl4);
				trEl.append(tdEl5);
				trEl.append(tdEl6);
				trEl.append(tdEl7);
				
				tbody.append(trEl);
			}
			
			setTitle();
		//전체근태, 개인 출퇴근조회, 부서근태조회 끝
			
		//개인연차, 전체연차 조회
		}else if(menu == 'indHoly' || menu == 'allHoly'){
			var colstyleEl1 = $('<col style="width:15%;"/>');
			var colstyleEl2 = $('<col style="width:15%;"/>');
			var colstyleEl3 = $('<col style="width:15%;"/>');
			var colstyleEl4 = $('<col style="width:15%;"/>');
			var colstyleEl5 = $('<col style="width:20%;"/>');
			var colstyleEl6 = $('<col style="width:20%;"/>');
			
			colgroup.append(colstyleEl1);
			colgroup.append(colstyleEl2);
			colgroup.append(colstyleEl3);
			colgroup.append(colstyleEl4);
			colgroup.append(colstyleEl5);
			colgroup.append(colstyleEl6);
			
			var trEl = $('<tr></tr>');
			
			var thEl1 = $('<th></th>').html("사원번호");
			var thEl2 = $('<th></th>').html("사원이름");
			var thEl3 = $('<th></th>').html("부서");
			var thEl4 = $('<th></th>').html("직급");
			var thEl5 = $('<th></th>').html("총연차");
			var thEl6 = $('<th></th>').html("사용연차");
			
			trEl.append(thEl1);
			trEl.append(thEl2);
			trEl.append(thEl3);
			trEl.append(thEl4);
			trEl.append(thEl5);
			trEl.append(thEl6);
			
			thead.append(trEl);
			
			if(list.length < 1){
				var trEl = $('<tr></tr>');
				var tdEl = $('<td colspan="6"></td>').html("데이터가 없습니다.");
				
				trEl.append(tdEl);
				tbody.append(trEl);
			}
			
			for(var i=1;i<res.length;i++){
				var map = res[i];
				
				var trEl = $('<tr></tr>');
				var tdEl1 = $('<td></td>').html(map['MEM_NO']);
				var tdEl2 = $('<td></td>').html(map['MEM_NAME']);
				var tdEl3 = $('<td></td>').html(map['DEPT_NAME']);
				var tdEl4 = $('<td></td>').html(map['POS_NAME']);
				var tdEl5 = $('<td></td>').html(map['MEM_HOLIDAY']);
				var tdEl6 = $('<td></td>').html(map['MEM_USEHOLIDAY']);

				trEl.append(tdEl1);
				trEl.append(tdEl2);
				trEl.append(tdEl3);
				trEl.append(tdEl4);
				trEl.append(tdEl5);
				trEl.append(tdEl6);
				
				tbody.append(trEl);
				
			}
				setTitle();
		//개인연차, 전체연차 조회 끝
		
		
		//부서별 근태 조회
		}else if(menu == 'depAssi'){
			var colstyleEl1 = $('<col style="width:50%;"/>');
			var colstyleEl2 = $('<col style="width:50%;"/>');
			
			colgroup.append(colstyleEl1);
			colgroup.append(colstyleEl2);
			
			var trEl = $('<tr></tr>');
			
			var thEl1 = $('<th></th>').html("부서");
			var thEl2 = $('<th></th>').html("총출근인원");
			
			trEl.append(thEl1);
			trEl.append(thEl2);
			
			thead.append(trEl);
			
			if(list.length < 1){
				var trEl = $('<tr></tr>');
				var tdEl = $('<td colspan="2"></td>').html("데이터가 없습니다.");
				
				trEl.append(tdEl);
				tbody.append(trEl);
			}
			
			for(var i=1;i<res.length;i++){
				var map = res[i];
				
				var trEl = $('<tr></tr>');
				var tdEl1 = $('<td></td>').html(map['']);
				var tdEl2 = $('<td></td>').html(map['']);

				trEl.append(tdEl1);
				trEl.append(tdEl2);
				
				tbody.append(trEl);
			}
			setTitle();
			
		}
		//부서별 근태조회 끝
		var pagingInfo = res.length-1;
			
		setPage(pagingInfo);
		
		
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
		$('input[name=currentPage]').val(1);
		
		showPage();
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
	#Main > h1 {
		margin-top: 70px;
	}
	#title h2{
		text-align: center;
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
		
	</div>
	<!-- 메뉴 선택과 페이징처리를 위한 form -->
	<form name="frmPage" method="post" action="<c:url value='/commute/commute.do'/>">
		<input type="hidden" name="currentPage" value="1">	
		<input type="hidden" name="countPerPage" value="10">	
		<input type="hidden" name="menu">
	</form>
	<!-- 메뉴 선택을 위한 form 끝 -->
		<form name="frmCommute" action="<c:url value='/commute/commute.do'/>" method="post">
		<table id="tblCommute" class="table table-hover">
			<colgroup>
			
			</colgroup>
			
			<thead>
			
			</thead>
			
			<tbody>
			
			</tbody>
		</table>
		</form>
		<div id="page"></div>
	</div>
	</div>
</div>

<c:import url="../inc/bottom.jsp"/>



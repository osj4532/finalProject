<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>
<c:set var="mypage" value="useJs"/>
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/js/moment.js'/>"></script>
<script type="text/javascript">

	$(function(){
		showPage();
	});
	
	
	function showPage(){
		var menu = $('input[name=menu]').val();
		//[{"page":{"currentPage":1,"recordCountPerPage":5,"blockSize":10,"totalRecord":1,"totalPage":1,"firstPage":1,"lastPage":1,"firstRecordIndex":0,"lastRecordIndex":5}},{"COMOUTDATE":1563250427000,"RNUM":1,"DEPTNAME":"기획팀","COMSTATUS":"N","COMINDATE":1563250427000,"POSNAME":"사원","MEMNO":4,"MEMNAME":"사원2"}]
		$.ajax({
			url:"<c:url value='/commute/comPage.do'/>",
			type:"post",
			data:{"menu":menu, "currentPage":$('input[name=currentPage]').val()},
			dataType:"json",
			success:function(res){
					makeList(res);
			},
			error:function(xhr, status, error){
				alert(status+":"+error);
			}
		});
	}
	
	function setTitle(){
		var menu = $('input[name=menu]').val();
		var title = $('<h2></h2>');
		
		if(menu == 'allAssiduity'){
			title.html("전체 조회");
		}else if(menu == 'indWork'){
			title.html("개인 출퇴근 조회");
		}else if(menu == 'depAssiduity'){
			title.html("부서 근태 조회");
		}else if(menu == 'indHoly'){
			title.html("개인 연차 조회");
		}else if(menu == 'allHoly'){
			title.html("전체 연차 조회");
		}
		$('#title').html(title);
	}
	
	function page(curPage){
		var menu = $('input[name=menu]').val();
		$('input[name=currentPage]').val(curPage);
		
		showPage();
	}
	
	function makeList(res){
		var colgroup = $('colgroup');
		var thead = $('thead');
		var tbody = $('tbody');
		
		colgroup.html("");		
		thead.html("");
		tbody.html("");
		
		
		//전체근태, 개인 출퇴근조회, 부서근태조회
		if($('input[name=menu]').val() == 'allAssiduity' || $('input[name=menu]').val() == 'indWork' || $('input[name=menu]').val() == 'depAssiduity'){
			var colstyleEl1 = $('<col style="width:10%;"/>');
			var colstyleEl2 = $('<col style="width:10%;"/>');
			var colstyleEl3 = $('<col style="width:10%;"/>');
			var colstyleEl4 = $('<col style="width:10%;"/>');
			var colstyleEl5 = $('<col style="width:25%;"/>');
			var colstyleEl6 = $('<col style="width:25%;"/>');
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
			
			
			if(res.length == 1){
				var trEl = $('<tr></tr>');
				var tdEl = $('<td colspan="7"></td>').html("데이터가 없습니다.");
				
				trEl.append(tdEl);
				tbody.append(trEl);
			}
			for(var i=1;i<res.length;i++){
				var map = res[i];
				
				if(map['COMINDATE'] != null){
					var d = moment(map['COMINDATE']).format('YYYY-MM-DD HH:mm:ss');
				}
				if(map['COMOUTDATE'] != null){
					var d2 = moment(map['COMOUTDATE']).format('YYYY-MM-DD HH:mm:ss');
				}
				var status = null;
				if(map['COMSTATUS'] == 'Y'){
					status = "근무중";
				}else if(map['COMSTATUS'] == 'N'){
					status = "퇴근";
				}else{
					status = "출근전";
				}
				
				var trEl = $('<tr></tr>');
				var tdEl1 = $('<td></td>').html(map['MEMNO']);
				var tdEl2 = $('<td></td>').html(map['MEMNAME']);
				var tdEl3 = $('<td></td>').html(map['DEPTNAME']);
				var tdEl4 = $('<td></td>').html(map['POSNAME']);
				var tdEl5 = $('<td></td>').html(d);
				var tdEl6 = $('<td></td>').html(d2);
				var tdEl7 = $('<td></td>').html(status);
				
				trEl.append(tdEl1);
				trEl.append(tdEl2);
				trEl.append(tdEl3);
				trEl.append(tdEl4);
				trEl.append(tdEl5);
				trEl.append(tdEl6);
				trEl.append(tdEl7);
				
				tbody.append(trEl);
			}
			
			
		//전체근태, 개인 출퇴근조회, 부서근태조회 끝
			
		//개인연차, 전체연차 조회
		}else if($('input[name=menu]').val() == 'indHoly' || $('input[name=menu]').val() == 'allHoly'){
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
			
			if(res.length == 1){
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
		//개인연차, 전체연차 조회 끝
		
		
		//부서별 근태 조회
		}else if($('input[name=menu]').val() == 'depAssi'){
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
			
			if(res.length == 1){
				var trEl = $('<tr></tr>');
				var tdEl = $('<td colspan="2"></td>').html("데이터가 없습니다.");
				
				trEl.append(tdEl);
				tbody.append(trEl);
			}
			
			for(var i=1;i<res.length;i++){
				var map = res[i];
				
				var trEl = $('<tr></tr>');
				var tdEl1 = $('<td></td>').html(map['COUNT']);
				var tdEl2 = $('<td></td>').html(map['DEPTNAME']);

				trEl.append(tdEl1);
				trEl.append(tdEl2);
				
				tbody.append(trEl);
			}
			
		}
		//부서별 근태조회 끝
		
		setTitle();
		var pagingInfo = res[0]['page'];
			
		pageSetting(pagingInfo);
		
	}
	
	function pageSetting(pagingInfo){
		var page = $('#page').html('');
		if(pagingInfo.firstPage!=1){
			var anchor=$('<a href="#"></a>')
			.html("<img src='<c:url value='/resources/img/first.JPG'/>' alt='이전블럭으로 이동'>")
			.attr("onclick", "page("+(pagingInfo.firstPage-1)+")");
			
			$("#page").html(anchor);
		}
		
		for(var i=pagingInfo.firstPage;i<=pagingInfo.lastPage;i++){
			if(i==pagingInfo.currentPage){
				var spanEl = $("<span style='color:blue;font-size:1em'></span>")
				.html(i);
				$('#page').append(spanEl);
			}else{
				var anchor = $("<a href='#'></a>").html("["+i+"]")
				.attr("onclick", "page("+i+")");
				$('#page').append(anchor);
			}
		}
		
		if(pagingInfo.lastPage<pagingInfo.totalPage){
			var anchor=$("<a href='#'></a>")
			.html("<img src='<c:url value='/resources/img/last.JPG'/>' alt='다음블럭으로 이동'>")
			.attr("onclick", "page("+(pagingInfo.lastPage+1)+")");
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
		min-width: 185px;
	}
	#Menu{
		min-height: 890px;
		background-color: white;
	}
	#content{
		min-height: 890px;
		background-color: white;
		min-width: 900px;
	}
	#Main > h1 {
		margin-top: 70px;
	}
	#title h2{
		text-align: center;
		background-color: white;
	}
	#page{
		text-align: center;	
	}
</style>

<div id="Main" class="container">
	<h1>근태조회</h1>
	<div class="row">
	<div id="Menu" class="col-md-2">
		<ul id="ulMenu" class="list-inline">
			<c:if test="${sessionScope.ranksNo >= 1 }">
			
			<a href="#" onclick="select('indWork')"><li class="list-group-item d-flex justify-content-between align-items-center">개인출퇴근조회<span class="badge badge-primary badge-pill">14</span></li></a>
			<a href="#" onclick="select('indHoly')"><li class="list-group-item d-flex justify-content-between align-items-center">개인연차조회</li></a>
			</c:if>
			<c:if test="${sessionScope.ranksNo >= 2 }">
			<a href="#" onclick="select('depAssiduity')"><li class="list-group-item d-flex justify-content-between align-items-center">부서근태조회</li></a>
			</c:if>
			<c:if test="${sessionScope.ranksNo >= 3 }">
			<a href="#" onclick="select('depAssi')"><li class="list-group-item d-flex justify-content-between align-items-center">부서별근태조회</li></a>
			<a href="#" onclick="select('allAssiduity')"><li class="list-group-item d-flex justify-content-between align-items-center">전체근태조회</li></a>
			<a href="#" onclick="select('allHoly')"><li class="list-group-item d-flex justify-content-between align-items-center">전체연차조회</li></a>
			</c:if>
		</ul>
	</div>
	<div id="content" class="col-md-8">
	<div id="title" class="col-md-8">
		
	</div>
	<!-- 메뉴 선택과 페이징처리를 위한 form -->
	<form name="frmPage" method="post" action="<c:url value='/commute/commute.do'/>">
		<input type="hidden" name="currentPage" value="1">	
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



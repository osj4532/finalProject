<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>
<c:set var="mypage" value="useJs"/>
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">

	$(function(){
		showPage("", 1);
		
		$('#search').keyup(function(){
			var keyword = $(this).val();
			showPage(keyword, 1);
		});
	});
		
	function showPage(keyword, currentPage){
		$.ajax({
			url:"<c:url value='/member/memberShow.do'/>",
			type:"post",
			data:{
				"keyword":keyword,
				"currentPage":currentPage,
				"resignChk":"N"},
				success:function(res){
					show(res);
				},
				error:function(xhr, status, error){
					alert(status + ":" + error);
				}
		});
	}
	
	function show(res){
		tbody = $('tbody');
		tbody.html("");
		
		if(res.length == 1){
			var trEl = $('<tr></tr>');
			var tdEl = $('<td colspan="6"></td>').html("해당하는 사원이 없습니다.");
		}
		for(var i=1;i<res.length;i++){
			var map = res[i];
			if(map['MEM_NO'] != ${sessionScope.memNo}){
				var trEl = $('<tr></tr>');
				var tdEl1 = $('<td></td>').html(map['MEM_NO']);
				var tdEl2 = $('<td></td>').html(map['MEM_NAME']);
				var tdEl3 = $('<td></td>').html(map['DEPT_NAME']);
				var tdEl4 = $('<td></td>').html(map['POS_NAME']);
				var tdEl5 = $('<td></td>').html(map['MEM_HP1']+"-"+map['MEM_HP2']+"-"+map['MEM_HP3']);
				
				var a1 = $('<a class="btn btn-theme"><i class="fa fa-cog"></i>수정</a>').attr("href", "<c:url value='/member/memberEdit.do?memNo="+map["MEM_NO"] +"'/>");
				var a2 = $('<a class="btn btn-danger"><i class="far fa-trash-alt"></i>퇴사</a></td>').attr("href", "#").attr("onclick", "resign("+map["MEM_NO"]+")");
				var tdEl6 = $('<td></td>').html(a1).append(a2);
				
				trEl.html(tdEl1);
				trEl.append(tdEl2);
				trEl.append(tdEl3);
				trEl.append(tdEl4);
				trEl.append(tdEl5);
				trEl.append(tdEl6);
				
				tbody.append(trEl);
			}
		}
		
		var page = $('#page');
		var ul = $('#ul');
		
		var pagingInfo = res[0]['page'];
		ul.html('');
		
		showList(pagingInfo);
	}
	
	function showList(pagingInfo){
		if(pagingInfo.currentPage != 1){
			var anchor1=$('<li class="page-item"></li>')
			.html("<a class='page-link' href='#'>First</a>")
			.attr("onclick", "page("+1+")");
			$("#ul").html(anchor1);
		}
		
		if(pagingInfo.firstPage!=1){
			var anchor=$('<li class="page-item"></li>')
			.html("<a class='page-link' href='#' tabindex='-1' aria-disabled='true'>Previous</a>")
			.attr("onclick", "page("+(pagingInfo.firstPage-1)+")");
			
			$('#ul').append(anchor);
		}
		
		for(var i=pagingInfo.firstPage;i<=pagingInfo.lastPage;i++){
			
			if(i==pagingInfo.currentPage){
				var spanEl = $("<li class='page-item active' aria-current='page'><a class='page-link' href='#'>"+i+"<span class='sr-only'>(current)</span></a></li>");
				$('#ul').append(spanEl);
			}else{
				var anchor = $("<li class='page-item'><a class='page-link' href='#'>"+i+"</a></li>")
				.attr("onclick", "page("+i+")");
				$('#ul').append(anchor);
			}
			
			
		}
		
		if(pagingInfo.lastPage<pagingInfo.totalPage){
			var anchor=$("<li class='page-item'></li>")
			.html("<a class='page-link' href='#'>Next</a>")
			.attr("onclick", "page("+(pagingInfo.lastPage+1)+")");
			$('#ul').append(anchor);
			
			
		}
			if(pagingInfo.currentPage<pagingInfo.totalPage){
			var anchor2=$("<li class='page-item'></li>")
			.html("<a class='page-link' href='#'>Last</a>")
			.attr("onclick", "page("+pagingInfo.totalPage+")");
			$('#ul').append(anchor2);
				
			}
	}
	function page(currentPage){
		var keyword = $('#search').val();
		showPage(keyword, currentPage);
	}
	
function resign(memNo){
	
    if(confirm("퇴사 시키시겠습니까?")){
    	
        location.href = "<c:url value='/member/memberResign.do?memNo='/>"+memNo;
        return true;
    } else {
        return false;
    }
}
</script>
<style type="text/css">
#Main{
		min-height: 900px;
	}
	.row{
		margin-top: 30px;
	}
	#page{
		text-align: center;
	}
</style>
<section id="main-content">
	<section class="wrapper">
	<h3><i class="fas fa-users"></i> 사원 목록</h3>
	<div class="row">
		<div class="col-lg-12">
			<div class="form-panel">
			<div class="col-sm-2">
                   <input type="text" id="search" name="search" class="form-control" placeholder="이름/직급/부서로 검색">
            </div>
			<form name="frmList" action="<c:url value='/member/memberList.do'/>" method="post">
				<table id="tblList" class="table table-hover">
					<colgroup>
						<col style="width:10%;"/>
						<col style="width:15%;"/>
						<col style="width:20%;"/>
						<col style="width:15%;"/>
						<col style="width:20%;"/>
						<col style="width:20%"/>
					</colgroup>
					<thead>
						<tr>
							<th>사원번호</th>
							<th>이름</th>
							<th>부서</th>
							<th>직급</th>
							<th>연락처</th>
							<th>수정/삭제</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</form>
			<div id="page">
				<nav aria-label="...">
					<ul id="ul" class="pagination">
					
					</ul>
				</nav>
			</div>
				<input type="button" id="register" value="사원 등록" class="btn btn-info" onclick="location.href='<c:url value='/member/memberRegister.do'/>'">
			</div>
		</div>
	</div>
	</section>
</section>

<c:import url="../inc/bottom.jsp"/>
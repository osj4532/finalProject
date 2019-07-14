<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="../inc/top.jsp"></c:import>

<style type="text/css">
	.wraper1{
		overflow: hidden;
		padding: 20px;
		padding-top: 100px;
	}

	.wraper1 .info1, .wraper1 .info2{
		float: left;
		border: 1px solid silver;
		min-height: 600px;
		background-color: white;
	}
	
	.info1{
		text-align: center;
	}
	
	.info1 li:hover{
		background:  rgb(38,123,204);
		color:#FFF;
	}
	
	.info2 table{
		text-align: center;
	}
	
	.info2 table th{
		text-align: center;
	}
	
	.selected{
		background:  rgb(38,123,204);
		color:#FFF;
	}
	
	#pageInfo{
		text-align: center;
	}
</style>

<div class="container">
	<div class="row wraper1">
		<div class="info1 col-sm-2">
			<h4>문서 상태</h4>
			<ul class="list-group">
            	<a onclick="moveMenu(1)">
                	<li id="listMenu" class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			결재대기
                		</li>
                </a>
                <a onclick="moveMenu(2)">
                	<li id="listMenu" class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			결재완료
                		</li>
                </a>
                <a onclick="moveMenu(3)">
                	<li id="listMenu" class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			결재반려
                		</li>
                </a>
                <a onclick="moveMenu(4)">
                	<li id="listMenu" class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			임시저장
                		</li>
                </a>
       		</ul>
       		
       		<a href="<c:url value="/document/docSel.do"/>" class="btn btn-info">문서 작성</a>
		</div>
		<div class="info2 col-sm-10">
			<div id="title">
			
			</div>
			<table class="table table-hover">
				<colgroup>
					<col width="15%">
					<col width="15%">
					<col width="10%">
					<col width="35%">
					<col width="25%">
				</colgroup>
				<thead>
					<tr>
						<th>문서 번호</th>
						<th>양식 종류</th>
						<th>기안자</th>
						<th>기안 제목</th>
						<th>문서 등록일</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
			
			<div id="pageInfo">
		
			</div>
		</div>
	</div>
</div>

<form name="pageForm">
	<input type="text" name="cfState" value="1">
	<input type="text" name="currentPage" value="1">
</form>

<c:import url="../inc/bottom.jsp"></c:import>
<script type="text/javascript">
	$(function(){
		showList();
	});

	function docDetail(cfNo){
		location.href="<c:url value='/document/docDetail.do?cfNo='/>"+cfNo;
	}
	
	function movePage(currPage){
		let state = $('input[name=cfState]').val();
		$('input[name=currentPage]').val(currPage);
		showList();
	}
	
	function moveMenu(cfState){
		$('input[name=cfState]').val(cfState);
		$('input[name=currentPage]').val(1);
		
		showList();
	}
	
	function setPage(pageInfo){
		let pageUl = $("<ul class='pagination'></ul>");
		pageUl.html('');
		let pageLi;
		let pageA;
		for(let i = pageInfo.firstPage; i<=pageInfo.lastPage; i++){
			pageA = $("<a class='page-link' href='#'></a>").html(i);
			if(i == $('input[name=currentPage]').val()){
				pageLi = $('<li class="page-item active"></li>').html(pageA);
			}else{
				pageLi = $('<li class="page-item"></li>').html(pageA);
			}
			pageLi.attr("onclick","movePage("+i+")");
			pageUl.append(pageLi);
		}
		
		$('#pageInfo').html(pageUl);
		
	}
	
	function setTitle(){
		let cfState = $('input[name=cfState]').val();
		let title = $("<h2></h2>");
		
		if(cfState == 1){
			title.html("결재 대기함");
		}else if(cfState == 2){
			title.html("결재 완료함");
		}else if(cfState == 3){
			title.html("결재 반려함");
		}else if(cfState == 4){
			title.html("임시 저장함");
		}
		
		$('#title').html(title);
	}
	
	function showList(){
		let cfState = $('input[name=cfState]').val();
		$.ajax({
			url:"<c:url value='/document/docListShow.do'/>",
			type:"post",
			data:{"cfState":cfState,
				"currentPage":$('input[name=currentPage]').val()},
			dataType:"json",
			success:function(data){
				let tbody = $('tbody');
				tbody.html("");
				
				if(data.length == 1){
					let trEl = $('<tr></tr>');
					let tdEl1 = $('<td colspan="5"></td>').html('등록된 문서가 없습니다.');
					
					trEl.append(tdEl1);
					tbody.append(trEl);
				}
				
				for(let i = 1; i < data.length; i++){
					let map = data[i];
					
					let trEl = $('<tr></tr>');
					let tdEl1 = $('<td></td>').html(map['CF_NO']);
					let tdEl2 = $('<td></td>').html(map['FORM_NAME']);
					let tdEl3 = $('<td></td>').html(map['MEM_NAME']);
					let tdEl4 = $('<td></td>').html(map['CF_TITLE']);
					
					let regdate = new Date(map['CF_REGDATE']);
					let year = regdate.getFullYear();
					let month = regdate.getMonth();
					let day = regdate.getDate();
					
					
					let tdEl5 = $('<td></td>').html(year+"-"+month+"-"+day);
					
					trEl.append(tdEl1);
					trEl.append(tdEl2);
					trEl.append(tdEl3);
					trEl.append(tdEl4);
					trEl.append(tdEl5);
					
					trEl.attr("onclick","docDetail("+map['CF_NO']+")")
					
					tbody.append(trEl);
					
				}
				
				setTitle();
				
				let pageInfo = data[0]['page'];
				
				setPage(pageInfo);
				
			},
			error:function(xhr,status,error){
				alert("에러 발생!!\n"+status+" : "+error);
			}
		});
	}
</script>
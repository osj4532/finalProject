<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<style>
	.wraper2{
		margin-top: 70px;
	}
  
  	.container-1{
  		width:300px;
  		vertical-align: middle;
  		white-space: nowrap;
  		position: relative;
  	}
  	
  	.container-1 input#addrSearch{
  		width:300px;
  		height: 50px;
  		background: #F2F2F2;
  		border: none;
  		font-size: 10pt;
  		float: left;
  		color:#63717f;
  		padding-left: 45px;
  		-webkit-border-radius: 5px;
  		-moz-border-radius: 5px;
  		border-radius: 5px;
  	}
  	
  	.container-1 input#search::-webkit-input-placeholder {
   		color: #65737e;
	}
 
	.container-1 input#search:-moz-placeholder { /* Firefox 18- */
	   color: #65737e;  
	}
	 
	.container-1 input#search::-moz-placeholder {  /* Firefox 19+ */
	   color: #65737e;  
	}
	 
	.container-1 input#search:-ms-input-placeholder {  
	   color: #65737e;  
	}
	
	.container-1 .icon{
	  position: absolute;
	  top: 40%;
	  margin-left: 17px;
	  margin-top: 14px;
	  z-index: 1;
	  color: #4f5b66;
	}
	
	.container-1 input#addrSearch:focus, .container-1 input#addrSearch:active{
	    outline:none;
	    background: #ffffff;
	    border: 1px solid gray;
	    border-bottom: 2px solid gray;
	  }
	
	.topnav{
		position: relative;
		height: 60px;
		vertical-align: middle;
		width: 600px;
		margin: 10px;
	}
	
	.header1{
		font-size: 2em;
		position: absolute;
		top:8px;
	}
	
	.box1{
		position: absolute;
  		width: 300px;
  		height: 50px;
  		left:230px;
  		top:5px;
  	}
  	
  	.title i{
  		color:blue;
  		font-size: 1.2em;
  		margin-right: 10px;
  	}
  	
  	.wraper2 table{
  		font-size: 1.5em;
  		text-align: center;
  	}
  	
  	.wraper2 table input[type=checkbox]{
  		width:20px;
  		height: 20px;
  	}
  	
  	.wraper2 table th{
  		text-align: center;
  	}
  	
  	.align-center{
  		text-align: center;
  	}
  	
  	#btnDiv{
  		margin: 10px;
  	}
</style>

<div class="container">
	<div class="wraper2 panel">
		<div class="topnav">
		<div class="header1">
			<span class="title"><i class="fas fa-user-circle"></i>개인주소록</span>
		</div>
		<div class="box1">
			<div class="container-1">
				<span class="icon"><i class="fa fa-search"></i></span>
				<input type="search" id="addrSearch" placeholder="이름/회사명/이메일 검색">
			</div>
		</div>
	</div>
		<table class="table table-hover">
			
		</table>
		<div class="align-center" id="pageDiv">
			
		</div>
		<div id="btnDiv" class="align-center">
			<button id="addrbookAdd" class="btn btn-success">연락처 등록</button>
			<button id="addrbookDel" class="btn btn-danger">연락처 삭제</button>
		</div>
	</div>
</div>

<%@ include file="../inc/bottom.jsp"%>
<script type="text/javascript">
	let selNo = new Array();
	
	$(function(){
		showList("", 1);
		
		$('#addrbookAdd').click(function(){
			location.href="<c:url value='/address/addAddr.do'/>";
		})
		
		$('#addrbookDel').click(function(){
			$('.wraper2 table tr:gt(0) input[type=checkbox]').each(function(idx, item){
				if($(item).is(':checked')){
					selNo.push($(item).val());
				}
			});
				//개인 주소록 삭제 핸들러
			if(selNo.length == 0){
				alert("삭제할 연락처를 체크해 주세요.");
				return false;
			}
			
			$.ajax({
				url:"<c:url value='/address/addrbookDel.do'/>",
				type:"post",
				dataType:"json",
				data:{"sel":selNo},
				success:function(data){
					if(data < 1){
						alert("연락처 삭제 실패!");
					}else{
						let keyword = $('#addrSearch').val();
						showList(keyword,1);
						selNo = [];
					}
				},
				error:function(xhr,status, error){
					alert(status+" : "+error);
				}
			});
				
		});
		
		$('#addrSearch').keyup(function(){
			let keyword = $(this).val();
			showList(keyword, 1);
		});
	});
	
	function showList(keyword, currentPage){
		$.ajax({
			url:"<c:url value='/address/showEmailList.do'/>",
			type:"post",
			dataType:"json",
			data:{"kind":2,
					"keyword":keyword,
					"currentPage":currentPage},
			success:function(data){
				
				let table = $('.wraper2 table');
				
				$('#pageDiv').html('');
				let headTr = $('<tr></tr>');
				let headTh1 = $('<th><input type="checkbox" id="chkAll"></th>')
				let headTh2 = $('<th><i class="fas fa-user"></i> 이름</th>')
				let headTh3 = $('<th><i class="fas fa-building"></i> 회사명</th>')
				let headTh4 = $('<th><i class="fas fa-mobile-alt"></i> 연락처</th>')
				let headTh5 = $('<th><i class="fas fa-envelope-square"></i> 이메일</th>')
				let headTh6 = $('<th>비고</th>');
				
				headTr.html(headTh1);
				headTr.append(headTh2);
				headTr.append(headTh3);
				headTr.append(headTh4);
				headTr.append(headTh5);
				headTr.append(headTh6);
				
				table.html(headTr);
				
				
				
				if(data.length == 1){
					let trEl = $('<tr></tr>');
					let tdEl = $('<td colspan="5">저장된 연락처가 없습니다.</td>');
					
					trEl.html(tdEl);
					table.append(trEl);
				}else{
					$(data).each(function(idx, item){
						if(idx == 0) return true;
						
						let trEl = $('<tr></tr>');
						let tdEl1 = $('<td></td>');
						let tdEl2 = $('<td></td>');
						let tdEl3 = $('<td></td>');
						let tdEl4 = $('<td></td>');
						let tdEl5 = $('<td></td>');
						let tdEl6 = $('<td></td>');
						
						tdEl1.html('<input type="checkbox" value="'+item["ADDRBOOK_NO"]+'">');
						tdEl2.html(item["ADDRBOOK_NAME"]);
						tdEl3.html(item["ADDRBOOK_COMNAME"]);
						tdEl4.html(item['ADDRBOOK_TEL']);
						tdEl5.html(item['ADDRBOOK_EMAIL']);
						tdEl6.html("<button class='btn btn-warning'>수정하기</button>");
						tdEl6.attr("onclick","location.href='<c:url value='/address/addEdit.do?addrbookNo="+item["ADDRBOOK_NO"]+"'/>'");
						
						trEl.html(tdEl1);
						trEl.append(tdEl2);
						trEl.append(tdEl3);
						trEl.append(tdEl4);
						trEl.append(tdEl5);
						trEl.append(tdEl6);
						
						table.append(trEl);
					});
					
					let pageDiv = $('#pageDiv');
					let pageUl = $("<ul class='pagination'></ul>");						
					
					let pageMap = data[0]['pageInfo'];
					pageUl.html('');
					
					if(pageMap.firstPage != 1){
						let pageLi = $('<li class="page-item"></li>');
						let pageA = $('<a href="#" class="page-link"><i class="fas fa-angle-left"></i><i class="fas fa-angle-left"></i></a>');
						pageA.attr("onclick","movePage("+(pageMap.firstPage-1)+")");
						pageLi.html(pageA);
						pageUl.append(pageLi);
					}
					
					for(let i = pageMap.firstPage; i <= pageMap.lastPage; i++){
						let pageLi = $('<li class="page-item"></li>');
						let pageA = $('<a href="#" class="page-link">'+i+'</a>');
						pageA.attr("onclick","movePage("+i+")");
						if(i == pageMap.currentPage){
							pageLi.addClass('active');
						}
						
						pageLi.html(pageA);
						pageUl.append(pageLi);
					}
					
					
					if(pageMap.totalPage > pageMap.lastPage){
						let pageLi = $('<li class="page-item"></li>');
						let pageA = $('<a href="#" class="page-link"><i class="fas fa-angle-right"></i><i class="fas fa-angle-right"></i></a>');
						pageA.attr("onclick","movePage("+(pageMap.lastPage+1)+")");
						pageLi.html(pageA);
						pageUl.append(pageLi);
					}
					
					pageDiv.html(pageUl);
					
					/* <li class="page-item"><a href="#" class="page-link">1</a></li>
					<li class="page-item"><a href="#" class="page-link">2</a></li>
					<li class="page-item"><a href="#" class="page-link">3</a></li> */
					
					$('#chkAll').click(function(){
						$('.wraper2 table tr:gt(0) input[type=checkbox]').prop("checked",$(this).is(':checked'));
					});
					
					$('.wraper2 table tr:gt(0)').click(function(){
						if($(this).find('input[type=checkbox]').prop("checked")){
							$(this).find('input[type=checkbox]').prop("checked",false);
						}else{
							$(this).find('input[type=checkbox]').prop("checked",true);
						}
					});
					
					$('.wraper2 table tr input[type=checkbox]').click(function(){
						event.stopPropagation();
					});
					
				}
				
			},
			error:function(xhr, status, error){
				alert(status + ":" + error);
			}
		});
	}
	
	function movePage(currentPage){
		let keyword = $('#addrSearch').val();
		showList(keyword, currentPage);
	}
</script>
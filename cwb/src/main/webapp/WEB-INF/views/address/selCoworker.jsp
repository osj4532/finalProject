<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
  <link href="<c:url value='/resources/lib/bootstrap/css/bootstrap.min1.css'/>"  rel="stylesheet">
  <style type="text/css">
  .wraper1{
  	margin: 10px 10px;
  	width: 600px;
  	min-height: 600px;
  	position: relative;
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
	}
	
	.header{
		font-size: 2em;
		position: absolute;
		top:8px;
	}
	
	.box{
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
  	
  	.close{
  		position: absolute;
  		left:550px;
  		top:9px;
  		height: 40px;
  		font-size: 40px;
  		
  		border: none;
  		background-color: transparent;
  		
  		cursor: pointer;
  	}
  	
  	.close{
  		outline: none;
  	}
  	
  	.addrMenu{
  		overflow: hidden;
  		width: 560px;
  	}
  	
  	.addrCheck{
  		float: left;
  		width:200px;
  	}
  	
  	.addrCheck span{
  		font-size: 1.7em;
  		display: inline-block;
  		position: relative;
  		top:-5px;
  	}
  	
  	.addrKind{
  		float: right;
  		width:200px;
  		margin-top: 20px;
  	}
  	
  	.addrCheck input[type=checkbox]{
		width:20px;
		height: 20px;
		margin-top: 20px;
  	}
  	
  	 #emailList input[type=checkbox]{
  	 	width:20px;
		height: 20px;
  	 }
  	
  	#emailList .table tr{
  		height: 50px;
  		font-size: 15pt;
  		text-align: left;
  	}
  	
  	#emailList .table tr:hover{
		background: rgb(230,230,230);
  	}
  	
  	#addrPage{
  		text-align: center;
  	}
  	
  	.addrBtn{
  		position: absolute;
  		bottom: 10px;
  		left: 256px;
  	}
  </style>
</head>
<body>

<div class="wraper1">
	<div class="topnav">
		<div class="header">
			<span class="title"><i class="fas fa-user-circle"></i>연락처 선택</span>
		</div>
		<div class="box">
			<div class="container-1">
				<span class="icon"><i class="fa fa-search"></i></span>
				<input type="search" id="addrSearch" placeholder="연락처 검색">
			</div>
		</div>
		<!-- <button type="button" class="close" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	    </button> -->
	</div>
	
	<div class="addrMenu">
		<div class="addrCheck">
			<input type="checkbox" id="chkAll">
			<span>전체 선택</span>
		</div>
	</div>
	<div id="emailList">
		<table class="table table-borderless">
		
		</table>
	</div>
	<div id="addrPage">
		<ul class="pagination">

		</ul>
	</div>
	<div class="addrBtn">
		<button id="add" class="btn btn-primary">추가하기</button>
	</div>
</div>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	let selAddr = new Array();
	
	$(function(){
		showList(1,"",1);
		
		$('#chkAll').click(function(){
			$('#emailList table tr input[type=checkbox]').prop("checked",$(this).is(':checked'));
		});
		
		$('#add').click(function(){
			selAddr = [];
			let chbox = $('#emailList table tr input[type=checkbox]');
			$(chbox).each(function(){
				if($(this).is(':checked')){
					selAddr.push($(this).val());
				}
			});
			let senAddr = opener.document.getElementById('msgrevId').value;
			if(senAddr == ''){
				opener.document.getElementById('msgrevId').value = selAddr;
			}else{
				opener.document.getElementById('msgrevId').value = senAddr+","+selAddr;
			}
			window.close();
		});
		
		/* $('.close').click(function(){
			//창 닫기
		}); */
		
		$('#addrSearch').keyup(function(){
			let keyword = $(this).val();
			let kind = Number($('.addrKind select').val());
			showList(kind, keyword, 1);
		});
	});
	
	function showList(kind, keyword, currentPage){
		$.ajax({
			url:"<c:url value='/address/showEmailList.do'/>",
			type:"post",
			dataType:"json",
			data:{"kind":1,
					"keyword":keyword,
					"currentPage":currentPage},
			success:function(data){
				
				let table = $('#emailList table');
				let colg = $('<colgroup></colgroup>');
				let col1 = $('<col width="10%">');
				let col2 = $('<col width="30%">');
				let col3 = $('<col width="*">');
				
				$('#addrPage').html('');
				
				colg.html(col1);
				colg.append(col2);
				colg.append(col3);
				
				table.html(colg);
				
				if(data.length == 1){
					let trEl = $('<tr></tr>');
					let tdEl = $('<td colspan="3">저장된 연락처가 없습니다.</td>');
					
					trEl.html(tdEl);
					table.append(trEl);
				}else{
					$(data).each(function(idx, item){
						if(idx == 0) return true;
						
						let trEl = $('<tr></tr>');
						let tdEl1 = $('<td></td>');
						let tdEl2 = $('<td></td>');
						let tdEl3 = $('<td></td>');
						
						tdEl1.html('<input type="checkbox" value="'+item['MEM_ID']+'">');
						tdEl2.html('<i class="fas fa-user"></i> '+item['MEM_ID']);
						tdEl3.html("["+item['DEPT_NAME']+"/"+item['POS_NAME']+"]"+item['MEM_NAME']);
						
						trEl.html(tdEl1);
						trEl.append(tdEl2);
						trEl.append(tdEl3);
						
						table.append(trEl);
					});
					
					let pageDiv = $('#addrPage');
					let pageUl = $("<ul class='pagination'></ul>");						
					
					let pageMap = data[0]['pageInfo'];
					pageUl.html('');
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
					
					pageDiv.html(pageUl);
					
					
					$('#emailList table tr').click(function(){
						if($(this).find('input[type=checkbox]').prop("checked")){
							$(this).find('input[type=checkbox]').prop("checked",false);
						}else{
							$(this).find('input[type=checkbox]').prop("checked",true);
						}
					});
					
					$('#emailList table tr input[type=checkbox]').click(function(){
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
		let kind = Number($('.addrKind select').val());
		showList(kind, keyword, currentPage);
	}
</script>
</body>
</html>
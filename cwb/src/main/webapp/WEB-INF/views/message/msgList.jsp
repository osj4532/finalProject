<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../inc/top.jsp"%>

<style>
	.wraper2{
		margin-top: 70px;
		overflow: hidden;
	}
	
	input[type=checkbox]{
		width: 20px;
		height: 20px;
	}
	
	.msgNav, .msgList{
		float: left;
		margin-left: 10px;
		margin-top: -2px;
	}
	
	.msgNav{
		width:115px;
	}
	
	.msgList{
		font-size: 0.9em;
		border-left: 1px solid gray;
		width: calc(100% - 135px);
	}
	
	.newBtn{
		margin: 10px;
	}
	
	.align-center{
		text-align: cetner;
	}
	
	.msgList table{
		text-align:center;
	}
	
	.msgList table th{
		text-align:center;
		border-right: 1px solid silver;
	}
	
	.msgNav ul li{
		cursor: pointer;
	}
	
	.box1{
		float: right;
	}
	
</style>

<div class="container">
	<div class="wraper2 panel">
		
		<div class="wraper2 msgNav">
		
			<div class="align-center newBtn">
				<button id="new" class="btn btn-info">쪽지 쓰기</button>
			</div>
			
			<ul class="list-group">
				<li class="list-group-item">받은 쪽지함</li>
				<li class="list-group-item">보낸 쪽지함</li>
			</ul>
		</div>
		<div class="wraper2 msgList">
			<div class="newBtn">
				<button id="del" title="삭제하기" class="btn btn-danger btn-sm"><i class="far fa-trash-alt"></i></button>
				<button id="re" title="새로고침" class="btn btn-warning btn-sm"><i class="fas fa-redo-alt"></i></button>
				<div class="box1">
					<div class="container-1">
						<span class="icon"><i class="fa fa-search"></i></span>
						<input type="search" id="msgSearch" placeholder="아이디/제목/내용 검색">
					</div>
				</div>
			</div>
			<table class="table table-hover">
			
			</table>
			<div class="pageDiv align-center">
			
			</div>
		</div>
	</div>
</div>
<input type="hidden" name="kind" value="1">
<input type="hidden" name="currentPage" value="1">
<%@ include file="../inc/bottom.jsp"%>
<script>
	

	$(function(){
		let sel = new Array();
		
		showList(1,"",1);
		$('.msgNav ul li:eq(0)').addClass("active");
		
		$('#del').click(function(){
			
			$('input[type=checkbox]:gt(0)').each(function(idx,item){
				if($(item).is(':checked')){
					sel.push($(item).val());
				}
			})
			
			if(sel.length == 0){
				alert("삭제할 쪽지를 선택해주세요.");
				return false;
			}
			
			let kind = $('input[name=kind]').val();
			
			$.ajax({
				url:"<c:url value='/message/revMsgDel.do'/>",
				type:"post",
				dataType:"json",
				data:{"sel":sel,
					"kind":kind},
				success:function(data){
					if(data > 0){
						alert("쪽지 삭제 성공!");
						let keyword = $('#msgSearch').val();
						let curr = $('input[name=currentPage]').val();
						
						console.log("삭제");
						showList(kind,keyword,1);
						
						sel = [];
					}else{
						alert("쪽지 삭제 실패!");
					}
				},
				error:function(xhr, status, error){
					alert(status+" : "+error);
				}
			});
			
		});
		
		$('#msgSearch').keyup(function(){
			let kind = $('input[name=kind]').val();
			let keyword = $(this).val();
			showList(kind,keyword,1);
		});
		
		$('#re').click(function(){
			let kind = $('input[name=kind]').val();
			let keyword = $('#msgSearch').val();
			showList(kind,keyword,1);
		});
		
		$('#new').click(function(){
			open('<c:url value="/address/sendMessage.do?"/>','','width=600px, height=600px, left=200px, top=100px, location=yes, resizable=no');
		});
		
		
		$('.msgNav ul li').each(function(idx, item){
			
			$(item).click(function(){
				$('.msgNav ul li').removeClass("active");
				if(idx==0){
					showList(1,"",1);
					$('input[name=kind]').val('1');
				}else if(idx == 1){
					showList(2,"",1);
					$('input[name=kind]').val('2');
				}
				
				$(item).addClass("active");
			});
		});
	});
	
	function showList(kind, keyword, currentPage){
		console.log("쪽지 리스트 보여주기");
		$.ajax({
			url:"<c:url value='/message/showMsgList.do'/>",
			type:"post",
			dataType:"json",
			data:{
				"kind":kind,
				"keyword":keyword,
				"currentPage":currentPage
			},
			success:function(data){
				let pageInfo = data[0]['pageInfo'];
				
				let table = $('.msgList table');
				
				if(kind == 1){
					let colg = $('<colgroup></colgroup>');
					let col1 = $('<col width="10%">');
					let col2 = $('<col width="25%">');
					let col3 = $('<col width="45%">');
					let col4 = $('<col width="*">');
					
					colg.html(col1);
					colg.append(col2);
					colg.append(col3);
					colg.append(col4);
					
					table.html(colg);
					
					let trEl = $('<tr></tr>');
					let thEl1 = $('<th><input type="checkbox" id="chkAll"></th>');
					let thEl2 = $('<th>보낸사람</th>');
					let thEl3 = $('<th>제목</th>');
					let thEl4 = $('<th>날짜</th>');
					
					trEl.html(thEl1);
					trEl.append(thEl2);
					trEl.append(thEl3);
					trEl.append(thEl4);
					
					table.append(trEl);
					
					if(data.length == 1){
						let trEl2 = $('<tr></tr>');
						let tdEl1 = $('<td colspan="4">쪽지가 없습니다.</td>');
						trEl2.html(tdEl1);
						table.append(trEl2);
					}else{
						for(let i = 1; i < data.length; i++){
							let map = data[i];
							let trEl2 = $('<tr></tr>');
							
							let tdEl1 = $('<td><input type="checkbox" value="'+map['MSGREV_NO']+'"></td>');
							tdEl1.attr("onclick","event.cancelBubble=true");
							
							let revMem = map['MEM_ID'];
							if(revMem == '${sessionScope.memId}'){
								revMem = "나";
							}else{
								revMem = map['MEM_ID']+' ['+map['MEM_NAME']+']';
							}
							
							let tdEl2 = $('<td>'+revMem+'</td>');
							let tdEl3 = $('<td>'+map['MSG_TITLE']+'</td>');
							
							let regdate = new Date(map['MSG_REGDATE']);
							let year = regdate.getFullYear();
							let month = regdate.getMonth()+1;
							let day = regdate.getDate();
							regdate = year+"-"+month+"-"+day;
							
							let tdEl4 = $('<td>'+regdate+'</td>');
							
							trEl2.html(tdEl1);
							trEl2.append(tdEl2);
							trEl2.append(tdEl3);
							trEl2.append(tdEl4);
							
							$(trEl2).attr("onclick","showDetail(1,"+map['MSGREV_NO']+")");
							
							table.append(trEl2);
						}
					}
				}else if(kind == 2){
					
					let colg = $('<colgroup></colgroup>');
					let col1 = $('<col width="10%">');
					let col2 = $('<col width="20%">');
					let col3 = $('<col width="40%">');
					let col4 = $('<col width="15%">');
					let col5 = $('<col width="15%">');
					
					colg.html(col1);
					colg.append(col2);
					colg.append(col3);
					colg.append(col4);
					colg.append(col5);
					
					table.html(colg);
					
					let trEl = $('<tr></tr>');
					let thEl1 = $('<th><input type="checkbox" id="chkAll"></th>');
					let thEl2 = $('<th>받는사람</th>');
					let thEl3 = $('<th>제목</th>');
					let thEl4 = $('<th>날짜</th>');
					let thEl5 = $('<th>수신확인</th>')
					
					trEl.html(thEl1);
					trEl.append(thEl2);
					trEl.append(thEl3);
					trEl.append(thEl4);
					trEl.append(thEl5);
					
					table.append(trEl);
					
					if(data.length == 1){
						let trEl2 = $('<tr></tr>');
						let tdEl1 = $('<td colspan="5">쪽지가 없습니다.</td>');
						trEl2.html(tdEl1);
						table.append(trEl2);
					}else{
						for(let i = 1; i < data.length; i++){
							let map = data[i];
							let trEl2 = $('<tr></tr>');
							
							let tdEl1 = $('<td><input type="checkbox" value="'+map['MSGREV_NO']+'"></td>');
							tdEl1.attr("onclick","event.cancelBubble=true");
							
							let revMem = map['MEM_ID'];
							if(revMem == '${sessionScope.memId}'){
								revMem = "나에게";
							}else{
								revMem = map['MEM_ID']+' ['+map['MEM_NAME']+']';
							}
							
							let tdEl2 = $('<td>'+revMem+'</td>');
							let tdEl3 = $('<td>'+map['MSG_TITLE']+'</td>');
							
							let regdate = new Date(map['MSG_REGDATE']);
							let year = regdate.getFullYear();
							let month = regdate.getMonth()+1;
							let day = regdate.getDate();
							regdate = year+"-"+month+"-"+day;
							
							let tdEl4 = $('<td>'+regdate+'</td>');
							
							
							let check = map['MSGREV_DATE'];
							if(check == null || check==''){
								check = "미확인";
							}else{
								check = "확인";
							}
							
							let tdEl5 = $('<td>'+check+'</td>')
							
							trEl2.html(tdEl1);
							trEl2.append(tdEl2);
							trEl2.append(tdEl3);
							trEl2.append(tdEl4);
							trEl2.append(tdEl5);
							
							$(trEl2).attr("onclick","showDetail(2,"+map['MSGREV_NO']+")");
							table.append(trEl2);
						}
					}
				}
				
				setPage(kind, pageInfo, currentPage);
				
				$('#chkAll').click(function(){
					$('input[type=checkbox]:gt(0)').prop("checked",$(this).is(':checked'));
				});
				
				
			},
			error:function(xhr, status, error){
				alert(status+" : "+error);
			}
		});
	}
	
	function movePage(kind, currPage){
		let keyword = "";
		let curr = $('input[name=currentPage]').val(currPage);
		showList(kind, keyword, currPage);
	}
	
	
	function setPage(kind, pageInfo, currentPage){
		let pageUl = $("<ul class='pagination'></ul>");
		let pageLi;
		let pageA;
		
		if(pageInfo.firstPage != 1){
			pageA = $("<a class='page-link' href='#'></a>").html("Prev");
			pageLi = $('<li class="page-item"></li>').html(pageA);
			pageLi.attr("onclick","movePage("+kind+","+(pageInfo.firstPage-1)+")");
			pageUl.append(pageLi);
		}
		
		for(let i = pageInfo.firstPage; i<=pageInfo.lastPage; i++){
			pageA = $("<a class='page-link' href='#'></a>").html(i);
			if(i == currentPage){
				pageLi = $('<li class="page-item active"></li>').html(pageA);
			}else{
				pageLi = $('<li class="page-item"></li>').html(pageA);
			}
			pageLi.attr("onclick","movePage("+kind+","+i+")");
			pageUl.append(pageLi);
		}
		
		
		if(pageInfo.totalPage > pageInfo.lastPage){
			pageA = $("<a class='page-link' href='#'></a>").html("Next");
			pageLi = $('<li class="page-item"></li>').html(pageA);
			pageLi.attr("onclick","movePage("+kind+","+(pageInfo.lastPage+1)+")");
			pageUl.append(pageLi);
		}
		
		
		$('.pageDiv').html(pageUl);

	
	}
	
	function showDetail(kind, msgrevNo, msgNo){
		open('<c:url value="/message/msgDetail.do?kind='+kind+'&revNo='+msgrevNo+'&msgNo='+msgNo+'"/>','',
				'width=600px, height=420px, left=200px, top=100px, location=yes, resizable=no');
	}
</script>


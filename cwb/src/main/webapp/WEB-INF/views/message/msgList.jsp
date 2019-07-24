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
		min-height: 500px;
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
</style>

<div class="container">
	<div class="wraper2 panel">
		
		<div class="msgNav">
		
			<div class="align-center newBtn">
				<button id="new" class="btn btn-info">쪽지 쓰기</button>
			</div>
			
			<ul class="list-group">
				<li class="list-group-item active">받은 쪽지함</li>
				<li class="list-group-item">보낸 쪽지함</li>
			</ul>
		</div>
		<div class="msgList">
			<div class="newBtn">
				<button title="삭제하기" class="btn btn-danger btn-sm"><i class="far fa-trash-alt"></i></button>
				<button title="새로고침" class="btn btn-warning btn-sm"><i class="fas fa-redo-alt"></i></button>
			</div>
		
			<table class="table table-borderless">
				
			</table>
		</div>
	</div>
</div>
<%@ include file="../inc/bottom.jsp"%>

<script>
	$(function(){
		showList(2,"",1);
	});
	
	function showList(kind, keyword, currentPage){
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
							let tdEl2 = $('<td>'+map['MEM_ID']+' ['+map['MEM_NAME']+']'+'</td>');
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
					let thEl2 = $('<th>보낸사람</th>');
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
						
					}
				}
				
				
				
			},
			error:function(xhr, status, error){
				alert(status+" : "+error);
			}
		});
	}
</script>


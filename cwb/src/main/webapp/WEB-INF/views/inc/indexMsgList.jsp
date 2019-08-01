<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table class="table">
	<thead>
		<tr>
			<th>보낸 사람</th>
			<th>제목</th>
		</tr>
	</thead>
	<tbody id="msgTb">
	
	</tbody>
</table>

<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(function(){
		showMsgList();
	});
	
	function showMsgList(){
		$.ajax({
			url:"<c:url value='/indexMsgList.do'/>",
			type:"post",
			dataType:"json",
			success:function(data){
				let tbody = $('#msgTb');
				tbody.html('');
				
				if(data.length == 0){
					let trEl = $('<tr></tr>');
					let tdEl1 = $('<td colspan="2">읽지 않은 쪽지가 없습니다.</td>');
					trEl.html(tdEl1);
					tbody.append(trEl);
				}else{
					$(data).each(function(idx, item){
						let trEl = $('<tr></tr>');
						let tdEl1 = $('<td>'+item['MEM_ID']+'</td>');
						let tdEl2 = $('<td>'+item['MSG_TITLE']+'</td>');
						
						trEl.attr('onclick','showDetail('+item['MSGREV_NO']+')')
						
						trEl.append(tdEl1);
						trEl.append(tdEl2);
						
						tbody.append(trEl);
					});
			
				}
				
			},
			error:function(status, error){
				alert(status + " : "+ error);
			}
		});
	}
	
	
	function showDetail(msgrevNo){
		open('<c:url value="/message/msgDetail.do?kind=1&revNo='+msgrevNo+'"/>','',
				'width=600px, height=420px, left=200px, top=100px, location=yes, resizable=no');
	}
</script>
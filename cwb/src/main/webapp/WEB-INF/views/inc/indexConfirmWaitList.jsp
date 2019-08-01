<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="table">
	<thead>
		<tr>
			<th>기안자</th>
			<th>문서종류</th>
			<th>제목</th>
		</tr>
	</thead>
	<tbody id="cfWTb">
	
	</tbody>
</table>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(function(){
		showCfWaitList();
	});
	
	function showCfWaitList(){
		$.ajax({
			url:"<c:url value='/indexConfirmWaitList.do'/>",
			type:"post",
			dataType:"json",
			success:function(data){
				let tbody = $('#cfWTb');
				tbody.html('');
				
				if(data.length == 0){
					let trEl = $('<tr></tr>');
					let tdEl1 = $('<td colspan="3">결재 대기중은 문서가 없습니다.</td>');
					trEl.html(tdEl1);
					tbody.append(trEl);
				}else{
					$(data).each(function(idx, item){
						let trEl = $('<tr></tr>');
						let tdEl1 = $('<td>'+item['MEM_NAME']+'</td>');
						let tdEl2 = $('<td>'+item['FORM_NAME']+'</td>');
						let tdEl3 = $('<td>'+item['CF_TITLE']+'</td>');
						
						trEl.attr('onclick','docDetail('+item['CF_NO']+')');
						
						trEl.append(tdEl1);
						trEl.append(tdEl2);
						trEl.append(tdEl3);
						
						tbody.append(trEl);
					});
			
				}
				
			},
			error:function(status, error){
				alert(status + " : "+ error);
			}
		});
	}
	
	
	function docDetail(cfNo){
		location.href="<c:url value='/document/docDetail.do?cfNo='/>"+cfNo;
	}
</script>
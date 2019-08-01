<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="table">
	<thead>
		<tr>
			<th>문서종류</th>
			<th>순서</th>
			<th>상태</th>
		</tr>
	</thead>
	<tbody id="cfRTb">
		
	</tbody>
</table>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(function(){
		showCfRecentList();
	});
	
	function showCfRecentList(){
		$.ajax({
			url:"<c:url value='/indexRecentConfirmList.do'/>",
			type:"post",
			dataType:"json",
			success:function(data){
				let tbody = $('#cfRTb');
				tbody.html('');
				
				if(data.length == 0){
					let trEl = $('<tr></tr>');
					let tdEl1 = $('<td colspan="3">결재 대기중은 문서가 없습니다.</td>');
					trEl.html(tdEl1);
					tbody.append(trEl);
				}else{
					$(data).each(function(idx, item){
						let trEl = $('<tr></tr>');
						let tdEl1 = $('<td>'+item['FORM_NAME']+'</td>');
						let tdEl2 = $('<td>'+item['CF_ORDER']+'</td>');
						
						let state = "";
						if(item['CF_STATE'] == 1){
							state = "결재 대기";
						}else if(item['CF_STATE'] == 2){
							state = "결재 완료";
						}else if(item['CF_STATE'] == 3){
							state = "결재 반려";
						}else if(item['CF_STATE'] == 4){
							state = "임시 저장";
						}
						
						let tdEl3 = $('<td>'+state+'</td>');
						
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
</script>
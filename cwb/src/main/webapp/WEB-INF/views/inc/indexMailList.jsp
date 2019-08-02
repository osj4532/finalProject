<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="table">
	<thead>
		<tr>
			<th>보낸주소</th>
			<th>제목</th>
		</tr>
	</thead>
	<tbody id="cfMTb">
	
	</tbody>
</table>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(function(){
		showMailList();
	});
	
	function showMailList(){
		
		$.ajax({
			url:"<c:url value='/indexMailList.do'/>",
			type:"post",
			dataType:"json",
			success:function(data){
				let tbody = $('#cfMTb');
				tbody.html('');
				
				if(data.length < 1){
					let trEl = $('<tr></tr>');
					let tdEl = $('<td>보낸 메일이 없습니다.</td>');
					
					trEl.html(tdEl);
					tbody.html(trEl);
				}else{
					$(data).each(function(idx, item){
						let trEl = $('<tr></tr>');
						let tdEl1 = $('<td>'+item.mailSenAddr +'</td>');
						let tdEl2 = $('<td>'+item.mailTitle+'</td>');
						
						trEl.attr("onclick","mailDetail("+item.mailNo+")");
						
						trEl.html(tdEl1);
						trEl.append(tdEl2);
						
						tbody.append(trEl);
					});
				}
			},
			error:function(status, error){
				alert(status+" : "+error);
			}
		});
	}
	
	function mailDetail(mailNo){
		location.href="<c:url value='/address/emailDetail.do?mailNo="+mailNo+"'/>";
	}
</script>
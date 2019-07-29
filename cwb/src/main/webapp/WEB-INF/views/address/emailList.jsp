<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>

<style>
	#wraper{
		margin-top: 70px;
		padding: 10px;
	}
	
	tbody tr{
		cursor: pointer;
	}
	
	#mlistHead{
		position: relative;
	}
	
	#mlistHead #newMail{
		position: absolute;
		right: 20px;
		top:10px;
	}
	
	.align-center{
		text-align: center;
	}
</style>

<div class="container">
	<div class="panel wraper2" id="wraper">
		<div id="mlistHead">
			<h1>보낸 메일함</h1>
			<button id="newMail" class="btn btn-success" onclick="sendEmail()">새 메일 쓰기</button>
			<button class="btn btn-danger" onclick="deleteMail()"><i class="fas fa-trash-alt"></i> 지우기</button>
		</div>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>
						<input type="checkbox" id="chkAll">
					</th>
					<th>메일 번호</th>
					<th>받는 주소</th>
					<th>메일 제목</th>
					<th>보낸 날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list }">
					<tr class="align-center">
						<td colspan="5">보낸 메일이 없습니다.</td>
					</tr>
				</c:if>
				
				<c:if test="${!empty list }">
					<c:forEach var="vo" items="${list }">
						<tr onclick="mailDetail('${vo.mailNo }')">
							<td onclick="event.cancelBubble=true"><input type="checkbox" id="chk" value="${vo.mailNo }"></td>
							<td>${vo.mailNo }</td>
							<td>${vo.mailSenAddr }</td>
							<td>${vo.mailTitle }</td>
							<td><fmt:formatDate value="${vo.mailRegdate }" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
				</c:if>
				
			</tbody>
		</table>
		
		<div class="align-center">
			<ul class="pagination">
			<!-- 이전 블럭 -->
				<c:if test="${pageInfo.firstPage != 1 }">
					<li class="page-item"><a class="page-link" href="#" onclick="e_movePage('${pageInfo.firstPage-1}')"><i class="fas fa-chevron-left"></i><i class="fas fa-chevron-left"></i></a></li>
				</c:if>
			
			<!-- 1, 2, 3 .... -->
				
			
				<c:forEach var="i" begin="${pageInfo.firstPage }" end="${pageInfo.lastPage }">
					<li class="page-item
					
					<c:if test="${param.currentPage == i }">
					active
					</c:if>
					"><a class="page-link" href="#" onclick="e_movePage('${i}')">${i }</a></li>
				</c:forEach>
			
			<!-- 다음 블럭 -->
				<c:if test="${pageInfo.totalPage> pageInfo.lastPage }">
					<li class="page-item"><a class="page-link" href="#" onclick="e_movePage('${pageInfo.lastPage+1}')"><i class="fas fa-chevron-right"></i><i class="fas fa-chevron-right"></i></a></li>
					
				</c:if>
			</ul>
		</div>
	</div>
</div>

<form name="pagefrm" method="post" action="<c:url value='/address//emailList.do'/>">
	<input type="hidden" name="currentPage" value="1">
</form>

<%@ include file="../inc/bottom.jsp"%>
<script>
	var email_sel = new Array();

	$(function(){
		$('#chkAll').click(function(){
			email_sel = [];
			$('input[type=checkbox]#chk').each(function(idx, item){
				$(this).prop("checked", $('#chkAll').is(":checked"));
				if($(item).is(':checked')){
					email_sel.push($(item).val());
				}else{
					email_sel.pop($(item).val());
				}
			});
			alert(email_sel);
		});
		
		$('input[type=checkbox]#chk').each(function(idx, item){
			$(this).click(function(){
				if($(this).is(':checked')){
					email_sel.push($(this).val());
				}else{
					email_sel.pop($(this).val());
				}
			});
		});
	});

	function e_movePage(curPage){
		$('input[name=currentPage]').val(curPage);
		$('form[name=pagefrm]').submit();
	}
	
	function deleteMail(){
		$.ajax({
			url:"<c:url value='/address/emailDelete.do'/>",
			type:"get",
			data:{"sel":email_sel},
			success:function(edata){
				alert(edata);
				if(edata > 0){
					location.reload();
				}else{
					alert("메일 삭제 실패!");
				}
			},
			error:function(xhr, status, error){
				alert(status+" : "+error);
			}
		});
	}
	
	function sendEmail(){
		let email = $('#email').html();
		open(getContextPath()+'/address/sendEmail.do','','width=900px, height=700px, left=200px, top=100px, location=yes, resizable=no');
	}

	function mailDetail(mailNo){
		location.href="<c:url value='/address/emailDetail.do?mailNo="+mailNo+"'/>";
	}
</script>
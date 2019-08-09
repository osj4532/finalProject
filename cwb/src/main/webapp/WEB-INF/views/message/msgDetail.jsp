<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 상세보기</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<style>
	div{
		width:100%;
		border-top: 1px solid silver;
		border-bottom: 1px solid silver;
	}
	
	.senId{
		font-weight: bold;
	}
	
	.msgContent{
		min-height: 260px;
	}
	
	button{
		margin: 5px;
	}
</style>
</head>
<c:if test="${param.kind == 1 }">
	<c:set var="title" value="<span class='senId'>${map['MEM_ID'] }</span>이 내게 쓴 쪽지" />
</c:if>

<c:if test="${param.kind == 2 }">
	<c:set var="title" value="<span class='senId'>${map['MEM_ID'] }</span>에게 쓴 쪽지"/>
</c:if>
	<c:set var="memNo" value="${map['REV_MEM'] }"/>
<body>
	<button id="del" title="삭제"><i class="far fa-trash-alt"></i></button>
	<button id="re" title="답장"><i class="fas fa-reply"></i></button>
	<c:if test="${!empty pre }">
		<button id="pre" title="이전쪽지"><i class="fas fa-arrow-left"></i></button>
	</c:if>
	<c:if test="${!empty next}">
		<button id="next" title="다음쪽지"><i class="fas fa-arrow-right"></i></button>
	</c:if>
	<div class="msgHead">
		<p>${title }</p>
		<p>보낸 시간 ${map['MSG_REGDATE'] }</p>
	</div>
	<div class="msgTitle">
		<p>제목 ${map['MSG_TITLE'] }</p>
	</div>
	<div class="msgContent">
		<p>${map['MSG_CONTENT'] }</p>
	</div>
</body>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#del').click(function(){
			let kind = ${param.kind};
			let revNo = ${param.revNo};
			
			let sel = new Array();
			sel.push(revNo);
			
			$.ajax({
				url:"<c:url value='/message/revMsgDel.do'/>",
				type:"post",
				dataType:"json",
				data:{"sel":sel,
					"kind":kind},
				success:function(data){
					if(data > 0){
						opener.showList(kind,"",1);
						window.opener.alert("쪽지 삭제 성공!");
						window.close();
					}else{
						alert("쪽지 삭제 실패!");
					}
				},
				error:function(xhr, status, error){
					alert(status+" : "+error);
				}
			});
		});
		
		$('#re').click(function(){
			let kind = ${param.kind};
			let memNo;
			if(kind == 1){
				memNo = ${map['MEM_NO']};
			}else{
				memNo = ${map['REV_MEM']};
			}
			open('<c:url value="/address/sendMessage.do?"/>memNo='+memNo,'','width=600px, height=600px, left=200px, top=100px, location=yes, resizable=no');
		});
		
		$('#pre').click(function(){
			let keyword = $(opener.document).find('#msgSearch').val();
			location.href="<c:url value='/message/msgDetail.do'/>?kind="+${param.kind}+"&revNo="+"${pre}";
		});
		
		$('#next').click(function(){
			let keyword = $(opener.document).find('#msgSearch').val();
			location.href="<c:url value='/message/msgDetail.do'/>?kind="+${param.kind}+"&revNo="+"${next}";
		});
	});
</script>
</html>

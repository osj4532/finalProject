<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>

<style>
	#wraper1{
		margin-top: 80px;
		line-height: 3em;
	}
	
	#wraper1 div{
		overflow:hidden;
	}
	
	#emailContent{
		min-height: 400px;
		border: 1px solid black;
		border-radius: 10px 10px 10px 10px;
		overflow: hidden;
		padding: 20px;
	}
	
	.mailLabel{
		float: left;
		padding-right: 20px;
		border-bottom: 1px solid white;
		font-weight: bold;
		width: 100px;
	}
	
	.mailsm{
		border-bottom: 1px solid black;
	}
	
	.align-center{
		text-align: center;
	}
</style>

<div class="container panel">
	<div class="wraper2" id="wraper1">
		<div>
			<span class="mailLabel">받는 주소</span>
			<p class="mailsm">${vo.mailSenAddr }</p>
		</div>
		
		<div>
			<span class="mailLabel">제목</span>
			<p class="mailsm">${vo.mailTitle }</p>
		</div>
		
		<div id="emailContent">
			<p>${vo.mailContent }</p>
		</div>
		
		<div>
			<span class="mailLabel">첨부파일</span>
			<c:if test="${empty vo.mailOriginalFileName }">
				<p class="mailsm">첨부된 파일이 없습니다.</p>
			</c:if>
			<c:if test="${!empty vo.mailOriginalFileName }">
				<p class="mailsm">
				<a href="<c:url value='/document/download.do?fileName=${vo.mailFileName }&fileOriginalName=${vo.mailOriginalFileName }'/>">${vo.mailOriginalFileName }</a> [${vo.mailFileSize}B]</p>
			</c:if>
		</div>
		<div class="align-center">
			<c:if test="${!empty next}">
				<button id="next" class="btn btn-warning">다음 메일</button>
			</c:if>
			<button id="list" class="btn btn-secondary">메일 함</button>
			<c:if test="${!empty pre}">
				<button id="pre" class="btn btn-info">이전 메일</button>
			</c:if>
		</div>
	</div>
</div>
<%@ include file="../inc/bottom.jsp"%>
<script>
	$(function(){
		$('#next').click(function(){
			location.href="<c:url value='/address/emailDetail.do?mailNo=${next}'/>"
		});
		
		$('#list').click(function(){
			location.href="<c:url value='/address/emailList.do'/>"
		});
		
		$('#pre').click(function(){
			location.href="<c:url value='/address/emailDetail.do?mailNo=${pre}'/>"
		});
	});
</script>



<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<c:set var='mypage' value="useJs" />
<style type="text/css">
.help-block{  
	display: none;
}
.contentColor {
    background: #dad7d752;
    border-radius: 15px;
}
.mouseOver:hover {
    background: #dad6d6;
    margin-left: -10px;
    margin-right: -10px;
} 
.form-horizontal .form-group {
    margin-right: 0px;
    margin-left: 0px;
}
</style> 
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">
$(function(){
	
});

</script>
<section id="main-content">
	<section class="wrapper"> 
		<h3>
			<i class="fas fa-keyboard mt"></i> 게시판 글
		</h3>
		<!-- BASIC FORM ELELEMNTS --> 
		<div class="row mt">
	   	      <div class="col-lg-12">
				<div class="form-panel">
					<form name="boardDetail" 
					class="form-horizontal style-form">
						<div class="form-group"> 
						</div>  
						<div class="form-group"> 
						<label class="col-sm-1 col-sm-1 control-label"><b>작성자</b></label>
							<div class="col-sm-3">
								<h6>${memName}</h6>  
							</div>   
						<label class="col-sm-1 col-sm-1 control-label"><b>글 번호</b></label>
							<div class="col-sm-3"> 
								<h6>${BVo.boardNo }</h6> 
							</div>    
						<label class="col-sm-1 col-sm-1 control-label"><b>조회수</b></label>
							<div class="col-sm-3"> 
								<h6>${BVo.boardReadcount }</h6> 
							</div>  
						</div>   
						<div class="form-group">
							<label class="col-sm-1 col-sm-1 control-label">
							<b> 추천 </b> </label>
							<div class="col-lg-3">  
							<button type="button" class="btn btn-theme">
								  <i class="fas fa-clipboard-check"></i> 추천하기 </button>
							</div> 
							<label class="col-sm-1 col-sm-1 control-label"><b> 추천 수 </b></label>
							<div class="col-sm-3"> 
								<h6>${BVo.boardRecommend}</h6> 
							</div>   
						</div> 
						<div class="form-group">  
							<label class="col-sm-1 col-sm-1 control-label" id="boardlistAdd">
							<b> 첨부파일 </b> </label> 
							<div class="col-lg-3">   
							<c:if test="${empty BVo.boardFilename}">
							</c:if>
							<c:if test="${!empty BVo.boardFilename}">
								<b><a 
	href="<c:url value='/Board/download.do?boardFilename=${BVo.boardFilename }&boardOriginalfilename=${BVo.boardOriginalfilename }'/>">${BVo.boardOriginalfilename }</a>
	</b>(${BVo.boardFilesize}Byte)    
							</c:if> 
							</div>  
						</div> 
						<div class="form-group">
							<label class="col-sm-1 col-sm-1 control-label">
							<b>제목</b> </label>
							<div class="col-lg-5">${BVo.boardTitle}
							</div> 
						</div> 
						<div class="form-group">  
							<div class="col-lg-12 contentColor "><br> 
							${BVo.boardContent}
							</div> 
						</div> 
					</form> 
					
				</div>
			</div>
		</div>
		
		<div class="row mt">  
			<div class="col-lg-12">
				
			 
				<div class="form-panel">
					<h4 class="mb" id="EditListTitle"> 
						<i class="fas fa-clipboard"></i> 댓글  
					</h4> 
				<form class="form-horizontal style-form" >  
				<c:if test="${empty reList}">
				
				</c:if>
				<c:if test="${!empty reList}">
				<c:forEach var="reVo" items="${reList}">
					<div class="form-group">  
					<script type="text/javascript">
					 $(function() {
               			 $.ajax({ 
               				type : "post", 
							url : "<c:url value='/Reply/findAjaxMember.do'/>",
							data : {  
								"memNo": ${reVo.memNo}
							},  
			 				success : function(data) { 
								document.getElementById("replyName"+${reVo.repNo}).innerHTML
								= data;    
							}, 
							error : function(xhr, err) { 
								alert("ERROR! - readyState: " 
										+ xhr.readyState
										+ "<br/>status: "
										+ xhr.status
										+ "<br/>responseText: " 
										+ xhr.responseText);
							}
               			 });
               		 });
					</script>
						<label class="col-sm-1 col-sm-1 control-label"><b id="replyName${reVo.repNo}"></b></label>
							<div class="col-sm-7"> 
							<b>${reVo.repContent}</b> 
							</div>       
							<div class="col-sm-1">   
							</div> 
						</div>  
						</c:forEach>
					</c:if>	
				</form>
					<form class="form-horizontal style-form" 
					action="<c:url value='/Reply/ReplyWrite.do'/>" method="post" >
						<div class="form-group">  
						<label class="col-sm-1 col-sm-1 control-label"><b>댓글 입력</b></label>
							<div class="col-sm-7"> 
								<input type="hidden"  value="${BVo.boardNo}" name="boardNo">
								<input type="text" class="form-control" name="repContent">
							</div>      
							<div class="col-sm-2">  
								<button type="submit" class="btn btn-theme">
								  <i class="fas fa-edit"></i> 댓글 등록 </button>
							</div>   <b>공개 여부</b>    
							<div class="col-sm-1">   
								<div class="switch switch-square" 
									data-on-label="<i class=' fa fa-check'></i>"
									data-off-label="<i class='fa fa-times'></i>">
								<input name="repSecret" type="checkbox" />
								</div>   
							</div> 
						</div>   
					</form>
			</div>	
			<!-- col-lg-12-->
		</div>
		<!-- /row -->
		</div>
		<!-- INLINE FORM ELELEMNTS -->
		<!-- /row --> 
	</section>
	<!-- /wrapper -->
</section>

   
<script src="<c:url value='/resources/lib/bootstrap-switch.js'/>"></script>
<%@include file="../inc/bottom.jsp"%>
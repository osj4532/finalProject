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
 
$.editmake=function(no){
	var content =$('#replyContent'+no).html(); 
	$('#replyContent'+no).contents()   
	.unwrap().wrap( '<input type="text" class="form-control" name="repContent" value="'+content+'">' );
	$('#replyButton'+no).html('수정 완료');      
	$('#replyButton'+no).contents().unwrap()  
	.wrap("<button type='submit' class='btn btn-theme02'>");
	$('input[name=repNo]').val(no);  
} 

$.makegroup=function(no){
	$("div[name=groupDiv"+no+"]").hide(); 
	$("#groupDiv"+no).hide();
	var group=$('<div class="form-group" id="groupDiv'+no+'"></div>');
	$('#group'+no).after(group);  
	 
	$.selectinput(no);
	
	var input=$.insertinput(no);
	$('#groupDiv'+no).append(input);    
	$("#groupButton"+no).attr("onclick", "$.delgroup("+no+")" ); 
	 
} 


$.selectinput=function(no){
	var divReplys='';
	$.ajax({ 
 		type : "post", 
		url : "<c:url value='/Reply/GroupSelect.do'/>",
		data : {   
			"repNo": no
		},   
			success : function(data) {
				$.each(data, function(index,
						item) {
					var dep=this.repDepth
					var repDepth ='';   
					for (var i = 1; i < dep; i++) { 
						repDepth+='<i class="fas fa-chevron-circle-right"></i>&nbsp;';
					} 
					var button = ''; 
					if(${sessionScope.memNo}==this.memNo || ${sessionScope.ranksNo}==3){
					button = '<button type="button" class="btn btn-theme02" id="replyButton'+this.repNo+'" ><i class="fas fa-edit"></i> 수정 </button> <button type="button" class="btn btn-theme04"><i class="fas fa-edit"></i> 삭제 </button>';
					}
					  
					$('#group'+no).after($('<div class="form-group" id="group'+this.repNo+'" name="groupDiv'+no+'"><label class="col-sm-1 col-sm-1 control-label"></label><label class="col-sm-1 col-sm-1 control-label">'+repDepth+'</label><label class="col-sm-1 control-label"><b>'+this.memName+'</b></label><label class="col-sm-6 control-label"><b id="replyContent'+this.repNo+'" >'+this.repContent+'</b></label><div class="col-sm-2" id="replyDiv'+this.repNo+'" >'+button+'</div><button type="button" class="btn btn-theme"  onclick="$.makegroup('+this.repNo+')"  id="groupButton'+this.repNo+'"><i class="fas fa-edit"></i> 답글 </button></div>'));
					 
				});
				//$('#group'+no).after(divReplys   
				   //alert(divReplys);  	 
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
	
	
	
}

$.insertinput=function(no){
	var input =$('<label class="col-sm-1 col-sm-1 control-label"></label><label class="col-sm-1 col-sm-1 control-label"><b>답글 입력</b></label><div class="col-sm-4"><input type="text" class="form-control" id="groupContent'+no+'" ></div><div class="col-sm-2"><button type="button" class="btn btn-theme" onclick="$.insertgroup('+no+')"><i class="fas fa-edit"></i> 등록 </button></div>');
	return input; 
}

$.delgroup=function(no){
	$("div[name=groupDiv"+no+"]").hide(); 
	$("#groupDiv"+no).hide();
	$("#groupButton"+no).attr("onclick", "$.makegroup("+no+")" );
}

$.insertgroup=function(no){
	var content=$("#groupContent"+no).val();
	//alert(content);
 	$.ajax({ 
 		type : "post", 
		url : "<c:url value='/Reply/GroupWrite.do'/>",
		data : {  
			"repNo": no,
			"content" :content
		},   
			success : function(data) { 
			$('#groupDiv'+no).remove();    
			$("div[name=groupDiv"+no+"]").remove(); 
			$.makegroup(no);
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
	
}
  
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
				<form class="form-horizontal style-form"
				method="post" 
				action="<c:url value='/Reply/ReplyEdit.do'/>">  
				<input type="hidden" value="" name="repNo"> 
				<input type="hidden" value="${BVo.boardNo}" name="boardNo"> 
				<c:if test="${empty reList}">
				
				</c:if>
				<c:if test="${!empty reList}">
				<c:forEach var="reVo" items="${reList}">
					<div class="form-group" id="group${reVo.repNo}">   
					<script type="text/javascript">
					 $(function() {
               			 $.ajax({ 
               				type : "post", 
							url : "<c:url value='/Reply/findAjaxMember.do'/>",
							data : {  
								"memNo": ${reVo.memNo},
								"repSecret": '${reVo.repSecret}' 
							},   
			 				success : function(data) { 
								document.getElementById("replyName"+${reVo.repNo}).innerHTML
								= data.memName;  
								if(data.show=='N'){
									document.getElementById("replyContent"+${reVo.repNo}).innerHTML
									= '<strike>비공개 댓글입니다.</strike>';        
								}  
								if(data.divshow=='N'){
									$("#replyDiv"+${reVo.repNo}).hide(); 
								}  
								
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
							<b id="replyContent${reVo.repNo}">${reVo.repContent}</b>    - ${reVo.repNo}
							</div>       
							<div class="col-sm-2" id="replyDiv${reVo.repNo}"> 
							   <button type="button" class="btn btn-theme02" id="replyButton${reVo.repNo}" 
							   onclick="$.editmake(${reVo.repNo})">  
								  <i class="fas fa-edit"></i> 수정 </button>    
							   <button type="button" class="btn btn-theme04"> 
								  <i class="fas fa-edit"></i> 삭제 </button> 
							</div>  
							   <button type="button" class="btn btn-theme" id="groupButton${reVo.repNo}" onclick="$.makegroup(${reVo.repNo})"> 
								  <i class="fas fa-edit"></i> 답글 </button>
						</div>  
<!-- 						<div class="form-group"><label class="col-sm-1 col-sm-1 control-label"><i class="fas fa-chevron-circle-right"></i>&nbsp;<i class="fas fa-chevron-circle-right"></i></label><label class="col-sm-1 control-label"><b>작성자</b></label><label class="col-sm-6 control-label"><b>내용내용</b></label><div class="col-sm-2" id="replyContent" ><button type="button" class="btn btn-theme02" id="replyButton" ><i class="fas fa-edit"></i> 수정 </button><button type="button" class="btn btn-theme04"><i class="fas fa-edit"></i> 삭제 </button></div><button type="button" class="btn btn-theme" id="groupButton"><i class="fas fa-edit"></i> 답글 </button></div>
 -->						</c:forEach>
<!-- 	<div class="form-group">     
	<label class="col-sm-1 col-sm-1 control-label"><i class="fas fa-chevron-circle-right"></i>&nbsp;<i class="fas fa-chevron-circle-right"></i></label>
	<label class="col-sm-1 control-label"><b>작성자</b></label> 
	<label class="col-sm-6 control-label"><b>내용내용</b></label> 
			<div class="col-sm-2" id="replyContent" >  
			<button type="button" class="btn btn-theme02" id="replyButton"  >  
			  <i class="fas fa-edit"></i> 수정 </button>    
		   <button type="button" class="btn btn-theme04"> 
			  <i class="fas fa-edit"></i> 삭제 </button> 
			</div>  
			   <button type="button" class="btn btn-theme" id="groupButton"> 
				  <i class="fas fa-edit"></i> 답글 </button>
		</div>   --> 
						
						
						
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
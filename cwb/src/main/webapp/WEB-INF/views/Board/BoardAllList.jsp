<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<c:set var='mypage' value="useJs" />
<style type="text/css">
.help-block{  
	display: none;
}

.mouseOver:hover {
    background: #dad6d6;
    margin-left: -10px;
    margin-right: -10px;
} 
</style> 
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">
$(function(){
	$("#EditListPanel").hide();  
	$("#addBdlistName").keyup(function(){
		//alert($(this).val());      
		$("#boardlistAdd").html($(this).val()+" 등록 ");
	});  
	
	$('#EditListForm').submit(function(){
		var info=$('#EditBdlistName').val();
		if(info==''){   
			$(".editinfo").show();    
			event.preventDefault();
		} 
	});
	
	$('form[name=boardListAdd]').submit(function(){
		var info=$('#addBdlistName').val();
		if(info==''){ 
			$(".addinfo").show();  
			event.preventDefault();
		} 
	});
	
	
});

var myNo=0; 
$.bdlistEdit=function(bdlistNo){
	if(myNo==bdlistNo){
		$("#EditListPanel").toggle(500);  
	}else if (myNo!=bdlistNo) {
		$("#EditListPanel").show(500);
		myNo=bdlistNo;
		$.ajax({
			type : "post", 
			url: "<c:url value='/Board/BoardListByNo.do'/>",
			data:{ 
				"bdlistNo" : bdlistNo
			}, 
			success : function(data) { 
				$("#EditListTitle").html("<i class='fas fa-edit'></i> "+data.bdlistName+"  수정");
				$("#EditListForm").find("[name=bdlistName]").val(data.bdlistName); 
				$("input[name=bdlistNo]").val(data.bdlistNo); 
				//댓글 허용
				if(data.bdlistRe=='Y'){ 
					$("#EditListForm").find("[name=bdlistRe]").prop('checked', true);
					$("#bdlistReCk").find('.switch-animate').removeClass('switch-off');
					$("#bdlistReCk").find('.switch-animate').addClass('switch-on');
				}else if (data.bdlistRe=='N') {
					$("#EditListForm").find("[name=bdlistRe]").prop('checked', false);
					$("#bdlistReCk").find('.switch-animate').removeClass('switch-on');
					$("#bdlistReCk").find('.switch-animate').addClass('switch-off');
				}
				//댓글 허용
				if(data.bdlistUp=='Y'){ 
					$("#EditListForm").find("[name=bdlistUp]").prop('checked', true);
					$("#bdlistUpCk").find('.switch-animate').removeClass('switch-off');
					$("#bdlistUpCk").find('.switch-animate').addClass('switch-on');
				}else if (data.bdlistUp=='N') {
					$("#EditListForm").find("[name=bdlistUp]").prop('checked', false);
					$("#bdlistUpCk").find('.switch-animate').removeClass('switch-on');
					$("#bdlistUpCk").find('.switch-animate').addClass('switch-off');
				} 
				//추천 허용
				if(data.bdlistRe=='Y'){ 
					$("#EditListForm").find("[name=bdlistRe]").prop('checked', true);
					$("#bdlistRcCk").find('.switch-animate').removeClass('switch-off');
					$("#bdlistRcCk").find('.switch-animate').addClass('switch-on');
				}else if (data.bdlistRe=='N') {
					$("#EditListForm").find("[name=bdlistRe]").prop('checked', false);
					$("#bdlistRcCk").find('.switch-animate').removeClass('switch-on');
					$("#bdlistRcCk").find('.switch-animate').addClass('switch-off');
				}
 
				$('#EditranksNo option').each(function(){
					if($(this).val()==data.ranksNo) {
						$(this).prop('selected', 'selected');
					}  
				}); 
				
				       
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
} 

function delBdList(bdlistNo){
	location.href='<c:url value="/Board/BoardListDel.do?bdlistNo="/>'+bdlistNo;
}
</script>
<section id="main-content">
	<section class="wrapper"> 
		<h3>
			<i class="fas fa-keyboard mt"></i> 게시판 관리
		</h3>
		<!-- BASIC FORM ELELEMNTS --> 
		<div class="row mt">
	   	      <div class="col-lg-12">
				<div class="form-panel">
					<h4 class="mb"> 
						<i class="fas fa-clipboard"></i> 게시판 리스트 추가
					</h4> 
					<form name="boardListAdd" 
					class="form-horizontal style-form" method="post" 
					action="<c:url value='/Board/BoardListInsert.do'/>">
						<div class="form-group"> 
						</div>  
						<div class="form-group"> 
						<label class="col-sm-2 col-sm-2 control-label">게시판 이름</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="bdlistName"
									id="addBdlistName"
									placeholder="7자 이하 입력"> <span 
									class="help-block addinfo" >입력 해주세요!</span>
							</div>
						</div>  
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">댓글 가능 게시판</label>
							<div class="col-sm-3"> 
								<div class="switch switch-square" 
									data-on-label="<i class=' fa fa-check'></i>"
									data-off-label="<i class='fa fa-times'></i>">
								<input name="bdlistRe" type="checkbox" />
							</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">파일업로드 가능 게시판
							</label>
							<div class="col-sm-3">
								<div class="switch switch-square" 
									data-on-label="<i class=' fa fa-check'></i>"
									data-off-label="<i class='fa fa-times'></i>">
								<input name="bdlistUp" type="checkbox" />
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">추천 가능 게시판</label>
							<div class="col-sm-3">
								<div class="switch switch-square" 
									data-on-label="<i class=' fa fa-check'></i>"
									data-off-label="<i class='fa fa-times'></i>">
								<input name="bdlistRc" type="checkbox" />
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-sm-2 control-label">
							게시판 권한 설정</label>
							<div class="col-lg-3">     
								<select class="form-control" name="ranksNo">
								<c:forEach var="rankVo" items="${rankList}">
									<option value="${rankVo.ranksNo}">${rankVo.ranksName}</option>
								</c:forEach> 
								</select> 
							</div> 
						</div>
						<div class="form-group">  
							<label class="col-sm-2 col-sm-2 control-label" id="boardlistAdd">
							 등록 </label>
							<div class="col-lg-3">     
							 <button type="submit" class="btn btn-theme">
								  <i class="fas fa-clipboard-check"></i> 게시판 등록 </button>
							</div> 
						</div>
					</form> 
					
				</div>
			</div>
		</div>
		
		<div class="row mt">  
			<div class="col-lg-12">
				
				<div class="row"> 
				 
       	       <div class="col-md-6 col-sm-6 mb">
				<div class="form-panel">
					<h4 class="mb"> 
						<i class="fas fa-clipboard"></i> 게시판 리스트 
					</h4> 
					<form class="form-horizontal style-form" method="get">
						<div class="form-group">
						</div>  
						<c:if test="${!empty bdLlist}">
						<c:forEach var="bLlistVo" items="${bdLlist}"> 
						<div class="form-group mouseOver" onclick="$.bdlistEdit(${bLlistVo.bdlistNo})"> 
						<label class="col-sm-9 control-label"> ${bLlistVo.bdlistName} </label>
							<div class="col-sm-3"> 
								  <button type="button" class="btn btn-theme04" onclick="delBdList(${bLlistVo.bdlistNo})">
								  <i class="fas fa-trash-alt"></i> 게시판 삭제 </button> 
							</div>
						</div> 
						 </c:forEach>
						 </c:if>	 
						 <c:if test="${empty bdLlist}">
						 	<div class="form-group" >  
								<label class="col-sm-9 control-label"><b>등록한 게시판이 없습니다.</b></label>
								<div class="col-sm-3"> 
							</div>
							</div>   
						 </c:if>
					
					</form> 
					
				</div>
			</div>
			 
			<div class="col-md-6 col-sm-6 mb" id="EditListPanel">
				<div class="form-panel">
					<h4 class="mb" id="EditListTitle"> 
						<i class="fas fa-clipboard"></i> 게시판 수정 
					</h4> 
					<form class="form-horizontal style-form" method="post" 
						action="<c:url value='/Board/BoardListEdit.do'/>" id="EditListForm">
						<div class="form-group">
							<input type="hidden" name="bdlistNo"> 
						</div>  
						<div class="form-group"> 
						<label class="col-sm-4 col-sm-4 control-label">게시판 이름</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" name="bdlistName"
									id="EditBdlistName"
									placeholder="수정 게시판 클릭"> <span  
									class="help-block editinfo" >입력 해주세요.</span>
							</div>
						</div> 
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label">댓글 가능 게시판</label>
							<div class="col-sm-3"> 
								<div class="switch switch-square" id="bdlistReCk" 
									data-on-label="<i class=' fa fa-check'></i>"
									data-off-label="<i class='fa fa-times'></i>">
								<input  name="bdlistRe"  type="checkbox"  />
							</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label">파일업로드 가능 게시판
							</label>
							<div class="col-sm-3">
								<div class="switch switch-square" id="bdlistUpCk"
									data-on-label="<i class=' fa fa-check'></i>"
									data-off-label="<i class='fa fa-times'></i>">
								<input name="bdlistUp" type="checkbox" />
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label">추천 가능 게시판</label>
							<div class="col-sm-3">
								<div class="switch switch-square" id="bdlistRcCk"
									data-on-label="<i class=' fa fa-check'></i>"
									data-off-label="<i class='fa fa-times'></i>">
								<input name="bdlistRc" type="checkbox" />
								</div> 
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label">
							게시판 권한 설정</label> 
							<div class="col-lg-3">     
								<select class="form-control" name="ranksNo" id="EditranksNo">
								<c:forEach var="rankVo" items="${rankList}">
									<option value="${rankVo.ranksNo}">${rankVo.ranksName}</option>
								</c:forEach> 
								</select> 
							</div> 
						</div>
						<div class="form-group">  
							<label class="col-sm-4 col-sm-4 control-label" id="boardlistEdit">
							 수정 </label>
							<div class="col-lg-3">     
							 <button type="submit" class="btn btn-theme">
								  <i class="fas fa-edit"></i> 게시판 수정 </button>
							</div>  
						</div>
					</form>  
				</div>
			<!-- col-lg-12-->
		</div>
		<!-- /row -->
		
		</div>
		</div>
		</div>  
		<!-- INLINE FORM ELELEMNTS -->
		<!-- /row --> 
	</section>
	<!-- /wrapper -->
</section>

   
<script src="<c:url value='/resources/lib/bootstrap-switch.js'/>"></script>
<%@include file="../inc/bottom.jsp"%>
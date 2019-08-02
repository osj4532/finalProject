<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>
<style>
	.wraper2{
		margin-top:70px; 
	}
	
	.whNav{
		padding: 10px;
	}
	
	.whBtn{
		color: #fff;
		background: rgb(51, 154, 240);
		border: none;
		border-radius: 30px 30px 30px 30px;
		overflow: hidden;
		width: 60px;
		height: 60px;
		font-size: 2em;
		outline: none;
		margin-left: 20px;
	}
	
	.whBtn:hover{
		background-color: rgb(66, 169, 255);
	}
	
	.whBtn:active{
		background-color: rgb(6, 109, 195);
	}
	
	.whNav label {
	  display: inline-block;
	  padding: 10px 15px;
	  color: #fff;
	  font-size: inherit;
	  line-height: normal;
	  background-color: rgb(51, 154, 240);
	  cursor: pointer;
	  border: 1px solid rgb(66, 169, 255);
	  border-radius: 3em;
	  -webkit-transition: background-color 0.2s;
	  transition: background-color 0.2s;
	  font-size: 2em;
	  width: 60px;
      height: 60px;
	}
	
	.whNav label:hover {
	  background-color: rgb(66, 169, 255);
	}
	
	.whNav label:active {
	  background-color: rgb(6, 109, 195);
	}
	
	.whNav input[type="file"] {
	  position: absolute;
	  width: 1px;
	  height: 1px;
	  padding: 0;
	  margin: -1px;
	  overflow: hidden;
	  clip: rect(0, 0, 0, 0);
	  border: 0;
	}
	
	.bgRed{
		background: #c9302c;
	}
	
	.bgRed:hover{
		background: #d9403c;
	}
	
	.bgRed:active{
		background: #a9100c;
	}
	
	.whNav{
		background: rgba(0,0,0,0.2);
	}
		
	#selecter{
		float:right;
		width: 150px;
	}
	
	input[type=checkbox]{
		width: 20px;
		height: 20px;
	}
</style>
<div class="container">
	<div class="panel wraper2">
		<div class="whNav">
			<form id="fileForm" method="post" enctype="multipart/form-data">
				<label for="upload"><i class="fas fa-upload"></i></label>
	  			<input type="file" id="upload" name="fileName" multiple="multiple">
				<button class="whBtn" id="download"><i class="fas fa-download"></i></button>
				<button class="whBtn bgRed" id="fileDel"><i class="fas fa-trash-alt"></i></button>
				
				<select class="form-control" id="selecter">
					<c:forEach var="listVo" items="${WBList }">
						<option value="${listVo.webNo }">${listVo.webCategory }</option>
					</c:forEach>
				</select>
			</form>
		</div>
		<div class="whCon">
			<table class="table table-striped">
			
			</table>
		</div>
	</div>
</div>
<c:import url="../inc/bottom.jsp"/>
<script>
	$(function(){
		showWbList($('#selecter').val());
		
		/*웹하드 카테고리*/
		$('#selecter').change(function(){
			showWbList($(this).val());
		});
		
		/*파일 업로드*/
		$('#upload').change(function(){
		    let chkMsg = ""
		    if($(this)[0].files.length == 1){
		    	chkMsg = $(this)[0].files[0].name+"파일을 업로드 하시겠습니까?";
		    }else if($(this)[0].files.length > 1){
		    	chkMsg = $(this)[0].files[0].name+"외 "+ ($(this)[0].files.length-1)+"개의 파일을 업로드 하시겠습니까?";
		    }
		    
		    let chk = confirm(chkMsg);
		   	if(chk){
		   		
		   		$.ajax({
		   			url:"<c:url value='/webhard/setwebNo.do'/>",
		   			type:"post",
		   			data:{"webNo":$('#selecter').val()},
		   			dataType:"json",
		   			error:function(e){alert(e);}
		   		});
		   		
		   		
		   		
		   		let formData = new FormData($('#fileForm')[0]);
		   		
		   		$.ajax({
		   			url:"<c:url value='/webhard/webhardUpload.do'/>",
		   			type:"post",
		   			enctype:"multipart/form-data",
		   			data: formData,
		   			processData: false,
		   			contentType: false,
		   			success:function(result){
		   				showWbList($('#selecter').val());
		   			},
		   			error:function(e){
						alert(e);		   				
		   			}
		   		});
		   	}
		});
	});
	
	/*웹하드 파일 목록 조회*/
	function showWbList(webNo){
		let memNo = ${sessionScope.memNo};
		$.ajax({
			url:"<c:url value='/webhard/webhardFileList.do'/>",
			type:"post",
			dataType:"json",
			data:{"webNo":webNo,
				"memNo":memNo},
			success:function(data){
				let col = 5;
				
				let table = $('table');
				let thead = $('<thead></thead>');
				let trEl = $('<tr></tr>');				
				let thEl1 = $('<th><input type="checkbox" id="chkAll"></th>');				
				let thEl2 = $('<th>파일 이름</th>');
				let thEl3 = $('<th>파일 크기</th>');
				let thEl4 = $('<th>파일 등록일</th>');
				let thEl5 = $('<th>다운로드 수</th>');
				
				trEl.html(thEl1);
				trEl.append(thEl2);
				trEl.append(thEl3);
				trEl.append(thEl4);
				trEl.append(thEl5);
				
				if(webNo != 2){
					let thEl6 = $('<th>등록한 사람</th>');
					trEl.append(thEl6);
					col = 6;
				}
				
				thead.html(trEl);
				table.html(thead);
				
				if(data.length < 1){
					let trEl1 = $('<tr></tr>');
					let tdEl = $('<td colspan="'+col+'">등록된 파일이 없습니다.</td>');
					tdEl.css("text-align","center");
					trEl1.html(tdEl);
					table.append(trEl1);
				}else{
					
				}
				
			},
			error:function(status, error){
				alert(status+" : "+error);
			}
		});
	}
	
</script>
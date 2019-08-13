<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>
<script type="text/javascript" src="<c:url value='/resources/lib/bootstrap/js/bootstrap.js'/>"></script>
<style>
	.wraper2{
		margin-top: 70px;
	}
	
	.wblist{
	}
	
	.wbInput{
	}
	
	.align-center{
		text-align: center;
	}
	
	#cateList{
		width:230px;
		
	}
</style>
<div class="container">
	<div class="row wraper2 panel">
		<h3>웹하드 관리</h3>
		<div class="col-sm-4">
			<select id="cateList" multiple="multiple" size="7">
				
			</select>
		</div>
		<div class="col-sm-8">
			<input type="hidden" name="webNo">
			<div class="form-group">
				<label>이름</label>
				<input type="text" class="form-control" name="oldCate" readonly="readonly">
			</div>
			<div class="form-group">
				<label>등록/수정할 이름</label>
				<input type="text" class="form-control" name="webCategory">
			</div>
			<div class="align-center">
				<button id="add" class="btn btn-primary">등록하기</button>
				<button id="edit" class="btn btn-warning">수정하기</button>
				<button id="del" class="btn btn-danger">삭제하기</button>
			</div>
		</div>
	</div>
</div>
<c:import url="../inc/bottom.jsp"/>
<script>
	$(function(){
		showList();
		
		$('#cateList').change(function(){
			let webNo = $('#cateList :selected').val();
			let cate = $('#cateList :selected').html();
			
			$('input[name=webNo]').val(webNo);
			$('input[name=oldCate]').val(cate);
		});
		
		$('#add').click(function(){
			event.preventDefault();
			
			let webCategory = $('input[name=webCategory]').val();
			if(webCategory != ''){
				$.ajax({
					url:"<c:url value='/webhard/addWBList.do'/>",
					type:"post",
					dataType:"json",
					data:{"webCategory":webCategory},
					success:function(data){
						if(data > 0){
							showList();
							$('input[name=webCategory]').val('');
						}else{
							alert("등록 실패!");
						}
					},
					error:function(e){
						alert(e);
					}
				});
			}
		});
		
		$('#edit').click(function(){
			event.preventDefault();
			
			let webNo = $('input[name=webNo]').val();
			let webCategory = $('input[name=webCategory]').val();
			if(webNo == 1 || webNo == 2){
				alert('수정이 불가능한 카테고리입니다.');
				return false;
			}
			
			if(webCategory != ''){
				$.ajax({
					url:"<c:url value='/webhard/editWBList.do'/>",
					type:"post",
					dataType:"json",
					data:{"webNo":webNo,
						"webCategory":webCategory},
					success:function(data){
						if(data > 0){
							showList();
							$('input[name=webCategory]').val('');
						}else{
							alert("수정 실패!");
						}
					},
					error:function(e){
						alert(e);
					}
				});
			}
		});
		
		$('#del').click(function(){
			event.preventDefault();
			
			let webNo = $('input[name=webNo]').val();
			if(webNo == 1 || webNo == 2){
				alert('삭제가 불가능한 카테고리입니다.');
				return false;
			}
			
			let check = confirm("정말 삭제 하시겠습니까?\n삭제하면 모든 파일이 지워집니다.");
			if(check && webNo != ''){
				$.ajax({
					url:"<c:url value='/webhard/delWBList.do'/>",
					type:"post",
					dataType:"json",
					data:{"webNo":webNo},
					success:function(data){
						if(data > 0){
							showList();
							$('input[name=webNo]').val('');
							$('input[name=oldCate]').val('');
						}else{
							alert("삭제 실패!");
						}
					},
					error:function(e){
						alert(e);
					}
				});
			}
		});
	});
	
	function showList(){
		$.ajax({
			url:"<c:url value='/webhard/showWBList.do'/>",
			type:"post",
			dataType:"json",
			success:function(data){
				let cateList = $('#cateList');
				cateList.html('');
				for(let i = 0; i < data.length; i++){
					let vo = data[i];
					let opt = $('<option value="'+vo.webNo+'">'+vo.webCategory+'</option>');
					cateList.append(opt);					
				}
				
				
			},
		});
	}
	
</script>
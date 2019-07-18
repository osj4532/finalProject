<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>
<style type="text/css">
	#wraper1{
		overflow: hidden;
		margin-top:90px;
		border: 1px solid white;
		border-radius: 10px 10px 10px 10px;
	}
	
	
	
	#info1{
		position:relative;
		width: 100%;
		height:500px;
		background-color: white;
	}
	
	#info2{
	}
	
	#image{
		position:absolute;
        max-width:100%; max-height:100%;
        width:auto; height:auto;
        margin:auto;
        top:0; bottom:0; left:0; right:0;
		padding:10px;        
	}
	
	form[name=signFrm] p{
		font-size: 1.5em;
	}
	
	form[name=signFrm] span{
		font-size: 0.7em;
	}
	
	form[name=signFrm] label{
		font-size: 2.0em;
	}
</style>

</head>
<body>
<div class="container">
	<div id="wraper1" class="center-block">
		<h2>사인 이미지 미리보기</h2>
		<div id="info1" >
			<img id="image"
				<c:if test="${!empty signVo }">
					src="<c:url value="/sign_file/${signVo.signFileName }"/>"
				</c:if>
			/>
		</div>
		<div id="info2" class="col">
			
			<form name="signFrm" method="post" action="<c:url value="/sign/signReg.do"/>"
				enctype="multipart/form-data">
				<c:if test="${!empty signVo.signFileName }">
					<div>
						<label>등록된 파일</label><span style="color:green;">※ 새로 등록하면 기존 파일은 삭제 됩니다.</span>
						<p>${signVo.signOriginalFileName }&nbsp;</p>
						
					</div>
				</c:if>
				<div class="form-group">
					<label>사인 파일</label>
					<input type="file" name="file" id="signFileName" class="form-control">			
				</div>
				<div class="form-group text-center">
					<c:if test="${empty signVo.signFileName }">
						<input id="insert" class="btn btn-primary" type="button" value="등록하기">
					</c:if>
					<c:if test="${!empty signVo.signFileName }">
						<input id="edit" class="btn btn-info" type="button" value="수정하기">
					</c:if>
					
				</div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$('#insert').click(function(){
		if($('#signFileName').val() == ''){
			alert("사인 파일을 선택해주세요.");
		}else{
			$('form[name=signFrm]').attr('action','<c:url value="/sign/signReg.do"/>');
			$('form[name=signFrm]').submit();
		}
		
	});

	$('#edit').click(function(){
		if($('#signFileName').val() == ''){
			alert("사인 파일을 선택해주세요.");
		}else{
			$('form[name=signFrm]').attr('action','<c:url value="/sign/signEdit.do"/>');
			$('form[name=signFrm]').submit();
		}
		
	});

	document.getElementById("signFileName").onchange = function(){
		var reader = new FileReader();
		
		reader.onload = function(e){
			document.getElementById("image").src = e.target.result;
		};
		
		reader.readAsDataURL(this.files[0]);
	};
</script>
<%@ include file="../inc/bottom.jsp" %>
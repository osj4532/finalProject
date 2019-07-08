<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	#wraper1{
		overflow: hidden;
	}
	
	#info1, #info2{
		border: 1px solid black;
	}
	
	#info1{
		position:relative;
		width: 300px;
		height:300px;
	}
	
	#info2{
	}
	
	#image{
		position:absolute;
        max-width:100%; max-height:100%;
        width:auto; height:auto;
        margin:auto;
        top:0; bottom:0; left:0; right:0;
	}
</style>

</head>
<body>
<div class="container">
	<div class="row" id="wraper1">
		<h2>사인 이미지 미리보기</h2>
		<div id="info1">
			<img id="image"/>
		</div>
		<div id="info2">
			<form>
				<div>
					<label>사인 파일</label>
					<input type="file" name="signFileName" id="signFileName">			
				</div>		
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	document.getElementById("signFileName").onchange = function(){
		var reader = new FileReader();
		
		reader.onload = function(e){
			document.getElementById("image").src = e.target.result;
		};
		
		reader.readAsDataURL(this.files[0]);
	};
</script>
</body>
</html>
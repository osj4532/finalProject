<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<title>Insert title here</title>
<style type="text/css">
	a{color: #fff;}
	#optionLayer{
		position:fixed;
		bottom:0;
		left:0;
		border: 1px solid rgb(78,205,196);
		background: rgb(78,205,196);
		width:210px;
		padding: 5px;
		z-index: 600;
	}
	
	#optionLayerTop{
		display:none;
		background-color: #fff;
	}
	
	#optionLaterBottom{
		text-align: right;
	}
		
		
	ul, #dept {
	  list-style-type: none;
	}
	
	#dept {
	  margin: 0;
	  padding: 0;
	}
	
	.box {
	  cursor: pointer;
	  -webkit-user-select: none; /* Safari 3.1+ */
	  -moz-user-select: none; /* Firefox 2+ */
	  -ms-user-select: none; /* IE 10+ */
	  user-select: none;
	}
	
	.box::before {
	  content: "\2610";
	  color: black;
	  display: inline-block;
	  margin-right: 6px;
	}
	
	.check-box::before {
	  content: "\2611"; 
	  color: dodgerblue;
	}
	.nested {
	  display: none;
	}
	
	.active {
	  display: block;
	}
	
	.nested a{
		color:#000;
		text-decoration: none;
	}
</style>
</head>
<body>
<div id="optionLayer">
	<div id="optionLayerBottom">
		<input type="text" name="keyword" placeholder="이름입력">
		<span id="openText" onclick="openOptions();">
			<i class="fas fa-arrow-up"></i>
		</span>
	</div>
	<div id="optionLayerTop">
		<p>조직도</p>
		<ul id="dept">
			<c:forEach var="deptVo" items="${depts }">
				<li><span class="box">
					<i class="fas fa-users"></i>
					${deptVo.deptName }
				</span>
				
				<ul class="nested">
					<c:forEach var="memVo" items="${members }">
						<c:if test="${deptVo.deptNo == memVo.deptNo }">
							<li>
								<span id="tree">&#9507;</span>
								<a href="#">${memVo.memName }</a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		var toggler = $('.box');
		$(toggler).each(function(){
			$(this).click(function(){
				$(this).next().toggleClass("active");
				$(this).toggleClass("check-box");
			});
		});
	});
	
	function showList(){
		$.ajax({
			url:"",
			type:"post",
			dataType:"json",
			data:{
				
			},
			success:function(data){
				
			},
			error:function(){
				
			}
		});
	}
	
	
	function openOptions(){
		let toOpen = $('#optionLayerTop');
		
		if($('#openText').html() == '<i class="fas fa-arrow-down"></i>'){
			$(toOpen).hide();
			$('#openText').html('<i class="fas fa-arrow-up"></i>');
		}else{
			$(toOpen).show();
			$('#openText').html('<i class="fas fa-arrow-down"></i>');
		}
	};
</script>

</body>
</html>
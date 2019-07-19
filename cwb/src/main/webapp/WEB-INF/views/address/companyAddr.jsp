<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<c:url value='/resources/lib/bootstrap/css/bootstrap.min1.css'/>"> --%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Insert title here</title>
<style type="text/css">
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
		min-height: 300px;
	}
	
	#optionLayerBottom{
		text-align: right;
		overflow: hidden;
		height: 40px;
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
	.ad_nested {
	  display: none;
	}
	
	.ad_active {
	  display: block;
	}
	
	.ad_nested a{
		color:#000;
		text-decoration: none;
	}
	
	#result a{
		color:#000;
		text-decoration: none;
	}
	
	input[name=keyword]{
		width:85%;
		float: left;
	}
	
	#result{
		padding-left: 5px; 
	}
	
	#openText{
		font-size: 20px;
	    position: relative;
		right: 6px;
	    top: 4px;
	    color:#fff;
	    cursor: pointer;
	}
	
	.align-center{
		text-align: center;
	}
	.modal-dialog{
		margin-top: 70px;
	}
	
	.modal-dialog.modal-infosize{
		width: 400px;
	}
	
</style>
</head>
<body>
<!-- 부서별 사원 목록 및 검색 -->
<div id="optionLayer">
	<div id="optionLayerBottom">
		<input type="text" name="keyword" class="w3-input w3-border-0 w3-round-xxlarge"
		 placeholder="이름/부서/직책 입력">
		 
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
				
				<ul class="ad_nested">
					<c:forEach var="memMap" items="${members }">
						<c:if test="${deptVo.deptNo == memMap['DEPT_NO'] }">
							<li>
								<span id="tree">&#9507;</span>
								<a href="#" onclick="showMemInfo('${memMap['MEM_NO']}')">[${memMap['POS_NAME']}] ${memMap['MEM_NAME'] }</a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</li>
			</c:forEach>
		</ul>
		<ul id="result">
					
		</ul>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="memInfo" tabindex="-1" role="dialog" aria-labelledby="memInfoLabel" aria-hidden="true">
  <div class="modal-dialog modal-infosize" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h5 class="modal-title" id="memInfoLabel">사원 정보</h5>
      </div>
      <div class="modal-body align-center">
      	<input type="hidden" id="memNo">
        <img id="pic" class="rounded-circle" src="" alt="" width="100" height="100">
        <h3 id="dept">[부서]</h3>
        <h4><span id="pos">[직책]</span><span id="name">이름</span></h4>
        <p id="tel">연락처 : 010-1234-4567</p>
        <p>이메일 : <span id="email">test@test.com</span></p>
        <button class="btn btn-info" onclick="sendMessage()">쪽지쓰기</button>
        <button class="btn btn-success" onclick="sendEmail()">이메일쓰기</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>
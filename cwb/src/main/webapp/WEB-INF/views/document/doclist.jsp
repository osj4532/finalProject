<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../inc/top.jsp"></c:import>

<style type="text/css">
	.wraper1{
		overflow: hidden;
		padding: 20px;
		padding-top: 100px;
	}

	.wraper1 .info1, .wraper1 .info2{
		float: left;
		border: 1px solid silver;
		min-height: 600px;
		background-color: white;
	}
	
	.info1 li:hover{
		background:  rgb(38,123,204);
		color:#FFF;
	}
	
	.info2 table{
		text-align: center;
	}
	
	.info2 table th{
		text-align: center;
	}
</style>

<div class="container">
	<div class="row wraper1">
		<div class="info1 col-sm-2">
			<h4>문서 상태</h4>
			<ul class="list-group">
            	<a href="#">
                	<li class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			결재대기
                		</li>
                </a>
                <a href="#">
                	<li class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			결재완료
                		</li>
                </a>
                <a href="#">
                	<li class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			결재반려
                		</li>
                </a>
                <a href="#">
                	<li class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			임시저장
                		</li>
                </a>
       		</ul>
		</div>
		<div class="info2 col-sm-10">
			<h2>문서 목록</h2>
			<table class="table table-hover">
				<colgroup>
					<col width="10%">
					<col width="15%">
					<col width="10%">
					<col width="35%">
					<col width="10%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th>문서 번호</th>
						<th>양식 종류</th>
						<th>기안자</th>
						<th>기안 제목</th>
						<th>문서 상태</th>
						<th>문서 등록일</th>
					</tr>
				</thead>
				<tbody>
					
					<tr onclick="docDetail(1)">
						<td>1</td>
						<td>일반품의서</td>
						<td>사원1</td>
						<td>테스트기안입니다.1</td>
						<td>대기</td>
						<td>2019-07-09</td>
					</tr>
					
					<tr>
						<td>2</td>
						<td>일반품의서</td>
						<td>사원1</td>
						<td>테스트기안입니다.2</td>
						<td>대기</td>
						<td>2019-07-09</td>
					</tr>
					<tr>
						<td>3</td>
						<td>일반품의서</td>
						<td>사원1</td>
						<td>테스트기안입니다.3</td>
						<td>대기</td>
						<td>2019-07-09</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

<c:import url="../inc/bottom.jsp"></c:import>
<script type="text/javascript">
	function docDetail(cfNo){
		location.href="<c:url value='/document/docDetail.do?cfNo='/>"+cfNo;
	}
</script>
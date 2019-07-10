<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            	<a href="<c:url value="/document/docList.do?cfState=1"/>">
                	<li class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			결재대기
                		</li>
                </a>
                <a href="<c:url value="/document/docList.do?cfState=2"/>">
                	<li class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			결재완료
                		</li>
                </a>
                <a href="<c:url value="/document/docList.do?cfState=3"/>">
                	<li class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			결재반려
                		</li>
                </a>
                <a href="<c:url value="/document/docList.do?cfState=4"/>">
                	<li class="list-group-item">
                		<i class="far fa-file-alt fa-lg"></i> 
                			임시저장
                		</li>
                </a>
       		</ul>
		</div>
		<div class="info2 col-sm-10">
			<h2>${title }</h2>
			<table class="table table-hover">
				<colgroup>
					<col width="15%">
					<col width="15%">
					<col width="10%">
					<col width="35%">
					<col width="25%">
				</colgroup>
				<thead>
					<tr>
						<th>문서 번호</th>
						<th>양식 종류</th>
						<th>기안자</th>
						<th>기안 제목</th>
						<th>문서 등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list }">
						<tr>
							<td colspan="6">등록된 문서가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty list }">
						<c:forEach var="map" items="${list }">
							<tr onclick="docDetail('${map['CF_NO']}')">
								<td>${map['CF_NO']}</td>
								<td>${map['FORM_NAME']}</td>
								<td>${map['MEM_NAME']}</td>
								<td>${map['CF_TITLE']}</td>
								<td><fmt:formatDate value="${map['CF_REGDATE']}" pattern="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>
					</c:if>
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
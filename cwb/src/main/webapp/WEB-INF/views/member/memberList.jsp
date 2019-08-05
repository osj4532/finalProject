<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>
<script type="text/javascript">
function resign(memNo){
	
    if(confirm("삭제하시겠습니까?")){
    	
        location.href = "<c:url value='/member/memberResign.do?memNo='/>"+memNo;
        return true;
    } else {
        return false;
    }
}
</script>
<style type="text/css">
#Main{
		min-height: 900px;
	}
	.row{
		margin-top: 100px;
	}
	#content{
		min-height: 890px;
		background-color: white;
		min-width: 900px;
	}
</style>
<section id="main-content">
	<section class="wrapper">
	<h3><i class="fas fa-users"></i> 사원 목록</h3>
	<div class="row">
		<div class="col-lg-12">   
			<div class="form-panel">
			<form name="frmList" action="<c:url value='/member/memberList.do'/>" method="post">
				<table id="tblList" class="table table-hover">
					<colgroup>
						<col style="width:10%;"/>
						<col style="width:15%;"/>
						<col style="width:20%;"/>
						<col style="width:15%;"/>
						<col style="width:20%;"/>
						<col style="width:20%"/>
					</colgroup>
					<thead>
						<tr>
							<th>사원번호</th>
							<th>이름</th>
							<th>부서</th>
							<th>직급</th>
							<th>연락처</th>
							<th>수정/삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list }">
							<tr>
								<td colspan="7">해당하는 상품이 없습니다.</td>
							</tr>
						</c:if>
						<c:forEach var="map" items="${list }">
						<c:if test="${map['MEM_NO'] != sessionScope.memNo}">
							<tr>
								<td>${map['MEM_NO'] }</td>
								<td>${map['MEM_NAME'] }</td>
								<td>${map['DEPT_NAME'] }</td>
								<td>${map['POS_NAME'] }</td>
								<td>${map['MEM_HP1'] }-${map['MEM_HP2'] }-${map['MEM_HP3'] }</td>
								<td><a class="btn btn-theme" href="<c:url value='/member/memberEdit.do?memNo=${map["MEM_NO"] }'/>"><i class="fa fa-cog"></i>수정</a>
								<a class="btn btn-danger" href="#" onclick="resign(${map['MEM_NO']})"><i class="far fa-trash-alt"></i>퇴사</a></td>
							</tr>
						</c:if>
						</c:forEach>
					</tbody>
				</table>
				<input type="button" id="register" value="등록" class="btn btn-info" onclick="location.href='<c:url value='/member/memberRegister.do'/>'">
			</form>
			
			</div>
		</div>
	</div>
	</section>
</section>

<c:import url="../inc/bottom.jsp"/>
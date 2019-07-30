<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>
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
<div id="Main" class="container">
	<div class="row">
		<div id="content" class="col-md-8">
			<form name="frmList" action="<c:url value='/member/memberList.do'/>" method="post">
				<table id="tblList">
					<colgroup>
						<col style="width:10%;"/>
						<col style="width:15%;"/>
						<col style="width:20%;"/>
						<col style="width:15%;"/>
						<col style="width:40%;"/>
					</colgroup>
					<thead>
						<tr>
							<th>사원번호</th>
							<th>이름</th>
							<th>부서</th>
							<th>직급</th>
							<th>연락처</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list }">
							<tr>
								<td colspan="7">해당하는 상품이 없습니다.</td>
							</tr>
						</c:if>
						<c:forEach var="vo" items="${list }">
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>

<c:import url="../inc/bottom.jsp"/>


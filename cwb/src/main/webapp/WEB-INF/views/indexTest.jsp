<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="inc/top.jsp" %>

<style>
	.info, .info th{
		text-align: center;
	}
	
	.subInfo{
		border: 1px solid white;
		background: white;
	}
	
	.subInfo .head{
		padding:5px;
		position: relative; 
	}
	
	.subInfo .detail{
		position: absolute;
		right: 10px;
    	top: 25px;
    	cursor: pointer;
	}
	
	.subInfo .content{
		
	}
</style>

<section id="main-content">
	<section class="wrapper">
		<div class="row mt info">
			<div class="col-md-4 col-sm-4 mb">
				<div class="subInfo">
					<div class="head">
						<h5><i class="far fa-comment-dots"></i> 읽지 않은 쪽지</h5>
						<a class="detail"><i class="far fa-plus-square"></i>더보기</a>
					</div>
					<div class="content">
						<table class="table">
							<tr>
								<th>보낸 사람</th>
								<th>제목</th>
							</tr>
							<tr>
								<td>사람1</td>
								<td>결재대기</td>
							</tr>
							<tr>
								<td>사람2</td>
								<td>결재대기</td>
							</tr>
							<tr>
								<td>사람3</td>
								<td>결재대기</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			
			<c:if test="${sessionScope.ranksNo > 1 }">
				<div class="col-md-4 col-sm-4 mb">
					<div class=" subInfo">
						<div class="head">
							<h5><i class="fas fa-file-signature"></i> 결재 대기 문서</h5>
							<a class="detail"><i class="far fa-plus-square"></i>더보기</a>
						</div>
						<div class="content">
							<table class="table">
								<tr>
									<th>기안자</th>
									<th>문서종류</th>
									<th>제목</th>
								</tr>
								<tr>
									<td>사람1</td>
									<td>휴가신청</td>
									<td>휴가</td>
								</tr>
								<tr>
									<td>사람2</td>
									<td>일반기안</td>
									<td>기안합니다.</td>
								</tr>
								<tr>
									<td>사람3</td>
									<td>결재서</td>
									<td>결재요청</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</c:if>
			
			<div class="col-md-4 col-sm-4 mb">
				<div class=" subInfo">
					<div class="head">
						<h5><i class="fas fa-file-upload"></i> 최근 기안 문서 상태</h5>
						<a class="detail"><i class="far fa-plus-square"></i>더보기</a>
					</div>
					<div class="content">
						<table class="table">
							<tr>
								<th>문서 종류</th>
								<th>순서</th>
								<th>상태</th>
							</tr>
							<tr>
								<td>품의서</td>
								<td>2</td>
								<td>결재대기</td>
							</tr>
							<tr>
								<td>품의서</td>
								<td>2</td>
								<td>결재대기</td>
							</tr>
							<tr>
								<td>품의서</td>
								<td>2</td>
								<td>결재대기</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			
			
			<div class="col-md-4 col-sm-4 mb">
				<div class=" subInfo">
					<div class="head">
						<h5><i class="fas fa-at"></i> 최근 보낸 메일</h5>
						<a class="detail"><i class="far fa-plus-square"></i>더보기</a>
					</div>
					<div class="content">
						<table class="table">
							<tr>
								<th>보낸주소</th>
								<th>제목</th>
							</tr>
							<tr>
								<td>test@test.com</td>
								<td>테스트메일입니다.</td>
							</tr>
							<tr>
								<td>test@test.com</td>
								<td>테스트메일입니다.</td>
							</tr>
							<tr>
								<td>test@test.com</td>
								<td>테스트메일입니다.</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
</section>

<%@include file="inc/bottom.jsp" %>
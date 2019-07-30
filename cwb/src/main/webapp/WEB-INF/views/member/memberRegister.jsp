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
	.width_80{
		width: 80px;
	}
	.width_350{
		width:350px;
	}
</style>
<div id="Main" class="container">
	<div class="row">
		<div id="content" class="col-md-8">
			<form name="frmContent" method="post" action="<c:url value='/member/memberRegister.do'/>" enctype="multipart/form-data">
				<fieldset>
					<legend>사원 등록</legend>
					<div class="input-group flex-nowrap">
					  <div class="input-group-prepend">
					    <span class="input-group-text" id="addon-wrapping">성명</span>
					  </div>
					  <input type="text" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="addon-wrapping">
					</div>
					<div>
						<label for="memId">사원ID</label>
						<input type="text" name="memId" id="memId"><span class="error"></span>
					</div>
					<div>
						<label for="pwd">비밀번호</label>
						<input type="Password" name="pwd" id="pwd">
					</div>
					<div>
						<label for="pwd2">비밀번호 확인</label>
						<input type="Password" name="pwd2" id="pwd2">
					</div>
					<div>
						<label for="zipcode">주소</label>
						<input type="text" name="zipcode" id="zipcode" ReadOnly
								title="우편번호" class="width_80">
						<input type="Button" value="우편번호 찾기" id="btnZipcode" title="새창열림"><br>
						<span class="sp1">&nbsp;</span>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="address" ReadOnly title="주소" class="width_350"><br>
						<span class="sp1">&nbsp;</span>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="addressDetail" title="상세주소" class="width_350">
					</div>
					<div>
						<label for="hp1">핸드폰</label>&nbsp;<select name="hp1" id="hp1" title="휴대폰 앞자리">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select>
						-
						<input type="text" name="hp2" id="hp2" maxlength="4" title="휴대폰 가운데자리" class="width_80">-
						<input type="text" name="hp3" id="hp3" maxlength="4" title="휴대폰 뒷자리" class="width_80">-
					</div>
					<div>
						<label for="email1">이메일 주소</label>
						<input type="text" name="email1" id="email1" title="이메일주소 앞자리">@
						<select name="email2" id="email2" title="이메일주소 뒷자리">
							<option value="naver.com">naver.com</option>
							<option value="hanmail.com">hanmail.com</option>
							<option value="nate.com">nate.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="etc">직접입력</option>
						</select>
						<input type="text" name="email3" id="email3" title="직접입력인 경우 이메일주소 뒷자리" style="visibility:hidden">
					</div>
					<div>
						<label for="achievement">학력</label>
						<input type="text" name="achievement" id="achievement">
					</div>
					<div>
						<label for="pay">연봉</label>
						<input type="text" name="pay" id="pay">
					</div>
					<div>
						<label for="memImage">사원사진</label>
						<input type="file" name="memImage" id="memImage">
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</div>

<c:import url="../inc/bottom.jsp"/>
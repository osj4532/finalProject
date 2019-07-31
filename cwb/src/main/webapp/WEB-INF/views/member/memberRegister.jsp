<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp" />

<style type="text/css">
#Main {
	min-height: 900px;
}

.minus {
    width: 11px;
    padding: 0px;
    margin-top: 5px;
}

#content {
	min-height: 890px;
	background-color: white;
	min-width: 900px;
}

.width_80 {
	width: 80px;
}

.width_350 {
	width: 350px;
}
</style>
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fas fa-keyboard mb mt"></i> 사원 등록
		</h3>  
		<div class="row">   
			<div class="col-lg-12">   
				<div class="form-panel"> 
					<h4 class="mb"> 
						<i class="fas fa-clipboard"></i> 사원 등록
					</h4>
					<form name="frmContent" class="form-horizontal style-form"
						method="post" action="<c:url value='/member/memberRegister.do'/>"
						enctype="multipart/form-data">
						<div class="form-group"> 
						</div>  
						<div class="form-group">  
							<label class="col-sm-1 col-sm-1 control-label" id="addon-wrapping">성명</label>
							<div class="col-sm-8">  
							<input type="text" class="form-control" placeholder="Username">
							</div> 
						</div>  	
						<div class="form-group"> 
							<label for="memId" class="col-sm-1 col-sm-1 control-label" >사원ID</label>
							<div class="col-sm-8">  
							 <input type="text" name="memId" class="form-control"
								id="memId"><span class="error"></span>
							</div>	
						</div>
						<div class="form-group"> 
							<label for="pwd" class="col-sm-1 col-sm-1 control-label">비밀번호</label>
							<div class="col-sm-8">  
							 <input type="Password" name="pwd" class="form-control"
								id="pwd">
							</div>
						</div>
						<div class="form-group"> 
							<label for="pwd2" class="col-sm-1 col-sm-1 control-label" >비밀번호 확인</label> 
							<div class="col-sm-8">  
							<input type="Password" class="form-control"
								name="pwd2" id="pwd2">
							</div>
						</div>
						<div class="form-group"> 
							<label for="zipcode" class="col-sm-1 col-sm-1 control-label" >주소</label>
							<div class="col-sm-10">       
								<div class="col-sm-4 mb">       
								<input type="text" name="zipcode"
									id="zipcode" ReadOnly title="우편번호" class="form-control">
								</div>        
								<div class="col-sm-6 mb">     
								<input type="Button" class="btn btn-success"
								 value="우편번호 찾기" id="btnZipcode" title="새창열림">  
								</div>    
								<div class="col-sm-10 mb">          
								<input type="text" name="address" class="form-control"
								 	ReadOnly title="주소" >  
							 	</div>         
							 	<div class="col-sm-10 mb">  
								<input type="text" name="addressDetail"  class="form-control"
									title="상세주소" >
								</div> 
							</div>  
						</div>  
						<div class="form-group"> 
							<label for="hp1" class="col-sm-1 col-sm-1 control-label" >핸드폰</label>
							  <div class="col-sm-1">    
								<select name="hp1" id="hp1" class="form-control"
									title="휴대폰 앞자리"> 
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select> 
								</div> 
								<div class="col-sm-1 minus"> 
								<i class="fas fa-minus"></i>
								</div>
								 <div class="col-sm-2"> 
								 	<input type="text" name="hp2" id="hp2" maxlength="4"
									title="휴대폰 가운데자리" class="form-control">
								</div>    
								<div class="col-sm-1 minus">  
									<i class="fas fa-minus"></i>
								</div>  
								 <div class="col-sm-2">
									<input type="text"
									name="hp3" id="hp3" maxlength="4" title="휴대폰 뒷자리"
									class="form-control" >
								</div>	   
						</div>
						
						<div class="form-group"> 
							<label for="email1"  class="col-sm-1 col-sm-1 control-label">이메일 주소</label> 
							<div class="col-sm-2">
							<input type="text" class="form-control"
								name="email1" id="email1" title="이메일주소 앞자리">
								</div>
								<div class="col-sm-1 minus"> 
								<i class="fas fa-at"></i> 
								</div>	 
								<div class="col-sm-2">
								<select class="form-control"
								name="email2" id="email2" title="이메일주소 뒷자리">
								<option value="naver.com">naver.com</option>
								<option value="hanmail.com">hanmail.com</option>
								<option value="nate.com">nate.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="etc">직접입력</option>
							</select> 
							</div>
							<div class="col-sm-2">
							<input type="text" name="email3" id="email3" class="form-control"
								title="직접입력인 경우 이메일주소 뒷자리" style="visibility: hidden" > 
							</div> 
						</div>
						<div class="form-group"> 
							<label for="achievement"  class="col-sm-1 col-sm-1 control-label">학력</label> 
							<div class="col-sm-8">
								<input type="text" class="form-control"
									name="achievement" id="achievement">
							</div> 
						</div>
						<div class="form-group"> 
							<label for="pay"  class="col-sm-1 col-sm-1 control-label">연봉</label>
							<div class="col-sm-8"> 
							 <input type="text" name="pay" class="form-control"
								id="pay">
							</div>								
						</div>
						<div class="form-group">  
							<label for="memImage" class="col-sm-1 col-sm-1 control-label">사원사진</label>
							<div class="col-sm-8">  
								<input type="file"  
									name="memImage" id="memImage">
							</div> 
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</section>
<c:import url="../inc/bottom.jsp" />
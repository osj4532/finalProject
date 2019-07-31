<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

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
<script type="text/javascript" src="<c:url value='/resources/js/member.js'/>"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#submit').click(function(){
		if($('#name').val().length<1){
			alert('성명을 입력하세요');
			event.preventDefault();
			$('#name').focus();
		}else if(!validate_userid($('#memId').val())){
			alert('아이디는 영문대소문자, 숫자, _만 입력가능합니다.');
			event.preventDefault();
			$('#memId').focus();
		}else if($('#pwd').val().length<1){
			alert('비밀번호를 입력하세요');
			event.preventDefault();
			$('#pwd').focus();
		}else if($('#pwd').val()!=$('#pwd2').val()){
			alert('비밀번호가 일치해야 합니다.');
			event.preventDefault();
			$('#pwd2').focus();
		}else if(!validate_hp($('#hp2').val()) || !validate_hp($('#hp3').val())){
			alert('휴대폰은 숫자만 입력 가능 합니다');
			event.preventDefault();
			$('#hp2').focus();
		}else if($('#chkId').val()!='Y'){
			alert('아이디 중복확인을 하세요');
			event.preventDefault();
			$('#btnChkId').focus();
		}
	});
	
	$('#memId').keyup(function(){
		if(validate_userid($('#memId').val()) && $('#memId').val().length>=2){
			$.ajax({
				url:"<c:url value='/member/ajaxDupUserid.do'/>",
				type:"get",
				data:"memId="+$('#memId').val(),
				success:function(res){
					var str ="";
					if(res){	//사용가능
						str="사용가능한 아이디";
						$('#chkId').val('Y');
					}else{
						str="이미 등록된 아이디";
						$('#chkId').val('N');
					}
					$('.error').html(str);
					$('.error').show();
					
				},
				error:function(xhr, status, error){
					alert(status+":"+error)
				}
			});
			
		}else{
			$(".error").html('아이디 규칙에 맞지 않습니다');
			$('.error').show();
			$('#chkId').val('N');
		}
	});
	
});

function getAddressInfo(){
    new daum.Postcode({
        oncomplete: function(data) {
        	
        	var value;
            var jusoSangsae="";
            var str = data.jibunAddress;
            str = str.split(" ");

            if(data.userSelectedType == "J"){
                for(var i =0;i<str.length;i++){
                    if(str[i]==data.bname){
                        value=i;
                    }
                }
            }else{
                str = data.roadAddress;
                str = str.split(" ");         
                for(var i=0;i<str.length;i++){
                    if(str[i]==data.roadname){
                        value=i;
                    }
                }
            }

            for(var i=value;i<str.length;i++){
                jusoSangsae = jusoSangsae+str[i];
            }
            $('#zipcode').val(data.zonecode);
            $('#address').val(data.sido+" "+data.sigungu+" "+jusoSangsae);
        },
        shorthand : false
    }).open();
}
</script>
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fas fa-keyboard mb mt"></i> 사원 등록
		</h3>  
		<div class="row">   
			<div class="col-lg-12">   
				<div class="form-panel"> 
					<form name="frmContent" class="form-horizontal style-form was-validated"
						method="post" action="<c:url value='/member/memberRegister.do'/>"
						enctype="multipart/form-data">
						<div class="form-group"> 
						</div>  
						<div class="form-group">  
							<label class="col-sm-1 col-sm-1 control-label" id="addon-wrapping">성명</label>
							<div class="col-sm-8">  
							<input type="text" class="form-control" id="name" name="name">
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
								<input type="Button" class="btn btn-info"
								 value="우편번호 찾기" id="btnZipcode" onclick="getAddressInfo()" title="새창열림">  
								</div>    
								<div class="col-sm-10 mb">          
								<input type="text" name="address" class="form-control" id="address"
								 	ReadOnly title="주소" >  
							 	</div>         
							 	<div class="col-sm-10 mb">  
								<input type="text" name="addressDetail"  class="form-control" id="addressDetail"
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
						<label for="department"  class="col-sm-1 col-sm-1 control-label">부서</label>
						<div class="col-sm-2">
								<select class="form-control"
								name="department" id="department" title="부서">
								<option value="1">기획팀</option>
								<option value="2">설계팀</option>
								<option value="3">디자인팀</option>
								<option value="4">지원팀</option>
								<option value="5">법인팀</option>
							</select>
							</div>
							</div>
							<div class="form-group">
						<label for="position"  class="col-sm-1 col-sm-1 control-label">직급</label>
						<div class="col-sm-2">
							<select class="form-control" name="position" id="position" title="직급">
								<option value="1">이사</option>
								<option value="2">사장</option>
								<option value="3">부장</option>
								<option value="4">과장</option>
								<option value="5">대리</option>
								<option value="6">팀장</option>
								<option value="7">사원</option>
							</select>
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
							<label for="holiday"  class="col-sm-1 col-sm-1 control-label">연차</label>
							<div class="col-sm-8"> 
							 <input type="text" name="holiday" class="form-control"
								id="holiday">
							</div>								
						</div>
						<div class="form-group">  
							<label for="memImage" class="col-sm-1 col-sm-1 control-label">사원사진</label>
							<div class="col-sm-8">  
								<input type="file"  
									name="memImage" id="memImage">
							</div> 
						</div>
						<div class="center">
							<input type="submit" id="submit" value="등록" class="btn btn-success">
							<input type="reset" id="reset" value="취소" class="btn btn-danger">
						</div>
						<input type="hidden" name="chkId" id="chkId">
					</form>
				</div>
			</div>
		</div>
	</section>
</section>
<c:import url="../inc/bottom.jsp" />
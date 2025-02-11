<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="<c:url value='/resources/lib/jquery-3.4.1.min.js'/>"></script>
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
.error{
	color: red;
	font-weight: bold;
	display: none;
}
</style>
<script type="text/javascript" src="<c:url value='/resources/js/member.js'/>"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#memHp1 option').each(function(item){
		if($(this).val() == '${map['MEM_HP1']}'){
			$(this).prop("selected", "selected");
		}
	});
	
	$('#memEmail2 option').each(function(item){
		if($(this).val() == '${map['MEM_EMAIL2']}'){
			$(this).prop("selected", "selected");
			return false;
		}else{
			$('#memEmail3').css("visibility", 'visible');
			$('#memEmail2').val("etc");
			$('#memEmail3').val('${map['MEM_EMAIL2']}');
		}
	});
	
	$('#submit').click(function(){
		if($('input[name=memName]').val().length<1){
			alert('성명을 입력하세요');
			event.preventDefault();
			$('input[name=memName]').focus();
		}else if($('#memId').val().length<1){
			alert('id를 입력하세요');
			event.preventDefault();
			$('#memId').focus();
		}else if($('#memPwd').val().length<1){
			alert('비밀번호를 입력하세요');
			event.preventDefault();
			$('#memPwd').focus();
		}else if($('#memPwd').val()!=$('#memPwd2').val()){
			alert('비밀번호가 일치해야 합니다.');
			event.preventDefault();
			$('#memPwd2').focus();
		}else if(!validate_hp($('#memHp2').val()) || !validate_hp($('#memHp3').val())){
			alert('휴대폰은 숫자만 입력 가능 합니다');
			event.preventDefault();
			$('#memHp2').focus();
		}else if($('#memHp2').val().length<1 || $('#memHp3').val().length<1){
			alert('전화번호를 입력하세요');
			event.preventDefault();
			$('#memHp2').focus();
		}else if($('#memEmail2').val() != "etc"){
			if($('#memEmail1').val().length<1 || $('#memEmail2').val().length<1){
				alert('이메일을 입력하세요');
				event.preventDefault();
				$('#memEmail1').focus();
			}
		}else if($('#memEmail2').val() == "etc"){
			if($('#memEmail1').val().length<1 || $('#memEmail3').val().length<1){
				alert('이메일을 입력하세요');
				event.preventDefault();
				$('#memEmail1').focus();
			}
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
            $('#memZipcode').val(data.zonecode);
            $('#memAddress').val(data.sido+" "+data.sigungu+" "+jusoSangsae);
        },
        shorthand : false
    }).open();
}


var contextPath = "/finalproject";
$(document).ready(function(){
	$('#memEmail2').change(function(){
		if($(this).val()=="etc"){
			$('#memEmail3').css('visibility', 'visible');
			$('#memEmail3').focus();
		}else{
			$('#memEmail3').css('visibility', 'hidden');
			$('#memEmail3').val("");
		}
	});
	
});

function validate_hp(hp){
	var pattern = new RegExp(/^[0-9]*$/g);
	return pattern.test(hp);
	/* 정규식 /^[0-9]*$/g
	0 에서 9사이의 숫자로 시작하거나 끝나야 한다는 의미
	(^는 시작, $는 끝을 의미)
	닫기 대괄호(]) 뒤의 * 기호는 0번 이상 반복 */
}

function validate_userid(userid){
	var pattern = new RegExp(/^[a-zA-Z0-9_]/g);
	return pattern.test(userid);
	/* 정규식 /^[a-zA-Z0-9_]+$/g
	a에서 z 사이의 문자, A~Z사이의 문자, 0에서 9사이의 숫자나 _로 시작하거나
	끝나야 한다는 의미
	닫기 대괄호(]) 뒤의 + 기호는 이 패턴이 한 번 또는 그 이상 반복된다는 의미 */
}

function list(){
	location.href="<c:url value='/member/memberList.do'/>";
}

</script>
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fas fa-user-plus"></i> 사원 정보
		</h3>  
		<div class="row">   
			<div class="col-lg-12">   
				<div class="form-panel"> 
					<form name="frmContent" class="form-horizontal style-form was-validated"
						method="post" action="<c:url value='/member/memberDetail.do'/>"
						enctype="multipart/form-data">
						<div class="form-group"> 
						</div>  
						<div class="form-group">  
							<label class="col-sm-1 col-sm-1 control-label">성명</label>
							<div class="col-sm-2">  
								<input type="text" class="form-control" id="memName" name="memName" value="${map['MEM_NAME'] }" readOnly>
							</div> 
						</div>  	
						<div class="form-group"> 
							<label for="memId" class="col-sm-1 col-sm-1 control-label" >사원ID</label>
							<div class="col-sm-2">  
							 <input type="text" name="memId" class="form-control"
								id="memId" value="${map['MEM_ID'] }" readOnly>
							</div>	
							<div class="col-sm-2">
								<span class="error"></span>
								</div>
						</div>
						<div class="form-group"> 
							<label for="memZipcode" class="col-sm-1 col-sm-1 control-label" >주소</label>
							<div class="col-sm-10">       
								<div class="col-sm-2 mb">       
								<input type="text" name="memZipcode"
									id="memZipcode" ReadOnly title="우편번호" class="form-control" value="${map['MEM_ZIPCODE'] }">
								</div>        
								<div class="col-sm-6 mb">     
								<input type="Button" class="btn btn-info"
								 value="우편번호 찾기" id="btnZipcode" onclick="getAddressInfo()" title="새창열림">  
								</div>    
								<div class="col-sm-8 mb">          
								<input type="text" name="memAddress" class="form-control" id="memAddress"
								 	ReadOnly title="주소" value="${map['MEM_ADDRESS'] }">  
							 	</div>         
							 	<div class="col-sm-8 mb">  
								<input type="text" name="memAddressDetail"  class="form-control" id="memAddressDetail"
									title="상세주소" value="${map['MEM_ADDRESSDETAIL'] }" readOnly>
								</div> 
							</div>  
						</div>  
						<div class="form-group"> 
							<label for="memHp1" class="col-sm-1 col-sm-1 control-label" >핸드폰</label>
							  <div class="col-sm-1">    
								<select name="memHp1" id="memHp1" class="form-control"
									title="휴대폰 앞자리" disabled="disabled">
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
								 <div class="col-sm-1"> 
								 	<input type="text" name="memHp2" id="memHp2" maxlength="4"
									title="휴대폰 가운데자리" class="form-control" value="${map['MEM_HP2']}" readOnly>
								</div>    
								<div class="col-sm-1 minus">  
									<i class="fas fa-minus"></i>
								</div>  
								 <div class="col-sm-1">
									<input type="text"
									name="memHp3" id="memHp3" maxlength="4" title="휴대폰 뒷자리"
									class="form-control" value="${map['MEM_HP3'] }" readOnly>
								</div>	   
						</div>
						
						<div class="form-group"> 
							<label for="memEmail1"  class="col-sm-1 col-sm-1 control-label">이메일 주소</label> 
							<div class="col-sm-2">
							<input type="text" class="form-control"
								name="memEmail1" id="memEmail1" title="이메일주소 앞자리" value="${map['MEM_EMAIL1'] }" readOnly>
								</div>
								<div class="col-sm-1 minus"> 
								<i class="fas fa-at"></i> 
								</div>	 
								<div class="col-sm-2">
								<select class="form-control"
								name="memEmail2" id="memEmail2" title="이메일주소 뒷자리" disabled="disabled">
								<option value="naver.com">naver.com</option>
								<option value="hanmail.com">hanmail.com</option>
								<option value="nate.com">nate.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="etc">직접입력</option>
							</select> 
							</div>
							<div class="col-sm-2">
							<input type="text" name="memEmail3" id="memEmail3" class="form-control"
								title="직접입력인 경우 이메일주소 뒷자리" style="visibility:hidden" readOnly> 
							</div> 
						</div>
						<div class="form-group"> 
							<label for="memAchievement"  class="col-sm-1 col-sm-1 control-label">학력</label> 
							<div class="col-sm-2">
								<input type="text" class="form-control"
									name="memAchievement" id="memAchievement" value="${map['MEM_ACHIEVEMENT'] }" readOnly>
							</div> 
						</div>
						<div class="form-group"> 
							<label for="memPay"  class="col-sm-1 col-sm-1 control-label">연봉</label>
							<div class="col-sm-2"> 
							 <input type="text" name="memPay" class="form-control"
								id="memPay" readOnly value="${map['MEM_PAY'] }">
							</div>								
						</div>
						<div class="form-group"> 
							<label for="memHoliday"  class="col-sm-1 col-sm-1 control-label">연차</label>
							<div class="col-sm-2"> 
							 <input type="text" name="memHoliday" class="form-control"
								id="memHoliday" readOnly value="${map['MEM_HOLIDAY'] }">
							</div>								
						</div>
						<div class="form-group">
						<label for="deptNo"  class="col-sm-1 col-sm-1 control-label">부서</label>
						<div class="col-sm-2">
								<select class="form-control"
								name="deptNo" id="deptNo" title="부서" disabled="disabled">
									<option value="1">${map['DEPT_NAME'] }</option>
							</select>
							</div>
							</div>
							<div class="form-group">
						<label for="posNo"  class="col-sm-1 col-sm-1 control-label">직급</label>
						<div class="col-sm-2">
							<select class="form-control" name="posNo" id="posNo" title="직급" disabled="disabled">
									<option value="1">${map['POS_NAME'] }</option>
							</select>
							</div>
							</div>
							<div class="form-group">
						<label for="ranksNo"  class="col-sm-1 col-sm-1 control-label">등급</label>
						<div class="col-sm-2">
							<select class="form-control" name="ranksNo" id="ranksNo" title="등급" disabled="disabled">
									<option value="1">${map['RANKS_NAME'] }</option>
							</select>
							</div>
							</div>
						<div class="form-group">  
							<label for="fileName" class="col-sm-1 col-sm-1 control-label">사원사진</label>
							<div class="col-sm-8">  
								<c:if test="${!empty map['MEM_FILENAME'] }">
									<img alt="사원사진" src="<c:url value='/member_file/${map["MEM_FILENAME"] }'/>" width="150px">
								</c:if>
							</div> 
						</div>
						<div class="center">
							<input type="button" id="btnUpdate" value="정보 수정하기" class="btn btn-success" onclick="location.href='<c:url value='/member/memberUpdate.do?memNo=${sessionScope.memNo }'/>'">
							<input type="button" id="back" value="돌아가기" class="btn btn-danger" onclick="location.href='<c:url value='/member/memberMypage.do'/>'">
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</section>
<c:import url="../inc/bottom.jsp" />
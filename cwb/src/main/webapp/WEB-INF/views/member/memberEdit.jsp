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
</script>
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fas fa-user-edit"></i> 사원 정보 수정
		</h3>  
		<div class="row">   
			<div class="col-lg-12">   
				<div class="form-panel"> 
					<form name="frmContent" class="form-horizontal style-form was-validated"
						method="post" action="<c:url value='/member/memberEdit.do'/>">
						<div class="form-group"> 
						</div>  
						<div class="form-group">  
							<label class="col-sm-1 col-sm-1 control-label">성명</label>
							<div class="col-sm-2">  
								<input type="text" class="form-control" id="memName" name="memName" readOnly
								value="${map['MEM_NAME'] }">
							</div> 
						</div>  	
						
						<div class="form-group">
						<label for="deptNo"  class="col-sm-1 col-sm-1 control-label">부서</label>
						<div class="col-sm-2">
								<select class="form-control"
								name="deptNo" id="deptNo" title="부서">
								<c:forEach var="deptVo" items="${deptList }">
									<option value="${deptVo.deptNo }"
									<c:if test="${deptVo.deptNo == map['DEPT_NO']}">
										selected="selected"
									</c:if>
									>${deptVo.deptName }</option>
								</c:forEach>
							</select>
							</div>
							</div>
							<div class="form-group">
						<label for="posNo"  class="col-sm-1 col-sm-1 control-label">직급</label>
						<div class="col-sm-2">
							<select class="form-control" name="posNo" id="posNo" title="직급">
								<c:forEach var="positionVo" items="${positionList }">
									<option value="${positionVo.posNo }"
									<c:if test="${positionVo.posNo == map['POS_NO']}">
										selected="selected"
									</c:if>
									>${positionVo.posName }</option>
								</c:forEach>
							</select>
							</div>
							</div>
							<div class="form-group">
						<label for="ranksNo"  class="col-sm-1 col-sm-1 control-label">등급</label>
						<div class="col-sm-2">
							<select class="form-control" name="ranksNo" id="ranksNo" title="등급">
								<c:forEach var="ranksVo" items="${ranksList }">
									<option value="${ranksVo.ranksNo }"
									<c:if test="${ranksVo.ranksNo == map['RANKS_NO']}">
										selected="selected"
									</c:if>
									>${ranksVo.ranksName }</option>
								</c:forEach>
							</select>
							</div>
							</div>
						<div class="center">
							<input type="submit" id="submit" value="수정" class="btn btn-success">
							<input type="reset" id="reset" value="취소" class="btn btn-danger">
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</section>
<c:import url="../inc/bottom.jsp" />
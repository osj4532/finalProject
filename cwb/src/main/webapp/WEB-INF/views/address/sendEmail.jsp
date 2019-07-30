<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/resources/lib/bootstrap/css/bootstrap.min1.css'/>"  rel="stylesheet">
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
<style type="text/css">
/* Making the label break the flow */
.floating-label
{
    position: absolute;
    top: 0;
    left: 0;
    user-select: none;
     z-index: 1500;
}

/* Hide the browser-specific focus styles */
.floating-label-field
{
    color: rgba(44, 62, 80, .75); 
    border-width: 0;
    z-index: 2000;
}
.floating-label-field:focus
{
    outline: 0;
    box-shadow: 0;
}
.floating-label-field::placeholder
{
    color: rgba(44, 62, 80, .5);
}

/* Make the label and field look identical on every browser */
.floating-label,
.floating-label-field
{
    font: inherit;
    line-height: 1; 

    display: block;

    width: 100%;
}

.floating-label-field,
.floating-label-wrap
{
    position: relative;
}

/* Input Style #1 */
.floating-label-field--s1
{
    transition: border-color .25s ease-in-out;

    color: rgba(0, 0, 0, .75); 
    border-bottom: 3px solid rgba(255, 255, 255, .05);
    background-color: transparent;
    
    border-bottom: 1px solid black;
}
.floating-label-field--s1 + .floating-label
{
    transition: transform .25s, opacity .25s ease-in-out;
    transform-origin: 0 0;

    opacity: .5;
}
.floating-label-field--s1:focus,
.floating-label-field--s1:not(:placeholder-shown)
{
    border-color: rgba(255, 255, 255, .1);
    border-bottom: 1px solid black;
}
.floating-label-field--s1:focus + .floating-label,
.floating-label-field--s1:not(:placeholder-shown) + .floating-label
{
    transform: translate(.25em, -30%) scale(.8);

    opacity: .25;
}
.floating-label-field--s1:valid:not(:placeholder-shown)
{
    border-color: rgba(46, 213, 115, .3);
}
.floating-label-field--s1:invalid
{
    border-color: rgba(255, 71, 87, .3);
}

.floating-label-field--s1:not(textarea),
.floating-label-field--s2:not(textarea),
.floating-label-field--s3:not(textarea)
{
    max-height: 4em;
}

.floating-label-field--s1,
.floating-label-field--s1 + .floating-label,
.floating-label-field--s2,
.floating-label-field--s2 + .floating-label
{
    padding: 2em;
}

.floating-label-field--s1 + .floating-label,
.floating-label-field--s2 + .floating-label
{
    z-index: 1500;
}

.floating-label-field--s1::placeholder,
.floating-label-field--s3::placeholder
{
    color: transparent;
}

.align-center{
	text-align: center;
}

.btnDiv{
	text-align: right;
	margin-right: 10px;
	margin-top: 10px;
}

</style>
</head>
<body>
<div class="btnDiv">
<button id="add" class="btn btn-info">받는사람</button>
</div>
<form name="mailfrm" action="<c:url value='/address/sendEmailProc.do'/>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mailRev" value="${memNo }"/>
	<input type="hidden" name="mailRevAddr" value="${sender }">
	<div class="lab-grid-cell lab-grid-cell--mb-2x w-third--d w-half--t w-full--m">
	    <div class="floating-label-wrap">
	      <input type="text" class="floating-label-field floating-label-field--s1" name="mailSenAddr" 
	      	id="mailSenAddr" placeholder="받는사람" value="${receiver }">
	      <label for="mailSenAddr" class="floating-label">
	      	받는사람
	      </label>
	    </div><!-- .floating-label-wrap -->        
	</div>
	
	<div class="lab-grid-cell lab-grid-cell--mb-2x w-third--d w-half--t w-full--m">
	    <div class="floating-label-wrap">
	      <input type="text" class="floating-label-field floating-label-field--s1" name="mailTitle" 
	      	id="mailTitle" placeholder="제목">
	      <label for="mailTitle" class="floating-label">제목</label>
	    </div><!-- .floating-label-wrap -->        
	</div>
	
	<br>
	
	<div>
		<textarea id="summernote" name="mailContent"></textarea>
	</div>
	<div>
		<label>첨부파일</label>
		<input type="file" name="fileName">
	</div>
	<div class="align-center">
		<button type="submit" class="btn btn-primary">메일 보내기</button>
	</div>
</form>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<c:url value="/resources/lib/bootstrap/js/bootstrap1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/summernote/summernote.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/summernote/lang/summernote-ko-KR.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    $('#summernote').summernote({
	    	height:300,
	    	lang: 'ko-KR',
	    	fontNames: ['돋움','휴먼모음T','궁서','휴먼옛체' ]
	    });
	});
	
	
	$(function(){
		$('form[name=mailfrm]').submit(function(){
			if($('#mailSenAddr').val() == ''){
				alert("보낼 주소를 입력해 주세요.");
				$('#mailSenAddr').focus();
				event.preventDefault();
			}else if($('#mailTitle').val() == ''){
				alert("보낼 이메일 제목을 입력해 주세요.");
				$('#mailTitle').focus();
				event.preventDefault();
			}
			opener.location.href="<c:url value='/address/emailList.do'/>";
			
		});
		
		$('#add').click(function(){
			window.open("<c:url value='/address/selAddr.do'/>",'',"width=630px,height=630px,left=100px,top=100px,resizable=no,location=yes");
		});
	})
</script>
</body>
</html>
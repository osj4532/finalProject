<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>

<style>
.wraper2{
		margin: 100px auto;
}

.card{
	width: 500px;
	min-height: 550px;
}

.card-body{
	font-size: 1.5em;
}

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

.floating-label-wrap{
	margin: 10px;
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

#btnDiv input{
	width: 90%;
	height:50px;
	margin: 10px;
	margin-top: 30px;
	font-size: 1.2em;
}
</style>

<div class="container">
	<div class="wraper2 card">
		<div class="card-body">
			<div class="align-center">
				<h2><i class="fas fa-address-card"></i> 개인 연락처 수정</h2>
			</div>
			
			<form action="<c:url value='/address/addEdit.do'/>" method="post">
				<input type="hidden" name="addrbookNo" value="${vo.addrbookNo }">
				<div class="lab-grid-cell lab-grid-cell--mb-2x w-third--d w-half--t w-full--m">
				    <div class="floating-label-wrap">
				      <input type="text" class="floating-label-field floating-label-field--s1" name="addrbookComname" 
				      	id="addrbookComname" placeholder="회사명" value="${vo.addrbookComname }">
				      <label for="addrbookComname" class="floating-label">
				      	회사명
				      </label>
				    </div><!-- .floating-label-wrap -->        
				</div>
				
				<div class="lab-grid-cell lab-grid-cell--mb-2x w-third--d w-half--t w-full--m">
				    <div class="floating-label-wrap">
				      <input type="text" class="floating-label-field floating-label-field--s1" name="addrbookName" 
				      	id="addrbookName" placeholder="이름" value="${vo.addrbookName }">
				      <label for="addrbookName" class="floating-label">
				      	이름
				      </label>
				    </div><!-- .floating-label-wrap -->        
				</div>
				
				<div class="lab-grid-cell lab-grid-cell--mb-2x w-third--d w-half--t w-full--m">
				    <div class="floating-label-wrap">
				      <input type="tel" class="floating-label-field floating-label-field--s1" name="addrbookTel" 
				      	id="addrbookTel" placeholder="이름" value="${vo.addrbookTel }">
				      <label for="addrbookTel" class="floating-label">
				      	연락처
				      </label>
				    </div><!-- .floating-label-wrap -->        
				</div>
				
				<div class="lab-grid-cell lab-grid-cell--mb-2x w-third--d w-half--t w-full--m">
				    <div class="floating-label-wrap">
				      <input type="email" class="floating-label-field floating-label-field--s1" name="addrbookEmail" 
				      	id="addrbookEmail" placeholder="이름" value="${vo.addrbookEmail }">
				      <label for="addrbookEmail" class="floating-label">
				      	이메일
				      </label>
				    </div><!-- .floating-label-wrap -->        
				</div>
				<div id="btnDiv" class="align-center">
					<input type="submit" class="btn btn-primary" value="수정하기">
				</div>
			</form>
		</div>
	</div>
</div>

<%@ include file="../inc/bottom.jsp"%>
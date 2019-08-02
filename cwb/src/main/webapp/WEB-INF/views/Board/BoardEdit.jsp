<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
  <title>컴워밸 - Company&Worker balance</title>

  <!-- Favicons -->
  <link href="<c:url value='/resources/img/favicon.png'/>" rel="icon">
  <link href="<c:url value='/resources/img/apple-touch-icon.png'/>" rel="apple-touch-icon">

  <!-- Bootstrap core CSS -->
  <link href="<c:url value='/resources/lib/bootstrap/css/bootstrap.min1.css'/>"  rel="stylesheet">
  <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"> -->
  <!--external css-->
  <link href="<c:url value='/resources/lib/font-awesome/css/font-awesome.css'/>"  rel="stylesheet" />
  <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/zabuto_calendar.css'/>" >
  <link rel="stylesheet" type="text/css" href="<c:url value='/resources/lib/gritter/css/jquery.gritter.css'/>"/>
  <!-- Custom styles for this template -->
  
  <link href="<c:url value='/resources/css/style.css'/>" rel="stylesheet">
  <link href="<c:url value='/resources/css/style-responsive.css'/>"  rel="stylesheet">
  <script src="<c:url value='/resources/lib/chart-master/Chart.js'/>" ></script>
<link rel="stylesheet" type="text/css"
 href="<c:url value='/resources/lib/bootstrap-fileupload/bootstrap-fileupload.css'/>"/>
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>	
<script type="text/javascript" 
src="<c:url value='/resources/SmartEditor2/js/service/HuskyEZCreator.js'/>" charset="utf-8"></script>
<script type="text/javascript">  
	$(function(){ 
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		 oAppRef: oEditors,
		 elPlaceHolder: "ir1",
		 sSkinURI: "<c:url value='/resources/SmartEditor2/SmartEditor2Skin.html'/>",
		 fCreator: "createSEditor2"
		});
		
		 // 에디터의 내용이 textarea에 적용된다.
		 //oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
		 // 에디터의 내용에 대한 값 검증은 이곳에서
 		// document.getElementById("ir1").value
 		
 			/*  try {
    			 elClickedObj.form.submit();
 			} catch(e) {} */
		try {  
	 		$("form[name=boardEdit]").submit(function(){
	 	        oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	 	        var ir1 = $("#ir1").val();
	 	        var title = $("input[name=boardTitle]").val();
	 	        if( ir1 == ""  || ir1 == null || ir1 == '&nbsp;' || ir1 == '<p><br></p>') {
	 	             //alert("내용을 입력하세요.");
	 	             $("#infoCon").html("내용을 입력하세요.");   
	 	             $(".chkInfo").show();    
	 	             oEditors.getById["ir1"].exec("FOCUS"); //포커싱
	 	          	 event.preventDefault();
	 	        }   
	 	        if(title == ""  || title == null ){
	 	        	$("#infoCon").html("제목을 입력하세요.");   
	 	             $(".chkInfo").show(); 
	 	            $("input[name=boardTitle]").focus();
	 	           event.preventDefault();
	 	        } 
	 	         
	 		});
		 } catch(e) {
			 alert(e); 
		 }
	});
	
</script>
<style type="text/css">
.form-panel{
	border-radius: 10px;
}
</style>
</head>
<body>
 <section id="container">
       <section class="wrapper" style="margin-top: 10px"> 
        <h3 style="margin-left: 15px"><i class="fa fa-plus-square"></i> ${bVo.boardTitle} 글 수정 </h3>
        <!-- BASIC FORM ELELEMNTS -->
        <div class="row"> 
          <div class="col-lg-12"> 
            <div class="form-panel">
              <form class="form-horizontal style-form" 
              enctype="multipart/form-data"
              method="post"  
              name="boardEdit"
              action="<c:url value='/Board/BoardEdit.do'/>">
              
                <div class="form-group mt">
                  <label class="col-sm-1 col-sm-1 control-label"> 제목 </label>
                  <div class="col-sm-11">       
                    <input type="text" class="form-control" value="${bVo.boardTitle}" name="boardTitle">
                    <input type="hidden" name="boardNo" value="${bVo.boardNo}">
                  </div>	  
                </div>
                <div class="form-group">  
                  <div class="col-sm-12 mt">   
                  <textarea name="boardContent" id="ir1" rows="20" cols="114">${bVo.boardContent}</textarea>
                  </div>            
                </div>         
             <div class="form-group"> 
                  <label class="col-sm-2 col-sm-2 control-label">파일 첨부 </label>
                  <div class="col-md-10">  
                     <div class="fileupload fileupload-new" data-provides="fileupload">
                      <span class="btn btn-theme02 btn-file">
                        <span class="fileupload-new">
						<c:if test="${!empty bVo.boardOriginalfilename}">
							<i class="fa fa-undo"></i>	${bVo.boardOriginalfilename} 파일 변경
       					</c:if> 
						<c:if test="${empty bVo.boardOriginalfilename}">
 							<i class="fa fa-paperclip"></i>	파일 선택 
       					</c:if>
                         </span>
                      <span class="fileupload-exists"><i class="fa fa-undo"></i> 파일 변경</span>
                      	<input type="file" class="default" name="upfile"/>   
                      	<input type="hidden"  name="oldFile" value="${bVo.boardFilename}"/>  
                      </span>  
                      <span class="fileupload-preview" style="margin-left:5px;"></span>
                      <a href="advanced_form_components.html#" class="close fileupload-exists" data-dismiss="fileupload" style="float: none; margin-left:5px;"></a>
                   	 </div>
                      </div>
                    </div> 
                    <div class="form-group"> 
		                  <label class="col-sm-5 col-sm-5 control-label"></label>
		                  <div class="col-md-5">  
		                    <button type="submit" 
		                        class="btn btn-theme">
		                        <i class="fa fa-check"></i> 수정 </button>
	                        <div class="chkInfo" style="display:none;">
		                    <span class="label label-info">입력!</span>
		                    <span id="infoCon">정확하게 기입하여 주세요</span>
		                     </div> 
                        </div>
                     </div>
              </form>
            </div>
          </div>
          <!-- col-lg-12-->
        </div>
    </section>
  <!--footer start-->
    <footer class="site-footer">
      <div class="text-center">
        <p>
          &copy; Copyrights <strong>Dashio</strong>. All Rights Reserved
        </p>
        <div class="credits">
          Created with Dashio template by <a href="https://templatemag.com/">TemplateMag</a>
        </div>
        <a href="index.html#" class="go-top">
          <i class="fa fa-angle-up"></i>
          </a>
      </div>
    </footer>
    <!--footer end  nav-expand.png-->
  </section>
  <!-- js placed at the end of the document so the pages load faster -->
	
  <script src="<c:url value='/resources/lib/bootstrap/js/bootstrap.min.js'/>"></script>
  <script class="include" type="text/javascript" src="<c:url value='/resources/lib/jquery.dcjqaccordion.2.7.js'/>"></script>
  <script src="<c:url value='/resources/lib/jquery.scrollTo.min.js'/>"></script>
  <script src="<c:url value='/resources/lib/jquery.nicescroll.js'/>" type="text/javascript"></script>
  <script src="<c:url value='/resources/lib/jquery.sparkline.js'/>"></script>
  
  <!--common script for all pages-->
  <script src="<c:url value='/resources/lib/common-scripts.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/resources/lib/gritter/js/jquery.gritter.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/resources/lib/gritter-conf.js'/>"></script>
  <!--script for this page--> 
  <script type="text/javascript" src="<c:url value='/resources/lib/bootstrap-fileupload/bootstrap-fileupload.js'/>"></script>
  <script src="<c:url value='/resources/lib/sparkline-chart.js'/>"></script>
  <script src="<c:url value='/resources/lib/zabuto_calendar.js'/>"></script>
</body>

</html>

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

  <!-- =======================================================
    Template Name: Dashio
    Template URL: https://templatemag.com/dashio-bootstrap-admin-template/
    Author: TemplateMag.com
    License: https://templatemag.com/license/
  ======================================================= -->
</head>
<body>
 <section id="container">
      <section class="wrapper">
        <h3><i class="fa fa-plus-square"></i> ${typeName}자원 추가</h3>
        <!-- BASIC FORM ELELEMNTS -->
        <div class="row">
          <div class="col-lg-12">
            <div class="form-panel">
              <h4></h4>
              <form class="form-horizontal style-form" method="get">
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">추가 자원명</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">자원 가격</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control round-form">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">자원 위치</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control round-form">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">자원 정보</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" placeholder="자세히(자원을 사랑합시다)">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-2 col-sm-2 control-label">Static control</label>
                  <div class="col-lg-10">
                    <p class="form-control-static">email@example.com</p>
                  </div>
                     <div class="form-group last">
                  <label class="control-label col-md-3">Image Upload</label>
                  <div class="col-md-9">
                    <div class="fileupload fileupload-new" data-provides="fileupload">
                      <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">
                        <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image" alt="" />
                      </div>
                      <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
                      <div>
                        <span class="btn btn-theme02 btn-file">
                          <span class="fileupload-new"><i class="fa fa-paperclip"></i> Select image</span>
                        <span class="fileupload-exists"><i class="fa fa-undo"></i> Change</span>
                        <input type="file" class="default" />
                        </span>
                        <a href="advanced_form_components.html#" class="btn btn-theme04 fileupload-exists" data-dismiss="fileupload"><i class="fa fa-trash-o"></i> Remove</a>
                      </div>
                    </div>
                    <span class="label label-info">NOTE!</span>
                    <span>
                      Attached image thumbnail is
                      supported in Latest Firefox, Chrome, Opera,
                      Safari and Internet Explorer 10 only
                      </span>
                  </div>
                </div>
                  
                </div>
              </form>
            </div>
          </div>
          <!-- col-lg-12-->
        </div>
  <!--footer start-->
    <footer class="site-footer">
      <div class="text-center">
        <p>
          &copy; Copyrights <strong>Dashio</strong>. All Rights Reserved
        </p>
        <div class="credits">
          <!--
            You are NOT allowed to delete the credit link to TemplateMag with free version.
            You can delete the credit link only if you bought the pro version.
            Buy the pro version with working PHP/AJAX contact form: https://templatemag.com/dashio-bootstrap-admin-template/
            Licensing information: https://templatemag.com/license/
          -->
          Created with Dashio template by <a href="https://templatemag.com/">TemplateMag</a>
        </div>
        <a href="index.html#" class="go-top">
          <i class="fa fa-angle-up"></i>
          </a>
      </div>
    </footer>
    <!--footer end  nav-expand.png-->
    </section>
  </section>
  <!-- js placed at the end of the document so the pages load faster -->
	<c:if test="${mypage!='useJs'}" >
  		<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>	
	</c:if>
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
  <script src="<c:url value='/resources/lib/sparkline-chart.js'/>"></script>
  <script src="<c:url value='/resources/lib/zabuto_calendar.js'/>"></script>
</body>

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
  <title>컴워밸 - Company&Worker balance</title>

  <!-- Favicons -->
  <link href="<c:url value='/resources/img/favicon.png'/>" rel="icon">
  <link href="<c:url value='/resources/img/apple-touch-icon.png'/>" rel="apple-touch-icon">

  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">

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
  
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<style type="text/css">
	#sidebar{
		z-index: 501;
	}
	
</style>
</head>

<body>
  <section id="container">
    <!-- **********************************************************************************************************************************************************
        TOP BAR CONTENT & NOTIFICATIONS
        *********************************************************************************************************************************************************** -->
    <!--header start-->
    <header class="header black-bg">
      <div class="sidebar-toggle-box">
        <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
      </div>
      <!--logo start-->
      <a href="<c:url value="/index.do"/>" class="logo"><b>ComWor<span>Bal</span></b></a>
      <!--logo end-->
      
      <div class="top-menu">
        <ul class="nav pull-right top-menu">
          <li><a class="logout" href="<c:url value='/logout/logout.do'/>">Logout</a></li>
        </ul>
      </div>
	      <div class="top-menu">
	      	<ul class="nav pull-right top-menu">
	          <li>
		          <c:if test="${sessionScope.state == 3}">
		          	<a class="attendance" href="<c:url value='/commute/inout.do?status=in'/>">출근</a>
		          </c:if>
				  <c:if test="${sessionScope.state == 1 or sessionScope.state == 2 }">					          
			      	<a class="leaveWork" href="<c:url value='/commute/inout.do?status=out'/>">퇴근</a>
		          </c:if>
	          </li>
	        </ul>
	      </div>
    </header>
    <!--header end-->
    <!-- **********************************************************************************************************************************************************
        MAIN SIDEBAR MENU
        *********************************************************************************************************************************************************** -->
    
    
    <!--sidebar start-->
    <aside>
      <div id="sidebar" class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
        	<c:if test="${!empty sessionScope.fileName }">
          <p class="centered"><a href="<c:url value='/member/memberMypage.do'/>"><img src="<c:url value='/member_file/${sessionScope.fileName}'/>" class="img-circle" width="80"></a></p>
        	</c:if>
        	<c:if test="${empty sessionScope.fileName }">
          <p class="centered"><a href="<c:url value='/member/memberMypage.do'/>"><img src="<c:url value='/member_file/user.png'/>" class="img-circle" width="80"></a></p>
        	</c:if>
          <h5 class="centered">${sessionScope.memName }</h5>
          <p class="centered"><a class="btn btn-round btn-default" href="<c:url value='/member/memberMypage.do'/>">My Page</a></p>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fas fa-address-book"></i>
              <span>주소록</span>
              </a>
            <ul class="sub">
              <li><a href="<c:url value="/address/privateAddrList.do"/>"><i class="fas fa-address-card"></i>개인주소록</a></li>
              <li><a href="<c:url value="/address/emailList.do"/>"><i class="far fa-paper-plane"></i>보낸 메일함</a></li>
              <li><a href="<c:url value="/message/msgList.do"/>"><i class="fas fa-comments"></i>쪽지 함</a></li>
            </ul>
          </li>
          
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="far fa-file-alt fa-o"></i>
              <span>전자결재</span>
              </a>
            <ul class="sub">
              <c:if test="${sessionScope.ranksNo > 1}">
              	<li><a href="<c:url value="/sign/signReg.do"/>"><i class="fas fa-file-signature"></i>결재사인관리</a></li>
              </c:if>
              <c:if test="${sessionScope.ranksNo == 3}">
              	<li><a href="<c:url value="/document/docSet.do"/>"><i class="fas fa-copy"></i>문서관리</a></li>
              </c:if>
              <li><a href="<c:url value="/document/docSel.do"/>"><i class="fas fa-edit"></i>문서작성</a></li>
              <li><a href="<c:url value="/document/docList.do"/>"><i class="fas fa-archive"></i>문서함</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fas fa-user-clock fa-o"></i>
              <span>근태</span>
              </a>
            <ul class="sub">
              <li><a href="<c:url value="/commute/commute.do"/>"><i class="fas fa-history"></i>근태조회</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fas fa-save"></i>
              <span>웹하드</span>
              </a>
            <ul class="sub">
              <li><a href="<c:url value="/webhard/webhard.do"/>"><i class="fas fa-download"></i>웹하드</a></li>
              <c:if test="${sessionScope.ranksNo == 3}">
              <li><a href="<c:url value="/webhard/webhardSetting.do"/>"><i class="fas fa-cog"></i>웹하드관리</a></li>
              </c:if>
            </ul>
          </li>
           <li class="sub-menu">
            <a href="javascript:;">
              <i class="far fa-calendar-alt"></i>
              <span>스케줄러</span>
              </a>
            <ul class="sub">
              <li><a href="<c:url value="/scheduler/scheduler.do"/>"><i class="fas fa-clock"></i>개인 스케줄</a></li>
              <li><a href="<c:url value="/teamscheduler/scheduler.do"/>"><i class="far fa-calendar-alt"></i> 부서 스케줄</a></li>
            </ul>
          </li>
           <li class="sub-menu">
            <a href="javascript:;">
              <i class="fas fa-box"></i> 
              <span>자원 관리</span>
              </a>
            <ul class="sub"> 
            
            <c:if test="${sessionScope.ranksNo>=2 }">
              <li><a href="<c:url value="/resources/list.do"/>"><i class="fas fa-cogs"></i>자원 관리</a></li>
            </c:if>  
            <c:if test="${sessionScope.ranksNo<2 }">
              <li><a href="<c:url value="/resources/list.do"/>">자원 신청</a></li>
            </c:if>
              
              <li><a href="<c:url value="/useResource/useResList.do"/>"><i class="fas fa-file"></i>나의 자원 내역</a></li>
        <c:if test="${sessionScope.ranksNo>=2 }">
              <li><a href="<c:url value="/useResource/AllUseResList.do"/>"><i class="fas fa-file-alt"></i>전체 자원 내역</a></li>
        </c:if>   
            </ul>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
             	<i class="fas fa-clipboard-list"></i>
              <span>게시판</span>
              </a>
            <ul class="sub">
            <c:if test="${sessionScope.ranksNo>=2 }">
              <li><a href="<c:url value="/Board/BoardAllList.do"/>"><i class="fas fa-clipboard-list"></i>게시판 관리</a></li>
            </c:if>  
              <c:import url="/Board/BoardTopIns.do"></c:import>
            </ul>
          </li>
              <c:if test="${sessionScope.ranksNo >= 3 }">
           <li class="sub-menu">
            <a href="javascript:;">
              <i class="fas fa-users-cog"></i>
              <span>사원관리</span>
              </a>
            <ul class="sub">
              <li><a href="<c:url value="/member/memberRegister.do"/>"><i class="fas fa-user-plus"></i>사원등록</a></li>
              <li><a href="<c:url value="/member/memberList.do"/>"><i class="fas fa-users"></i>사원목록</a></li>
              <li><a href="<c:url value="/member/memberEdit.do?memNo=${sessionScope.memNo }"/>"><i class="fas fa-user-edit"></i>사원정보수정</a></li>
            </ul>
          </li>
          </c:if>
          
        </ul>
	        <c:import url="/address/companyAddr.do"></c:import>
        <!-- sidebar menu end-->
      </div>
      
      
    </aside>

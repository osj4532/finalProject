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
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
  
  <link href="<c:url value='/resources/css/style.css'/>" rel="stylesheet">
  <link href="<c:url value='/resources/css/style-responsive.css'/>"  rel="stylesheet">
  <script src="<c:url value='/resources/lib/chart-master/Chart.js'/>" ></script>
<link rel="stylesheet" type="text/css"
 href="<c:url value='/resources/lib/bootstrap-fileupload/bootstrap-fileupload.css'/>"/>

<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>	
<script type="text/javascript">
		

</script>
  <style>
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
</head>
<body>
 <section id="container">
      <section class="wrapper" style="margin-top: 10px">
        <h3 style="margin-left: 15px"> <i class="fas fa-map-marked-alt"></i> 자원 현위치</h3>
        <!-- BASIC FORM ELELEMNTS -->
        <div class="row">
          <div class="col-lg-12"> 
            <div class="form-panel">
               <div class="map_wrap">
                  <div id="map" style="width:730px;height:350px;"></div>
   				<div class="hAddr">    
		      <span class="title"> 주소정보 </span>
		      <span id="centerAddr"></span> 
		    </div>
		</div>
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
	</section>
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
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=66fc63c70e3d4b0aa612be53665e59ba&libraries=services"></script>
 <script> 
 
		//이미지 지도에 표시할 마커입니다
		//이미지 지도에 표시할 마커를 아래와 같이 배열로 넣어주면 여러개의 마커를 표시할 수 있습니다 
		var markers = [
		  {  
		      position: new kakao.maps.LatLng(${resVo.resLocation}),  
		      text: '${resVo.resName}의 위치!' // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다     
		  }
		];
		
		var staticMapContainer  = document.getElementById('map'), // 이미지 지도를 표시할 div  
		  staticMapOption = { 
		      center: new kakao.maps.LatLng(${resVo.resLocation} ), // 이미지 지도의 중심좌표
		      level: 3, // 이미지 지도의 확대 레벨
		      marker: markers // 이미지 지도에 표시할 마커 
		  };    
		 
		//이미지 지도를 생성합니다
		var map = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
		var geocoder = new kakao.maps.services.Geocoder();
			 infowindow = new kakao.maps.InfoWindow({zindex:1});	
		
	  	searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		 
	  	
	  	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
	  	    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
	  	        if (status === kakao.maps.services.Status.OK) {
	  	            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
	  	            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
	  	            
	  	            var content = '<div class="bAddr">' +
	  	                            '<span class="title"> 주소 </span>' + 
	  	                            detailAddr + 
	  	                        '</div>';

	  	            // 마커를 클릭한 위치에 표시합니다 
	  	           //marker.setPosition(mouseEvent.latLng);
	  	            //marker.setMap(map);

	  	            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
	  	            infowindow.setContent(content); 
	  	            infowindow.open(map, marker);  
	  	        }   
	  	    });
	  	});
	  	
	  	kakao.maps.event.addListener(map, 'idle', function() {
	  	    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	  	});
	  	 
		function searchAddrFromCoords(coords, callback) {
		    // 좌표로 행정동 주소 정보를 요청합니다
		    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
		}
		
		function searchDetailAddrFromCoords(coords, callback) {
		    // 좌표로 법정동 상세 주소 정보를 요청합니다
		    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}
		
		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		        var infoDiv = document.getElementById('centerAddr');

		        for(var i = 0; i < result.length; i++) {
		            // 행정동의 region_type 값은 'H' 이므로
		            if (result[i].region_type === 'H') {     
		                infoDiv.innerHTML = result[i].address_name;
		                break;  
		            }
		        }
		    }    
		} 
		
</script>	
</body>

</html>

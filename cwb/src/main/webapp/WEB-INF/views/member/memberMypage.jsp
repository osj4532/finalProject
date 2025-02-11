<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="../inc/top.jsp"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style type="text/css">
	.row{
		margin-top: 15px;
	}
	#info{
		min-height: 200px;
		background-color: white;
		min-width: 300px;
	}
	#info2{
		height:200px;
		background-color: white;
	}
	#info3{
		background-color: white;
		
		margin: 0 auto;
	}
	#main-content{
		height: 900px;
	}
	
</style>
<section id="main-content">
	<section class="wrapper">
	<h3><i class="fas fa-users"></i>My Page</h3>
	<div class="row">
		<div class="col-lg-3" id="info">
					<c:if test="${!empty sessionScope.fileName }">
		          <p class="centered"><img src="<c:url value='/member_file/${sessionScope.fileName}'/>" class="img-circle" width="80"></p>
		        	</c:if>
		        	<c:if test="${empty sessionScope.fileName }">
		          <p class="centered"><img src="<c:url value='/member_file/user.png'/>" class="img-circle" width="80"></p>
		        	</c:if>
		          <h5 class="centered">${sessionScope.memName }</h5>
		          <div class="centered">
			          <button class="btn btn-info centered" id="btnDetail" onclick="location.href='<c:url value='/member/memberDetail.do?memNo=${sessionScope.memNo }'/>'">상세정보</button>
		          </div>
		</div>
		
		<div class="col-lg-3" id="info2">
			<label>ID : </label><span> ${map['MEM_ID'] }</span>
			<br><br>
			<label>E-MAIL : </label><span> ${map['MEM_EMAIL1'] }@${map['MEM_EMAIL2'] }</span>
			<br><br>
			<label>HP : </label><span> ${map['MEM_HP1'] }-${map['MEM_HP2'] }-${map['MEM_HP3'] }</span>
			<br><br>
			<label>입사일 : </label><span><fmt:formatDate pattern="yyyy-MM-dd" value="${map['MEM_JOINDATE'] }"/></span>
		</div>
		
	</div>
	<div class="row">
		<div class="col-lg-6" id="info3">
		<canvas id="myChart"></canvas>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.4/Chart.bundle.min.js"></script>
			<script type="text/javascript" charset="utf-8" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
			<script type="text/javascript">
			var ctx = document.getElementById("myChart");
			var myBarChart = new Chart(ctx, {
				type: 'bar',
			data : {
				labels : ["금월 출근일수", "올해 출근일수"],
				datasets : [
					{
						label : "나의 근태 조회",
						data: [${month}, ${year}],
						backgroundColor : [
							'rgba(255, 99, 132, 0.2)',
							'rgba(54, 162, 235, 0.2)'
						],
						borderColor : [
							'rgba(255, 99, 132, 132, 1)',
							'rgba(54, 162, 235, 1)'
						],
						borderWidth : 1
					}
				]
			},
				options: {
					scales: {
						yAxes:[{
							ticks: {
								beginAtZero:true,
								stepSize:20
							}
						}]
					}
				}
			});
			</script>
	</div>
	</div>
	</section>
</section>
<c:import url="../inc/bottom.jsp"/>
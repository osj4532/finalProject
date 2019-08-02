<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="inc/top.jsp" %>

<style>
	.subInfo{
		border: 1px solid white;
		background: white;
		/* background: #dfdfe1; */
		border: thin;
		box-shadow: 0 2px 1px rgba(0,0,0,0.2);
	}
	
	.subInfo .head{
		padding:5px;
		background: #4ECDC4;
		text-align: center;
		color:#fff;
	}
	
	.subInfo .detail{
		right: 5px;
		top:5px;
    	cursor: pointer;
    	position: absolute;
	}
	
	.subInfo .content{
		padding: 3px;
	}
	
	.table{
		min-height: 176px;
	}
	
	.table>thead>tr>th{
		background: #ccd1d9;
	}
	
	.table>tbody>tr{
		height: 34px;
		font-size: 0.8em;
	}
	
	.table>tbody>tr:hover{
		background: rgba(0,0,0,0.1);
		cursor: pointer;
	}
	
	.plus{
		position:relative;
		font-size: 0.8em;
	}
	
	.align-right{
		text-align: right;
	}
</style>

<section id="main-content">
	<section class="wrapper">
		<div class="row mt info">
			<div class="col-md-4 col-sm-4 mb">
				<div class="subInfo">
					<div class="head">
						<h5><i class="far fa-comment-dots"></i> 읽지 않은 쪽지</h5>
					</div>
					<div class="plus align-right">
						<a href="<c:url value='/message/msgList.do'/>" class="detail"><i class="far fa-plus-square"></i>더보기</a>
					</div>
					<div class="content">
						<c:import url="/indexMsgShow.do"/>
					</div>
				</div>
			</div>
			
			<c:if test="${sessionScope.ranksNo > 1 }">
				<div class="col-md-4 col-sm-4 mb">
					<div class=" subInfo">
						<div class="head">
							<h5><i class="fas fa-file-signature"></i> 결재 대기 문서</h5>
						</div>
						<div class="plus align-right">
							<a href="<c:url value='/document/docList.do'/>" class="detail"><i class="far fa-plus-square"></i>더보기</a>
						</div>
						<div class="content">
							<c:import url="/indexConfirmWaitShow.do"/>
						</div>
					</div>
				</div>
			</c:if>
			
			<div class="col-md-4 col-sm-4 mb">
				<div class=" subInfo">
					<div class="head">
						<h5><i class="fas fa-file-upload"></i> 최근 기안 문서 상태</h5>
					</div>
					<div class="plus align-right">
						<a href="<c:url value='/document/docList.do'/>" class="detail"><i class="far fa-plus-square"></i>더보기</a>
					</div>
					<div class="content">
						<c:import url="/indexRecentConfirmShow.do"/>
					</div>
				</div>
			</div>
			
			
			<div class="col-md-4 col-sm-4 mb">
				<div class=" subInfo">
					<div class="head">
						<h5><i class="fas fa-at"></i> 최근 보낸 메일</h5>
					</div>
					<div class="plus align-right">
						<a href="<c:url value='/address/emailList.do'/>" class="detail"><i class="far fa-plus-square"></i>더보기</a>
					</div>
					<div class="content">
						<c:import url="/indexMailShow.do"/>
					</div>
				</div>
			</div>
			
			
			<div class="col-md-4 col-sm-4 mb">
                <div class="grey-panel pn donut-chart">
                  <div class="grey-header">
                    <h5>SERVER LOAD</h5>
                  </div>
                  <canvas id="serverstatus01" height="120" width="120"></canvas>
                  <script>
                    var doughnutData = [{
                        value: 200-25,
                        color: "#FF6B6B"
                      },
                      {
                        value: 25,
                        color: "#fdfdfd"
                      }
                    ];
                    var myDoughnut = new Chart(document.getElementById("serverstatus01").getContext("2d")).Doughnut(doughnutData);
                  </script>
                  <div class="row">
                    <div class="col-sm-6 col-xs-6 goleft">
                      <p>Usage<br/>Increase:</p>
                    </div>
                    <div class="col-sm-6 col-xs-6">
                      <c:set var="percent" value="${(200-25)/200*100}"></c:set>
                      <h2>${percent}%</h2>
                    </div>
                  </div>
                </div>
                <!-- /grey-panel -->
              </div>
		</div>
	</section>
</section>

<%@include file="inc/bottom.jsp" %>
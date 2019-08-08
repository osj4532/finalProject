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
		min-height: 200px;
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
	
	.align-center{
		text-align: center;
	}
	
	.align-right{
		text-align: right;
	}
	
	.wrapper hr{
		color:black;
	}
	
	.info{
		border-bottom: 1px solid #ccd1d9;
	}
	
	.chartDiv{
		display: inline-block;
		width:200px;
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
		</div>
		
		<div class="row mt info">
<%-- 			<div class="col-md-4 col-sm-4 mb">
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
              
           --%>
              
              <div class="col-md-4 col-sm-4 mb">
				<div class=" subInfo">
					<div class="head">
						<h5><i class="fas fa-hdd"></i> 내 웹하드 공간</h5>
					</div>
					<div class="content align-center">
						<div class="chartDiv">
  							<canvas id="chart8"></canvas>
						</div>
						<p>100MB 중 ${usingWB}MB 사용 중 입니다.</p>
					</div>
				</div>
			</div>
		</div>
	</section>
</section>


<%@include file="inc/bottom.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.4/Chart.bundle.min.js"></script>
<script type="text/javascript" charset="utf-8" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
<script type="text/javascript">
var num =  ${usingWB}/100;

  var data = {

      labels: [
          "사용중인공간",
          "사용가능공간"
      ],
      datasets: [
          {
              data: [num, 1-num],
              backgroundColor: [
                  "rgba(255,0,0,0.3)"
              ],
              hoverBackgroundColor: [
            	  "rgb(255,0,0)"
              ]
          }]
  };
   
  window.onload = function() {
    var ctx8 = $('#chart8').get(0).getContext("2d");
    window.theChart8 = new Chart(ctx8, {
        type: 'doughnut',
        data: data,
        options: {
                responsive: true,
            legend: {
                  display: false
              },
                elements: {
                    center: {
                      text: Math.round(num*100),
                      fontStyle: 'Helvetica', //Default Arial
                      sidePadding: 15 //Default 20 (as a percentage)
                  }
                },
                maintainAspectRatio : false,
                cutoutPercentage:70,
                animation: false,
                rotation: 1 * Math.PI,
                circumference: 1 * Math.PI
        }
    });
}

Chart.plugins.register({
  beforeDraw: function (chart) {
    if (chart.config.options.elements.center) {
        //Get ctx from string
        var ctx = chart.chart.ctx;
 
        //Get options from the center object in options
        var centerConfig = chart.config.options.elements.center;
        var fontSize = centerConfig.fontSize || '50';
        var fontStyle = centerConfig.fontStyle || 'Arial';
        var txt = centerConfig.text;
        var color = centerConfig.color || '#000';
        var sidePadding = centerConfig.sidePadding || 20;
        var sidePaddingCalculated = (sidePadding/100) * (chart.innerRadius * 2)
        //Start with a base font of 30px
        ctx.font = fontSize + "px " + fontStyle;
 
        //Get the width of the string and also the width of the element minus 10 to give it 5px side padding
        var stringWidth = ctx.measureText(txt).width;
        var elementWidth = (chart.innerRadius * 2) - sidePaddingCalculated;
 
        // Find out how much the font can grow in width.
        var widthRatio = elementWidth / stringWidth;
        var newFontSize = Math.floor(30 * widthRatio);
        var elementHeight = (chart.innerRadius * 0.7);
 
        // Pick a new font size so it will not be larger than the height of label.
        var fontSizeToUse = Math.min(newFontSize, elementHeight);
 
        //Set font settings to draw it correctly.
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        var centerX = ((chart.chartArea.left + chart.chartArea.right) / 2);
        var centerY = ((chart.chartArea.top + chart.chartArea.bottom) / 1.6);
        ctx.font = fontSizeToUse+"px " + fontStyle;
        ctx.fillStyle = color;
 
        //Draw text in center
        ctx.fillText(txt+"%", centerX, centerY);

        ctx.font = '15px Arial';
        ctx.fillText('0', 15, 135);
        ctx.fillText('100', 185, 135);
      }
  }
});
</script>
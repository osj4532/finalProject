<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<link rel='stylesheet'
	href="<c:url value='/resources/lib/scheduler/fullcalendar.min.css'/>" />
<link rel='stylesheet' media="print"
	href="<c:url value='/resources/lib/scheduler/fullcalendar.print.min.css'/>" />

<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/lib/scheduler/moment.min.js'/>"></script>
<script
	src="<c:url value='/resources/lib/scheduler/fullcalendar.min.js'/>"></script>
<script
	src="<c:url value='/resources/lib/scheduler/fullcalendar-ko.js'/>"></script>

<style type="text/css">
.mg_text {
	font-size: 36px;
	color: #00bcd4ad; 
	font-weight: bold;
}
.fc-event .fc-content {
    font-size: medium;
    font-weight: bold;
    font-family: unset;
  	background: #ffffff87;
    border-radius: 5px;
    color: #2f323ab3;
}
.darkblue-panel {
    background: #2f323a;
}
.fc-ltr .fc-basic-view .fc-day-top .fc-day-number {
    float: right;
    font-size: large;
}

.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
    padding: 8px;
    line-height: 1.42857143;
    vertical-align: top;
    border-top: 1px solid #000;
    color: black;
    font-size: initial;
    font-weight: bold;
    background: azure;
}
element.style {
    overflow: hidden auto;
    height: 898px;
    background: azure;
}
</style>
<script type="text/javascript">
	$(function() {
		$('#calendar').fullCalendar({
				themeSystem : 'bootstrap3',
				customButtons: { 
			        myCustomButton: { 
			            text: '일정입력', 
			            click: function(event) { 
			              onSelectEvent(event); 
			            } 
			        } 
				}, 
				header : {
					left : 'prevYear,prev,next,nextYear today myCustomButton',
					center : 'title',
					right : 'month,agendaWeek,agendaDay,listMonth '  
				},
				defaultDate : new Date(),
				selectable : true,
				aspectRatio : 1.8,
				selectHelper : true,
				eventLimit: true, 
				select : function(start, end,  allDay) {
					var title = prompt('일정을 입력하세요.');
					alert(start.format());
					if(title){
						$.ajax({
							type : "post",
							url : "<c:url value='/scheduler/userScdWrite.do'/>",
							data : {
								"scdContent" : title,
								"scdStart" :start.format(),
								"scdEnd" : end.format()
								
								//"scdStart" :moment(start).format('YYYY/MM/DD a hh:mm:ssSSSS'),
								//"scdEnd" :moment(end).format('YYYY/MM/DD a hh:mm:ssSSSS') 
							}, 
							success : function(data) {
								alert("저장 완료");
								$("#calendar").fullCalendar("refetchEvents");
							},
							error : function(xhr, err) { 
								//alert(moment(end).format('YYYY/MM/DD a hh:mm:ssSSSS')); 
								alert("ERROR! - readyState: "
										+ xhr.readyState
										+ "<br/>status: "
										+ xhr.status
										+ "<br/>responseText: "
										+ xhr.responseText);
							}
						}); 
					}else if(title==null){
					}else {
						alert('입력값이 없습니다!');
					}
					
					/* if (title) { //true
						calendar.fullCalendar('renderEvent', 
								//월이나 연도가 바뀌어도 없어지지않게(등록한 것이)
						{
							title : schedulerVo.scdContent, //입력값 
							start : schedulerVo.scdStrart, //인자값
							end : scdEnd //인자값
						}, true // make the event "stick"
						);
					}//if
					//입력이 안되면 선택취소 (메서드)
					calendar.fullCalendar('unselect'); //선택취소 */
				},
				/* editable : true, //수정 가능 */
				//DB에서 가져온 값으로 해당 날짜에 붙이는 기능
				events : function(start, end, allDay, callback) {
					$.ajax({
						type : "post",
						url : "<c:url value='/scheduler/userScdFind.do'/>",
						dataType : 'json',
						success : function(data) {
							var events = [];
							$.each(data, function(index,
									item) {

								events.push({
									title : this.scdContent,
									start : this.scdStart,
									end : this.scdEnd
								}); 
								console.log($(this))
							});  
							callback(events);
						},
						error : function(xhr, err) {
							alert("ERROR! - readyState: "
									+ xhr.readyState
									+ "<br/>status: "
									+ xhr.status
									+ "<br/>responseText: "
									+ xhr.responseText);
						}
					});

				}
			});
});

	/* 			events : function(start, end, callback) {
	 $.ajax({
	 url : "<c:url value='/scheduler/userScdFind.do'/>",
	 dataType : "json",
	 success : function(data) {
	 //alert(data.length);
	 if(data.length>0){
	 $.each(data,function(idx,item){
	 alert("내용 : "+this.scdContent); 
	 alert("시작시간 : "+this.scdEnd);  
	 title : this.scdContent,
	 start: this.scdStart,
	 end:this.scdEnd 
	 });  
	 } 
	 },
	 error : function(request, status, error) {
	 if (request.status != '0') {
	 alert("code : " + request.status
	 + "\r\nmessage : "
	 + request.reponseText
	 + "\r\nerror : " + error);
	 }
	 }
	 });

	 }//events
	 });
	 }); */

	/* $(document).ready(function() {
	 var date = new Date();
	 var d = date.getDate();
	 var m = date.getMonth();
	 var y = date.getFullYear();
	 var calendar = $('#calendar').fullCalendar({
	 header: {
	 left: 'prev,next today',
	 center: 'title',
	 right: 'month,agendaWeek,agendaDay'
	 },
	 selectable: true,  //사용자가 클릭 및 드래그하여 선택을 할 수 있도록
	 selectHelper: true,//사용자가 드래그되는 동안 "자리"이벤트를 그릴 것인지 여부를 지정할 수 있습니다.
	 select: function(start, end, allDay) {
	 alert(allDay);
	 var title = prompt('일정을 입력하세요.');
	 $.ajax({
	 type:"post",
	 url:"/project/calendarData.do ",
	 data:{"title":title,
	 "start":start.format(),
	 "end":end.format()
	 } 
	
	 });
	 if (title) { //true
	 calendar.fullCalendar('renderEvent', //월이나 연도가 바뀌어도 없어지지않게(등록한 것이)
	 {
	 title: title, //입력값 
	 start: start, //인자값
	 end: end,  //인자값
	 allDay: allDay//인자값
	 },   
	 true // make the event "stick"
	 );
	 }//if
	 //입력이 안되면 선택취소 (메서드)
	 calendar.fullCalendar('unselect'); //선택취소
	 },
	 editable: true, //수정 가능
	 //DB에서 가져온 값으로 해당 날짜에 붙이는 기능
	 events:function(start,end,callback){
	 $.ajax({
	 url:"/project/selectJsonData.do ",
	 dataType:"json",
	 success:function(data){
	 alert("success");
	 },
	 error : function(request, status, error) {
	 if (request.status != '0') {
	 alert("code : " + request.status + "\r\nmessage : "
	 + request.reponseText + "\r\nerror : " + error);
	 }
	 }
	 });
	 }//events
	 });
	 }); */
</script>

<c:set var='mypage' value="useJs" />

<section id="main-content">
	<section class="wrapper">
		<h1 class="mg_text">
			<i class="fa fa-angle-right mt text-important"></i>개인 스케줄 
		</h1>
		<!-- page start-->
		<div class="row">
			<div class="col-lg-12">
				<div class="darkblue-panel"
					style="padding: 30px; border-radius: 35px;">
					<div id='calendar'></div>
				</div>
			</div>

		</div>
	</section>
</section>

<%@include file="../inc/bottom.jsp"%>
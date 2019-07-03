<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<link rel='stylesheet'
	href='<c:url value='/resources/lib/scheduler/fullcalendar.min.css'/>' />
<link rel='stylesheet' media="print"
	href='<c:url value='/resources/lib/scheduler/fullcalendar.print.min.css'/>' />

<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
<script src='<c:url value='/resources/lib/scheduler/moment.min.js'/>'></script>
<script	src='<c:url value='/resources/lib/scheduler/fullcalendar.min.js'/>'></script>
<script	src='<c:url value='/resources/lib/scheduler/fullcalendar-ko.js'/>'></script>

<style type="text/css">
	.mg_text{
	    font-size: 36px;
	    color: #333;
	    font-weight: bold;
	}
</style>
<script type="text/javascript">
	$(function() {
	  	$('#calendar').fullCalendar({
	  		
	  		header: { center: 'month,agendaWeek' }, // buttons for switching between views

	  	  views: {
	  	    month: { // name of view
	  	      titleFormat: 'YYYY, MM, DD'
	  	      // other view-specific options here
	  	    }
	  	  },
	  		
	  		dayClick: function() {
			    alert('클릭');
			  }
	  	
	  	
		})
	});

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

<c:set var='mypage' value="useJs"/>
	
<section id="main-content">
	<section class="wrapper" style="background: #668fa296;">
		<h1 class="mg_text">
			<i class="fa fa-angle-right mt text-important"></i>개인 스케줄
		</h1>
		<!-- page start-->
		<div class="row mt">
			<aside class="col-lg-12 mt">
				<div id='calendar' ></div>
			</aside>

		</div>
	</section>
</section>

<%@include file="../inc/bottom.jsp"%>
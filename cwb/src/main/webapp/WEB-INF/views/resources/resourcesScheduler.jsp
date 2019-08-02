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
#dialog-background {
    display: none;
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,.3);
    z-index: 10;
}
#my-dialog {
    display: none; 
    position: fixed;  
    left: calc( 50% - 260px ); top: calc( 50% - 150px );
    width: 500px; height: 320px; 
    background: #fff;  
    z-index: 11;   
    padding: 10px;
} 

.form-horizontal.style-form .form-group { 
	margin-left: -10px;
    margin-right: -10px;
}



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
#switchinfo {
    font-size: 20pt;
    font-weight: bold;
    display: inline-block;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#dialog-background").click(function () {
			$("#my-dialog,#dialog-background").hide();
			$('#meminfo').val('');
			$('#contentinfo').val('');  
		});    
		var st='';
		var en='';
		
		
		
		$('#calendar').fullCalendar({
				themeSystem : 'bootstrap3',
				header : {
					left : 'prevYear,prev,next,nextYear today',
					center : 'title',
					right : 'month,agendaWeek,agendaDay,listMonth '  
				},
				defaultDate : new Date(),
				selectable : true,
				aspectRatio : 1.8,
				selectHelper : true,
				eventLimit: true,
				select : function(start, end,  allDay) {
					st=start.format(); 
					en=end.format(); 
					if(st.length==10){
						st=start.format();
						en=end.format();
					}else{
						st=start.format('YYYY/MM/DD HH:mm:ss');
						en=end.format('YYYY/MM/DD HH:mm:ss');
					};
						$.ajax({
							type : "post",
							url : "<c:url value='/resScheduler/ExistDay.do'/>",
							data : { 
								"resNo": '${param.resNo}',
								"useRegdate": st,
								"returnRegdate" : en 
							},
							success : function(exist) {
								if(exist=="O"){								
											if(confirm("${resVo.resName}의 대여를 신청하시겠습니까?")){ 
												$.ajax({
													type : "post",
													url : "<c:url value='/resScheduler/ResScdWrite.do'/>",
													data : { 
														"resNo": '${param.resNo}', 
														"reservContent" : '${resVo.resName}',
														"useRegdate" :st,
									 					"returnRegdate" : en 
														
													}, 
													success : function(data) {
														alert("신청 완료");
														$("#calendar").fullCalendar("refetchEvents");
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
										
										}else if(title==null){
										}else {
											alert('입력값이 없습니다!'); 
										}
								}else if(exist=="E"){ //Exist
									alert("이미 대여신청 및 대여중입니다.");
								}else if (exist=="D") {
									alert("지난 날짜입니다.");
								}			
							}, 
							error : function(xhr, err) { 
								alert("ERROR! - readyState: "
										+ xhr.readyState
										+ "<br/>status: "
										+ xhr.status
										+ "<br/>responseText: "
										+ xhr.responseText);
							}

						});//사용가능여부 찾는 ajax
					
					
				}, 
				eventClick: function(event, element){

					<c:if test="${ranksNo>=2}">   
					 
						if(event.title=='승인' || event.title=='거절' ||
								event.title=='대여 완료'){
							alert("이미 완료된 문서입니다 변경은 자원사용 내역에서 가능합니다.")
							return;
						}; 
						
						$.ajax({
							type: "post",
							url: "<c:url value='/resScheduler/findMember.do'/>",
							data:{
								memNo: event.memNo 
							}, 
							success : function(mem) {
								st=event.start.format(); 
								en=event.end.format(); 
								if(st.length==10){ 
									st=event.start.format(); 
									en=event.end.format();
								}else{ 
									st=event.start.format('YYYY/MM/DD HH:mm:ss');
									en=event.end.format('YYYY/MM/DD HH:mm:ss');
								} 
								
								$("#startinfo").val(st); 
								$("#endinfo").val(en);   
								$("#meminfo").html(mem);      
								$("#noinfo").val(event.id);  
								//$("#insinfo").hide(); 
								//$("#infoname").html(' 신청 내역 ');  
								$("#my-dialog,#dialog-background").show();
								 
								//if($("#EditChk").is(":checked")){
								
								//}else {
									//반려 ajax
									//}
								//}내부 ajax
							},
							error : function(xhr, err) { 
								alert("ERROR! - readyState: "
										+ xhr.readyState
										+ "<br/>status: "
										+ xhr.status
										+ "<br/>responseText: "
										+ xhr.responseText);
							}
						});//외부 ajax
					</c:if> 
					<c:if test="${ranksNo<2}">  
						if(event.memNo==${memNo}){
							if(event.title=='승인'||event.title=='신청하신 대여건 검토중'){
								alert('자원 내역에서 취소 및 변경 가능합니다.'); 
							} 
						}
					</c:if> 
				}, 
				events : function(start, end, allDay, callback) {
					$.ajax({
						type : "post",
						url : "<c:url value='/resScheduler/ResScdFind.do'/>",
						data:{
							"resNo": ${param.resNo} 
						},
						dataType : 'json', 
						success : function(data) {
							var events = [];
							$.each(data, function(index,
									item) {
								var color="skyblue"; 
								var Flagtitle="검토중"; 
								if(this.apprFlag=='Y'){   
									color="green";  
									Flagtitle="승인";
									if(this.memNo==${memNo}){
										Flagtitle="대여 완료";
									}
								}else if (this.apprFlag=='N') {
									color= "red";  
									Flagtitle="거절";
								}else if (this.apprFlag=='W') {
									color="skyblue";  
									Flagtitle="검토중";
									if(this.memNo==${memNo}){
										color="skyblue";   
										Flagtitle="신청하신 대여건 검토중";
									}
								}  
								events.push({
									id:this.reservNo, 
									title : Flagtitle,
									start : this.useRegdate,
									end : this.returnRegdate,
									backgroundColor: color,
									memNo: this.memNo
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
		
		
		$("#insinfo").click(function(){
			var id= $("#noinfo").val();
			if(confirm("승인하시겠습니까?")){ 
					$.ajax({ 
						type : "post", 
						url : "<c:url value='/resScheduler/approve.do'/>",
						data : { 
							"reservNo": id 
						}, 
						success : function(data) {
							alert("승인 완료");
							$("#calendar").fullCalendar("refetchEvents");
							$("#my-dialog,#dialog-background").hide();
							$('#meminfo').val(''); 
							$('#contentinfo').val('');  
						},
						error : function(xhr, err) { 
							alert("ERROR! - readyState: "
									+ xhr.readyState
									+ "<br/>status: "
									+ xhr.status
									+ "<br/>responseText: "
									+ xhr.responseText);
						}
					}); //승인 ajax
			} 
		});
		$("#delinfo").click(function(){
			var id= $("#noinfo").val(); 
			if(confirm("반려하시겠습니까?")){
					$.ajax({
						type:"post", 
						url:"<c:url value='/resScheduler/refuse.do'/>",
						data:{ 
							"reservNo": id 
						}, 
						success : function(data) {
							alert("반려 완료");
							$("#calendar").fullCalendar("refetchEvents");
							$("#my-dialog,#dialog-background").hide();
							$('#meminfo').val('');
							$('#contentinfo').val('');  
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

</script>

<c:set var='mypage' value="useJs" />

<section id="main-content"> 
	<section class="wrapper">
		<h1 class="mg_text">
			<i class="far fa-calendar-alt mt "></i>  ${resVo.resName} 자원 신청 스케줄
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


<div id="my-dialog">
   <h3 id="infoname"> 신청 내역 </h3>
   <form name="scheduleInfo" class="form-horizontal style-form">
   <div class="form-group">
   </div>  
   <div class="form-group">   
			<label class="col-sm-3 col-sm-3 control-label"> 신청자 </label>
				<div class="col-sm-6">
					<h5 id="meminfo"></h5>
				</div>
			</div>  
			
	<div class="form-group">
               <label class="control-label col-md-3">신청 시간</label>
                <div class="col-md-12">   
                  <!--  <input type="text" readonly class="form-control">
                   <span class="input-group-addon">To</span>
                   <input type="text" readonly class="form-control"> -->
                   <div class="input-group input-large" >
                      <input type="text" readonly class="form-control" id="startinfo" >
                      <span class="input-group-addon">To</span>
                      <input type="text" readonly class="form-control" id="endinfo">
                    </div>
                </div>
    </div>
    <div class="form-group">  
		<label class="col-sm-4 control-label" id="btLb"></label>
		<div class="col-lg-5">            
		 <button type="button" class="btn btn-theme" id="insinfo">
			  <i class="fas fa-clipboard-check"></i> 승인 </button>
		 <button type="button" class="btn btn-theme" id="delinfo">
			  <i class="fas fa-clipboard-check"></i> 반려 </button>
		</div> 
	</div> 
	<input type="hidden" id="noinfo">			
   </form>
</div>  
<div id="dialog-background"></div>



 <script src="<c:url value='/resources/lib/bootstrap-switch.js'/>"></script>
<%@include file="../inc/bottom.jsp"%>
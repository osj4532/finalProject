<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<!-- 날짜 css -->
<!-- 날짜 css 끝 -->	 
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
    width: 500px; height: 380px; 
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
			$('#titleinfo').val('');
			$('#contentinfo').val('');  
		});    
		$('#insinfo').hide();
		$('#editinfo').hide();
		var title='';
		var content='';
		var scd_id ="";
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
					//var title = prompt('일정을 입력하세요.');
					var st=start.format(); 
					var en=end.format();  
					if(st.length==10){
						st=start.format(); 
						en=end.format();
					}else{ 
						st=start.format('YYYY/MM/DD HH:mm:ss');
						en=end.format('YYYY/MM/DD HH:mm:ss');
					}
					$("#startinfo").val(st); 
					$("#endinfo").val(en); 
					$("#infoname").html(' 일정 등록 '); 
					$("#editinfo").hide();
					$("#insinfo").show();
					$("#my-dialog,#dialog-background").show();
				}, 
				eventMouseover:function( event, jsEvent, view ) { 
					var etime =event.start.format();
					var mytime = "";
					var content = event.content;  
					content = content.replace(/\n/g, "<br>");
					if(etime.length==10){ 
						estart=event.start.format();
						eend=event.end.format(); 
						mytime=estart+' ~ '+eend;
					}else{
						mytime="<br>";
						estart=event.start.format('YYYY/MM/DD HH:mm:ss');
						eend=event.end.format('YYYY/MM/DD HH:mm:ss');
						if(estart.substring(0, 10)==eend.substring(0, 10)){
							eend=eend.substring(11, 19);  
						}
						mytime+=estart+"~"+eend;
					}    
					scd_id = $.gritter.add({ 
				            title: '일정 : '+event.title 
				            +' <br> 시간 : '+mytime,
				            text: '<h6>상세 일정</h6>'+content
				        });        
				}, 
				eventMouseout:function( event, jsEvent, view ) { 
					$.gritter.remove(scd_id);  
				},       
				eventClick: function(event, element){ 
					if($("#EditChk").is(":checked")){
						//var title = prompt('['+event.title+']을 수정합니다.');
						var st=event.start.format(); 
						var en=event.end.format(); 
						if(st.length==10){
							st=event.start.format();
							en=event.end.format();
						}else{
							st=event.start.format('YYYY/MM/DD HH:mm:ss');
							en=event.end.format('YYYY/MM/DD HH:mm:ss');
						}
						$("#startinfo").val(st); 
						$("#endinfo").val(en);   
						$("#titleinfo").val(event.title);   
						$("#contentinfo").val(event.content);  
						$("#noinfo").val(event.id);  
						$("#insinfo").hide();
						$("#editinfo").show(); 
						$("#infoname").html(' 일정 수정 ');  
						
						$("#my-dialog,#dialog-background").show();
						
						/* 수정 */
					}else {
			 			if(confirm("일정을 삭제하시겠습니까?")){
							$.ajax({
								type:"post",
								url:"<c:url value='/scheduler/userScdDel.do'/>",
								data:{ 
									"scdNo":event.id,
								},
								success : function(data) {
									alert("삭제 완료");
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
						}
					}
				}, 
				editable : true, //수정 가능  
				eventDrop: function( event, dayDelta, allDay ) {//이벤트 드롭 수정
	                var st=event.start.format(); 
					var en=event.end.format(); 
					if(st.length==10){
						st=event.start.format();
						en=event.end.format();
					}else{
						st=event.start.format('YYYY/MM/DD HH:mm:ss');
						en=event.end.format('YYYY/MM/DD HH:mm:ss');
					}
					$.ajax({
						url:"<c:url value='/scheduler/userScdEdit.do'/>",
						type:"post",
						data:{ 
							"scdNo":event.id,
							"scdStart" :st,
		 					"scdEnd" : en 
							
						},
						success : function(data) {
							alert("수정 완료");
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
				
				},
	            eventResize:function(event,jsEvent){ // 이벤트 드래그 수정
		                var st=event.start.format(); 
						var en=event.end.format(); 
						if(st.length==10){
							st=event.start.format();
							en=event.end.format();
						}else{
							st=event.start.format('YYYY/MM/DD HH:mm:ss');
							en=event.end.format('YYYY/MM/DD HH:mm:ss');
						}
						$.ajax({
							url:"<c:url value='/scheduler/userScdEdit.do'/>",
							type:"post",
							data:{ 
								"scdNo":event.id,
								"scdStart" :st,
			 					"scdEnd" : en 
								
							},
							success : function(data) {
								alert("수정 완료");
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
	            },
				events : function(start, end, allDay, callback) {
					$.ajax({
						type : "post",
						url : "<c:url value='/scheduler/userScdFind.do'/>",
						dataType : 'json',
						success : function(data) {
							var events = [];
							$.each(data, function(index,
									item) {
								var color= "#50e6ffa3";
								if(this.isday){   
									color="#d0d882";  
								}
								events.push({
									id:this.scdNo,  
									title : this.scdTitle,
									content : this.scdContent,
									start : this.scdStart,
									end : this.scdEnd,
									backgroundColor: color 
								});  
								//console.log($(this))
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
		
		$("#editinfo").click(function(){
			title=$('#titleinfo').val(); 
			content=$('#contentinfo').val();
			var st=$('#startinfo').val();
			var en=$('#endinfo').val();
			var id=$('#noinfo').val();
			if(title!='' && content!=''){
				$.ajax({
					type : "post",
					url : "<c:url value='/scheduler/userScdEditCon.do'/>",
					data : { 
						"scdNo" :id,
						"scdTitle" : title,
						"scdContent" : content 
					}, 
					success : function(data) {
						alert("내용 수정 완료");
						$("#calendar").fullCalendar("refetchEvents");
						$('#titleinfo').val(''); 
						$('#contentinfo').val('');   
						$("#my-dialog,#dialog-background").hide();
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
				alert('모두 입력해주세요!');
			}
		}); 
		$("#insinfo").click(function(){ 
			title=$('#titleinfo').val(); 
			content=$('#contentinfo').val();
			var st=$('#startinfo').val();
			var en=$('#endinfo').val();
				if(title!='' && content!=''){
					$.ajax({ 
						type : "post",
						url : "<c:url value='/scheduler/userScdWrite.do'/>",
						data : { 
							"scdTitle" : title,
							"scdContent" : content,
							"scdStart" :st,
		 					"scdEnd" : en 
						}, 
						success : function(data) {
							alert("저장 완료");
							$("#calendar").fullCalendar("refetchEvents");
							$('#titleinfo').val(''); 
							$('#contentinfo').val('');  
							$("#my-dialog,#dialog-background").hide();
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
				}else { 
					alert('입력값이 없습니다!'); 
				}
		}); 
		
		
		
});

</script>

<c:set var='mypage' value="useJs" />

<section id="main-content">
	<section class="wrapper">
		<h1 class="mg_text"> 
			<i class="far fa-calendar-alt mt "></i> 개인 스케줄   
		</h1> 
		<!-- page start--> 
		<div class="row"> 
			<div class="col-lg-12">    
				<span id="switchinfo"><i class="fas fa-hand-point-right"></i>  Click    </span>      
                  <div class="switch switch-square" data-on-label="수정" data-off-label="삭제">
                    <input type="checkbox" id="EditChk"/>
                  </div>
				<div class="darkblue-panel"
					style="padding: 30px; border-radius: 35px;">
					<div id='calendar'></div> 
				</div>
			</div>
		</div>
	</section> 
</section>
<div id="my-dialog">
   <h3 id="infoname"> 일정 등록 </h3>
   <form name="scheduleInfo" class="form-horizontal style-form">
   <div class="form-group">
   </div>  
   <div class="form-group">   
			<label class="col-sm-3 col-sm-3 control-label">제목</label>
				<div class="col-sm-6">
					<input type="text" class="form-control"
						placeholder="일정 제목 입력" id="titleinfo"> 
				</div>
			</div>  
   <div class="form-group">   
			<label class="col-sm-3 col-sm-3 control-label">내용</label>
				<div class="col-sm-6"> 
				 <textarea class="form-control " placeholder="일정 내용 입력" id="contentinfo" name="comment" ></textarea>
				</div>
			</div>   
			
	<div class="form-group">
               <label class="control-label col-md-3">일정 시간</label>
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
		<label class="col-sm-5 col-sm-5 control-label"></label>
		<div class="col-lg-6">       
		 <button type="button" class="btn btn-theme" id="insinfo">
			  <i class="fas fa-clipboard-check"></i> 등록 </button>
		 <button type="button" class="btn btn-theme" id="editinfo">
			  <i class="fas fa-clipboard-check"></i> 수정 </button>
		</div> 
	</div>
	<input type="hidden" id="noinfo">			
   </form>
</div>  
<div id="dialog-background"></div>
<!-- 날짜 js --> 

 

<!-- 날짜 js 끝 --> 
 <script src="<c:url value='/resources/lib/bootstrap-switch.js'/>"></script>
<%@include file="../inc/bottom.jsp"%>
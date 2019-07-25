<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../inc/top.jsp"%>
<link rel="stylesheet" href="<c:url value='/resources/css/to-do.css'/>" >
<c:set var="mypage" value="useJs"/>
<script src="<c:url value='/resources/js/paging.js'/>"></script>
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">
var searchKeyword='';
var searchCondition='';
var searchName='';

$(function(){
	$("#AllRes").hide();
	<c:if test="${!empty param.scrollTop}"> 
		$(window).scrollTop(${param.scrollTop});
	</c:if>
	 
	$.useRes(1);
	$("#AllResView").click(function(){
		$("#AllRes").toggle(500);   
	}); 
	$('form[name=AlluseSearch]').submit(function() {
		event.preventDefault();
		$.useRes(1); //default로 1페이지 조회
	}); 
	$('input[name=searchKeyword]').keyup(function() {
		$.useRes(1);  
	}); 
	
	 
	$('form[name=AppSearch]').submit(function(){ 
		event.preventDefault();
	/* 	$('input[name=AppsearchCondition]').val($('#AppsearchCondition option:selected').val());
		$('input[name=AppsearchKeyword]').val($('#AppsearchKeyword').val());
		document.AllAppSearch.submit();   */
		$.AppPageFunc(1);
	});
	 
	$('form[name=WaitSearch]').submit(function(){ 
		event.preventDefault();
		$.WaitPageFunc(1) 
	});
	
	$('form[name=ReJectSearch]').submit(function(){ 
		event.preventDefault();
		$.ReJectPageFunc(1);
	});
	
});  
 

$.useRes=function(curPage){
	//현재 페이지 setting
	$("input[name=currentPage]").val(curPage);
		searchCondition= $("#searchCondition").val();  
		searchName= $("#searchCondition option:selected").text();  
		searchKeyword= $("input[name=searchKeyword]").val();
	$.ajax({ 
		url:"<c:url value='/useResource/AllUsefindResList.do'/>",
		type:"post",  
		data:{ 
			"currentPage":curPage,		
			"searchCondition":searchCondition,
			"searchKeyword":searchKeyword
		},
		success:function(res){ 
			makeList(res);
		},
		error:function(xhr,status,error){
			alert(status+": "+error);
		}
	});
}//function


function makeList(res){ 
	$('#AllUseRes').html(""); 
	$('#hidden-table-info_info').html(""); 
	$('#AllUseResPaging').html(""); 
	var totalCount = 0;
	if(res==''){
		if(searchKeyword!=''){
			$('#AllUseRes').append("<td colspan='4'><h4><b>검색하신 자원이 없습니다.</b></h4></td>");
		}else {
			$('#AllUseRes').append("<td colspan='4'><h4><b>신청하신 자원이 없습니다.</b></h4></td>");
		}
	}else{
		$.each(res, function(index,item) {
			var trEl =$("<tr></tr>");
				var typeName=this.typeName;
				var resName=this.resName;
				var regdate=this.useRegdate+" ~ "+this.returnRegdate;
				var memName=this.memName;
				
				var tdEl1=$("<td></td>").html(typeName);
				var tdEl2=$("<td class='hidden-phone' ></td>").html(resName);
				var tdEl3=$("<td></td>").html(regdate);
				var tdEl4=$("<td></td>").html(memName);
				
				trEl.append(tdEl1);
				trEl.append(tdEl2);
				trEl.append(tdEl3);
				trEl.append(tdEl4); 
		
			$('#AllUseRes').append(trEl);
			totalCount = this.totalCount;
		}); 
	}
		
	  
	//페이징 처리 
	var p_recordCount=5, p_blockSize=5; 
	var p_curPage=$('input[name=currentPage]').val();
	
	pagination(p_curPage,p_recordCount,p_blockSize,totalCount);
			 
	$.pageSetting(res); 
	   
}  

$.pageSetting=function(){ 
	
	if(searchKeyword!=''){ 
		$("#hidden-table-info_info").append(" "+searchName+" 검색 : "+searchKeyword+"<br>"); 
	}   
	$("#hidden-table-info_info").append(" 전체 사용내역 - "+
			totalRecord+"건 ");  
	
	if(firstPage>1){     
	 var anchor=$("<li class='prev'><a href='#'>← Previous</a></li>")
	 .attr("onclick","$.useRes("+(Number(firstPage)-1)+")")
		$('#AllUseResPaging').append(anchor);    
	}   
	/*페이지 번호 추가   
	[1][2][3][4][5][6][7][8][9][10] */
	for(var i=firstPage;i<=lastPage;i++){
		if(i==currentPage){  
			var spanEl=$("<li class='active'><a href='#'>"+i+"</a></li>");
			$('#AllUseResPaging').append(spanEl) ;
		}else {
			var anchor =$("<li><a href='#'>"+i+"</a></li>")
			.attr("onclick","$.useRes("+i+")");
			$('#AllUseResPaging').append(anchor);
		} 
	}//for 
	//다음 블럭으로 이동하기
	if(lastPage<totalPage-1){
		 var anchor=$("<li class='next'><a href='#'>Next → </a></li>")
.attr("onclick","$.useRes("+(Number(lastPage)+1)+")");
		 $('#AllUseResPaging').append(anchor);
	}	 
}




function AppResScd(reservNo){
	if(confirm("신청을 승인 하시겠습니까?")){
		location.href="<c:url value='/useResource/AppResSchedule.do?reservNo='/>"+reservNo;
	}
	
}

function rejectResScd(reservNo){
	if(confirm("신청을 반려 하시겠습니까?")){
		location.href="<c:url value='/useResource/rejectResSchedule.do?reservNo='/>"+reservNo;
	}
} 
function WaitResScd(reservNo){
	if(confirm("재검토 하시겠습니까?")){
		location.href="<c:url value='/useResource/WaitResSchedule.do?reservNo='/>"+reservNo;
	}
}
$.AppPageFunc=function(cur){ 
	document.AllAppSearch.AppcurrentPage.value=cur;
	$('input[name=AppsearchCondition]').val($('#AppsearchCondition option:selected').val());
	$('input[name=AppsearchKeyword]').val($('#AppsearchKeyword').val()); 
	
	var scroll=$(window).scrollTop(); 
	$('input[name=scrollTop]').val(scroll);
	
	document.AllAppSearch.submit(); 
}


$.WaitPageFunc=function(cur){ 
	document.AllAppSearch.WaitcurrentPage.value=cur;
	$('input[name=WaitsearchCondition]').val($('#WaitsearchCondition option:selected').val());
	$('input[name=WaitsearchKeyword]').val($('#WaitsearchKeyword').val());
	
	var scroll=$(window).scrollTop(); 
	$('input[name=scrollTop]').val(scroll);
	
	document.AllAppSearch.submit(); 
}
  
$.ReJectPageFunc=function(cur){ 
	document.AllAppSearch.ReJectcurrentPage.value=cur;
	$('input[name=ReJectsearchCondition]').val($('#ReJectsearchCondition option:selected').val());
	$('input[name=ReJectsearchKeyword]').val($('#ReJectsearchKeyword').val());
		
	var scroll=$(window).scrollTop(); 
	$('input[name=scrollTop]').val(scroll);
	 
	document.AllAppSearch.submit();
} 



</script>
<!--main content start--> 
<section id="main-content">
	<section class="wrapper">
		<h3> 
			<i class="fas fa-sitemap"></i> 사원전체 자원 신청 내역
			<button type="button" id="AllResView" class="btn btn-round btn-info">사원전체 자원 사용 내역 보기</button> 
		</h3>
        
          <div class="row mt" id="AllRes">
          <div class="col-md-12">
            <div class="content-panel">
              <table class="table table-striped table-advance table-hover">
                <h4><i class="fas fa-clipboard-check"></i> 사원전체 자원 사용 내역</h4>
                <hr>
                <thead> 
                  <tr>
                    <th width="20%"><i class="fas fa-archive"></i>  자원 </th>
                    <th width="20%" class="hidden-phone"><i class="fas fa-info-circle"></i> 자원명 </th>
                    <th width="30%"><i class="fas fa-history"></i>  사용 기간 </th>
                    <th width="30%"><i class="fas fa-user-clock"></i> 사용 사원 </th>
                  </tr>  
                </thead>
                <tbody id="AllUseRes"><!-- AllUseList -->
	                	
                </tbody> 
              </table>
   
            <!-- /content-panel -->
            <div class='span6'>
            <div class='dataTables_info'id='hidden-table-info_info'>
            </div>
            </div>
				<div class="span6">  
				<form method="post" name="AlluseSearch" class="form-inline" role="form">
						<input type="hidden" name='currentPage' value="1"> 
						<select name="searchCondition" id="searchCondition" class="form-control ">
								<option value="type_Name"> 자원 </option>
								<option value="res_Name"> 자원명 </option>
								<option value="mem_Name"> 사원명 </option>
						</select>      
						<div class="form-group"> 
	                  <label class="sr-only" for="AllResKeyword">내용</label>
	                  <input type="text" class="form-control" name="searchKeyword" 
	                  id="AllResKeyword" placeholder="내용 입력"> 
	                </div>  
	               		 <button type="submit" class="btn btn-theme">검색</button> 
				</form> 
					<div class="dataTables_paginate paging_bootstrap pagination">
						<ul id="AllUseResPaging">
						</ul>
					</div> 
				</div> 
       		
       		  </div>
          </div>
          <!-- /col-md-12 -->
				  
        <!-- /row -->
        </div>
        <!-- /row -->
        
        
          <div class="row mt">
          <div class="col-md-12">
            <div class="content-panel">
              <table class="table table-striped table-advance table-hover">
                <h4><i class="fas fa-calendar-check"></i>전체 승인 내역</h4>
                <hr>
                <thead>
                  <tr>
                    <th><i class="fas fa-archive"></i> 자원</th>
                    <th class="hidden-phone"><i class="fas fa-info-circle"></i> 자원명</th>
                    <th><i class="fas fa-user-clock"></i>  신청 기간 </th>
                    <th><i class="fas fa-user-tag"></i> 신청 사원 </th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                 <c:if test="${empty AppList}">
                	<tr> 
                    <td colspan="5">
							<h4><b>
						 	<c:if test="${empty param.AppsearchKeyword}">
							신청
		                  	</c:if> 
						 	<c:if test="${!empty param.AppsearchKeyword}">
							검색
		                  	</c:if>
							하신 자원이 없습니다.</b></h4>
					</td>
                  </tr>  
				</c:if>  
                <c:if test="${!empty AppList}">
                 <c:forEach var="AanVo" items="${AppList}">
                  <tr>
                    <td>${AanVo.typeName } 
                    </td> 
                    <td class="hidden-phone">${AanVo.resName }</td>
                    <td>${AanVo.useRegdate } ~ ${AanVo.returnRegdate }</td>
                    <td>${AanVo.memName }</td>
                    <td>
                      <button class="btn btn-primary btn-xs"
                     onclick="WaitResScd(${AanVo.reservNo })"><i class="fas fa-undo"> 승인 취소 </i></button>
                    </td>     
                  </tr>   
                      </c:forEach> 
                  </c:if> 
                </tbody>
              </table> 
	            <!-- /content-panel -->
	            <div class="row-fluid">
					<div class="span6">
						<div class="dataTables_info" id="hidden-table-info_info">
						전체 승인 내역 - ${AppPagingInfo.totalRecord} 건</div>
					</div>
					<div class="span6">
					  
					 
						<form method="post" name="AppSearch" class="form-inline" role="form">
								<select  id="AppsearchCondition" class="form-control">
										<option value="type_Name" 
										<c:if test="${param.AppsearchCondition eq 'type_Name'}">
										selected='selected'
										</c:if> 
										> 자원 </option> 
										<option value="res_Name" 
										<c:if test="${param.AppsearchCondition eq 'res_Name'}">
										selected='selected'
										</c:if> 
										> 자원명 </option>
										<option value="mem_Name" 
										<c:if test="${param.AppsearchCondition eq 'mem_Name'}">
										selected='selected' 
										</c:if> 
										> 사원명 </option>
								</select>     
								<div class="form-group">  
			                  <input type="text" class="form-control" id="AppsearchKeyword" 
			                  placeholder="내용 입력" value="${param.AppsearchKeyword}">
			                </div>    
			               		 <button type="submit" class="btn btn-theme">검색</button> 
						</form> 
				
				
						<div class="dataTables_paginate paging_bootstrap pagination">
							<ul>
							<!-- 이전블럭으로 이동하기 -->
							<c:if test="${AppPagingInfo.firstPage>1 }">	
								<li class="prev disabled">
									<a href="#" onclick="$.AppPageFunc(${AppPagingInfo.firstPage-1})">← Previous</a>
								</li>
							</c:if>
							<!-- 페이지 번호 추가 -->
							<!-- [1][2][3][4][5][6][7][8][9][10] -->
							<c:forEach var="i" begin="${AppPagingInfo.firstPage }" end="${AppPagingInfo.lastPage }">
								<c:if test="${i==AppPagingInfo.currentPage }">
									<li class="active"><a href='#'>${i}</a></li>
								</c:if> 
								<c:if test="${i!=AppPagingInfo.currentPage }">
									<li><a href="#" onclick="$.AppPageFunc(${i})">${i}</a></li>
								</c:if>
							</c:forEach>
							<!--  페이지 번호 끝 -->
							
							<!-- 다음 블럭으로 이동하기 -->
							<c:if test="${AppPagingInfo.lastPage<AppPagingInfo.totalPage }">	
								<li class="next"><a href="#" onclick="$.AppPageFunc(${AppPagingInfo.lastPage+1})">Next → </a></li>
							</c:if>
							</ul> 
						</div>
					</div>
					 
					<!-- row-fluid -->
				</div> 
				 <form action="<c:url value='/useResource/AllUseResList.do'/>" 
						method="post" name="AllAppSearch" class="form-inline" role="form">
						<!-- 승인 페이지 처리 -->
						<input type="hidden" name='AppcurrentPage' value="1">
						<!-- 승인 검색 처리 -->
						<input type="hidden" name='AppsearchCondition' > 
						<input type="hidden" name='AppsearchKeyword' >
						<!-- 검토 페이지 처리 -->  
						<input type="hidden" name='WaitcurrentPage' value="1"> 
						<!-- 검토 검색 처리 --> 
						<input type="hidden" name='WaitsearchCondition' >
						<input type="hidden" name='WaitsearchKeyword'>  
						<!-- 반려 페이지 처리 -->
						<input type="hidden" name='ReJectcurrentPage' value="1">
						<!-- 반려 검색 처리 -->
						<input type="hidden" name='ReJectsearchCondition'>
						<input type="hidden" name='ReJectsearchKeyword'>

						<input type="hidden" name='scrollTop'>
						
					</form> 
				<!-- row-fluid -->
            </div> 
          </div>
          <!-- /col-md-12 -->
        </div>
               <div class="row mt">
          <div class="col-md-12">
            <div class="content-panel">
              <table class="table table-striped table-advance table-hover">
                <h4><i class="fas fa-hourglass-half"></i> 전체 검토 내역</h4>
                <hr>
                <thead>
                  <tr>
                    <th><i class="fas fa-archive"></i> 자원</th>
                    <th class="hidden-phone"><i class="fas fa-info-circle"></i> 자원명</th>
                    <th><i class="fas fa-user-clock"></i>  신청 기간 </th>
                    <th><i class="fas fa-user-tag"></i> 신청 사원 </th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                 <c:if test="${empty waitList}">
                	<tr>
	                    <td colspan="5">
								<h4><b>
							 	<c:if test="${empty param.WaitsearchKeyword}">
								신청 
			                  	</c:if> 
							 	<c:if test="${!empty param.WaitsearchKeyword}">
								검색
			                  	</c:if>
								신청하신 자원이 없습니다.</b></h4>
						</td>
                 	 </tr> 
                 </c:if>
                 <c:if test="${!empty waitList}">
                 <c:forEach var="waitVo" items="${waitList }">
	                  <tr>
	                    <td>${waitVo.typeName }
	                    </td>
	                    <td class="hidden-phone">${waitVo.resName }</td>
	                    <td>${waitVo.useRegdate } ~ ${waitVo.returnRegdate }</td>
	                    <td>${waitVo.memName }</td>
	                    <td> 
	                      <button class="btn btn-success btn-xs"
	                      onclick="AppResScd(${waitVo.reservNo })"><i class="fa fa-check"> 승인 </i></button>
	                      <button class="btn btn-danger btn-xs"
	                      onclick="rejectResScd(${waitVo.reservNo })"><i class="fas fa-times"> 반려 </i></button>
	                    </td>   
	                  </tr>  
                  </c:forEach>  
	              </c:if>

				</tbody>
              </table>
               <!-- /content-panel -->
            <div class="row-fluid">
					<div class="span6">
						<div class="dataTables_info" id="hidden-table-info_info">
						전체 검토 내역 - ${WaitPagingInfo.totalRecord} 건</div>
					</div>
					
					<div class="span6">
					
					<form method="post" name="WaitSearch" class="form-inline" role="form">
								<select  id="WaitsearchCondition" class="form-control">
										<option value="type_Name" 
										<c:if test="${param.WaitsearchCondition eq 'type_Name'}">
										selected='selected'
										</c:if> 
										> 자원 </option> 
										<option value="res_Name" 
										
										<c:if test="${param.WaitsearchCondition eq 'res_Name'}">
										selected='selected'
										</c:if> 
										 
										> 자원명 </option>
										<option value="mem_Name" 
										  
										<c:if test="${param.WaitsearchCondition eq 'mem_Name'}">
										selected='selected' 
								 		</c:if> 
										
										> 사원명 </option>
								</select>     
								<div class="form-group">  
			                  <input type="text" class="form-control" id="WaitsearchKeyword" 
			                  placeholder="내용 입력" value="${param.WaitsearchKeyword}">
			                </div>    
			               		 <button type="submit" class="btn btn-theme">검색</button> 
						</form> 
					
					
						<div class="dataTables_paginate paging_bootstrap pagination">
							<ul>
							
							<!-- 이전블럭으로 이동하기 -->
							<c:if test="${WaitPagingInfo.firstPage>1 }">	
								<li class="prev disabled">
									<a href="#" onclick="$.WaitPageFunc(${WaitPagingInfo.firstPage-1})">← Previous</a>
								</li>
							</c:if>
							<!-- 페이지 번호 추가 -->
							<!-- [1][2][3][4][5][6][7][8][9][10] -->
							<c:forEach var="i" begin="${WaitPagingInfo.firstPage }" end="${WaitPagingInfo.lastPage }">
								<c:if test="${i==WaitPagingInfo.currentPage }">
									<li class="active"><a href='#'>${i}</a></li>
								</c:if> 
								<c:if test="${i!=WaitPagingInfo.currentPage }">
									<li><a href="#" onclick="$.WaitPageFunc(${i})">${i}</a></li>
								</c:if>
							</c:forEach>
							<!--  페이지 번호 끝 -->
							 
							<!-- 다음 블럭으로 이동하기 -->
							<c:if test="${WaitPagingInfo.lastPage<WaitPagingInfo.totalPage }">	
								<li class="next"><a href="#" onclick="$.WaitPageFunc(${WaitPagingInfo.lastPage+1})">Next → </a></li>
							</c:if>
								
							</ul>
						</div>
					</div>
				</div>
               
            </div>
            <!-- /content-panel -->
          </div>
          <!-- /col-md-12 -->
        </div>
               <div class="row mt">
          <div class="col-md-12">
            <div class="content-panel">
              <table class="table table-striped table-advance table-hover">
                <h4><i class="fas fa-calendar-times"></i> 전체 반려 내역</h4>
                <hr>
                <thead>
                  <tr>
                    <th><i class="fas fa-archive"></i> 자원</th>
                    <th class="hidden-phone"><i class="fas fa-info-circle"></i> 자원명</th>
                    <th><i class="fas fa-user-clock"></i>  신청 기간 </th>
                    <th><i class="fas fa-user-tag"></i> 신청 사원 </th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                    <c:if test="${empty refuseList}">
                	<tr>
	                    <td colspan="5">
								<h4><b>
								<c:if test="${empty param.ReJectsearchKeyword}">
								신청 
			                  	</c:if>  
							 	<c:if test="${!empty param.ReJectsearchKeyword}">
								검색
			                  	</c:if>
								하신 자원이 없습니다.</b></h4>
						</td>
                 	 </tr>   
                 </c:if>
                 <c:if test="${!empty refuseList}">
                 <c:forEach var="refuseVo" items="${refuseList }">
	                  <tr> 
	                    <td>${refuseVo.typeName }  
	                    </td>
	                    <td class="hidden-phone">${refuseVo.resName }</td> 
	                    <td>${refuseVo.useRegdate } ~ ${refuseVo.returnRegdate }</td>
	                     <td>${refuseVo.memName }</td>
	                    <td>
	                      <button class="btn btn-primary btn-xs"
	                      onclick="WaitResScd(${refuseVo.reservNo })"><i class="fas fa-undo">  재검토 </i></button>
	                    </td>  
	                  </tr> 
                  </c:forEach>  
                  </c:if>   
                </tbody>
              </table> 
               <!-- /content-panel -->
            <div class="row-fluid">
					<div class="span6">
						<div class="dataTables_info" id="hidden-table-info_info">
						전체 반려 내역 - ${ReFusePagingInfo.totalRecord} 건</div>
					</div>
					<div class="span6">
					
					<form method="post" name="ReJectSearch" class="form-inline" role="form">
								<select  id="ReJectsearchCondition" class="form-control">
										<option value="type_Name" 
										<c:if test="${param.ReJectsearchCondition eq 'type_Name'}">
										selected='selected'
										</c:if> 
										> 자원 </option> 
										<option value="res_Name" 
										<c:if test="${param.ReJectsearchCondition eq 'res_Name'}">
										selected='selected'
										</c:if> 
										> 자원명 </option>
										<option value="mem_Name" 
										<c:if test="${param.ReJectsearchCondition eq 'mem_Name'}">
										selected='selected' 
										</c:if>  
										> 사원명 </option>
								</select>      
								<div class="form-group">  
			                  <input type="text" class="form-control" id="ReJectsearchKeyword" 
			                  placeholder="내용 입력" value="${param.ReJectsearchKeyword}">
			                </div>   
			               		 <button type="submit" class="btn btn-theme">검색</button> 
						</form> 
					
						<div class="dataTables_paginate paging_bootstrap pagination">
							<ul>
							
							<!-- 이전블럭으로 이동하기 -->
							<c:if test="${ReFusePagingInfo.firstPage>1 }">	
								<li class="prev disabled">
									<a href="#" onclick="$.ReJectPageFunc(${ReFusePagingInfo.firstPage-1})">← Previous</a>
								</li>
							</c:if>
							<!-- 페이지 번호 추가 -->
							<!-- [1][2][3][4][5][6][7][8][9][10] -->
							<c:forEach var="i" begin="${ReFusePagingInfo.firstPage }" end="${ReFusePagingInfo.lastPage }">
								<c:if test="${i==ReFusePagingInfo.currentPage }">
									<li class="active"><a href='#'>${i}</a></li>
								</c:if> 
								<c:if test="${i!=ReFusePagingInfo.currentPage }">
									<li><a href="#" onclick="$.ReJectPageFunc(${i})">${i}</a></li>
								</c:if>
							</c:forEach>
							<!--  페이지 번호 끝 -->
							
							<!-- 다음 블럭으로 이동하기 -->
							<c:if test="${ReFusePagingInfo.lastPage<ReFusePagingInfo.totalPage }">	
								<li class="next"><a href="#" onclick="$.ReJectPageFunc(${ReFusePagingInfo.lastPage+1})">Next → </a></li>
							</c:if>
							
							</ul>
						</div>
					</div>
				</div>
				 
              
            </div>
            <!-- /content-panel -->
          </div>
          <!-- /col-md-12 --> 
        </div>
       


	</section>
	<!-- /wrapper -->
</section>



<%@include file="../../inc/bottom.jsp"%>

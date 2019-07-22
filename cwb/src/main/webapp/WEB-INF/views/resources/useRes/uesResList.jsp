<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../inc/top.jsp"%>
<link rel="stylesheet" href="<c:url value='/resources/css/to-do.css'/>" >
<c:set var="mypage" value="useJs"/>
<script src="<c:url value='/resources/js/paging.js'/>"></script>
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">
$(function(){
	$("#MyRes").hide();
	$("#notfindRes").hide();
	$.useRes(1);
	$("#MyResView").click(function(){
		$("#MyRes").toggle(500);   
	});
	$('form[name=useSearch]').submit(function() {
		event.preventDefault();
		$.useRes(1); //default로 1페이지 조회
		
	}); 
}); 
 
 
$.useRes=function(curPage){
	//현재 페이지 setting
	$("input[name=currentPage]").val(curPage);
	/* var searchCondition= $("#searchCondition").val(); 
	var searchKeyword= $("input[name=searchKeyword]").val();
	alert(searchKeyword);  */
	$.ajax({ 
		url:"<c:url value='/useResource/usefindResList.do'/>",
		type:"post",
		data:{ 
			"currentPage":curPage,		
			/* "searchCondition":searchCondition,
			"searchKeyword":searchKeyword  */
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
	$('#useRes').html(""); 
	$('#hidden-table-info_info').html(""); 
	$('#useResPaging').html(""); 
	var totalCount = 0; 
	$.each(res, function(index,item) {
		var trEl =$("<tr></tr>");
		if(this.totalCount==0){
			var tdEl1=$("<td colspan='3'><h4><b>신청하신 자원이 없습니다.</b></h4></td>")
			trEl.append(tdEl1);
		}else{
			var typeName=this.typeName;
			var resName=this.resName;
			var regdate=this.useRegdate+" ~ "+this.returnRegdate;
			
			var tdEl1=$("<td></td>").html(typeName);
			var tdEl2=$("<td class='hidden-phone' ></td>").html(resName);
			var tdEl3=$("<td></td>").html(regdate);
			
			trEl.append(tdEl1);
			trEl.append(tdEl2);
			trEl.append(tdEl3);
		}
	
		$('#useRes').append(trEl);
		totalCount = this.totalCount;
		
	}); 
		
	  
	//페이징 처리 
	var p_recordCount=5, p_blockSize=5;
	var p_curPage=$('input[name=currentPage]').val();
	
	pagination(p_curPage,p_recordCount,p_blockSize,totalCount);
			 
	$.pageSetting(); 
	   
}  

$.pageSetting=function(){ 
	
	$("#hidden-table-info_info").append("전체 사용내역 - "+
			totalRecord+"건"); 
	if(firstPage>1){  
	 var anchor=$("<li class='prev'><a href='#'>← Previous</a></li>")
	 .attr("onclick","$.useRes("+(Number(firstPage)-1)+")")
		$('#useResPaging').append(anchor);    
	}   
	/*페이지 번호 추가  
	[1][2][3][4][5][6][7][8][9][10] */
	for(var i=firstPage;i<=lastPage;i++){
		if(i==currentPage){  
			var spanEl=$("<li class='active'><a href='#'>"+i+"</a></li>");
			$('#useResPaging').append(spanEl) ;
		}else {
			var anchor =$("<li><a href='#'>"+i+"</a></li>")
			.attr("onclick","$.useRes("+i+")");
			$('#useResPaging').append(anchor);
		} 
	}//for 
	//다음 블럭으로 이동하기
	if(lastPage<totalPage-1){
		 var anchor=$("<li class='next'><a href='#'>Next → </a></li>")
.attr("onclick","$.useRes("+(Number(lastPage)+1)+")");
		 $('#useResPaging').append(anchor);
	}	 
	/*    
	  
	<c:forEach var="i" begin="${pagingInfo.firstPage }" end="${pagingInfo.lastPage }">
		<c:if test="${i==pagingInfo.currentPage }">
				<li class="active"><a href="#">${i}</a></li>
		</c:if>
		<c:if test="${i!=pagingInfo.currentPage }">
			<li><a href="#"  onclick="useRes(${i})">${i}</a></li>
		</c:if>
	</c:forEach>
	<li class="next"><a href="#">Next → </a></li>
	
	
	<c:forEach var="i" begin="${pagingInfo.firstPage }" end="${pagingInfo.lastPage }">
		<c:if test="${i==pagingInfo.currentPage }">
			<span style="color:pink;font-size: 1em">[${i}]</span>
		</c:if>
		<c:if test="${i!=pagingInfo.currentPage }">
			<a href="#" onclick="pageFunc(${i})">[${i}]</a>
		</c:if>
	</c:forEach>*/
	/* 페이지 번호 끝 
	
	 
	/*
	<c:if test="${pagingInfo.lastPage<pagingInfo.totalPage }">	
		<a href="#" onclick="pageFunc(${pagingInfo.lastPage+1})">
			<img src="<c:url value='/resources//images/last.JPG'/>" alt="다음블럭으로 이동">
		</a>
	</c:if>	
	*/ 
}




function delResScd(reservNo){
	if(confirm("자원 신청을 취소 하시겠습니까?")){
		location.href="<c:url value='/useResource/delResSchedul.do?reservNo='/>"+reservNo;
	}
	
}

function reResScd(reservNo){
	if(confirm("재신청 하시겠습니까?")){
		location.href="<c:url value='/useResource/reResSchedule.do?reservNo='/>"+reservNo;
	}
}


</script>
<!--main content start--> 
<section id="main-content">
	<section class="wrapper">
		<h3> 
			<i class="fa fa-angle-right"></i> 자원 신청 내역
			<button type="button" id="MyResView" class="btn btn-round btn-info">자원 사용 내역 보기</button> 
		</h3>
        
          <div class="row mt" id="MyRes">
          <div class="col-md-12">
            <div class="content-panel">
              <table class="table table-striped table-advance table-hover">
                <h4><i class="fa fa-angle-right"></i>자원 사용 내역</h4>
                <hr>
                <thead> 
                  <tr>
                    <th width="20%"><i class="fa fa-bullhorn"></i> 자원 </th>
                    <th width="30%" class="hidden-phone"><i class="fa fa-question-circle"></i> 자원명 </th>
                    <th width="50%"><i class="fa fa-bookmark"></i> 사용 기간 </th>
                  </tr>  
                </thead>
                <tbody id="useRes"><!-- myUseList -->
	                	
                </tbody> 
              </table>
            </div>
            <!-- /content-panel -->
            <div class='span6'>
            <div class='dataTables_info'id='hidden-table-info_info'>
            </div>
            </div>
				<div class="span6">
				<form method="post" name="useSearch" class="form-inline" role="form">
						<input type="hidden" name='currentPage' value="1">
						<!-- <select name="searchCondition" id="searchCondition">
							<optgroup label="searchCondition">
								<option value=""> 검색 조건 선택  </option>
								<option value="type_Name"> 자원 타입 </option>
								<option value="res_Name"> 자원 명 </option>
							</optgroup>  
						</select>  
						<div class="form-group">
	                  <label class="sr-only" for="exampleInputEmail2">내용</label>
	                  <input type="text" class="form-control" name="searchKeyword" 
	                  id="exampleInputEmail2" placeholder="내용 입력">
	                </div>  
	               		 <button type="submit" class="btn btn-theme">검색</button> -->
				</form> 
					<div class="dataTables_paginate paging_bootstrap pagination">
						<ul id="useResPaging">
						</ul>
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
                <h4><i class="fa fa-angle-right"></i> 승인 내역</h4>
                <hr>
                <thead>
                  <tr>
                    <th><i class="fa fa-bullhorn"></i> 자원</th>
                    <th class="hidden-phone"><i class="fa fa-question-circle"></i> 자원명</th>
                    <th><i class="fa fa-bookmark"></i> 신청 기간 </th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                 <c:if test="${empty canList}">
                	<tr>
                    <td colspan="3">
							<h4><b>신청하신 자원이 없습니다.</b></h4>
					</td>
                  </tr> 
				</c:if> 
                <c:if test="${!empty canList}">
                 <c:forEach var="canVo" items="${canList}">
                  <tr>
                    <td>${canVo.typeName } 
                    </td> 
                    <td class="hidden-phone">${canVo.resName }</td>
                    <td>${canVo.useRegdate } ~ ${canVo.returnRegdate }</td>
                    <td>
                      <button class="btn btn-danger btn-xs"
                      onclick="delResScd(${canVo.reservNo })"><i class="fa fa-check">신청 취소</i></button>
                    </td>    
                  </tr>   
                      </c:forEach> 
                  </c:if> 
                </tbody>
              </table> 
            </div>
            <!-- /content-panel -->
          </div>
          <!-- /col-md-12 -->
        </div>
               <div class="row mt">
          <div class="col-md-12">
            <div class="content-panel">
              <table class="table table-striped table-advance table-hover">
                <h4><i class="fa fa-angle-right"></i> 검토 내역</h4>
                <hr>
                <thead>
                  <tr>
                    <th><i class="fa fa-bullhorn"></i> 자원</th>
                    <th class="hidden-phone"><i class="fa fa-question-circle"></i> 자원명</th>
                    <th><i class="fa fa-bookmark"></i> 신청 기간 </th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                 <c:if test="${empty waitList}">
                	<tr>
	                    <td colspan="3">
								<h4><b>신청하신 자원이 없습니다.</b></h4>
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
	                    <td>
	                      <button class="btn btn-danger btn-xs"
	                      onclick="delResScd(${waitVo.reservNo })"><i class="fa fa-check">신청 취소</i></button>
	                    </td>  
	                  </tr> 
                  </c:forEach>  
	              </c:if>     
                </tbody>
              </table> 
            </div>
            <!-- /content-panel -->
          </div>
          <!-- /col-md-12 -->
        </div>
               <div class="row mt">
          <div class="col-md-12">
            <div class="content-panel">
              <table class="table table-striped table-advance table-hover">
                <h4><i class="fa fa-angle-right"></i> 반려 내역</h4>
                <hr>
                <thead>
                  <tr>
                    <th><i class="fa fa-bullhorn"></i> 자원</th>
                    <th class="hidden-phone"><i class="fa fa-question-circle"></i> 자원명</th>
                    <th><i class="fa fa-bookmark"></i> 신청 기간 </th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                    <c:if test="${empty refuseList}">
                	<tr>
	                    <td colspan="3">
								<h4><b>신청하신 자원이 없습니다.</b></h4>
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
	                    <td>
	                      <button class="btn btn-primary btn-xs"
	                      onclick="reResScd(${refuseVo.reservNo })"><i class="fa fa-check">재검토 신청</i></button>
	                    </td>  
	                  </tr> 
                  </c:forEach>  
                  </c:if>   
                </tbody>
              </table> 
            </div>
            <!-- /content-panel -->
          </div>
          <!-- /col-md-12 --> 
        </div>
       


	</section>
	<!-- /wrapper -->
</section>



<!--
 <div class="task-checkbox">
         <input type="checkbox" class="list-child" value="" />
                  <a href="basic_table.html#">Dashio </a>
 </div> -->


<%@include file="../../inc/bottom.jsp"%>

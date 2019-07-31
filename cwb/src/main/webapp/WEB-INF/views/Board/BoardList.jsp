<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<c:set var="mypage" value="useJs"/>
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>
<script type="text/javascript">


function writeBoard(bdlistNo){
	window.open(
			"${pageContext.request.contextPath}/Board/BoardWrite.do?bdlistNo="+bdlistNo,
			"resourceWrite",  
			"left=450, top=150, width=800, height=770, scrollbars=yes,resizable=yes");
	};
</script>	
<section id="main-content">
	<section class="wrapper">
		<h3 class='mt'>   
			<i class="fas fa-clipboard-list"></i> ${blVo.bdlistName} 	
		</h3>   
		  <div class="row mt">
          <div class="col-md-12"> 
            <div class="content-panel"> 
              <table class="table table-striped table-advance table-hover">
                <h4> 
                <button type="button" onclick="writeBoard(${blVo.bdlistNo})"  
                class="btn btn-round btn-success"> 글쓰기 </button>
                </h4>
                <hr>
                <thead>
                  <tr>
                    <th width="10%"> 번호 </th>
                    <th width="40%"> 제목 </th>
                    <th width="20%"> 조회수 </th>
                    <th width="20%"> 등록일 </th>
                    <th width="10%"></th>
                  </tr> 
                </thead> 
                <tbody>
                 <c:if test="${empty AppList}">
                	<tr> 
                    <td colspan="5">
							<h4><b>
						 	<c:if test="${empty param.AppsearchKeyword}">
							게시판 목록이 없습니다.
		                  	</c:if> 
						 	<c:if test="${!empty param.AppsearchKeyword}">
							검색 결과가 없습니다.
		                  	</c:if> 
							</b></h4>
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
                      <button class="btn btn-primary btn-xs">
                      <i class="fas fa-undo"> 승인 취소 </i></button>
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
						검색 - ${AppPagingInfo.totalRecord} 건</div>
					</div>
					<div class="span6"> 
					 
						<form method="post" name="AppSearch" class="form-inline" role="form">
								<select  id="AppsearchCondition" class="form-control">
										<option value="type_Name" 
										> 제목 </option> 
										<option value="res_Name" 
										> 내용 </option>
										<option value="mem_Name" 
										> 제목+내용 </option>
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
				 <form 
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

	</section>
	<!-- /wrapper -->
</section>


<%@include file="../inc/bottom.jsp"%>
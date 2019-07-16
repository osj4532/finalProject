<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp"%>
<link rel="stylesheet" href="<c:url value='/resources/css/to-do.css'/>" >
<c:set var="mypage" value="useJs"/>
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>

<script type="text/javascript">
	$(function(){
		$("#resplus").hide();
		$("#findPlus").click(function(){
			$("#resplus").toggle(500);   
		}); 
		
		
		$("#insertTypeListPost").submit(function(){
				if(confirm('자원리스트 추가하시겠습니까?')){
					if($("#typeName").val()==''){
						alert("자원명을 입력해주세요");
						event.preventDefault();
					}else{
						var typeName = $("#typeName").val();
						location.href="<c:url value='/resources/restype/write.do?typeName='/>"+typeName;
					}
				}	
		});
		
		
	});
	function delRes(idx){
		alert("자원리스트을 삭제하시겠습니까?");
		if(confirm('정말 삭제하시겠습니까?')){
			location.href="<c:url value='/resources/restype/del.do?typeNo='/>"+idx;
		}		
	};
	function writeRes(idx){
		if(confirm('자원등록하시겠습니까?')){
			window.open(
					"${pageContext.request.contextPath}/resources/resourcesWrite.do?typeNo="+idx,
					"resourceWrite", 
					"left=450, top=150, width=800, height=770, scrollbars=yes,resizable=yes");
		}		
	};
	function editRes(resNo){
		window.open(
				"${pageContext.request.contextPath}/resources//resourcesEdit.do?resNo="+resNo, 
				"resourceWrite", 
				"left=450, top=150, width=800, height=800, scrollbars=yes,resizable=yes");
	};
	function findmap(resNo){
		window.open(
				"${pageContext.request.contextPath}/resources/resourcesMap.do?resNo="+resNo, 
				"resourcesMap", 
				"left=450, top=150, width=800, height=600, scrollbars=yes,resizable=yes");
	};
	function deleteRes(resNo){
		if(confirm('정말 삭제하시겠습니까?')){
			location.href="<c:url value='/resources/resourcesDelete.do?resNo='/>"+resNo;
		}
	};
	function resScheduler(resNo){
		location.href="<c:url value='/resScheduler/resScheduler.do?resNo='/>"+resNo;
	};
	
	 
</script>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 자원 관리 
			<button type="button" id="findPlus" class="btn btn-round btn-info">자원 리스트추가</button>
		</h3>
					<!-- 자원 추가버튼 hide -->
		
		 <div class="row mt" id="resplus">
          <div class="col-lg-12">
            <h4><i class="fa fa-angle-right"></i>자원</h4>
            <div class="form-panel">
            
					<!-- 자원 리스트 -->
			<div class="custom-check goleft">
                <table id="todo" class="table table-hover custom-check">
                  <tbody>
                    <c:forEach  var="RTlist" items="${ResTypelist }">
                    <tr>
                      <td>
                        <span class="check"><input type="checkbox" class="checked"></span>
                        <b>${RTlist.typeName }</b></span>
                        <button class="close" aria-hidden="true" type="button" onclick="delRes(${RTlist.typeNo})">×</button>
                      </td>
                    </tr>
                      </c:forEach>
                  </tbody>
                </table>
              </div>
              <!-- /table-responsive -->
					
					<!-- 자원 리스트 끝 -->
              <form role="form" method="post" 
              	id="insertTypeListPost"
               class="form-horizontal style-form" action="<c:url value='/resources/restype/write.do'/>">
                <div class="form-group has-success">
                  <label class="col-lg-1 control-label">자원 리스트명</label>
                  <div class="col-lg-10">
                    <input type="text" placeholder="" name="typeName" 
                    	id="typeName"
                    class="form-control">
                    <p class="help-block">회사의 자원을 사랑합시다</p>
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-lg-offset-5 col-lg-5">
                    <button class="btn btn-theme" type="submit" >자원 리스트 추가</button>
                  </div>
                </div>
              </form>
            </div>
            <!-- /form-panel -->
          </div>
          <!-- /col-lg-12 -->
        </div>
		
		<!-- SORTABLE TO DO LIST -->
		<c:if test="${empty ResTypelist}">
		<div class="row mt mb">
			<div class="col-md-12">
				<section class="task-panel tasks-widget">
					<div class="panel-heading">
						<div class="pull-left">
							<h5>
								<i class="fa fa-tasks"></i> 등록된 자원이 없습니다
							</h5>
						</div>
						<br>
					</div>
					<div class="panel-body">
						
						<div class=" add-task-row">
						</div>
					</div>
				</section>
			</div>
			<!--/col-md-12 -->
		</div>
		</c:if>
		<c:if test="${!empty ResTypelist }">
		<c:forEach var="i" begin="0" end="${fn:length(ResTypelist)-1 }" >
		    <div class="row mt">
          <div class="col-md-12">
            <div class="content-panel" style="border-radius: 15px;"> 
              <table class="table table-striped table-advance table-hover">
                <h4><i class="fa fa-tasks"></i> ${ResTypelist[i].typeName } 
                
                 <button type="button" class="btn btn-round btn-success"
                  onclick="writeRes(${ResTypelist[i].typeNo})">
                  ${ResTypelist[i].typeName } 자원 추가</button>
                </h4>
                <hr> 
                <thead>
                  <tr>
                    <th><i class="fa fa-bullhorn"></i> 자원명</th>
                    <th class="hidden-phone"><i class="fa fa-question-circle"></i> 자원 정보</th>
                    <th><i class="fa fa-bookmark"></i> 자원 위치</th>
                    <th><i class=" fa fa-edit"></i> 상태 </th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                  <c:if test="${!empty ResList[i] }">
                	<c:forEach var="j" begin="0" end="${fn:length(ResList[i])-1 }" >  
                	<!--자원 반복 -->
                  <tr>
                    <td>
                      <h5><b>${ResList[i][j].resName }</b></h5>
                    </td>
                    <td class="hidden-phone">${ResList[i][j].resInformation }</td>
                    
                    <td>
    				<c:if test="${fn:indexOf(ResList[i][j].resLocation,'!')==0}">                 
	                    ${fn:substringAfter(ResList[i][j].resLocation,'!')}
                    </c:if>
    				<c:if test="${fn:indexOf(ResList[i][j].resLocation,'!')!=0}"> 
    				<button type="button" class="btn btn-default  btn-sm" 
    				onclick="findmap(${ResList[i][j].resNo})">
    				<i class="fas fa-map-marker-alt">
    				</i> 외부 자원(위치확인)</button>
                    </c:if>
                    </td>
                    <td>
              			<c:if test="${ResList[i][j].reservFlag=='N'}">
							<span class="badge bg-theme04">사용중</span>
						</c:if>
						<c:if test="${ResList[i][j].reservFlag=='Y'}">
					 		<span class="badge bg-theme">사용가능</span>
						</c:if>
                    <td>  
                      <button class="btn btn-success btn-xs" onclick="resScheduler(${ResList[i][j].resNo})"><i class="far fa-calendar-alt"></i></button>
                      <button class="btn btn-primary btn-xs" onclick="editRes(${ResList[i][j].resNo})">
                      <i class="fas fa-edit"></i></button>
                      <button class="btn btn-danger btn-xs" onclick="deleteRes(${ResList[i][j].resNo})">
                      <i class="fas fa-trash-alt"></i></button>
                    </td> 
                  </tr> 
                  <!--자원 반복 -->
                   </c:forEach>
                  </c:if>
                   <c:if test="${empty ResList[i] }">
                  	<tr>
                  		<td colspan="5">
							<h4><b>등록된 자원이 없습니다.</b></h4>
					</td>
                  	</tr>
                  </c:if>
                </tbody>
              </table> 
                   
							
            </div>
            <!-- /content-panel -->
          </div>
          <!-- /col-md-12 -->
        </div>
        <!-- /row -->
		</c:forEach>
		</c:if>
		
	</section>
	<!-- /wrapper -->
</section>






<%@include file="../inc/bottom.jsp"%>

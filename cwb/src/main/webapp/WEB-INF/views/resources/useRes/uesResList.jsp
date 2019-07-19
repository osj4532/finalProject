<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../inc/top.jsp"%>
<link rel="stylesheet" href="<c:url value='/resources/css/to-do.css'/>" >
<c:set var="mypage" value="useJs"/>
<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>

<script type="text/javascript">
$(function(){
	$("#MyRes").hide();
	$("#MyResView").click(function(){
		$("#MyRes").toggle(500);   
	}); 
});

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
                <tbody><!-- myUseList -->
                <c:if test="${empty myUseList}">
                	<tr>
                    <td colspan="3">
							<h4><b>사용하신 자원이 없습니다.</b></h4>
					</td>
                  </tr> 
				</c:if>      
				<c:if test="${!empty myUseList}">           
                <c:forEach var="resVo" items="${myUseList}">
                  <tr>
                    <td>
                      	${resVo.typeName }
                    </td> 
                    <td class="hidden-phone">${resVo.resName}</td>
                    <td >${resVo.useRegdate } ~ ${resVo.returnRegdate }</td> 
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
							<h4><b>사용하신 자원이 없습니다.</b></h4>
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
                  <tr>
                    <td>회의실
                    </td>
                    <td class="hidden-phone">다목적실</td>
                    <td>2019-07-20 ~ 2019-07-24</td>
                    <td>
                      <button class="btn btn-danger btn-xs"><i class="fa fa-check">신청 취소</i></button>
                    </td>  
                  </tr>   
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
                  <tr>
                    <td>회의실
                    </td>
                    <td class="hidden-phone">다목적실</td>
                    <td>2019-07-20 ~ 2019-07-24</td>
                    <td>
                      <button class="btn btn-primary btn-xs"><i class="fa fa-check">재검토 신청</i></button>
                    </td>  
                  </tr>    
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

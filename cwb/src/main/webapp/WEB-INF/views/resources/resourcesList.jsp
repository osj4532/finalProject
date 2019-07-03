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
		
		$("#insertTypeList").click(function(){
			if(confirm('자원리스트 추가하시겠습니까?')){
				if($("#typeName").val()==''){
					alert("자원명을 입력해주세요");
				}else{
					var typeName = $("#typeName").val();
					location.href="<c:url value='/resources/restype/write.do?typeName='/>"+typeName;
				}
			}		
		});
		
		
	});
	function delRes(){
		alert("자원리스트을 삭제하시겠습니까?");
		if(confirm('정말 삭제하시겠습니까?')){
			
		}		
	};
	
</script>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<h3>
			<i class="fa fa-angle-right"></i> 자원 관리 
			<button type="button" id="findPlus" class="btn btn-round btn-info">자원 리스트추가</button>
		</h3>
		
		 <div class="row mt" id="resplus">
          <div class="col-lg-12">
            <h4><i class="fa fa-angle-right"></i>자원</h4>
            <div class="form-panel">
					<!-- 자원 리스트 -->
			<div class="custom-check goleft">
                <table id="todo" class="table table-hover custom-check">
                  <tbody>
                    <tr>
                      <td>
                        <span class="check"><input type="checkbox" class="checked"></span>
                        <a href="index.html#">회의실</a></span>
                        <button class="close" aria-hidden="true" type="button" onclick="delRes()">×</button>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /table-responsive -->
					
					<!-- 자원 리스트 끝 -->
              <form role="form" class="form-horizontal style-form">
                <div class="form-group has-success">
                  <label class="col-lg-1 control-label">자원 리스트명</label>
                  <div class="col-lg-10">
                    <input type="text" placeholder="" id="typeName" class="form-control">
                    <p class="help-block">회사의 자원을 사랑합시다</p>
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-lg-offset-5 col-lg-5">
                    <button class="btn btn-theme" type="button" id="insertTypeList">자원 리스트 추가</button>
                  </div>
                </div>
              </form>
            </div>
            <!-- /form-panel -->
          </div>
          <!-- /col-lg-12 -->
        </div>
		
	<!-- 	<div class="row mt">
			<div class="col-md-12">
				<section class="task-panel tasks-widget">
					<div class="panel-heading">
						<div class="pull-left">
							<h5>
								<i class="fa fa-tasks"></i> 회의실
							</h5>
						</div>
						<br>
					</div>
					<div class="panel-body">
						<div class="task-content">
							<ul class="task-list">
								<li>
									<div class="task-checkbox">
										<input type="checkbox" class="list-child" value="" />
									</div>
									<div class="task-title">
										<span class="task-title-sp">Dashio - Admin Panel &
											Front-end Theme</span> <span class="badge bg-theme">Done</span>
										<div class="pull-right hidden-phone">
											<button class="btn btn-success btn-xs">
												<i class=" fa fa-check"></i>
											</button>
											<button class="btn btn-primary btn-xs">
												<i class="fa fa-pencil"></i>
											</button>
											<button class="btn btn-danger btn-xs">
												<i class="fa fa-trash-o "></i>
											</button>
										</div>
									</div>
								</li>
								<li>
									<div class="task-checkbox">
										<input type="checkbox" class="list-child" value="" />
									</div>
									<div class="task-title">
										<span class="task-title-sp">Extensive collection of
											plugins</span> <span class="badge bg-warning">Cool</span>
										<div class="pull-right hidden-phone">
											<button class="btn btn-success btn-xs">
												<i class=" fa fa-check"></i>
											</button>
											<button class="btn btn-primary btn-xs">
												<i class="fa fa-pencil"></i>
											</button>
											<button class="btn btn-danger btn-xs">
												<i class="fa fa-trash-o "></i>
											</button>
										</div>
									</div>
								</li>
								<li>
									<div class="task-checkbox">
										<input type="checkbox" class="list-child" value="" />
									</div>
									<div class="task-title">
										<span class="task-title-sp">Free updates always, no
											extra fees.</span> <span class="badge bg-success">2 Days</span>
										<div class="pull-right hidden-phone">
											<button class="btn btn-success btn-xs">
												<i class=" fa fa-check"></i>
											</button>
											<button class="btn btn-primary btn-xs">
												<i class="fa fa-pencil"></i>
											</button>
											<button class="btn btn-danger btn-xs">
												<i class="fa fa-trash-o "></i>
											</button>
										</div>
									</div>
								</li>
								<li>
									<div class="task-checkbox">
										<input type="checkbox" class="list-child" value="" />
									</div>
									<div class="task-title">
										<span class="task-title-sp">More features coming soon</span> <span
											class="badge bg-info">Tomorrow</span>
										<div class="pull-right hidden-phone">
											<button class="btn btn-success btn-xs">
												<i class=" fa fa-check"></i>
											</button>
											<button class="btn btn-primary btn-xs">
												<i class="fa fa-pencil"></i>
											</button>
											<button class="btn btn-danger btn-xs">
												<i class="fa fa-trash-o "></i>
											</button>
										</div>
									</div>
								</li>
								<li>
									<div class="task-checkbox">
										<input type="checkbox" class="list-child" value="" />
									</div>
									<div class="task-title">
										<span class="task-title-sp">Hey, seriously, you should
											buy this Dashboard</span> <span class="badge bg-important">Now</span>
										<div class="pull-right">
											<button class="btn btn-success btn-xs">
												<i class=" fa fa-check"></i>
											</button>
											<button class="btn btn-primary btn-xs">
												<i class="fa fa-pencil"></i>
											</button>
											<button class="btn btn-danger btn-xs">
												<i class="fa fa-trash-o "></i>
											</button>
										</div>
									</div>
								</li>
							</ul>
						</div>
						<div class=" add-task-row">
							<a class="btn btn-success btn-sm pull-left"
								href="todo_list.html#">Add New Tasks</a> <a
								class="btn btn-default btn-sm pull-right" href="todo_list.html#">See
								All Tasks</a>
						</div>
					</div>
				</section>
			</div>
			/col-md-12
		</div> -->
		<!-- /row -->
		<!-- SORTABLE TO DO LIST -->
		<div class="row mt mb">
			<div class="col-md-12">
				<section class="task-panel tasks-widget">
					<div class="panel-heading">
						<div class="pull-left">
							<h5>
								<i class="fa fa-tasks"></i> 회의실
							</h5>
						</div>
						<br>
					</div>
					<div class="panel-body">
						<div class="task-content">
							<ul id="sortable" class="task-list">
								<li class="list-primary"><i class=" fa fa-ellipsis-v"></i>
									<div class="task-checkbox">
										<input type="checkbox" class="list-child" value="" />
									</div>
									<div class="task-title">
										<span class="task-title-sp">13층 101호 회의실</span>
										 <span class="badge bg-theme">예약완료</span>
										<div class="pull-right hidden-phone">
											<button class="btn btn-success btn-xs fa fa-check"></button>
											<button class="btn btn-primary btn-xs fa fa-pencil"></button>
											<button class="btn btn-danger btn-xs fa fa-trash-o"></button>
										</div>
									</div>
									</li>
							</ul>
						</div>
						<div class=" add-task-row">
							<a class="btn btn-success btn-sm pull-left"
								href="todo_list.html#">회의실 추가</a> <!-- <a
								class="btn btn-default btn-sm pull-right" href="todo_list.html#">See
								All Tasks</a> -->
						</div>
					</div>
				</section>
			</div>
			<!--/col-md-12 -->
		</div>
		<!-- /row -->
	</section>
	<!-- /wrapper -->
</section>






<%@include file="../inc/bottom.jsp"%>

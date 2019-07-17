<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
   <!--footer start-->
    <footer class="site-footer">
      <div class="text-center">
        <p>
          &copy; Copyrights <strong>Dashio</strong>. All Rights Reserved
        </p>
        <div class="credits">
          <!--
            You are NOT allowed to delete the credit link to TemplateMag with free version.
            You can delete the credit link only if you bought the pro version.
            Buy the pro version with working PHP/AJAX contact form: https://templatemag.com/dashio-bootstrap-admin-template/
            Licensing information: https://templatemag.com/license/
          -->
          Created with Dashio template by <a href="https://templatemag.com/">TemplateMag</a>
        </div>
        <a href="index.html#" class="go-top">
          <i class="fa fa-angle-up"></i>
          </a>
      </div>
    </footer>
    <!--footer end  nav-expand.png-->
  </section>
  <!-- js placed at the end of the document so the pages load faster -->
	<c:if test="${mypage!='useJs'}" >
  		<script src="<c:url value='/resources/lib/jquery/jquery.min.js'/>"></script>	
	</c:if>
  <script src="<c:url value='/resources/lib/bootstrap/js/bootstrap.min.js'/>"></script>
  <script class="include" type="text/javascript" src="<c:url value='/resources/lib/jquery.dcjqaccordion.2.7.js'/>"></script>
  <script src="<c:url value='/resources/lib/jquery.scrollTo.min.js'/>"></script>
  <script src="<c:url value='/resources/lib/jquery.nicescroll.js'/>" type="text/javascript"></script>
  <script src="<c:url value='/resources/lib/jquery.sparkline.js'/>"></script>
  <!--common script for all pages-->
  <script src="<c:url value='/resources/lib/common-scripts.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/resources/lib/gritter/js/jquery.gritter.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/resources/lib/gritter-conf.js'/>"></script>
  <!--script for this page-->
  <script src="<c:url value='/resources/lib/sparkline-chart.js'/>"></script>
  <script src="<c:url value='/resources/lib/zabuto_calendar.js'/>"></script>
  
  <script src="<c:url value='/resources/js/companyAddress.js'/>"></script>
  
  <script type="text/javascript">
    $(document).ready(function() {
      var unique_id = $.gritter.add({
        // (string | mandatory) the heading of the notification
        title: 'Welcome to Worker!',
        // (string | mandatory) the text inside the notification
        text: 'Hover me to enable the Close Button. You can hide the left sidebar clicking on the button next to the logo.',
        // (string | optional) the image to display on the left
        image: 'resources/img/ui-sam.jpg',
        // (bool | optional) if you want it to fade out on its own or just sit there
        sticky: false,
        // (int | optional) the time you want it to be alive for before fading out
        time: 8000,
        // (string | optional) the class name you want to apply to that specific message
        class_name: 'my-sticky-class'
      });

      return false;
    });
  </script>
</body>

</html>

<%@ page pageEncoding="utf-8"%>
<div class="row">
	<nav class="navbar-nav navbar navbar-expand-md bg-dark navbar-dark fixed-top justify-content-between">
	  <ul class="navbar-nav">
	  	<li class="nav-item">
	      <a class="nav-link" id="traineeInfoBtn" href="#this">대원 페이지</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" id="downloadExcelBtn" href="#this">출결상황 다운받기</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" id="setSurveyInfoBtn" href="#this">설문조사 내용 설정</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" id="surveyResultBtn" href="#this">설문조사 결과</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" id="changePasswdBtn" href="#this">비밀번호 변경</a>
	    </li>
	  </ul>
	  <div class="navbar-brand">
      	<img src="<c:url value='/images/logo.PNG'/>"/>
      </div>
	</nav>
</div>

<script type="text/javascript">
        $(document).ready(function(){
        	$("#traineeInfoBtn").on("click", function(e){
                e.preventDefault();
                fn_traineeInfo();
            });
        	
            $("#downloadExcelBtn").on("click", function(e){
                e.preventDefault();
                fn_downloadExcel();
            });
             
            $("#setSurveyInfoBtn").on("click", function(e){
                e.preventDefault();
                fn_setSurvey();
            });
            
            $("#surveyResultBtn").on("click", function(e){
                e.preventDefault();
                fn_surveyResult();
            });
            
            $("#changePasswdBtn").on("click", function(e){
                e.preventDefault();
                fn_changePasswd();
            });
        });
            
        function fn_traineeInfo(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sigungu_admin/adminPage.do' />");
            comSubmit.submit();
        }
            
        function fn_downloadExcel(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sigungu_admin/downloadAttendExcel.do' />");
            comSubmit.submit();
        }
         
        function fn_setSurvey(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sigungu_admin/openSurveyPage.do' />");
            comSubmit.submit();
        } 
        
        function fn_surveyResult(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sigungu_admin/resultSurvey.do' />");
            comSubmit.submit();
        }
        
        function fn_changePasswd(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sigungu_admin/changePasswd.do' />");
            comSubmit.submit();
        }
</script>
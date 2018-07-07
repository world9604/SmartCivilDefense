<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</head>
<body style="padding-top:90px">
	<div class="container">
	<%@ include file="/WEB-INF/include/include-header_sigungu_admin.jsp" %>
		<div class="row mx-auto">
			<div class="col-12">
				<table class="table">
					<thead>
						<tr>
							<th class="text-center" colspan="2">설문 기간 / 비밀코드 설정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">설문 기간 설정</th>
		            		<td>
			            		<div class="input-group input-daterange">
								    <input type="text" id="fromDate" class="form-control" value='${survey.start_date}'>
								    <div class="input-group-addon">to</div>
								    <input type="text" id="toDate" class="form-control" value='${survey.end_date}'>
								</div>
							</td>
		            	</tr>
		            	<tr>
		            		<th scope="row">비밀 코드 설정</th>
		            		<td>
							    <input type="text" id="secretCode" class="form-control" value='${survey.secret_code}'>
							</td>
		            	</tr>
		            	<tr>
		            		<th scope="row">비밀 코드 사용 여부</th>
		            		<td>
			            		<div class="form-check form-check-inline">
									<label class="form-check-label">사용&nbsp;</label>
				               		<input type='radio' name="secretCodeUse" id="secretCodeUse_y" value='Y'/>
								</div>
								<div class="form-check form-check-inline">
									<label class="form-check-label">미사용&nbsp;</label>
				               		<input type='radio' name="secretCodeUse" id="secretCodeUse_n" value='N' checked/>
								</div>
							</td>
		            	</tr>
	            	</tbody>
				</table>
				<button class="btn btn-dark mb-5" id="updateSurvey">설정</button>
			</div>
				
			<div class="col-12">
				<table class="table table-striped">
				  <thead>
				  	<tr>
					  	<th colspan="3" style="text-align:center">
					  		설문지 질문 내용 작성
					  	</th>
				  	</tr>
				  </thead>
				  <tbody>
				     	<tr>
				     		<th scope="row">질문</th>
			                <td>
			                	<input type=text name=content id=content style="width:100%"/>
			                </td>
			            </tr>
			            <tr>
			            	<th scope="row">답안</th>
			                <td>
			                	(고정) 매우 그렇다, 그렇다, 보통, 그렇지 않다, 매우 그렇지 않다
			                </td>
			            </tr>
			            <tr>
			                <th scope="row">노출 여부</th>
			                <td>
			                	<span>Yes &nbsp; <input type=radio name=show_yn value='Y' checked/></span>
			                	&emsp;
			                	<span>No &nbsp; <input type=radio name=show_yn value='N'/></span>
			                </td>
		            	</tr>
				  </tbody>
				</table>
				<button class="btn btn-dark mb-5" id="setSurveyBtn">설정</button>
			</div>
		</div>
		
		<div class="row mx-auto mt-5">
			<div class="col-12">
				<table class="table table-striped">
				  <thead>
				    <tr>
				      <th scope="col">질문</th>
				      <th scope="col">등록일자</th>
				      <th scope="col">노출 여부</th>
				      <th scope="col">노출 수정</th>
				    </tr>
				  </thead>
				  <tbody>
				      <c:choose>
				            <c:when test="${fn:length(questionList) > 0}">
				                <c:forEach items="${questionList}" var="question">
					               		<tr>
					                        <td>
					                        	${question.content}
					                        </td>
					                        <td>
					                        	${question.register_date}
					                        </td>
					                        <td>
					                        	${question.show_yn}
					                        </td>
					                        <td>
					                        	<input type="hidden" value='${question.no}' class='questionNo'>
					                        	<a href="#this" class="show_y">Y</a>
					                        	<span>&nbsp;/&nbsp;</span>
					                        	<a href="#this" class="show_n">N</a>
					                        </td>
					                    </tr>
				                </c:forEach>
				            </c:when>
				            <c:otherwise>
				                <tr>
				                    <td colspan="3">조회된 결과가 없습니다.</td>
				                </tr>
				            </c:otherwise>
				        </c:choose>
				  </tbody>
				</table>
			</div>
		</div>
    </div>
    
    
     
    <%@ include file="/WEB-INF/include/include-body.jsp" %>
    <script type="text/javascript">
        $(document).ready(function(){
        	fn_initSecretCodeUse();
        	fn_dateTimePicker();
        	
            $("#setSurveyBtn").on("click", function(e){
                e.preventDefault();
                fn_setSurvey2();
            });
            $("#updateSurvey").on("click", function(e){
                e.preventDefault();
                fn_updateSurvey();
            })
            $(".show_y").on("click", function(e){
                e.preventDefault();
                fn_updateShow_yn($(this));
            })
            $(".show_n").on("click", function(e){
                e.preventDefault();
                fn_updateShow_yn($(this));
            })
        });
        
        function fn_updateShow_yn(param){
        	var comSubmit = new ComSubmit();
  			comSubmit.setUrl("<c:url value='/sigungu_admin/openSurveyPage.do' />");
  			comSubmit.addParam("update_show_yn", param.text());
  			comSubmit.addParam("questionNo", param.closest("td").find("input").val());
  			comSubmit.submit();
        }
        
        function fn_updateSurvey(){
        	var fromDate = $('#fromDate').val(); 
			var toDate = $('#toDate').val();
			var secretCode = $('#secretCode').val(); 
			var secretCodeUse = $("input:radio[name=secretCodeUse]:checked").val();

  			var comSubmit = new ComSubmit();
  			comSubmit.setUrl("<c:url value='/sigungu_admin/openSurveyPage.do' />");
  			comSubmit.addParam("fromDate", fromDate);
  			comSubmit.addParam("toDate", toDate);
  			comSubmit.addParam("secretCode", secretCode);
  			comSubmit.addParam("secretCodeUse", secretCodeUse);
  			comSubmit.submit();
        }
         
        function fn_setSurvey2(){
  			var comSubmit = new ComSubmit();
  			comSubmit.setUrl("<c:url value='/sigungu_admin/openSurveyPage.do' />");
  			comSubmit.addParam("content", $("#content").val());
  			comSubmit.addParam("show_yn", $(":input:radio[name=show_yn]:checked").val());
  			comSubmit.submit();
        }
        
        function fn_callBackResult(data){

        	if(data['successInsert'] == 'y'){
        		alert("성공적으로 등록 되었습니다.");
        	}else {
        		alert("등록에 실패 하였습니다.");
        	}
        	
        }
        
        function fn_dateTimePicker(){
        	/* var fromDate = '${survey.start_date}';
        	var toDate = '${survey.end_date}';
        	
        	if(fromDate != null
        			&& toDate != null
        			&& fromDate != ""
        			&& toDate != ""){
        		$('#fromDate').val(fromDate);
        		$('#toDate').val(toDate);
        	} */
        	
        	$('.input-daterange input').each(function() {
        	    $(this).datepicker({
        	    	format: "yyyy-mm-dd",
        	    	startView: 3,
        	    	language: "kr",
        	    	orientation: "top auto",
        	    	keyboardNavigation: false,
	          		forceParse: false,
	          		autoclose: true,
	          		todayHighlight: true
        	    });
        	});
        }
        
        function fn_initSecretCodeUse(){
        	var secretCodeUse ='${survey.secret_code_use}';
        	
        	if(secretCodeUse != null
        			&& secretCodeUse != ""){
        		if(secretCodeUse == 'Y'){
            		$("#secretCodeUse_y").prop("checked", true);
            	}else if(secretCodeUse == 'N'){
            		$("#secretCodeUse_n").prop("checked", true);
            	}
        	}
        	
        }
    </script>
</body>
</html>
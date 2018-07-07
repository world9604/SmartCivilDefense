<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.small-font{
	font-size: 60%;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/include/include-header2.jsp" %>
	<div class="mt-3 text-center">1-4년차 민방위 대원 설문조사</div>
	<div class="container">
	<div class="col-12">
	<form class="frm">
        <c:choose>
            <c:when test="${fn:length(questionList) > 0}">
                <c:forEach items="${questionList}" var="question">
                	<div class="form-group mt-5">
	                   	<input type="hidden" class="questionNo" value="${question.no}">
	                   	<label for="questionContent">${question.content}</label>
	                </div>
                	<div class="btn-group btn-group-toggle" data-toggle="buttons">
	                	<label class="btn btn-outline-primary active small-font">
	                		<input type='radio' name="${question.no}" autocomplete="off" value='1' checked/>매우그렇다
	                	</label>
	                	
	                	<label class="btn btn-outline-primary small-font">
	                		<input type='radio' name="${question.no}" autocomplete="off" value='2'/>그렇다
	                   	</label>	
	                   	
	                   	<label class="btn btn-outline-primary small-font">
	                   		<input type='radio' name="${question.no}" autocomplete="off" value='3'/>보통
	                   	</label>
	                   	
	                   	<label class="btn btn-outline-primary small-font">
	                   		<input type='radio' name="${question.no}" autocomplete="off" value='4'/>그렇지않다
	                   	</label>
	                   	
	                   	<label class="btn btn-outline-primary small-font">
	                   		<input type='radio' name="${question.no}" autocomplete="off" value='5'/>매우그렇지않다
	                   	</label>
                	</div>
                </c:forEach>
                <button class="btn btn-primary btn-lg mb-3 mt-5 float-right" id="write" >완료</button>
            </c:when>
            <c:otherwise>
               	조회된 결과가 없습니다.
            </c:otherwise>
        </c:choose>
	</form>
	</div>
	</div>
	
	<%@ include file="/WEB-INF/include/include-body.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
       		
			$("#write").on("click", function(e){
				e.preventDefault();
				fn_requestResponseAnswerAjax();
			});
		});
		
		function fn_findResponseAnswerJSON(){
			var surveyResponseArray = new Array();
			
			$.each($(".questionNo"), function(i, e){ 
       			var questionNo = $(e).val();
       			var responseAnswer = $("input:radio[name=" + questionNo + "]:checked").val();
       			var surveyResponse = {};
       			surveyResponse['trainee_no'] = '${traineeNo}';
       			surveyResponse['question_no'] = questionNo;
       			surveyResponse['answer_no'] = responseAnswer;
       			surveyResponseArray.push(surveyResponse);
   			});
			
   			return JSON.stringify(surveyResponseArray);
		}
		
		function fn_redirectCertificate(obj){
			var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/attend/certificateDetail.do'/>");
            comSubmit.addParam('traineeNo', '${traineeNo}');
            comSubmit.submit();
         }
	         
         function fn_requestResponseAnswerAjax(pageNo){
        	 var responseSurvey = fn_findResponseAnswerJSON();
        	 
        	 var comAjax = new ComAjax();
        	 comAjax.setUrl("<c:url value='/attend/insertSurveyResponse.do' />");
        	 comAjax.setCallback(fn_redirectCertificate);
        	 comAjax.addParam(responseSurvey);
        	 comAjax.ajax();
         } 
         
        /*  function fn_selectBoardListCallback(data){
        	 var total = data.TOTAL;
        	 var body = $("table>tbody")
        	 body.empty();
        	 if(total == 0){
        		 var str = "<tr>" + 
        		 				"<td colspan='4'>조회된 결과가 없습니다.</td>" +
       		 			   "</tr>";
 			     body.append(str);
        	 }else{
        		 var params = {
        				divId : "PAGE_NAVI",
        				pageIndex : "PAGE_INDEX",
        				totalCount : total,
        				eventName : "fn_selectBoardList"
        		 };
        		 gfn_renderPaging(params);
        		 
        		 var str = "";
        		 $.each(data.list, function(key, value){
        			 str += "<tr>" + 
        			 			"<td class='title'>" + 
        			 				"<a href='#this' name='QUESTION'>" + value.QUESTION + "</a>" +
        			 				"<input type='hidden' name='NO' id='NO' value=" + value.NO + ">" +
       			 				"</td>" +
       			 				"<td>" + "아주 좋음" + "<input type='radio' name='answer1' value='answer1' />" + "</td>" +
       			 				"<td>" + "좋음" + "<input type='radio' name='answer2' value='answer2' />" + "</td>" + 
   			 					"<td>" + "보통" + "<input type='radio' name='answer3' value='answer3' />" + "</td>" +
       			 				"<td>" + "나쁨" + "<input type='radio' name='answer4' value='answer4' />" + "</td>" +
      			 				"<td>" + "아주 나쁨" + "<input type='radio' name='answer5' value='answer5' />" + "</td>" +
   			 				"</tr>";
        		 });
        		 body.append(str);
        	 }
         } */
         /* 
         
         function fn_renderAnswer(){
        	 var str = "";
        	 var answer = '${ANSWER}';
        	 var question = '${QUESTION}';
    		 $.each(data.list, function(key, value){
    			 str += "<tr>" + 
			    			 "<td class='title'>" + 
				 				"<a href='#this' name='QUESTION'>" + value.QUESTION + "</a>" +
				 				"<input type='hidden' name='NO' id='NO' value=" + value.NO + ">" +
			 				"</td>" +
    			 		"</tr>" + 
    				 	"<tr>" + 
   			 				"<td>" + "아주 좋음" + "<input type='radio' name='answer1' value='answer1' />" + "</td>" +
   			 				"<td>" + "좋음" + "<input type='radio' name='answer2' value='answer2' />" + "</td>" + 
			 					"<td>" + "보통" + "<input type='radio' name='answer3' value='answer3' />" + "</td>" +
   			 				"<td>" + "나쁨" + "<input type='radio' name='answer4' value='answer4' />" + "</td>" +
  			 				"<td>" + "아주 나쁨" + "<input type='radio' name='answer5' value='answer5' />" + "</td>" +
		 				"</tr>";
    		 });
    		 body.append(str);
         } */
	</script>
</body>
</html>
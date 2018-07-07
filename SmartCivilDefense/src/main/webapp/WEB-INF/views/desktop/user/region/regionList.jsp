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
.btn{
    white-space:normal !important;
    word-wrap: break-word; 
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/include/include-header2.jsp" %>
	<%-- <div class="container mb-3">
	<div class="row">
		<div class="col-12 logo">
			<img class="mx-auto d-block mt-3" src="<c:url value='/images/logo.PNG'/>"/>
		</div>
	</div> --%>
	<div class="mt-3 text-center" >소속 지역을 선택해 주세요</div>
	<div class="container">
	<c:choose>
    <c:when test="${fn:length(list) > 0}">
       <c:forEach items="${list}" var="item" varStatus="status">
       	   <c:if test="${ status.count % 3 == 1 }">
       	   		<div class="row mt-4" style="height:100px">
       	   </c:if>
    		<c:choose>	
	    		<c:when test="${fn:length(item.SIDO) > 0}">
	   	   			<button class="col-3 ml-4 btn btn-outline-primary" data-dd="${item.NO}" name="sido" value="${item.SIDO}">
	   	   				${item.SIDO}
	   	   			</button>
	           	</c:when>
	           	<c:otherwise>
		           	<button class="col-3 ml-4 btn btn-outline-primary" data-dd="${item.NO}" name="sigungu">
		           		${item.SIGUNGU}
		           	</button>
	           	</c:otherwise>
           	</c:choose>
           <c:if test="${ status.count % 3 == 0 }">
           		</div>
           </c:if>
       </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="col-12 mt-5 text-center">
        	조회된 결과가 없습니다.
      	</div>
    </c:otherwise>
	</c:choose>
	</div>
	<!-- </div> -->
	 				
	<%@ include file="/WEB-INF/include/include-body.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
			
			$("button[name='sido']").on("click", function(e){
                e.preventDefault();
                fn_goSigunguPage($(this));
            });
			
			$("button[name='sigungu']").on("click", function(e){
                e.preventDefault();
                fn_insertTraineeInfo($(this));
            });

		});
	         
         function fn_goSigunguPage(obj){
             var comSubmit = new ComSubmit();
             comSubmit.setUrl("<c:url value='/region/sigunguList.do' />");
             comSubmit.addParam("region", obj.val());
             comSubmit.submit();
         }
         
         function fn_insertTraineeInfo(obj){
             var comSubmit = new ComSubmit();
             comSubmit.setUrl("<c:url value='/attend/informWrite.do' />");
             comSubmit.addParam("NO", obj.attr("data-dd"));
             comSubmit.submit();
         }
	</script>
</body>
</html>
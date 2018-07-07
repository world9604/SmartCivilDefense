<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<title>Insert title here</title>
</head>
<body>
	<h2>게시판 목록</h2>
	<table class="board_list" style="border:1px solid #ccc">
	    <colgroup>
	        <col width="10%"/>
	        <col width="10%"/>
	        <col width="10%"/>
	        <col width="10%"/>
	        <col width="10%"/>
	    </colgroup>
	    <thead>
	        <tr>
	            <th scope="col">이름</th>
	            <th scope="col">성별</th>
	            <th scope="col">폰넘버</th>
	            <th scope="col">주소</th>
	            <th scope="col">삭제_구분</th>
	        </tr>
	    </thead>
	    <tbody>
	        <%-- <c:choose>
	            <c:when test="${fn:length(list) > 0}">
	                <c:forEach items="${list }" var="row">
	                    <tr>
	                    	<td>
	                    		<a href="#this" name="name">${row.NAME}</a>
	                    		<input type="hidden" id="NAME" value="${row.NAME}">
                    		</td>
	                        <td>${row.SEX }</td>
	                        <td>${row.PHONE}</td>
	                        <td>${row.ADDRESS}</td>
	                        <td>${row.DEL_GB}</td>
	                    </tr>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	                <tr>
	                    <td colspan="4">조회된 결과가 없습니다.</td>
	                </tr>
	            </c:otherwise>
	        </c:choose> --%>
	    </tbody>
	</table>
	
	<div id="PAGE_NAVI"></div>
	<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
	
	<br/>
	<a href="#this" class="btn" id="write">글쓰기</a>
	
	<%@ include file="/WEB-INF/include/include-body.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
			fn_selectBoardList(1);
			
			$("#write").on("click", function(e){ //글쓰기 버튼
				e.preventDefault();
				fn_openBoardWrite();
			});
			
			$("a[name='name']").on("click", function(e){ //제목
				e.preventDefault();
				fn_openBoardDetail($(this));
			});
		});
		
		 function fn_openBoardWrite(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sample/openBoardWrite.do' />");
            comSubmit.submit();
         }
	         
         function fn_openBoardDetail(obj){
             var comSubmit = new ComSubmit();
             comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do' />");
             comSubmit.addParam("NAME", obj.parent().find("#NAME").val());
             comSubmit.submit();
         }
         
         function fn_selectBoardList(pageNo){
        	 var comAjax = new ComAjax();
        	 comAjax.setUrl("<c:url value='/sample/selectBoardList.do' />");
        	 comAjax.setCallback("fn_selectBoardListCallback");
        	 comAjax.addParam("PAGE_INDEX", pageNo);
        	 comAjax.addParam("PAGE_ROW", 15);
        	 comAjax.ajax();
         }
         
         function fn_selectBoardListCallback(data){
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
        			 				"<a href='#this' name='NAME'>" + value.NAME + "</a>" +
        			 				"<input type='hidden' name='NAME' value=" + value.NAME + ">" +
       			 				"</td>" +
       			 				"<td>" + value.SEX + "</td>" +
       			 				"<td>" + value.PHONE + "</td>" + 
   			 					"<td>" + value.ADDRESS + "</td>" +
       			 				"<td>" + value.DEL_GB + "</td>" +
   			 				"</tr>";
        		 });
        		 body.append(str);
        	 }
         }
	</script>
</body>
</html>
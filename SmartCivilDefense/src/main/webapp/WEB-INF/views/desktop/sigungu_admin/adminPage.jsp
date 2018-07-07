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
				<table class="table table-striped frm">
				  <thead>
				    <tr>
				      <th scope="col">이수번호</th>
				      <th scope="col">이름</th>
				      <th scope="col">전화번호</th>
				      <th scope="col">등록일자</th>
				      <th scope="col">생년월일</th>
				      <th scope="col">주소</th>
				      <th scope="col">
				 	   	<button class="btn btn-dark" id="all-delete" value="전체 삭제">전체 삭제</button>
				 	  </th>
				    </tr>
				  </thead>
				  <tbody>
				      <c:choose>
				            <c:when test="${fn:length(trainees) > 0}">
				                <c:forEach items="${trainees}" var="trainee">
					               		<tr>
					               			<th scope="row">${trainee.NO}</th>
					                        <td>
					                        	${trainee.NAME}
					                        </td>
					                        <td>
					                        	${trainee.PHONE}
					                        </td>
					                        <td>
					                        	${trainee.REGISTER_DATE}
					                        </td>
					                        <td>
					                        	${trainee.BIRTH}
					                        </td>
					                        <td>
					                        	${trainee.ADDRESS}
					                        </td>
					                        <td>
					                        	<button class="btn btn-dark delete" value="삭제">삭제</button>
					                        	<input type="hidden" value="${trainee.NO}">
					                        </td>
					                    </tr>
				                </c:forEach>
				            </c:when>
				            <c:otherwise>
				                <tr>
				                    <td colspan="7">조회된 결과가 없습니다.</td>
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
            $(".delete").on("click", function(e){
                e.preventDefault();
                fn_updateTrainee(this);
            });
            
            $("#all-delete").on("click", function(e){
                e.preventDefault();
                fn_updateTrainee(this);
            });
            
        });
         
        function fn_updateTrainee(obj){
        	var whatDelete = $(obj).val();
        	var comSubmit = new ComSubmit();
        	comSubmit.setUrl("<c:url value='/sigungu_admin/adminPage.do' />");
        	
        	if(whatDelete === '삭제'){
        		comSubmit.addParam("deleteType", "personal");
        		comSubmit.addParam("whatDelete", $(obj).parent("td").children("input").val());	
        	}else{
        		comSubmit.addParam("deleteType", "all");
        	}
        	comSubmit.submit();
        }
    </script>
</body>
</html>
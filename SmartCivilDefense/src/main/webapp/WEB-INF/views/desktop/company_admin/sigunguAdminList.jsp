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
		<%@ include file="/WEB-INF/include/include-header_company_admin.jsp" %>
		<div class="row mx-auto">
			<div class="col-12">
				<div class="text-center">
					시/군/구 아이디 목록
				</div>
				<table class="table table-striped mt-2">
				  <thead>
				    <tr>
				      <th scope="col">아이디</th>
				      <th scope="col">패스워드</th>
				      <th scope="col">설문 시작일</th>
				      <th scope="col">설문 마감일</th>
				      <th scope="col">비밀코드</th>
				      <th scope="col">비밀코드 사용</th>
				      <th scope="col">시도</th>
				      <th scope="col">시군구</th>
				      <th scope="col">삭제</th>
				    </tr>
				  </thead>
				  <tbody>
				      <c:choose>
				            <c:when test="${fn:length(sigunguAdminList) > 0}">
				                <c:forEach items="${sigunguAdminList}" var="sigunguAdmin" varStatus="i">
					               		<tr>
					                        <td>
					                        	${sigunguAdmin.ID}
					                        </td>
					                        <td>
					                        	${sigunguAdmin.PASSWD}
					                        </td>
					                        <td>
					                        	${sigunguAdmin.START_DATE}
					                        </td>
					                        <td>
					                        	${sigunguAdmin.END_DATE}
					                        </td>
					                        <td>
					                        	${sigunguAdmin.SECRET_CODE}
					                        </td>
					                        <td>
					                        	${sigunguAdmin.SECRET_CODE_USE}
					                        </td>
					                        <td>
					                        	${zipcodeList[i.index].sido}
					                        </td>
					                        <td>
					                        	${zipcodeList[i.index].sigungu}
					                        </td>
					                        <td>
					                        	<button class="btn btn-dark delete">삭제</button>
					                        	<input type="hidden" value="${sigunguAdmin.no}"/>
					                        </td>
					                    </tr>
				                </c:forEach>
				            </c:when>
				            <c:otherwise>
				                <tr>
				                    <td colspan="4">조회된 결과가 없습니다.</td>
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
        	
            $("#assignSigunguAdminBtn").on("click", function(e){
                e.preventDefault();
                fn_assignSigunguAdmin();
            });
            
            $(".delete").on("click", function(e){
                e.preventDefault();
                fn_deleteSigunguAdmin(this);
            });
            
        });
        
        function fn_assignSigunguAdmin(){
        	var comSubmit = new ComSubmit();
        	comSubmit.setUrl("<c:url value='/company_admin/assignSigunguAdmin.do' />");
        	comSubmit.submit();
        }
        
        function fn_deleteSigunguAdmin(obj){
        	var comSubmit = new ComSubmit();
        	comSubmit.setUrl("<c:url value='/company_admin/sigunguAdminList.do' />");
        	comSubmit.addParam("sigunguAdminNo", $(obj).parent("td").children("input").val());
        	comSubmit.submit();
        }
    </script>
</body>
</html>
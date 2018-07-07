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
				<table class="table table-bordered frm" style="text-align:center;">
				  <thead>
				    <tr>
				      <th scope="col" colspan="4">총 응답자 : ${answerCountList[0].total}</th>
				    </tr>
				  </thead>
				  <tbody>
				      <c:choose>
			            <c:when test="${fn:length(answerCountList) > 0}">
			                <c:forEach items="${answerCountList}" var="answerCount">
			                		<tr class="text-light bg-dark">
		                				<td colspan="4">
				               				${answerCount.content}
				               			</td>
			                		</tr>
				               		<tr>
				               			<td>
				               				1. 매우 그렇다
				               			</td>
				                        <td>
				                        	${answerCount.answer_1}명
				                        </td>
				                        <td>
				                        	${answerCount.answer_1_percent}%
				                        </td>
				                        <td rowspan="2" class="align-middle">
				                        	${answerCount.answer_1_2_percent}%
				                        </td>
				                    </tr>
				                    <tr>
				                        <td>
				               				2. 그렇다
				               			</td>
				                        <td>
				                        	${answerCount.answer_2}명
				                        </td>
				                        <td>
				                        	${answerCount.answer_2_percent}%
				                        </td>
				                    </tr>
				                    <tr>
				                        <td>
				               				3. 보통
				               			</td>
				                        <td>
				                        	${answerCount.answer_3}명
				                        </td>
				                        <td>
				                        	${answerCount.answer_3_percent}%
				                        </td>
				                        <td class="align-middle">
				                        	${answerCount.answer_3_3_percent}%
				                        </td>
				                    </tr>
				                    <tr>
				                        <td>
				               				4. 그렇지 않다
				               			</td>
				                        <td>
				                        	${answerCount.answer_4}명
				                        </td>
				                        <td>
				                        	${answerCount.answer_4_percent}%
				                        </td>
				                        <td rowspan="2" class="align-middle">
				                        	${answerCount.answer_4_5_percent}%
				                        </td>
				                    </tr>
				                    <tr>
				                        <td>
				               				5. 매우 그렇지 않다
				               			</td>
				                        <td>
				                        	${answerCount.answer_5}명
				                        </td>
				                        <td>
				                        	${answerCount.answer_5_percent}%
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
        });
        
    </script>
</body>
</html>
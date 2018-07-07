<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</head>
<body>
	 <table class="board_view">
        <colgroup>
            <col width="15%"/>
            <col width="15%"/>
            <col width="15%"/>
            <col width="15%"/>
            <col width="15%"/>
            <col width="15%"/>
        </colgroup>
        <caption>이수증</caption>
        <tbody>
            <tr>
                <th scope="row">이름</th>
                <td>${trainee.name}</td>
                <th scope="row">생년월일</th>
                <td>${trainee.birth}</td>
            </tr>
            <tr>
            	<th scope="row">이수번호</th>
                <td>${trainee.no}</td>
                <th scope="row">소속</th>
                <td></td>
            </tr>
            <tr>
                <th scope="row">이수일</th>
                <td id="completedDate"></td>
                <th scope="row">발급일</th>
                <td id="issuedDate"></td>
            </tr>
            <tr>
                <th scope="row">발급 시/군/구</th>
            	<td>${sido} ${sigungu}</td>
            </tr>
         </tbody>
      </table>
     
    <a href="#this" class="btn" id="list">직인</a>
    <a href="#this" class="btn" id="update">서초구청</a>
    <a href="#this" class="btn" id="update">%캡처해서 저장하세요</a>
     
    <%@ include file="/WEB-INF/include/include-body.jsp" %>
    <script type="text/javascript">
        $(document).ready(function(){
        	fn_currentDate();
        	
            $("#list").on("click", function(e){ //목록으로 버튼
                e.preventDefault();
                fn_openBoardList();
            });
             
            $("#update").on("click", function(e){
                e.preventDefault();
                fn_openBoardUpdate();
            });
        });
         
        function fn_openBoardList(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
            comSubmit.submit();
        }
         
        function fn_openBoardUpdate(){
            var name = "${map.NAME}";
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sample/openBoardUpdate.do' />");
            comSubmit.addParam("NAME", name);
            comSubmit.submit();
        } 
        
        function fn_currentDate(){
        	var today = new Date();
        	var dd = today.getDate();
        	var mm = today.getMonth()+1; //January is 0!
        	var yyyy = today.getFullYear();

        	if(dd<10) {
        	    dd='0'+dd
        	} 

        	if(mm<10) {
        	    mm='0'+mm
        	} 

        	today = yyyy + '.' + mm + '.' + dd;
        	$('#issuedDate').text(today);
        	$('#completedDate').text(today);
        }
    </script>
</body>
</html>
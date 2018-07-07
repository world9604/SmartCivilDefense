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
        </colgroup>
        <caption>게시글 상세</caption>
        <tbody>
            <tr>
                <th scope="row">이름</th>
                <td>${map.NAME}</td>
                <th scope="row">성별</th>
                <td>${map.SEX}</td>
            </tr>
            <tr>
                <th scope="row">주소</th>
                <td>${map.ADDRESS}</td>
                <th scope="row">폰번호</th>
                <td>${map.PHONE}</td>
            </tr>
            <tr>
                <th scope="row">출결</th>
                <td>20170214</td>
                <th scope="row">좋아요</th>
                <td>10</td>
            </tr>
            <tr>    
                <th scope="row">보통</th>
                <td>5</td>
                <th scope="row">싫어요</th>
                <td>7</td>
            </tr>
        </tbody>
    </table>
     
    <a href="#this" class="btn" id="list">목록으로</a>
    <a href="#this" class="btn" id="update">수정하기</a>
     
    <%@ include file="/WEB-INF/include/include-body.jsp" %>
    <script type="text/javascript">
        $(document).ready(function(){
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
    </script>
</body>
</html>
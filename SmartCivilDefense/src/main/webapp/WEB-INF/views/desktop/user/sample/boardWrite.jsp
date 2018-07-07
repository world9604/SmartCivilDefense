<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
</head>
<body>
	<form id="frm">
		<table class="board_view">
			<colgroup>
				<col width="15%">
				<col width="*"/>
			</colgroup>
			<caption>게시글 작성</caption>
			<tbody>
				<tr>
					<th scope="row">이름</th>
					<td><input type="text" id="NAME" name="NAME" class="wdp_90"></input></td>
				</tr>
				<tr>
					<th scope="row">성별</th>
					<td><input type="text" id="SEX" name="SEX" class="wdp_90"></input></td>
				</tr>
				<tr>
					<th scope="row">폰번호</th>
					<td><input type="text" id="PHONE" name="PHONE" class="wdp_90"></input></td>
				</tr>
				<tr>
					<th scope="row">주소</th>
					<td><input type="text" id="ADDRESS" name="ADDRESS" class="wdp_90"></input></td>
				</tr>
			</tbody>
		</table>
		
		<a href="#this" class="btn" id="write" >작성하기</a>
        <a href="#this" class="btn" id="list" >목록으로</a>
	</form>
	
	<%@ include file="/WEB-INF/include/include-body.jsp" %>
    <script type="text/javascript">
        $(document).ready(function(){
        	 $(document).ready(function(){
        	        $("#list").on("click", function(e){
        	            e.preventDefault();
        	            fn_openBoardList();
        	        });    
        	        $("#write").on("click", function(e){ //작성하기 버튼
        	            e.preventDefault();
        	            fn_insertBoard();
        	        });
        	    });
        	     
        	    function fn_openBoardList(){
        	        var comSubmit = new ComSubmit();
        	        comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
        	        comSubmit.submit();
        	    }
        	    
        	    function fn_insertBoard(){
        	        var comSubmit = new ComSubmit("frm");
        	        comSubmit.setUrl("<c:url value='/sample/insertBoard.do' />");
        	        comSubmit.submit();
        	    }
        });
    </script>
		
</body>
</html>
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
			<caption>1-4년차 민방위 대원 기본 교육 출석</caption>
			<tbody>
				<tr>
					<th scope="row">이름</th>
					<td><input type="text" id="NAME" name="NAME" class="wdp_90"></input></td>
				</tr>
				<tr>
					<th scope="row">생년월일</th>
					<td><input type="text" id="BIRTH" name="BIRTH" class="wdp_90"></input></td>
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
		
		<p>
			개인정보취급동의
			<span>전문 보기</span>
		</p>
		<a href="#this" class="btn" id="write" >출석</a>
	</form>
	
	<%@ include file="/WEB-INF/include/include-body.jsp" %>
    <script type="text/javascript">
        $(document).ready(function(){
      	        $("#write").on("click", function(e){ //작성하기 버튼
      	            e.preventDefault();
      	            fn_insertBoard();
      	        });
        	     
        	    function fn_insertBoard(){
        	        var comSubmit = new ComSubmit("frm");
        	        comSubmit.setUrl("<c:url value='/attend/insertInform.do' />");
        	        comSubmit.addParam("ZIPCODE_NO", '${ZIPCODE_NO}');
        	        comSubmit.submit();
        	    }
        });
    </script>
		
</body>
</html>
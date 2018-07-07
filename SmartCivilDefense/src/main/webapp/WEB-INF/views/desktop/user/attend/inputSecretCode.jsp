<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/include/include-header2.jsp" %>
	<div class="mt-3 text-center">교육 출석을 해주세요</div>
	<div class="col-10 mx-auto">
	<form>
		<div class="form-group mt-3">		
			<label for="name">비밀 코드를 입력해 주세요.</label>
			<input type="text" id="secretCode" class="form-control"></input>
		</div>
		<button type="submit" class="btn btn-primary btn-lg mb-3 float-right" id="write" >입력</button>
	</form>
	</div>
	
<%@ include file="/WEB-INF/include/include-body.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
     $(document).ready(function(){
   	        $("#write").on("click", function(e){
   	            e.preventDefault();
   	         	fn_writeSecretCode();
   	        });
     });
    	     
    function fn_writeSecretCode(){
        var comSubmit = new ComSubmit();
        comSubmit.setUrl("<c:url value='/attend/checkSecretCode.do' />");
        comSubmit.addParam("secretCode", $("#secretCode").val());
        comSubmit.submit();
    }
  	        
</script>
</body>
</html>
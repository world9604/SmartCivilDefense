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
				<form id="frm">
					<div class="form-group row">		
						<label class="col-2" for="id">아이디</label>
						<div class="col-10">
					      <input type="text" readonly class="form-control-plaintext" value="${id}">
					    </div>
					</div>
					<div class="form-group row">		
						<label class="col-2" for="region">지역</label>
						<div class="col-10">
					      <input type="text" readonly class="form-control-plaintext" value="${sido} ${sigungu}">
					    </div>
					</div>
					<div class="form-group">
						<label for="passwd">비밀번호</label>
						<input type="password" id="passwd" name="passwd" class="form-control"></input>
					</div>
					<div class="form-group">
						<label for="passwdCheck">비밀번호 확인</label>
						<input type="password" id="passwdCheck" name="passwdCheck" class="form-control"></input>
					</div>
					<button type="submit" class="btn btn-dark" id="write" >변경</button>
				</form>
			</div>
		</div>
	</div>
     
    
     
    <%@ include file="/WEB-INF/include/include-body.jsp" %>
    <script type="text/javascript">
        $(document).ready(function(){
        	
        	fn_checkResponse();
        	
            $("#write").on("click", function(e){
                e.preventDefault();
                fn_changePasswd();
            });
        });
        
        function fn_checkResponse(){
        	var response = '${response}';
        	if(response != null
        			&& response == 'success'){
        		alert("성공적으로 변경 되었습니다.");
        	}
        }
        
        function fn_changePasswd(){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sigungu_admin/changePasswd.do' />");
            comSubmit.addParam("passwd", $("#passwd").val());
            comSubmit.addParam("passwdCheck", $("#passwdCheck").val());
            comSubmit.submit();
        }
         
    </script>
</body>
</html>
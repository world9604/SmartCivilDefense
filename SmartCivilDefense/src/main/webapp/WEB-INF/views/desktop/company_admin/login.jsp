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
	<div class="container">
	<div class="row">
    	<div class="col-12 text-center mt-3">스마트 민방위 관리자 로그인</div>
    </div>
    <div class="row">
	    <div class="col-4 mx-auto mt-5">
			<form id="frm">
				<div class="form-group">
			        <label for="id">ID</label>
			       	<input type="text" id="ID" name="ID" placeholder="ID" class="form-control"/>
		       	</div>
		       	<div class="form-group">
			    	<label for="passwd">PASSWORD</label>
			       	<input type="password" id="PASSWD" name="PASSWD" placeholder="PASSWORD" class="form-control" />
		       	</div>
		       	<button class="btn btn-dark" id="loginBtn">로그인</button>
		    </form>
	    </div>
    </div>
    </div>
 	 
 	<%@ include file="/WEB-INF/include/include-body.jsp" %>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#loginBtn").on("click", function(e){
                e.preventDefault();
                fn_loginCompanyAdmin();
            });
        });
         
        function fn_loginCompanyAdmin(){
            var comSubmit = new ComSubmit("frm");
            comSubmit.setUrl("<c:url value='/company_admin/loginCheck.do'/>");
            comSubmit.submit();
        }
    </script>
</body>
</html>
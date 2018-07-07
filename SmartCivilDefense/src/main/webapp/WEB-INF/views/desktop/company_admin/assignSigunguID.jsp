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
		<%-- <div class="row">
			<nav class="navbar-nav navbar navbar-expand-md bg-dark navbar-dark fixed-top justify-content-between">
			  <ul class="navbar-nav">
			    <li class="nav-item active">
			      <a class="nav-link" id="sigunguAdminListBtn" href="#this">시군구 어드민 목록</a>
			    </li>
			  </ul>
			  <div class="navbar-brand">
		      	<img src="<c:url value='/images/logo.PNG'/>"/>
		      </div>
			</nav>
		</div> --%>
		<div class="row mx-auto">
			<div class="col-12">
				<div class="row">  
			    <div class="col-12 text-center  mt-3">시/군/구 관리자 아이디 부여</div>
		      </div>
		      <div class="row">  
			      <div class="col-4 mx-auto">
				     <form id="frm" class="mt-5">
					   <div class="form-group">
					     <label for="id">ID</label>
					     <input type="text" class="form-control" id="id" name="id">
					   </div>
					   <div class="form-group">
					     <label for="sidoSigungu">시도 시/군/구</label>
					     <select class="form-control" name="zipcode" id="zipcode">
					   	   <c:forEach items='${list}' var="item">
				             <option value='${item.no}'>${item.sido} ${item.sigungu}</option>
				           </c:forEach>
					     </select>
					  </div>
					  <div class="form-group">
					    <label for="passwd">비밀번호</label>
					    <input type="password" class="form-control" name="passwd" id="passwd" />
					  </div>
					  <div class="form-group">
					    <label for="passwd">비밀번호 확인</label>
					    <input type="password" class="form-control" name="passwdCheck" id="passwdCheck" />
					  </div>
				     </form>
			    	<button class="btn btn-dark" id="write">등록</button>
			      </div>
		      </div>
			</div>
		</div>
	</div>

    
    <%@ include file="/WEB-INF/include/include-body.jsp" %>
    <script type="text/javascript">
        $(document).ready(function(){
        	
        	$("#sigunguAdminListBtn").on("click", function(e){
                e.preventDefault();
                fn_sigunguAdminList();
        	});
        	
            $("#write").on("click", function(e){
                e.preventDefault();

                var params = new Object();
                params['id'] = $("#id").val();
                params['passwd'] = $("#passwd").val();
                params['passwdCheck'] = $("#passwdCheck").val();
                params['zipcode'] = $("#zipcode option:selected").val();
                params = JSON.stringify(params);
                
                fn_enrollSigunguID(params);
            });
             
        });
        
        function fn_sigunguAdminList(){
        	var comSubmit = new ComSubmit();
        	comSubmit.setUrl("<c:url value='/company_admin/sigunguAdminList.do' />");
        	comSubmit.submit();
        }
        
        function fn_enrollSigunguID(params){
        	var comAjax = new ComAjax();
        	comAjax.setUrl("<c:url value='/company_admin/enrollSigunguAdmin.do' />");
            comAjax.addParam(params);
            comAjax.setCallback(fn_callBackResult);
            comAjax.ajax();
        }
        
        function fn_callBackResult(data){
        	
        	if(data['hasId'] == 'y'){
        		alert("이미 등록된 아이디가 있습니다.");
        	}else if(data['notMatch'] == 'y'){
        		alert("비밀번호가 일치 하지 않습니다.");
        	}else{
        		alert("성공적으로 등록 되었습니다.");
        	}
        	
        }
    </script>
</body>
</html>
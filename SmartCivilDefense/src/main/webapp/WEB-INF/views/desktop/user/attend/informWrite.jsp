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
	<form id="frm" novalidate>
		<div class="form-group mt-3">		
			<label for="name">이름</label>
			<input type="text" id="NAME" name="NAME" placeholder="ex: 홍길동" class="form-control" required></input>
			<div class="invalid-feedback" id="nameVal">
	          	이를을 입력해주세요.
	        </div>
		</div>
		<div class="form-group">
			<label for="birth">생년월일</label>
			<input type="text" id="BIRTH" name="BIRTH" placeholder="ex: 19870102" class="form-control" required></input>
			<div class="invalid-feedback" id="birthVal">
	          	생년월일을 입력해주세요.
	        </div>
		</div>
		<div class="form-group">
			<label for="phone">핸드폰 번호</label>
			<input type="text" type="number" min="6" max="6" id="PHONE" name="PHONE" placeholder="ex: 01012345678" class="form-control" required></input>
			<div class="invalid-feedback" id="phoneVal">
	          	핸드폰번호를 입력해주세요.
	        </div>
		</div>
		<div class="form-group">
			<label for="address">주소</label>
			<div class="form-row">
				<div class="col-6">
					<input type="text" id="postcode" placeholder="우편번호" class="form-control" required>
				</div>
				<div class="col-2">
					<button class="btn btn-light" id="findPost">찾기</button>
				</div>
			</div>
			<div class="form-row">
				<div class="col-12">
					<input type="text" id="address" placeholder="주소" class="form-control" required>
				</div>
			</div>
			<div class="form-row">
				<div class="col-12">
					<input type="text" id="address2" placeholder="상세주소" class="form-control">
				</div>
			</div>
			<!-- <input type="text" id="ADDRESS" name="ADDRESS" class="form-control" required></input> -->
		    <small class="form-text text-muted" >
		    	<div class="custom-control custom-checkbox">
				  <input type="checkbox" class="custom-control-input" id="privacyCheck" required>
				  <label class="custom-control-label" for="privacyCheck" style="font-size:90%">
				    	개인정보취급방침 및 이용약관 동의
				    	<a data-toggle="collapse" href="#privacyInfo" aria-expanded="false" aria-controls="collapseExample">[전문보기]</a>
				  </label>
				</div>
				<div class="collapse" id="privacyInfo"></div>
	   		</small>
	    </div>
		<button type="submit" class="btn btn-primary btn-lg mb-3 float-right" id="write" >출석</button>
	</form>
	</div>
	
<%@ include file="/WEB-INF/include/include-body.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
     $(document).ready(function(){
    	 	fn_clickPrivacyInfo();
      	 	
   	        $("#write").on("click", function(e){
   	            e.preventDefault();
   	            
   	            var form = $("#frm")[0]
   	            //유효성 체크
	   	        if (!form.checkValidity()
		           		|| !fn_birthValidate()
		           		|| !fn_phoneValidate()
		           		|| !fn_nameValidate()
		           		|| !fn_addressValidate()
		           		|| !fn_privacyValidate()) {
		             event.preventDefault();
		             event.stopPropagation();
		             fn_birthValidate();
		             fn_phoneValidate();
		             fn_nameValidate();
		             fn_addressValidate();
		             fn_privacyValidate();
	            }else{
	            	fn_clickAttendBtn();
	            }
   	          	
   	        });
   	        
   	        /* $("#privacyInfo").on("click", function(e){
   	        	e.preventDefault();
   	            fn_clickPrivacyInfo();
   	        }) */
   	        
   	        $("#findPost").on("click", function(e){
   	        	e.preventDefault();
   	        	fn_execDaumPostcode();
   	        })
   	     
     });
    	     
    	    function fn_clickAttendBtn(){
    	    	var address = $("#address").val() + " " + $("#address2").val();
    	        var comSubmit = new ComSubmit("frm");
    	        comSubmit.setUrl("<c:url value='/attend/insertInform.do' />");
    	        comSubmit.addParam("ADDRESS", address);
    	        comSubmit.submit();
    	    }
  	        
  	      	function fn_clickPrivacyInfo(){
	   	        var comAjax = new ComAjax();
	   	        comAjax.setUrl("<c:url value='/attend/selectPrivacyInfo.do' />");
	   	        comAjax.setCallback(fn_callBackPrivacyInfo);
	   	        comAjax.ajax();
  	    	}
  	      	
  	      	function fn_callBackPrivacyInfo(data){
  	      		if(!gfn_isNull(data)){
  	      			for(var i=0;i<data['privacyInfo'].length;i++){
  	      				var privacyInfo = data['privacyInfo'][i];
  	      				var title = privacyInfo.TITLE;
  	      				var content = privacyInfo.CONTENT.replace(/\n/g, '<br/>');
  	      				$("#privacyInfo").append('<div class="card"><div class="card-header">' + title + '</div><div class="card-body">' + content + '</div></div>');
  	      			}
  	      		}
  	      	}
  	      	
  	      function fn_birthValidate(){
   	      	var date = $("#BIRTH").val(); 
   	        var y = parseInt(date.substr(0, 4), 10); 
   	        var m = parseInt(date.substr(4, 2), 10); 
   	        var d = parseInt(date.substr(6, 2), 10); 

   	        var dt = new Date(y, m-1, d); 
			var birthVal = $("#birthVal");
			
			if(date.length != 8){
				birthVal.html("길이가 유효하지 않습니다");
		   	        	$("#BIRTH").removeClass("is-valid");
		   	        	$("#BIRTH").addClass('is-invalid');
		   	        	return false;
			}else if(dt.getDate() != d) { 
   	        	birthVal.html("일이 유효하지 않습니다");
   	        	$("#BIRTH").removeClass("is-valid");
   	        	$("#BIRTH").addClass('is-invalid');
   	        	return false;
   	        }else if(dt.getMonth()+1 != m) { 
   	        	birthVal.html("월이 유효하지 않습니다"); 
   	        	$("#BIRTH").removeClass("is-valid");
   	        	$("#BIRTH").addClass('is-invalid');
   	        	return false;
   	        }else if(dt.getFullYear() != y) { 
   	        	birthVal.html("년도가 유효하지 않습니다"); 
   	        	$("#BIRTH").removeClass("is-valid");
   	        	$("#BIRTH").addClass('is-invalid');
   	        	return false;
   	        }else { 
   	        	$("#BIRTH").removeClass("is-invalid");
   	        	$("#BIRTH").addClass('is-valid');
   	        	return true;
	        	} 
	      	}
  	      
  	      function fn_phoneValidate(){
  	      		var regExp = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
  	      	    var phone = $("#PHONE").val();
  	      	    
  	      		if(phone.match(regExp)){
   	      		$("#PHONE").removeClass('is-invalid');
   	      		$("#PHONE").addClass('is-valid');
  	      			return true;
  	      		}
  	      		
	   	      	$("#phoneVal").html("핸드폰 포맷이 맞지 않습니다.");
	   	      	$("#PHONE").removeClass('is-valid');
	   			$("#PHONE").addClass('is-invalid');
  	      		return false;
  	      }
  	      
  	      function fn_nameValidate(){
  	    		var name = $("#NAME").val();
  	    		
  	    		if(name.length == 0 ){
  	    			$("#nameVal").html("이름을 입력해주세요.");
  	    			$("#NAME").removeClass('is-valid');
   	      			$("#NAME").addClass('is-invalid');
  	    			return false;
  	    		}else if(isNumber(name)){
  	    			$("#nameVal").html("한글로 입력해주세요.");
  	    			$("#NAME").removeClass('is-valid');
   	      			$("#NAME").addClass('is-invalid');
  	    			return false;
  	    		}
  	    		$("#NAME").removeClass('is-invalid');
  	      		$("#NAME").addClass('is-valid');
  	      		return true;
  	      }
  	      
  	    function fn_privacyValidate(){
	    		var privacyCheck = $("#privacyCheck").prop("checked");
	    		
	    		if(!privacyCheck){
	    			$("#privacyCheck").removeClass('is-valid');
 	      			$("#privacyCheck").addClass('is-invalid');
	    			return false;
	    		}
	    		
	    		$("#privacyCheck").removeClass('is-invalid');
	      		$("#privacyCheck").addClass('is-valid');
	      		return true;
	      }
  	      
   	    function isNumber(s) {
   	      s += '';
   	      s = s.replace(/^\s*|\s*$/g, ''); // 좌우 공백 제거
   	      if (s == '' || isNaN(s)) return false;
   	      return true;
   	    }
   	    
   	    function fn_addressValidate(){
   	    	if($("#postcode").val().length == 0
   	    			|| $("#address").val().length == 0){
   	    		$("#postcode").removeClass('is-valid');
  	      		$("#postcode").addClass('is-invalid');
  	      		$("#address").removeClass('is-valid');
	      		$("#address").addClass('is-invalid');
	      		return false;
   	    	}
   	    	$("#postcode").removeClass('is-invalid');
      		$("#postcode").addClass('is-valid');
      		$("#address").removeClass('is-invalid');
      		$("#address").addClass('is-valid');
      		return true;
   	    }
   	    
	   	 function fn_execDaumPostcode() {
	         new daum.Postcode({
	             oncomplete: function(data) {
	                 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                 // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                 // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                 var fullAddr = ''; // 최종 주소 변수
	                 var extraAddr = ''; // 조합형 주소 변수
	
	                 // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                 if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                     fullAddr = data.roadAddress;
	
	                 } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                     fullAddr = data.jibunAddress;
	                 }
	
	                 // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                 if(data.userSelectedType === 'R'){
	                     //법정동명이 있을 경우 추가한다.
	                     if(data.bname !== ''){
	                         extraAddr += data.bname;
	                     }
	                     // 건물명이 있을 경우 추가한다.
	                     if(data.buildingName !== ''){
	                         extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                     }
	                     // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                     fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                 }
	
	                 // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                 document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
	                 document.getElementById('address').value = fullAddr;
	
	                 // 커서를 상세주소 필드로 이동한다.
	                 document.getElementById('address2').focus();
	             }
	         }).open();
	     }
</script>
</body>
</html>
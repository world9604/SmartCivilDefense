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
	<%-- <%@ include file="/WEB-INF/include/include-header2.jsp" %>
    <div class="mt-3 text-center">스마트 민방위 교육</div> --%>
    
    <div class="container">
		<div class="row">
			<div class="col-12 logo">
				<img class="mx-auto d-block mt-3" style="width:100px;height:100px" src="<c:url value='/images/mbw_logo5.png'/>"/>
			</div>
		</div>
	</div>
    <div class="card mx-auto" style="width: 90%;" id="card">
	  <div class="card-body">
	    <h5 class="card-title">민방위 교육 이수증</h5>
	    <p class="card-text">
	    	이름 : ${trainee.name}<br/>
	    	생년월일 : ${trainee.birth}<br/>
	    	이수번호 : ${trainee.no}<br/>
	    	<span style="text-decoration: underline;">민방위 교육 이수를 확인합니다.</span>
	    </p>
   		<br/>
   		<div style="display:inline-block;">
     		이수일 : <span id="completedDate"></span><br/>
    		발급일 : <span id="issuedDate"></span>
   		</div>
   		<div style="display:inline-block;margin-left: 5%;">
   			<div style="position: absolute; margin-top:10%; font-size:150%; z-index:2;">${sido} ${sigungu}</div>
   			<c:choose>
			    <c:when test="${sigungu eq '강릉시'}">
					<img style="position: relative; margin-left:40%;" src="/images/gangneung_jigin.png">
			    </c:when>
			    <c:otherwise>
			    	<img style="position: relative; margin-left:40%;" src="/images/jigin.png">
			    </c:otherwise>
			</c:choose>
     	</div>
	  </div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-12">
	    		<a class="btn btn-primary btn-lg float-right mt-2 mr-3 active" aria-pressed="true" id="write">저장</a>
			</div>
		</div>
		<div class="row">
			<div class="col-12 mt-5 text-center" style="font-size:10px">
				@서버제공: 스마트민방위교육
			</div>
		</div>	
	</div>
	
     
    <%@ include file="/WEB-INF/include/include-body.jsp" %>
    <script type="text/javascript">
        $(document).ready(function(){
        	element = $("#card")[0];
        	getCanvas = '';
        	
        	fn_currentDate();
        	fn_captureCertificate();
        	
	        $("#write").on('click', function(){
	        	
	        	alert("캡처 해주세요.");
	        	
	        	//크롬
	       	    //var imageData = getCanvas.toDataURL("image/png");
	       	    //var newData = imageData.replace(/^data:image\/png/, "data:application/octet-stream");
	       	    //$("#write").attr("download", "certificate.png").attr("href", newData);

	       	    //익스플로러
	       	 	//fn_downloadImage(imageData, 'certificate.png');
       		});
       		
        });
        
        function fn_downloadImage(img, fileName) {
        	  var imgData = atob(img.split(',')[1]),
        	    len = imgData.length,
        	    buf = new ArrayBuffer(len),
        	    view = new Uint8Array(buf),
        	    blob, 
        	    i;
        	  
        	  for (i = 0; i < len; i++) {
        	    view[i] = imgData.charCodeAt(i) & 0xff; // masking
        	  }

        	  blob = new Blob([view], {
        	    type: 'application/octet-stream'
        	  });
        	  
        	  if (window.navigator.msSaveOrOpenBlob) {
        	    window.navigator.msSaveOrOpenBlob(blob, fileName);
        	  } else {
        	    //var url = URL.createObjectURL(blob);
        	    var a = document.createElement('a');
        	    a.style = "display: none";
        	    //a.href = url;
        	    a.href = img.src;
        	    a.download = fileName;
        	    document.body.appendChild(a);
        	    a.click();
        	    
        	    setTimeout(function() {
        	      document.body.removeChild(a);
        	      //URL.revokeObjectURL(url);
        	    }, 100);
        	  }
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
        
        function fn_captureCertificate(){
        	html2canvas(element).then( function (canvas) {
        		getCanvas = canvas;
       		});
        }
        
	</script>
</body>
</html>
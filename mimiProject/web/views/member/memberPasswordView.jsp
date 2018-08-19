<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>

<!-- <title>Insert title here</title> -->
<style type="text/css">
	@media ( min-width : 1200px) { /*본문 컨텐츠 가로 조절*/
		.container.join-content{
			max-width: 1000px;
		}
	}
</style>

	<article class="container join-content">
		<h3>비밀번호 찾기</h3>
	    <hr class="margin2">
	    <div class="col-md-6 col-md-offset-3" style="margin-top:80px; margin-bottom: 70px;">   	
	    	<p class="help-block text-left" style="color:#5cb85c; margin-bottom: 60px;">-등록 할 새 비밀번호를 입력해 주세요.</p>	
		  		<div class="form-group">
	              <label for="userpassword">새비밀번호</label>
	              <input type="password" class="form-control" id="userpassword" name="userpassword" maxlength="20" placeholder="비밀번호">
	              <p class="help-block" id="checkpassword"></p>
	            </div>
	            <div class="form-group">
	              <label for="userpassword2">새비밀번호 확인</label>
	              <input type="password" class="form-control" id="userpassword2" maxlength="20" placeholder="비밀번호 확인">
	              <p class="help-block" id="checkpassword2"></p>
	            </div>	
				
				<div class="form-group text-center" style="margin-top: 50px;">
	              <button type="button"  id="updatepassword-btn" class="btn btn-info" style="width:70pt;outline: none">등록<i class="fa fa-check spaceLeft"></i></button>
	            </div>  
	    </div>
	</article>
	
	<script>
		
		var booleanpassword = false;
  		var booleanpassword2 = false;
  		
		$(function(){
			
			$(document).on("blur", "#userpassword", function(){	//비밀번호 입력 input focusout될때
      			
      			if(isValidPassword($("#userpassword").val().trim()) != false){
      				$("#checkpassword").html("생성 가능한 비밀번호입니다.");
      	      		$("#checkpassword").css("color", "#5cb85c");
      	      		booleanpassword = true;
      			}
      			else{
      				$("#checkpassword").html("비밀번호는 6~16자의 영문 소문자, 최소 1개의 숫자 혹은 특수 문자의 조합이 필요합니다.");
      	      		$("#checkpassword").css("color", "#d9534f");	
      	      		booleanpassword = false;
      			}
      		});
      		
      		$(document).on("blur", "#userpassword2", function(){	//비밀번호 확인 입력 input focusout될때
      			if($("#userpassword2").val().trim() === $("#userpassword").val().trim()){
      				if($("#userpassword2").val().trim() === ""){
      					$("#checkpassword2").html("비밀번호를 먼저 입력해주세요.");
          	      		$("#checkpassword2").css("color", "#d9534f");	
          	      		booleanpassword2 = false;
      				}
      				else{
      					$("#checkpassword2").html("비밀번호와 일치합니다.");
      	      			$("#checkpassword2").css("color", "#5cb85c");
      	      			booleanpassword2 = true;
      				}
      				
      			}
      			else{
      				$("#checkpassword2").html("비밀번호와 일치하지 않습니다.");
      	      		$("#checkpassword2").css("color", "#d9534f");	
      	      		$("#userpassword2").val("");
      	      		booleanpassword2 = false;
      			}
      		});
      		
      		$(document).on("click", "#updatepassword-btn", function(){
      			
      			if(booleanpassword === false){
					return false;
				}
		      	if(booleanpassword2 === false){
		      		return false;
		      	}
		      	
		      	$.ajax({
      	       		url : "/mimi/memberupdatepassword",
      	       		type : "post",
      	          	data : {
      	          		"userid" : "<%=request.getParameter("userId")%>",
      	          		"userpassword"	: $("#userpassword").val().trim()
      	          	},
      	          	
      	          	success : function(data){ 
      	            	if(data !== ""){
      	            		alert("새비밀번호 등록에 성공하셨습니다!");  //비밀번호 변경 성공 시 뜨는 메세지
      	            		
      	            		$.ajax({
	      	  	  	       		url : "/mimi/memberlogin",
	      	  	  	       		type : "post",
	      	  	  	          	data : {
	      	  	  	          			"userid" : "<%=request.getParameter("userId")%>",
	      	  	  	          			"userpassword" : $("#userpassword").val().trim()
	      	  	  	          	},
	      	  	  	          	success : function(data){
	      	  	  	      
	      	  	  	          		if(data === "success"){  //아이디,비번 입력 성공시
	      	  	  	          			window.location = "/mimi/index.jsp";//현재 페이지 새로고침
	      	  	  	          		}
	      	  	  	          		else{
	      	  	  	          			alert(data);  //에러 메세지 화면에 보여주기
	      	  	  	          		}
	      	  	  	        	}                     
      	  	  	  			});
      	            	}	
      	            	else{
      	            		alert("새비밀번호 등록에 실패했습니다.");    //에러 메세지   		
      	            	}
      	        	}                     
      	  		});
      		});
		});
		
		function isValidPassword(param){
      		var passwordReg = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,16}$/;
      		
      		if(!passwordReg.test(param)){
      			return false;
      		}
      	}
	</script>









<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
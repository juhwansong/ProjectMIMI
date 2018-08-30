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
	
	form {
		color : #333;
	}
</style>
	
	<article class="container join-content">	
		<h3>비밀번호 찾기</h3>
	    <hr class="margin2">
	    <div class="col-md-6 col-md-offset-3">
	    	<p style="font-size:12px; text-align: left; margin-top:20px; vertical-align:top; color:#aaa">아이디가 기억나지 않으세요?&nbsp;&nbsp;<a id="leave-btn" href="/mimi/views/member/idFindView.jsp">아이디부터 찾기</a></p><br>
	    </div>
	    <div class="col-md-6 col-md-offset-3" style="margin-top:70px; margin-bottom: 50px;">
	    	
	    	<form role="form" name="inputform-box">
		    	<div class="form-group" >
		    	  <p class="help-block text-left" style="color:#5cb85c; margin-bottom: 40px;">-비밀번호를 찾기 위해 이메일 인증이 필요합니다.</p>	
	              <label for="userid">아이디</label>
	              <input type="text" class="form-control" id="userid" name="userid" maxlength="20" value="">
	              <input type="hidden" id="saveuserid" value="">
	            </div>
	            <div class="form-group">
	              <label for="email">본인 확인 이메일</label>
	              <div class="input-group">
	                <input type="email" class="form-control" id="email" maxlength="30" name="email" value="" placeholder="">
	                <input type="hidden" id="saveemail" value="">
	                <span class="input-group-btn">
	                  <button type="button" id="emailcert_btn" class="btn btn-success" style="outline: none">인증번호 전송<i class="fa fa-mail-forward spaceLeft"></i></button>
	                </span>
	              </div>
	              <p id="checkemail" class="help-block"></p>
	            </div>
	            <div class="form-group">
              	<label for="otpnumber">인증번호 입력</label>
              	<input type="text" class="form-control" id="otpnumber" placeholder="인증번호" readonly="readonly">
              	<input type="hidden"  name="h_code" id="h_code" value=""> <!-- 생성한 코드를 저장하기 위한 장소 -->
              	<p id="checkCode" class="help-block"></p>
            	</div>
            	
            	<div class="form-group text-center" style="margin-top: 50px;">
              		<button type="button" id="next-btn" class="btn btn-info" style="width:70pt; outline: none">다음<i class="fa fa-check spaceLeft"></i></button>
            	</div>
            </form>
	    </div>
	    
	</article>
	
	<script>
		var booleanemail = false;
		var booleanotpnumber = false;
		
		$(function(){
			$(document).on("click", "#emailcert_btn", function(){ //인증하기 클릭 시 해당 이메일로 인증번호 전송  
      			
				$.ajax({
      	       		url : "/mimi/memberpasswordfind",
      	       		type : "post",
      	          	data : {
      	          		"email" : $("#email").val().trim(),
      	          		"userid"	: $("#userid").val().trim()	
      	          	},
      	          	
      	          	success : function(data){ 
      	            	if(data !== ""){
      	            		$("#saveemail").val($("#email").val().trim());
      	            		$("#saveuserid").val($("#userid").val().trim());
      	            		
							booleanemail = true;
			      			booleanotpnumber = false; //인증번호 일치한 후 다시 인증하기 버튼을 누를경우
			      			document.getElementById('checkCode').innerHTML = ""; //인증번호 일치한 후 다시 인증하기 버튼을 누를경우
			      			$("#otpnumber").val("");
			      			make_code();
      	            	}
      	            	else{
      	            		$("#checkemail").html("아이디와 이메일이 일치하지 않습니다.");
      	      	      		$("#checkemail").css("color", "#d9534f");  
      	      	      		$("#otpnumber").attr("readonly", "readonly");
      	      	      		$("#checkCode").html("");
      	      	      		$("#otpnumber").val("");
      	      	      		booleanemail = false;            		
      	            	}
      	        	}                     
      	  		});
      			
      			
      		});
      		
      		$(document).on("blur", "#otpnumber",function(){ //인증번호입력칸 포커스 아웃
      			if($("#otpnumber").attr("readonly") === "readonly"){
      				return false;
      			}
      			checkCode();
      		});
      		
      		$(document).on("click", "#next-btn", function(){
      			if(booleanemail === false){
      				return false;
      			}
      			if(booleanotpnumber === false){
      				return false;
      			}
      			
      			$.ajax({
      	       		url : "/mimi/memberpasswordfind",
      	       		type : "post",
      	          	data : {
      	          		"email" : $("#email").val().trim(),
      	          		"userid"	: $("#userid").val().trim()	
      	          	},
      	          	
      	          	success : function(data){ 
      	            	if(data !== "" && $("#saveemail").val().trim() === $("#email").val().trim() && $("#saveuserid").val().trim() === $("#userid").val().trim()){
	      	            	//자바스크립트에서 post 방식으로 보내기
	      	            	//파라미터가 유저 id이기에 post방식
	      	      			var form = document.createElement("form");
	      	      			var input= document.createElement("input");
	      	      			
	      	      			input.setAttribute("type", "hidden");
	      	      			input.setAttribute("name", "userId");
	      	      			input.setAttribute("value", data);
	      	      			form.appendChild(input);

	      	      			form.method = "post";
	      	      			form.action = "/mimi/views/member/memberPasswordView.jsp"; //필요한 정보인 id를 가지고 있으니 바로 뷰로 이동
	      	      			
	      	      			document.body.appendChild(form);
	      	      			form.submit();
      	            	}
      	            	else{
      	            		alert("아이디와 이메일을 다시 확인해 주세요.");         		
      	            	}
      	        	}                     
      	  		});
      		});
		});	
		
		function make_code() {
      		var a_code = Math.floor((Math.random()*(99999-10000+1)))+10000;
      		set_code('h_code', a_code);
      		
      	}

      	function set_code(input_id, val) {
    		
      		document.getElementById(input_id).setAttribute("value", val);
      		$("#checkemail").html("해당 이메일에 인증번호를 발송했습니다.");
      		$("#checkemail").css("color", "#5cb85c");
      		$("#otpnumber").attr("readonly", null);
      		$("#checkCode").html("인증번호를 입력해주세요.(유효시간 30분)");
      		$("#checkCode").css("color", "#5cb85c");
      		mail_send();
      	}
      		
      	function mail_send(){
      	       var sendreceiver = $("#email").val().trim();
      	       var code = $("#h_code").val();

      	       $.ajax({
      	       		url : "/mimi/msendaj",
      	       		type : "post",
      	          	data : {receiver : sendreceiver, code_check : code},
      	          	success : function(data){
      	            	setTimeout(function() {  //일정 시간 지나고 한번 실행되는 함수
      	            		$("#h_code").val(""); //30분 지나면 코드값을 공백으로 바꿈 (공백일땐 처리 안되게 했으니 공백으로 초기화)
      	            		$("#otpnumber").val("");
      	            		$("#otpnumber").attr("readonly", "readonly");
      	            		$("#checkCode").html("유효시간이 끝났습니다.");
      	      	      		$("#checkCode").css("color", "#d9534f");
      	            	}, 1000*60*30); //30분 뒤 실행	
      	        	}                     
      	  		});
		}
      	
      	function checkCode() {
      		var v1 = $("#otpnumber").val().trim(); 
      		var v2 = $("#h_code").val().trim();
      		if (v2 === "" || v1 != v2) {
      			document.getElementById('checkCode').style.color = "#d9534f";
      			document.getElementById('checkCode').innerHTML = "잘못된인증번호";
      			booleanotpnumber = false;
      		} else {
      			document.getElementById('checkCode').style.color = "#5cb85c";
      			document.getElementById('checkCode').innerHTML = "인증되었습니다.";
      			booleanotpnumber = true;
      			$("#checkemail").html("");//인증되었으니 인증번호 보냈다는 문구는 더이상 필요없음. 
      		}
      	}
		
	</script>

<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
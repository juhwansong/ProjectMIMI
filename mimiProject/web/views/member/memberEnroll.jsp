<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>
<title>Insert title here</title>

<style>
@media ( min-width : 1200px) { /*본문 컨텐츠 가로 조절*/
	.container.join-content {
		max-width: 950px;
	}
}
</style>
	
	
	<article class="container join-content">
        <h3>회원가입</h3>
	        <hr class="margin2"><br>
        <div class="col-md-6 col-md-offset-3">
            <div class="form-group">
              <label for="userid">아이디</label>
              <input type="text" class="form-control" id="userid" name="userid" maxlength="20" placeholder="아이디">
              <p class="help-block" id="checkid"></p>
            </div>
            <div class="form-group">
              <label for="userpassword">비밀번호</label>
              <input type="password" class="form-control" id="userpassword" name="userpassword" maxlength="20" placeholder="비밀번호">
              <p class="help-block" id="checkpassword"></p>
            </div>
            <div class="form-group">
              <label for="userpassword2">비밀번호 확인</label>
              <input type="password" class="form-control" id="userpassword2" maxlength="20" placeholder="비밀번호 확인">
              <p class="help-block" id="checkpassword2"></p>
            </div>
            <div class="form-group">
              <label for="username">이름</label>
              <input type="text" class="form-control" id="username" name="username" maxlength="20" placeholder="이름을 입력해 주세요">
              <p class="help-block" id="checkname"></p>
            </div>
            <div class="form-group">
              <label for="nickname">닉네임</label>
              <input type="text" class="form-control" id="nickname" name="nickname" maxlength="20" placeholder="닉네임을 입력해 주세요">
              <p class="help-block" id="checknickname"></p>
            </div>
            <div class="form-group">
              <label for="birthyear">생년월일</label><label for="birthyear" style="font-size: 10pt; color: #888;">&nbsp;(선택)</label>
              <div class="row">
              	<div class="col-sm-4">
              		<input type="text" class="form-control" id="birthyear" name="birthyear" maxlength="4" placeholder="년(4자)">
              	</div>
              	<div class="col-sm-4">
              		<input type="text" class="form-control" id="birthmonth" name="birthmonth" maxlength="2" placeholder="월">
              	</div>
              	<div class="col-sm-4">
              		<input type="text" class="form-control" id="birthday" name="birthday" maxlength="2" placeholder="일">	
              	</div>
              	
              </div>
              <p class="help-block" id="checkbirthdate"></p>
              
              
            </div>
            <div class="form-group">
              <label for="email">본인 확인 이메일</label>
              <div class="input-group">
                <input type="email" class="form-control" id="email" onkeyup="emailEnterKey();" maxlength="30" name="email" placeholder="">
                <input type="hidden" id="saveemail" value="">
                <span class="input-group-btn">
                  <button id="emailcert_btn" type="button" class="btn btn-success" style="outline: none">인증번호 전송<i class="fa fa-mail-forward spaceLeft"></i></button>
                </span>
              </div>
              <p id="checkemail" class="help-block"></p>
            </div>
            <div class="form-group">
              <label for="otpnumber">인증번호 입력</label>
              <input type="text" class="form-control" id="otpnumber" placeholder="인증번호" readonly="readonly" onkeyup="certEnterKey();">
              <input type="hidden"  name="h_code" id="h_code" value=""> <!-- 생성한 코드를 저장하기 위한 장소 -->
              <p id="checkCode" class="help-block"></p>
            </div>
            <div class="form-group">
              <label for="phone">휴대전화</label>
              <input type="tel" class="form-control" id="phone" name="phone" placeholder="" onkeyup="phoneEnterKey();">
              <p id="checkphone" class="help-block"></p>
            </div>
            
            <div class="form-group text-center">
              <button type="button"  id="enroll-btn" class="btn btn-info" style="outline: none">회원가입<i class="fa fa-check spaceLeft"></i></button>
              <button type="button" class="btn btn-warning" onclick="window.history.back();" style="outline: none;">가입취소<i class="fa fa-times spaceLeft"></i></button>
            </div>
        </div>
      </article> 
      
      <script>
      	var booleanid = false;			//submit으로 서블릿으로 넘어가기 전 유효성 검사를 위한 변수 선언
      	var booleanpassword = false;
      	var booleanpassword2 = false;
      	var booleanname = false;
      	var booleannickname = false;
      	var booleanbirthdate = true;
      	var booleanemail = false;
      	var booleanotpnumber = false;
      	var booleanphone = false;
      	
      	$(function(){	
      		
      		$(document).on("blur", "#userid", function(){	//아이디 입력 input focusout될때
      			if($("#userid").val().trim().length > 5 && $("#userid").val().trim().length < 17 && isValidId($("#userid").val().trim())!= false){      				
      	      		//동일한 아이디 있는지 아이작스로 확인
	      	      	$.ajax({
	      	       		url : "/mimi/memberinfocheck",
	      	       		type : "post",
	      	          	data : {"userid" : $("#userid").val().trim()},
	      	          	success : function(data){	      		
	      	            	if(data !== ""){
	      	            		$("#checkid").html("이미 존재하는 아이디가 있습니다.");
	      	      	      		$("#checkid").css("color", "#d9534f");
	      	      	      		booleanid = false;
	      	            	}
	      	            	else{
	      	            		$("#checkid").html("생성 가능한 아이디입니다.");
	      	            		$("#checkid").css("color", "#5cb85c");
	      	            		booleanid = true;
	      	            	}
	      	        	}                     
	      	  		});
      			}
      			else{
      				$("#checkid").html("아이디는 6~16자의 영문 소문자, 숫자만 사용 가능합니다.");
      	      		$("#checkid").css("color", "#d9534f");
      	      		booleanid = false;
      			}
      		});
      		
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
      		
      		$(document).on("blur", "#username", function(){		//이름 입력 input focusout될때
      			
      			if(isValidName($("#username").val().trim()) != false ){
      				$("#checkname").html("");
      				booleanname = true;
      			}
      			else{
      				$("#checkname").html("한글과 영문 대소문만 가능합니다.");
      	      		$("#checkname").css("color", "#d9534f");	
      	      		booleanname = false;
      			}
      		});
      		
      		$(document).on("blur", "#nickname", function(){		//닉네임 입력 input focusout될때
      			
      			if(isValidNickname($("#nickname").val().trim()) != false){
      				//동일한 닉네임 있는지 아이작스로 확인
	      	      	$.ajax({
	      	       		url : "/mimi/memberinfocheck",
	      	       		type : "post",
	      	          	data : {"nickname" : $("#nickname").val().trim()},
	      	          	success : function(data){
		      	        	if(data !== ""){
		      	        		$("#checknickname").html("이미 존재하는 닉네임이 있습니다.");
	      	      	      		$("#checknickname").css("color", "#d9534f");
	      	      	      		booleannickname = false;
	      	            	}
	      	            	else{
	      	            		$("#checknickname").html("사용 가능한 닉네임입니다.");
	      	      				$("#checknickname").css("color", "#5cb85c");	
	      	      				booleannickname = true;
	      	            	}
	      	          	}
	      	  		});
      				
      			}
      			else{
      				$("#checknickname").html("한글과 영문 대소문자와 숫자만 가능합니다.");
      	      		$("#checknickname").css("color", "#d9534f");
      	      		booleannickname = false;
      			}
      		});
      		
      		$(document).on("blur", "#birthyear,#birthmonth,#birthday", function(){
      			if($("#birthmonth").val().trim().length == 1){ //달을 한자리수로 입력했을때  앞에 0을 붙여준다.
      				$("#birthmonth").val("0" + $("#birthmonth").val().trim());
      			}
      			if($("#birthday").val().trim().length == 1){	//일을 한자리수로 입력했을때  앞에 0을 붙여준다.
      				$("#birthday").val("0" + $("#birthday").val().trim());
      			}
      			
      			var inputBirthDate = $("#birthyear").val().trim() + $("#birthmonth").val().trim() + $("#birthday").val().trim();//생년월일 합치기
      			if(inputBirthDate === ""){ //필수 입력정보가 아니기에  공백이면 true
      				$("#checkbirthdate").html("");
      				booleanbirthdate = true;
      			}
      			else if(isValidDate(inputBirthDate) === false){//생년월일 유효성 검사 메소드 이용, return값이 false면 유효하지 않음.
      				$("#checkbirthdate").html("생년월일을 다시 확인해주세요.");
      	      		$("#checkbirthdate").css("color", "#d9534f");
      	      		booleanbirthdate = false;
      			}
      			else{	//유효
      				$("#checkbirthdate").html("");
      				booleanbirthdate = true;
      			}
      			
      		});
      		
      		
      		$(document).on("click", "#emailcert_btn", function(){ //인증하기 클릭 시 해당 이메일로 인증번호 전송  
      			if(isValidEmail($("#email").val().trim()) === false){	//먼저 이메일 유효성 검사 체크
      				$("#checkemail").html("이메일을 다시 확인해주세요.");
      	      		$("#checkemail").css("color", "#d9534f");
      	      		$("#otpnumber").attr("readonly", "readonly");
      	      		$("#otpnumber").val("");
      	      		$("#checkCode").html("");
      	      		booleanemail = false;
      				return false;
      			}
      			
      			$.ajax({
      	       		url : "/mimi/memberinfocheck",
      	       		type : "post",
      	          	data : {"email" : $("#email").val().trim()},
      	          	success : function(data){
      	            	if(data !== ""){
      	            		$("#checkemail").html("이미 존재하는 이메일이 있습니다.");
      	      	      		$("#checkemail").css("color", "#d9534f");  
      	      	      		$("#otpnumber").attr("readonly", "readonly");
      	      	      		booleanemail = false;
      	      	
      	            	}
      	            	else{
      	            		booleanemail = true;
      	        			booleanotpnumber = false; //인증번호 일치한 후 다시 인증하기 버튼을 누를경우
      	        			$("#saveemail").val($("#email").val().trim()); //인증번호까지 무사히 입력 후 이메일을 바꿔치기 할수 있기 때문
      	        			document.getElementById('checkCode').innerHTML = ""; //인증번호 일치한 후 다시 인증하기 버튼을 누를경우
      	        			$("#otpnumber").val("");
      	        			make_code();
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
      		
      		//일반 전화번호(휴대폰 아님) 정규식: /^(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]))(\d{3,4})(\d{4})$/  
      		$(document).on("blur", "#phone", function(){
      			$("#phone").val($("#phone").val().trim().replace(/-/gi, ""));  //입력한 값에 포함된 모든 "-"를 없앰.
      						
      			if(isValidPhone($("#phone").val().trim()) != false){
      				$("#checkphone").html("");
      				booleanphone = true;
      			}
      			else{
      				$("#checkphone").html("전화번호를 다시 확인해주세요.");
      	      		$("#checkphone").css("color", "#d9534f");
      	      		booleanphone = false;
      			}
      		});
      		
			$(document).on("click", "#enroll-btn", function(){	//submit 버튼 누를 시 서블릿으로 넘어가기 전에 유효성 검사
				if(booleanid === false){
					return false;
				}
				if(booleanpassword === false){
					return false;
				}
		      	if(booleanpassword2 === false){
		      		return false;
		      	}
		      	if(booleanname === false){
		      		return false;
		      	}
		      	if(booleannickname === false){
		      		return false;
		      	}
		      	if(booleanbirthdate === false){
		      		return false;
		      	}
		      	if(booleanemail === false){
		      		return false;
		      	}
		      	if(booleanotpnumber === false){
		      		return false;
		      	}
		      	if(booleanphone === false){
		      		return false;
		      	}
		      	if($("#saveemail").val().trim() !== $("#email").val().trim()){
		      		alert("인증한 이메일이 아닙니다.");
		      		return false;
		      	}   	
		      	
		      	$.ajax({
      	       		url : "/mimi/memberenroll",
      	       		type : "post",
      	          	data : {
      	          		"userid" : $("#userid").val().trim(),
      	          		"userpassword"	: $("#userpassword").val().trim(),
      	          		"username"	: $("#username").val().trim(),
      	          		"nickname": $("#nickname").val().trim(),
      	          		"birthyear" : $("#birthyear").val().trim(),
      	          		"birthmonth" : $("#birthmonth").val().trim(),
      	          		"birthday" : $("#birthday").val().trim(),
      	          		"email" : $("#email").val().trim(),
      	          		"phone" : $("#phone").val().trim()
      	          	},
      	          	
      	          	success : function(data){ 
      	            	if(data === "1"){
      	            		alert("회원가입에 성공하셨습니다!");  //회원가입 성공시 뜨는 메시지
	      	            	location.href = "/mimi/index.jsp";      	            	
      	            	}
      	            	else{
      	            		alert(data);    //서블릿에서 가지고 온 에러 메세지   		
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
      	
      	function isValidPhone(param){
      		var phoneReg = /^(?:(010\d{4})|(01[1|6|7|8|9]\d{3,4}))(\d{4})$/; 
      		
      		if(!phoneReg.test(param)){
      			return false;
      		}
      	}
      	
      	function isValidName(param){
      		var nameReg = /^[가-힣|a-z|A-Z|\*]+$/;
      		
      		if(!nameReg.test(param)){
      			return false;	
      		}
      	}
      	
      	function isValidPassword(param){
      		var passwordReg = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,16}$/;
      		
      		if(!passwordReg.test(param)){
      			return false;
      		}
      	}
      	
      	function isValidNickname(param){
      		var nicknameReg = /^[가-힣|a-z|A-Z|0-9|\*]+$/;
      		
      		if(!nicknameReg.test(param)){
      			return false;
      		}
      	}
      	
      	function isValidId(param){
      		var idReg = /^[a-z]+[a-z0-9]/g;
      		
      		if(!idReg.test(param)){
      			return false;
      		}
      	}
      	
      	function isValidEmail(param){		//이메일 유효성 체크
      		var emailReg = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
      		
      		if(!emailReg.test(param)){
      			return false;
      		}
      	}
      	
      	function isValidDate(param) {		//날짜 유효성 체크(윤달 여부 포함)
            try
            {
                param = param.replace(/-/g,'');
     
                // 자리수가 맞지않을때
                if( isNaN(param) || param.length!=8 ) {
                    return false;
                }
                 
                var year = Number(param.substring(0, 4));
                var month = Number(param.substring(4, 6));
                var day = Number(param.substring(6, 8));
     
                var dd = day / 0;
     
                 
                if( month<1 || month>12 ) {
                    return false;
                }
                 
                var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
                var maxDay = maxDaysInMonth[month-1];
                 
                // 윤년 체크
                if( month==2 && ( year%4==0 && year%100!=0 || year%400==0 ) ) {
                    maxDay = 29;
                }
                 
                if( day<=0 || day>maxDay ) {
                    return false;
                }
                return true;
     
            } catch (err) {
                return false;
            }                       
        }
      	
      	function certEnterKey() {
	        if (window.event.keyCode == 13) { 
	            // 엔터키가 눌렸을 때 실행할 내용
	        	if($("#otpnumber").attr("readonly") === "readonly"){
      				return false;
      			}
      			checkCode();
      			
	        	$("#enroll-btn").trigger("click");
	        }
		}
      	
      	function emailEnterKey(){
      		if (window.event.keyCode == 13) { 
	             // 엔터키가 눌렸을 때 실행할 내용
	        	$("#emailcert_btn").trigger("click");
	        }     		
      	}
      	
      	function phoneEnterKey(){
      		if (window.event.keyCode == 13) { 
	             // 엔터키가 눌렸을 때 실행할 내용
      			$("#phone").val($("#phone").val().trim().replace(/-/gi, ""));  //입력한 값에 포함된 모든 "-"를 없앰.
					
      			if(isValidPhone($("#phone").val().trim()) != false){
      				$("#checkphone").html("");
      				booleanphone = true;
      			}
      			else{
      				$("#checkphone").html("전화번호를 다시 확인해주세요.");
      	      		$("#checkphone").css("color", "#d9534f");
      	      		booleanphone = false;
      			}
      			
      			$("#enroll-btn").trigger("click");
	        }  
      	}
      	
      	
      </script>
      
      <%@include file="../../footer.jsp" %> 	
	  <%@include file="../../end.jsp" %> 
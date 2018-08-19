<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%! public int getRandom(){
	int random = 0;
	random = (int)Math.floor((Math.random()*(99999-10000+1)))+10000;
	return random;
} %>  --%>  

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/second/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
function checkCode() {
	var v1 = check_code_form.input_code.value;
	var v2 = $("#h_code").val();
	if (v1 != v2) {
		document.getElementById('checkCode').style.color = "red";
		document.getElementById('checkCode').innerHTML = "잘못된인증번호";
		makeNull();
	} else {
		document.getElementById('checkCode').style.color = "blue";
		document.getElementById('checkCode').innerHTML = "인증되었습니다.";
		makeReal();
	}
}
function makeReal() {
	var emailCert = document.getElementById("#emailcert");
	emailCert.type = "submit";
}
function makeNull() {
	var emailCert = document.getElementById("#emailcert");
	emailCert.type = "hidden";
}

function make_code() {
	var a_code = Math.floor((Math.random()*(99999-10000+1)))+10000;
	alert("버튼" + a_code + "을 누르셨습니다.");
	set_code('h_code', a_code);
}

function set_code(input_id, val) {
	document.check_code_form.reset();
	document.getElementById('checkCode').innerHTML = "";
	document.getElementById(input_id).setAttribute('value', val);
	alert("코드값은" + val + "입니다.");
	makeNull();
	mail_send();
}
	
function mail_send(){
       var sendreceiver = $("#receiver").val();
       var code = $("#h_code").val();

       $.ajax({
          url : "/second/msendaj",
          type : "post",
          data : {receiver : sendreceiver, code_check : code},
          success : function(data){
              console.log(data);
              $("#receiver").html($("#receiver").text() + data);
          }                     
    });
 }

</script>
</head>
<body>
	<table>
		<tr>
			<td><input type='text' id="receiver" name='receiver'  placeholder="이메일을 입력하세요." value="kyi1498@naver.com"></td>
			<td><button onclick="make_code()">ajax체크</button></td>
			<td><input type="hidden"  name="h_code"
			id="h_code" value=""></td>
		</tr>
	</table>
	<br>
	<form name="check_code_form" id ="check_code_form" action="javascript:getPassword()">
		<table>
			<tr>
				<td><span>인증번호</span></td>
				<td><input type="text" name="input_code" id="input_code"
					onkeyup="checkCode()" placeholder="인증번호를 입력하세요.">
				</td>
			</tr>
			<tr>
				<td></td><td><div id="checkCode"></div></td>
			</tr>
		</table>
		<input id = "hi" type="hidden" value='인증하기'/>
		</form>

</body>
</html>
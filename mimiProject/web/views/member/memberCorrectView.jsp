<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>
<%@include file="../../header.jsp" %>
<!-- <title>Insert title here</title> -->

<style type="text/css">
	@media ( min-width : 1200px) { /*본문 컨텐츠 가로 조절*/
		.container.join-content {
			max-width: 950px;
		}
	}
	
	form {
		color : #333;
	}
</style>
	
	
	<article class="container join-content">
	        <h3>내 정보 수정</h3>
	        <hr class="margin2">
        
        <p style="font-size:12px; text-align: right; vertical-align:top; color:#aaa"><a href="#">회원 탈퇴하기</a></p><br>
        <div class="col-md-6 col-md-offset-3">
          <form role="form">
            <div class="form-group">
              <label for="userid">아이디</label>
              <input type="text" class="form-control" id="userid" name="userid" value="user01">
            </div>
            <div class="form-group">
              <label for="userpassword">비밀번호</label>
              <input type="password" class="form-control" id="userpassword" name="userpassword" placeholder="비밀번호">
              <p class="help-block" style="color:#d9534f">6~16자의 영문 소문자,숫자,특수문자의 조합이 필요합니다.</p>
            </div>
            <div class="form-group">
              <label for="userpassword2">비밀번호 확인</label>
              <input type="password" class="form-control" id="userpassword2" placeholder="비밀번호 확인">
              <p class="help-block" style="color:#d9534f">필수 정보입니다.</p>
            </div>
            <div class="form-group">
              <label for="username">이름</label>
              <input type="text" class="form-control" id="username" name="username" value="미미">
            </div>
            <div class="form-group">
              <label for="nickname">닉네임</label>
              <input type="text" class="form-control" id="nickname" name="nickname" placeholder="닉네임을 입력해 주세요">
              <p class="help-block" style="color:#5cb85c">사용 가능한 닉네임입니다.</p>
            </div>
            <div class="form-group">
              <label for="birthyear">생년월일</label>
              <div class="row">
              	<div class="col-sm-4">
              		<input type="text" class="form-control" id="birthyear" name="birthyear" value="1945">
              	</div>
              	<div class="col-sm-4">
              		<input type="text" class="form-control" id="birthmonth" name="birthmonth" value="9월">
              	</div>
              	<div class="col-sm-4">
              		<input type="text" class="form-control" id="birthday" name="birthday" value="16일">
              	</div>
              </div>
              
              
            </div>
            <div class="form-group">
              <label for="email">본인 확인 이메일</label>
              <div class="input-group">
                <input type="email" class="form-control" id="email" name="email" placeholder="">
                <span class="input-group-btn">
                  <button class="btn btn-success" style="outline: none">인증번호 전송<i class="fa fa-mail-forward spaceLeft"></i></button>
                </span>
              </div>
            </div>
            <div class="form-group">
              <label for="otpnumber">인증번호 입력</label>
              <div class="input-group">
                <input type="text" class="form-control" id="otpnumber" placeholder="인증번호">
                <span class="input-group-btn">
                  <button class="btn btn-success" style="outline: none">인증번호 입력<i class="fa fa-edit spaceLeft"></i></button>
                </span>
              </div>
            </div>
            <div class="form-group">
              <label for="phone">휴대전화</label>
              <input type="tel" class="form-control" id="phone" name="phone" placeholder="">
            </div>
            
            <div class="form-group text-center">
              <button type="submit" class="btn btn-info" style="width:70pt; outline: none">수정하기<i class="fa fa-check spaceLeft"></i></button>
              <button type="submit" class="btn btn-warning" style="width:70pt; outline: none">취소<i class="fa fa-times spaceLeft"></i></button>
            </div>
          </form>
        </div>
      </article> 
      
	<%@include file="../../footer.jsp" %> 	
	<%@include file="../../end.jsp" %> 
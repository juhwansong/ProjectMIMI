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
		<h3>아이디 찾기</h3>
	    <hr class="margin2">
	    <div class="col-md-6 col-md-offset-3" style="margin-top:120px; margin-bottom: 70px;">   	
	    	<p class="help-block text-center" style="color:#5cb85c; margin-bottom: 60px;">-고객님의 정보와 일치하는 아이디입니다.</p>	
	    	<div  class="form-group">         
              <label style="margin-left:24%; margin-bottom:20px;">아이디</label>
              <div align="center"> 	
              	<div class="input-group" >         		
              		<input type="text" class="form-control" id="userid" name="userid" style="width:200px;" maxlength="20" readonly="readonly" value="<%=request.getParameter("userId")%>">
              		<button type="button" id="idcopy-btn" style="background:#fff; padding:1px; outline: none;" title="id 복사하기"><img class="btn-img" width=28px src="/mimi/resources/images/icon/icon_copy.png"></button>             	
              	</div>
              </div>	              
            </div>
	  
	    	<div class="form-group text-center" style="margin-top: 110px;">
	    		<button type="button"  id="home-btn" class="btn btn-info" style="width:90pt;outline: none">홈으로<i class="fa fa-check spaceLeft"></i></button>
	    		<button type="button" id="findpassword-btn" class="btn btn-success" style="width:90pt;outline: none;">비밀번호 찾기<i class="fa fa-check spaceLeft"></i></button>         
			</div>	    
	    </div>
	</article>

	

	<script>
		$(function(){
			new Clipboard('#idcopy-btn', {text: function() {
				alert("클립보드에 id가 복사되었습니다.");
			    return $("#userid").val();
			  }
			});
			$(document).on("click", "#home-btn", function(){
				location.href = "/mimi/index.jsp";
			});
			$(document).on("click", "#findpassword-btn", function(){
				location.href = "/mimi/views/member/passwordFindView.jsp";
			});
		});
	</script>


<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
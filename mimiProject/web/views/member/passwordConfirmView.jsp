<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>

<!-- <title>passwordConfirmView</title> -->

<style type="text/css">
	@media ( min-width : 1200px) { /*본문 컨텐츠 가로 조절*/
		.container.join-content {
			max-width: 1000px;
			 
		}
	}   
</style>

	<article class="container join-content">	
        <div class="page-header">
          <h1>내 정보 보기 및 수정</h1>
        </div> 
        <div class="col-md-6 col-md-offset-3">
          <form role="form">
            <div class="form-group" style="margin-top:100px;">
              <p class="help-block text-center" style="color:#d9534f">-내 정보 및 수정 페이지를 보기 위해선 현재 비밀번호 입력이 필요합니다.</p>	
            </div>
            <div class="form-group" align="center" style="margin-top:70px; margin-bottom:35px;">
              <label for="userpassword" style="display:block; outline: none;">비밀번호 확인</label>
              <input type="password" class="form-control" id="userpassword" name="userpassword" placeholder="비밀번호" style="margin-top:20px;width:60%;">
            </div>
            <div class="form-group text-center" style="margin-bottom:150px;">
              <button type="button" id="passwordcheck-btn" class="btn btn-info" style="width:70pt;">확인<i class="fa fa-check spaceLeft"></i></button>        
            </div>
          </form>
        </div>
      </article> 
      
    
    <script>
    	$(function(){
    		$(document).on("click", "#passwordcheck-btn", function(){
    			$.ajax({
      	       		url : "/mimi/memberpasswordcheck",
      	       		type : "post",
      	          	data : {
      	          			"userpassword" : $("#userpassword").val()
      	          	},
      	          	success : function(data){
      	      			if(data === "success"){
      	      				//성공할 시 해당 회원 정보를 가져오는 서블릿으로 이동
      	      				location.href = "/mimi/memberselect";
      	      			}
      	      			else{
      	      				alert(data);  //비밀번호 일치 하지 않을시
      	      			}    	          	    		
      	        	}                     
      	  		});		
    		});   			
    	});
    </script>
      
	<%@include file="../../footer.jsp" %> 	
	<%@include file="../../end.jsp" %> 
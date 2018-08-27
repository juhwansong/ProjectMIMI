<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

<title>MIMI</title>
<!-- 상단에 노출되서 주석처리.. <title>header</title> -->

<style type="text/css">
	
	body {
		padding-top: 120px;
		
	}
	
	#mainNav > a{ 
		display: inline-block; 
	} 
	
	/*메뉴 묶음 박스*/
	#mini-menu-box{
		position:absolute;
		top:26px;
		right: 100px;
		width:50px;
		height:50px;
		
	}
/* 	
	#mini-menu-box > div#menu-box-btn{
		position:absolute;
		top: 0px;	
		left:0%;
		font-size: 50px;
		color: #666;
	}
	
 */		
 
 	/* 크기, 색상, 위치 수정 */
	#mini-menu-box > div#menu-box-btn{
		position:absolute;
		top: 5px;	
		left:10%;
		font-size: 40px;
		color: #888;
	}
	
	/*비회원 메뉴 박스*/
	.menu-box 
	{
		display : none;
		top: 58pt;
		right:-25pt;
		position: absolute;
		width: 260px;
		height: 370px;
		padding: 10px;
		background: white;
		-webkit-border-radius: 0px;
		-moz-border-radius: 0px;
		border-radius: 0px;
		border: #000000 solid 1px;
		box-shadow:0 5px 20px rgba(0, 0, 0, 0.8);
	}
	

	.menu-box:after 
	{
		content: '';
		position: absolute;
		border-style: solid; 
		border-width: 0 16px 20px;
		border-color: white transparent;
		display: block;
		width: 0;
		z-index: 1;
		top: -20px;
		left: 185px;
		
	} 

	.menu-box:before 
	{
		content: '';
		position: absolute;
		border-style: solid;
		border-width: 0 16px 20px;
		border-color: #000000 transparent;
		display: block;
		width: 0;
		z-index: 0;
		top: -21px;
		left: 185px;
		 
	}   
	
	@media (max-width:390px){
		#mini-menu-box{
			/* display:relative; */
			left : 200px!important
		}
	} 
	@media (max-width:355px){
		#song-navbar-toggle{
			left:90px;
			width:75px;
		}	
	}
	@media (max-width: 992px){
		.mini-li-box{
			display: inline-block;
			float: none;
		} 
		#bs-example-navbar-collapse-1{ /*헤더 네비 가운데 정렬*/
			text-align: center; 
		
		} 
	}
	
	.mini-li-box{
		display: inline-block;
		float: none;
	} 
	#bs-example-navbar-collapse-1{ /*헤더 네비 가운데 정렬*/
		text-align: center; 
		
	} 
	
	#menu-box-btn:hover {
		color: #ccc!important;	
	}
	
	@media (min-width: 993px){ 
		#bs-example-navbar-collapse-1{
			top:0px;
		}
	}
		
</style>

	
	<!-- Navigation -->
    <nav id="mainNav" class="navbar navbar-default navbar-fixed-top header-and-footer">
        
        <a href="/mimi/index.jsp"><img style="position: absolute; max-height:50px;max-width:200px; left:5%; top:24px; z-index: 1;" src="/mimi/resources/images/logo/mm_logo_onlytext_red.svg"></a>
        <div class="container" style="position:relative; top:-10px;">
            <!-- Brand and toggle get grouped for better mobile display -->
           
            <div class="navbar-header">
            
                <button id="song-navbar-toggle" type="button"  class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
                </button>
                
                <div style="height:50px;width:0px;"></div><!--세로 크기 줄어들지 않게 하기 위한 투명 박스 -->
            </div>
	
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" >
                <ul class="nav navbar-nav mini-li-box">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li> 
                    <li>
                        <a href="/mimi/noticelist">공지사항</a>
                    </li>
                    <li>
                        <a href="/mimi/adminboardlist">MIMI 리뷰</a>
                    </li>
                    <li>
                        <a href="/mimi/bestboardlist">Best리뷰</a>
                    </li>
                    <li>
                        <a href="/mimi/userboardlist">유저리뷰</a>
                    </li>
                    <li>
                        <a href="/mimi/views/board/nearShop.jsp">주변매장</a>
                    </li>
                    <li>
                        <a href="/mimi/supportlist">고객센터</a>
                    </li>
                    <li>
                        <a href="/mimi/views/intro/information.jsp">사이트소개</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
        <nav id="mini-menu-box">
			<div id="menu-box-btn" class="far fa-user-circle" aria-hidden="true"></div>
			<!-- 로그 아웃상태에서 메뉴 버튼 누를시 -->
			<div class="menu-box">
				<h3 align="center">로그인 및 회원가입</h3>
				<hr style="border: thin 1px black;">
				
				<form role="form" >
            		<div class="form-group" align="center">
              			<input type="text" class="form-control" id="menu-userid" name="menu-userid" style="width:150pt;" maxlength="20" placeholder="아이디 입력">
              		</div>
              		<div class="form-group" align="center">	
              			<input type="password" class="form-control" id="menu-userpassword" name="menu-userpassword" style="width:150pt;" maxlength="20" placeholder="비밀번호 입력">
              		</div>	
              		<div class="form-group">
              			<p class="help-block" align="right" style="color:#d9534f; font-size:12px;"><a href="/mimi/views/member/idFindView.jsp">아이디</a>&nbsp;/&nbsp;<a href="/mimi/views/member/passwordFindView.jsp">비밀번호 찾기</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
              		</div>
              		<div class="form-group" align="center">	
              			<button type="button" id="login-btn" class="btn btn-info" style="width:80%; margin:0px; outline: none;">로그인&nbsp;<i class="fa fa-check spaceLeft"></i></button>		
            		</div>	
            	</form>	
            	<hr style="margin: 0px 1px 10px 1px;">		
            	<div align="center">	
              		<a href="/mimi/views/member/memberEnroll.jsp"><button type="button" class="btn btn-success" style="width:80%; outline: none;">회원가입&nbsp;<i class="fa fa-check spaceLeft"></i></button></a>		
            	</div>
			</div>
		</nav>
    </nav>
    
    <script type="text/javascript">
		$(function(){
			//미니 메뉴 관련 동작 (해당 메뉴를 제외한 위치를 클릭했을때 미니 메뉴 사라짐)
			$(document).on("mouseover", "#menu-box-btn", function(){
				$("#menu-box-btn").css("cursor", "pointer");
			});
			
			
			$(document).on("click", "body", function(event){
				if($(".menu-box").css("display") === "none"){
					if($(event.target).is("#menu-box-btn,#menu-box-btn *")){
						$(".menu-box").slideDown("slow", function() {	
						});	
					}
				}
				else{					
					if(!$(event.target).is(".menu-box,.menu-box *")){
						$(".menu-box").slideUp("slow", function() {	
						});	
					}
				}
			});
			
			//로그인 ajax 이용(실패 했을때 바로 처리를 위해)
			$(document).on("click", "#login-btn", function(){
				$.ajax({
	  	       		url : "/mimi/memberlogin",
	  	       		type : "post",
	  	          	data : {
	  	          			"userid" : $("#menu-userid").val(),
	  	          			"userpassword" : $("#menu-userpassword").val()
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
			});
			
			
		});
	</script>	
	

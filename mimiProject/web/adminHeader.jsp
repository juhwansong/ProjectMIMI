<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>MIMI</title>
<!-- <title>adminHeader</title> -->

<style type="text/css">
	
	body {
		padding-top: 120px;
		
	}
	
	.admin-menu-box span, #mainNav > a  { 
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
	
/* 	#mini-menu-box > div#menu-box-btn{
		position:absolute;
		top: 0px;	
		left:0%;
		font-size: 50px;
		color: #666;
	} */
	
	/* 크기, 위치, 색상 수정 */
	#mini-menu-box > div#menu-box-btn{
		position:absolute;
		top: 8px;	
		left:15%;
		font-size: 35px;
		color: #888;
	}
	
	/*관리자 메뉴 박스*/
	.admin-menu-box 
	{
		display : none;
		top: 58pt;
		right:-29pt;
		position: absolute;
		width: 260px;
		height: 350px;
		padding: 10px;
		background: white;
		-webkit-border-radius: 0px;
		-moz-border-radius: 0px;
		border-radius: 0px;
		border: #000000 solid 1px;
		box-shadow:0 5px 20px rgba(0, 0, 0, 0.8);
	}

	.admin-menu-box:after 
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

	.admin-menu-box:before 
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
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav mini-li-box">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li> 
                    <li>
                        <a  href="/mimi/noticelist">공지사항</a>
                    </li>
                    <li>
                        <a  href="/mimi/adminboardlist">MIMI 리뷰</a>
                    </li>
                    <li>
                        <a  href="/mimi/views/bestReview/bestReviewList.jsp">Best리뷰</a>
                    </li>
                    <li>
                        <a  href="/mimi/userboardlist">유저리뷰</a>
                    </li>
                    <li>
                        <a  href="/mimi/views/board/nearShop.jsp">주변매장</a>
                    </li>
                    <li>
                        <a  href="/mimi/views/member/customer.jsp">고객센터</a>
                    </li>
                    <li>
                        <a  href="/mimi/views/intro/information.jsp">사이트소개</a>
                    </li>
                     <li>
                        <a href="/mimi/testlist">테스트페이지</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
        <nav id="mini-menu-box">
			<div id="menu-box-btn" class="fas fa-cogs" aria-hidden="true"></div>
			<!-- 관리자 로그인 상태에서 메뉴 버튼 누를시 -->
			<div class="admin-menu-box">
				<div>
					<p id="menu-gradename" align="center" style="margin:0px;font-size:7pt;"></p>
					<p id="menu-nickname" align="center" style="margin:0px;"></p>
					<p id="menu-userid" align="center" style="font-size:7pt;"><%=session.getAttribute("userId") %></p>
				</div>
				<div align="center">
					<a href="/mimi/memberlogout">로그아웃</a>
				</div>
				<hr style="border: thin 1px black;">
			
				<div style="padding-top:20px;" align="center">	
					<span style="width:100px;">	
						<!-- <a href="/mimi/views/board/myContent.jsp"> -->
						<a href="/mimi/myboardlist?attr=NICKNAME&nickName=<%=session.getAttribute("nickName")%>">
							<div>
								<p style="font-size:25pt;" class="far fa-file-alt" aria-hidden="true"></p>
								<p>작성한 글</p>	
							</div>
						</a>
					</span>			
					<span style="width:100px;">	
						<!-- <a href="/mimi/views/board/myComment.jsp"> -->
						<a href="/mimi/mycommentlist?attr=NICKNAME&nickName=<%=session.getAttribute("nickName")%>">
							<div>
								<p style="font-size:25pt;" class="far fa-comments" aria-hidden="true"></p>
								<p>작성한 댓글</p>	
							</div>
						</a>
					</span>
				</div>
			
				<div style="padding-top:20px;" align="center">	
					<span style="width:100px;">
						<a href="/mimi/bookmarklist">
							<div>
								<p style="font-size:25pt;" class="fas fa-map-marker-alt" aria-hidden="true"></p>
								<p>즐겨찾기</p>
							</div>
						</a>
					</span>
					<span style="width:100px;">	
						<a href="/mimi/views/admin/adminPage.jsp">
							<div>
								<p style="font-size:25pt;" class="fas fa-cog" aria-hidden="true"></p>
								<p>관리자페이지</p>
							</div>
						</a>
					</span>
				</div>  
			</div>
		</nav>
    </nav>
   
    <script type="text/javascript">
		$(function(){
			//화면 로딩 시 바로 ajax 통해서 회원 닉네임, 등급이름 가져온다.
			$.ajax({
	      		url : "/mimi/membermenuinfo",
	      		type : "post",
	      		success : function(data){
	      			var json = data;
	      			$("#menu-gradename").html(decodeURI(json.gradeName));
	      			$("#menu-nickname").html(decodeURI(json.nickName));
	      		}
	      	});
			
			
			$(document).on("mouseover", "#menu-box-btn", function(){
				$("#menu-box-btn").css("cursor", "pointer");
			});
			
			
			$(document).on("click", "body", function(event){
				if($(".admin-menu-box").css("display") === "none"){
					if($(event.target).is("#menu-box-btn,#menu-box-btn *")){
						$(".admin-menu-box").slideDown("slow", function() {	
						});	
					}
				}
				else{					
					if(!$(event.target).is(".admin-menu-box,.admin-menu-box *")){
						$(".admin-menu-box").slideUp("slow", function() {	
						});	
					}
				}
			});	
			
			
			
		});
	</script>
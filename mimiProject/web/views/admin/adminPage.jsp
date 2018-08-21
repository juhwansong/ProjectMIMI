<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>


<!-- ----------- -->
<!-- <title>adminPage</title> -->
<style type="text/css">
/* 	h1 { border-bottom: 1px solid rgba(0,0,0,1); }

	#menuTitle { 
		margin-bottom: 30px;
		width: 250px;
	} */
	
	#main {
		width: 50%;
	}
	
	#img { 
		width: 50px; 
		height: 50px;
		margin-top: 20px;
		opacity: .75;
	}
	
	.thumbnail {
		/* width: 100%; */
		height: 20%;
		text-align: center;
		color: #f2f2f2;
	}
	
	h3, h4 {
		color: #555;
	}
</style>


<div class="container" id="main" style="width:1150px;">
	<div id="menuTitle">
		<h3>관리자 메뉴</h3>
	</div>
	<hr>
	<div class="row">
		<div class="col-sm-6 col-md-4">
		    <div class="thumbnail" style="cursor: pointer;" onclick="location.href='/mimi/customerlist'">
		    	<img src="../../resources/images/admin/address-card-solid.svg" id="img" alt="회원정보 관리">
			    <div class="caption">
			        <h4>전체 회원 관리</h4>
		    	</div>
	    	</div>
	  	</div>
	  	<div class="col-sm-6 col-md-4">
	    	<!-- <div class="thumbnail" style="cursor: pointer;" onclick="location.href='contentManage.jsp'"> -->
	    	<div class="thumbnail" style="cursor: pointer;" onclick="location.href='/mimi/allboardlist'">
	      		<img src="../../resources/images/admin/align-left-solid.svg" id="img" alt="게시물 관리">
	      		<div class="caption">
	        		<h4>전체 게시물 관리</h4>
	      		</div>
	    	</div>
	  	</div>
	  	<div class="col-sm-6 col-md-4">
	    	<!-- <div class="thumbnail" style="cursor: pointer;" onclick="location.href='commentManage.jsp'"> -->
	    	<div class="thumbnail" style="cursor: pointer;" onclick="location.href='/mimi/allcommentlist'">
	      		<img src="../../resources/images/admin/comments-solid.svg" id="img" alt="댓글 관리">
	      		<div class="caption">
	        		<h4>전체 댓글 관리</h4>
	      		</div>
	    	</div>
	  	</div>
	</div>
</div>

<!-- ------------------------------------------------ -->
<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %>
<!-- ------------------------------------------------ -->
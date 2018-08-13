<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="head.jsp" %> 
<%-- <%@include file="header.jsp" %> --%>
<%-- <%@include file="memberHeader.jsp" %> --%>
<%@include file="adminHeader.jsp" %>

<title>MIMI</title>

<style type="text/css">
	/*중앙 검색 라인*/
	.form-inline{
		position: absolute;
		bottom: 45%;
		width: 100%;
		min-width:1150px; /* 추가, 게시판 너비 맞추기용*/
		z-index: 100;
		background: rgba(0,0,0,.7);
		padding: 50px;
		opacity: .8;
	}
</style>

	
	
<!-- 이미지 슬라이드 -->
<div class="carousel slide" id="myCarousel" data-ride="carousel"  style="position:relative; min-width:1150px;"> 
	<!-- 검색 -->
	<div class="form-inline">
		<form name="select-category" id="select-category" method="get" action="#"
		 style="display: flex; justify-content: center;">
			<div class="form-group">
				<select class="form-control" style="border-radius: 5px 0 0 5px; padding: 3px; height: 35px;">
					<option value="" selected disabled hidden>Category</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
				</select>
			</div>
			<div class="form-group">
		 		<input type="text" class="form-control" name="search-text" id="search-text" size="30" placeholder="검색할 키워드를 입력하세요" style="border-radius: 0 5px 5px 0; padding: 2px; height: 35px;">
		​​​​​​​  		<button type="button" class="btn" name="btn" style="outline: none;">Search&nbsp;<i class="fas fa-search"></i></button>
			</div>
		</form>
	</div>
	<!-- /검색 -->	
	<!-- 하단 리스트 -->
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
		<li data-target="#myCarousel" data-slide-to="3"></li>
		<li data-target="#myCarousel" data-slide-to="4"></li>
	</ol>

	<div class="carousel-inner">
		<div class="item active"> 
			<img src="/mimi/resources/images/main/img3.jpg" style="width:100%" alt="">
			<div class="container">
				<div class="carousel-caption">
				</div>
			</div>
		</div>
		<div class="item"> 
			<img src="/mimi/resources/images/main/img1.jpg" style="width:100%" alt="">
			<div class="container">
				<div class="carousel-caption">
				</div>
			</div>
		</div>
		<div class="item"> 
			<img src="/mimi/resources/images/main/img4.jpg" style="width:100%" alt="">
			<div class="container">
				<div class="carousel-caption">
				</div>
			</div>
		</div>
		<div class="item"> 
			<img src="/mimi/resources/images/main/img6.jpg" style="width:100%" alt="">
			<div class="container">
				<div class="carousel-caption">
				</div>
			</div>
		</div>
		<div class="item"> 
			<img src="/mimi/resources/images/main/img2.jpg" style="width:100%" alt="">
			<div class="container">
				<div class="carousel-caption">
				</div>
			</div>
		</div>
	</div>
	<!-- 좌우 버튼 -->
	<!-- 
	<a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a> 
	<a class="right carousel-control" href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
	-->
</div>
<!-- test -->
<!-- /이미지 슬라이드 -->
<%@include file="footer.jsp" %> 
<%@include file="end.jsp" %> 
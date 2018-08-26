<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>
<%-- <%@include file="../../header.jsp" %> --%>
<%@include file="../../memberHeader.jsp" %>
<%-- <%@include file="../../adminHeader.jsp" %> --%> 

<div class="container" style="width:1150px;">


<!-- 이미지 슬라이드 -->
<div class="carousel slide" id="myCarousel" data-ride="carousel" style="padding: 5px 10px;">
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
		<div class="img-div2">
			<a href="#"><img src="/mimi/resources/images/main/img3.jpg" class="img2" alt=""></a></div>
			<div class="container carousel-caption">
				</div> 
		</div>
		<div class="item">
		<div class="img-div2">
			<a href="#"><img src="/mimi/resources/images/main/img1.jpg" class="img2" alt=""></a></div>
			<div class="container carousel-caption">
				</div> 
		</div>
		<div class="item">
		<div class="img-div2">
			<a href="#"><img src="/mimi/resources/images/main/img4.jpg" class="img2" alt=""></a></div>
			<div class="container carousel-caption">
				</div> 
		</div>
		<div class="item">
		<div class="img-div2">
			<a href="#"><img src="/mimi/resources/images/main/img6.jpg" class="img2" alt=""></a></div>
			<div class="container carousel-caption">
				</div> 
		</div>
		<div class="item">
		<div class="img-div2">
			<a href="#"><img src="/mimi/resources/images/main/img2.jpg" class="img2" alt=""></a></div>
			<div class="container carousel-caption">
				</div> 
		</div>
	</div>
</div>

<!-- /이미지 슬라이드 -->

	<table style="width:100%; border:0;">
		<tr>
			<td><h3>공지사항</h3></td>
			<td style="text-align: right; vertical-align:bottom; color:#777">
				<!-- 카테고리 -->
				<form class="form-inline" name="select-category" id="select-category" method="get" action="#">
					<div class="form-group" style="float: right; margin:3px;">
						<input type="text" class="form-control" name="search-text" id="search-text" size="12" placeholder=" ">
				​​​​​​​  		<button type="button" class="btn" name="btn" style="outline: none">검색&nbsp;<i class="fas fa-search"></i>
			</button>
					</div>
				</form>
			</td>
		</tr>
	</table>
<!-- 게시글 -->
<hr class="margin2">
<table class="table table-hover" id="table-css">
	<thead>
	<tr>
		<th width="12%">글번호</th><th width="30%">제목</th><th width="16%"><i class="fas fa-pen"></i>작성자</th><th width="16%"><i class="far fa-calendar"></i>작성일</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><a href="noticeView.jsp">Title</a><!-- 제목 --></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><a href="noticeView.jsp">Title</a><!-- 제목 --></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><a href="noticeView.jsp">Title</a><!-- 제목 --></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><a href="noticeView.jsp">Title</a><!-- 제목 --></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><a href="noticeView.jsp">Title</a><!-- 제목 --></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><a href="noticeView.jsp">Title</a><!-- 제목 --></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	</tbody>
</table>


<!-- /게시글 -->
<hr class="margin1" style="margin: 0px auto 5px auto;">

<table style="width:100%">
	<tr>
		<td width="10%"></td><!-- 빈칸 -->
		<td width="*"><!-- 페이지 -->
	<!-- Pagination -->
		<ul class="pagination" style="float: center; display: flex; justify-content: center;">
			<li>
				<a href="#" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
				<span class="sr-only">Previous</span>
				</a>
			</li>
			<li>
				<a href="#">1</a>
			</li>
			<li>
				<a href="#">2</a>
			</li>
			<li>
				<a href="#">3</a>
			</li>
			<li>
				<a href="#" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
				<span class="sr-only">Next</span>
				</a>
			</li>
		</ul>	
	</td>
		<!-- 글쓰기버튼 -->
		<td width="10%" style="vertical-align:top;">
						<input type="button" class="btn btn-default pull-right"
			onClick="location.href='/mimi/views/notice/noticeWrite.jsp'"
			value="글쓰기" style="outline: none;"></td>
	</tr>
</table>
</div><!-- /container -->


<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
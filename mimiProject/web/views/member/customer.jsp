<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%@include file="../../head.jsp"%>
<!-- ----------- -->

<!-- <title>adminPage</title> -->
<style>

#td-title{
	text-align: left;
	font-size: 15px;
}
/* 
@media screen and (max-width: 700px) {
	table, tr, td {
		display: block;
	}
} */
</style>
<!-- ------------------------------------------------ -->

<div class="container" style="width:1150px;">

<!-- 상단 이미지 -->
	<div class="img-div2" style="padding: 5px 10px;">
		<a href="#"><img src="/mimi/resources/images/intro/mimi_service_header.jpg" class="img2" alt=""></a>
	</div>


<!-- 게시판 시작 -->
	<table style="width: 100%; border: 0;">
		<tr>
			<td><h3>고객센터</h3></td>
			<td style="text-align: right; vertical-align: bottom; color: #777">
				<!-- 카테고리 -->
				<form class="form-inline" name="select-category"
					id="select-category" method="get" action="#">
					<div class="form-group" style="float: right; margin: 3px;">
						<input type="text" class="form-control" name="search-text"
							id="search-text" size="12" placeholder=" ">​​​​​​​
						<button type="button" class="btn" name="btn" style="outline: none">
							검색&nbsp;<i class="fas fa-search"></i>
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
			<th width="8%">글번호</th>
			<th width="10%">종류</th>
			<th width="10%">처리상태</th>
			<th width="*">제목</th>
			<th width="12%">작성자</th>
			<th width="12%">작성일</th>
		</tr>
		</thead>
		<tbody>
			<tr>
				<td>110</td>
				<td>문의</td>
				<td>검토중</td>
				<td id="td-title"><a href="#">Title</a></td>
				<td>user11</td>
				<td>18.08.01 12:00</td>
			</tr>
			<tr>
				<td>110</td>
				<td>문의</td>
				<td>검토중</td>
				<td id="td-title"><a href="#">Title</a></td>
				<td>user11</td>
				<td>18.08.01 12:00</td>
			</tr>
			<tr>
				<td>110</td>
				<td>문의</td>
				<td>검토중</td>
				<td id="td-title"><a href="#">Title</a></td>
				<td>user11</td>
				<td>18.08.01 12:00</td>
			</tr>
			<tr>
				<td>110</td>
				<td>문의</td>
				<td>검토중</td>
				<td id="td-title"><a href="#">Title</a></td>
				<td>user11</td>
				<td>18.08.01 12:00</td>
			</tr>
		</tbody>
	</table>


<hr class="margin1" style="margin: 0px 0 5px 0;">

<table style="width:100%;">
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
			onClick="location.href='/mimi/views/member/cwritepage.jsp'"
			value="글쓰기" style="outline: none;">
		</td>
	</tr>
</table>
</div>
<!-- ------------------------------------------------ -->
<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>
<!-- ------------------------------------------------ -->
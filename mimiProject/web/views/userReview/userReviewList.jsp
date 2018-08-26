<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../../head.jsp"%>
<%@include file="../../header.jsp"%>


<style>
table {
	text-align: center;
	line-height: middle;
}
</style>

<!-- <title>유저리뷰게시판</title> -->


<div class="container" style="width:1150px;">
	<h3>유저 리뷰</h3>
	<hr class="margin1" style="margin: auto auto 5px auto;">
	<form class="form-inline" name="select-category" id="select-category" method="get" action="#">
		<!-- 왼쪽 -->
		<div class="form-group">
			<select class="form-control">
				<option value="" selected disabled hidden>Category</option>
				<option value="1">전체</option>
				<option value="2">대분류1</option>
				<option value="3">대분류2</option>
				<option value="4">대분류3</option>
				<option value="5">대분류4</option>
				<option value="5">대분류5</option>
			</select>&nbsp;&nbsp;&nbsp; <span style="color: #555; font-size: 12px;">
				<a href="#">추천수&nbsp;<i class="fas fa-sort"></i></a>&nbsp;&nbsp;&nbsp;
				<a href="#">조회수&nbsp;<i class="fas fa-sort"></i></a>&nbsp;&nbsp;&nbsp;
				<a href="#">기간&nbsp;<i class="fas fa-sort"></i></a>
			</span>
		</div>
		<!-- 오른쪽 -->
		<div class="form-group" style="float: right; margin: 1px;">
			<input type="text" class="form-control" name="search-text"
				id="search-text" size="12" placeholder=" ">​​​​​​​
			<button type="button" class="btn" name="btn" style="outline: none;">
				검색&nbsp;<i class="fas fa-search"></i>
			</button>
		</div>
	</form>
	<hr class="margin2">
	<!-- 게시물 시작 -->
	<form>

		<table class="table table-hover" id="table-css">
			<thead>
				<tr>
					<th width="8%">글번호</th>
					<th width="*" colspan="2">제목</th>
					<th width="12%"><i class="fas fa-pen"></i>작성자</th>
					<th width="8%"><i class="far fa-calendar"></i>작성일</th>
					<th width="8%"><i class="far fa-eye"></i>조회수</th>
					<th width="8%"><i class="far fa-thumbs-up"></i>추천</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>10</td>
					<td style="width: 90px"><a href="#"><img class="img-thumb img-mover"
							src="/mimi/resources/images/userReview/s_1.jpg"></a></td>
					<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
					<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<td>10</td>
					<td style="width: 90px"><a href="#"><img class="img-thumb img-mover"
							src="/mimi/resources/images/userReview/s_1.jpg"></a></td>
					<td class="tbl-td-title" style="vertical-align: middle;"><a
						href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;<span
							class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<td>10</td>
					<td style="width: 90px"><a href="#"><img class="img-thumb img-mover" src="/mimi/resources/images/userReview/s_1.jpg"></a></td>
					<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
					<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<td>10</td>
					<td style="width: 90px"><a href="#"><img class="img-thumb img-mover"
							src="/mimi/resources/images/userReview/s_1.jpg"></a></td>
					<td class="tbl-td-title" style="vertical-align: middle;"><a
						href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;<span
							class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<td>10</td>
					<td style="width: 90px"><a href="#"><img class="img-thumb img-mover"
							src="/mimi/resources/images/userReview/s_1.jpg"></a></td>
					<td class="tbl-td-title" style="vertical-align: middle;"><a
						href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;<span
							class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<td>10</td>
					<td style="width: 90px"><a href="#"><img class="img-thumb img-mover"
							src="/mimi/resources/images/userReview/s_1.jpg"></a></td>
					<td class="tbl-td-title" style="vertical-align: middle;"><a
						href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;<span
							class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<td>10</td>
					<td style="width: 90px"><a href="#"><img class="img-thumb img-mover"
							src="/mimi/resources/images/userReview/s_1.jpg"></a></td>
					<td class="tbl-td-title" style="vertical-align: middle;"><a
						href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;<span
							class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<td>10</td>
					<td style="width: 90px"><a href="#"><img class="img-thumb img-mover"
							src="/mimi/resources/images/userReview/s_1.jpg"></a></td>
					<td class="tbl-td-title" style="vertical-align: middle;"><a
						href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;<span
							class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
			</tbody>
		</table>
		<hr class="margin1" style="margin: 0px auto 5px auto;">



<table style="width:100%;">
	<tr>
		<td width="30%"></td><!-- 빈칸 -->
		<td width="*"><!-- 페이지 -->
	<!-- Pagination -->
		<ul class="pagination" style="float: center; display: flex; justify-content: center;">
			<li>
				<a href="#" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
				<span class="sr-only">Previous</span>
				</a>
			</li>
			<li><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li>
				<a href="#" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
				<span class="sr-only">Next</span>
				</a>
			</li>
		</ul>	
	</td>
		<!-- 버튼 -->
		<td style="width:30%; vertical-align: top;">
			<input type="button" class="btn btn-default pull-right"
			onClick="location.href='/mimi/views/userReview/userReviewInsert.jsp'" value="글쓰기" style="outline: none;"></td>
	</tr>
</table>
		
</div>

<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="../../head.jsp" %>


<!-- <title>MIMI</title> -->

<div class="container" style="width:1150px;">
<h3>MIMI 리뷰</h3>
<hr class="margin2">
<!-- 검색 -->

	<form class="form-inline" name="select-category" id="select-category"
		method="get" action="#">
		<!-- 왼쪽 -->
		<div class="form-group">
			<select class="form-control">
				<option value="" selected disabled hidden>Category</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select>&nbsp;&nbsp;&nbsp; <span style="color: #555; font-size: 12px;">
			<a href="#">추천수&nbsp;<i class="fas fa-sort"></i></a>&nbsp;&nbsp;&nbsp; 
			<a href="#">조회수&nbsp;<i class="fas fa-sort"></i></a>&nbsp;&nbsp;&nbsp; 
			<a href="#">기간&nbsp;<i class="fas fa-sort"></i></a></span>
		</div>
		<!-- 오른쪽 -->
		<div class="form-group" style="float: right; margin: 1px;">
			 <input type="text" class="form-control" name="search-text" id="search-text" size="12" placeholder=" ">​​​​​​​
			<button type="button" class="btn" name="btn" style="outline: none">
				검색&nbsp;<i class="fas fa-search"></i>
			</button>
		</div>
	</form>

	<!-- 게시물 시작 -->
<!-- class img : 음식이미지 사용시/ class img_logo : 로고이미지 사용시 -->
	<hr class="margin2">
	<div class="row">
		<div class="col-lg-4 col-sm-6 portfolio-item">
			<div class="rounded"><!-- 카드 테두리 둥글게 -->
				<div class="img-div"><!-- 이미지사이즈 -->
					<div class="cb"><!-- 이미지 하단 텍스트영역 -->
						<span class="text"> <i class="fas fa-comments"></i>111<!-- 댓글수 -->&nbsp;&nbsp;
							<i class="far fa-thumbs-up"></i>111<!-- 좋아요 수 -->
						</span>
					</div>
					<a href="#"><img class="img img-mover"
						src="/mimi/resources/images/main/img1.jpg" alt=""></a>
				</div>
				<div class="r-body"><!-- 본문영역 -->
					<table class="r-table"><!-- 본문영역 테이블 지정 -->
						<tr>
							<td>
								<h4>
									<a href="#">제목은한글최대열네자까지가능합니다</a>
								</h4> <!-- 한글 최대 14글자 -->

							</td>
							<td class="td-ast" style="font-size: 12px;">
								08.09<!-- 작성일 -->
							</td>
						</tr>
					</table>
					<p class="r-text">contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents</p>
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-sm-6 portfolio-item">
			<div class="rounded"><!-- 카드 테두리 둥글게 -->
				<div class="img-div"><!-- 이미지사이즈 -->
					<div class="cb"><!-- 이미지 하단 텍스트영역 -->
						<span class="text"> <i class="fas fa-comments"></i>111<!-- 댓글수 -->&nbsp;&nbsp;
							<i class="far fa-thumbs-up"></i>111<!-- 좋아요 수 -->
						</span>
					</div>
					<a href="#"><img class="img img-mover"
						src="/mimi/resources/images/main/img2.jpg" alt=""></a>
				</div>
				<div class="r-body"><!-- 본문영역 -->
					<table class="r-table"><!-- 본문영역 테이블 지정 -->
						<tr>
							<td>
								<h4>
									<a href="#">일이삼사오육칠팔구십일이삼사오육</a>
								</h4> <!-- 한글 최대 14글자 -->

							</td>
							<td class="td-ast" style="font-size: 12px;">
								08.09<!-- 작성일 -->
							</td>
						</tr>
					</table>
					<p class="r-text">contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents</p>
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-sm-6 portfolio-item">
			<div class="rounded"><!-- 카드 테두리 둥글게 -->
				<div class="img-div"><!-- 이미지사이즈 -->
					<div class="cb"><!-- 이미지 하단 텍스트영역 -->
						<span class="text"> <i class="fas fa-comments"></i>111<!-- 댓글수 -->&nbsp;&nbsp;
							<i class="far fa-thumbs-up"></i>111<!-- 좋아요 수 -->
						</span>
					</div>
					<a href="#"><img class="img img-mover"
						src="/mimi/resources/images/main/img3.jpg" alt=""></a>
				</div>
				<div class="r-body"><!-- 본문영역 -->
					<table class="r-table"><!-- 본문영역 테이블 지정 -->
						<tr>
							<td>
								<h4>
									<a href="#">일이삼사오육칠팔구십일이삼사오육</a>
								</h4> <!-- 한글 최대 14글자 -->

							</td>
							<td class="td-ast" style="font-size: 12px;">
								08.09<!-- 작성일 -->
							</td>
						</tr>
					</table>
					<p class="r-text">contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents</p>
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-sm-6 portfolio-item">
			<div class="rounded"><!-- 카드 테두리 둥글게 -->
				<div class="img-div"><!-- 이미지사이즈 -->
					<div class="cb"><!-- 이미지 하단 텍스트영역 -->
						<span class="text"> <i class="fas fa-comments"></i>111<!-- 댓글수 -->&nbsp;&nbsp;
							<i class="far fa-thumbs-up"></i>111<!-- 좋아요 수 -->
						</span>
					</div>
					<a href="#"><img class="img img-mover"
						src="/mimi/resources/images/main/img5.jpg" alt=""></a>
				</div>
				<div class="r-body"><!-- 본문영역 -->
					<table class="r-table"><!-- 본문영역 테이블 지정 -->
						<tr>
							<td>
								<h4>
									<a href="#">일이삼사오육칠팔구십일이삼사오육</a>
								</h4> <!-- 한글 최대 14글자 -->

							</td>
							<td class="td-ast" style="font-size: 12px;">
								08.09<!-- 작성일 -->
							</td>
						</tr>
					</table>
					<p class="r-text">contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents</p>
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-sm-6 portfolio-item">
			<div class="rounded"><!-- 카드 테두리 둥글게 -->
				<div class="img-div"><!-- 이미지사이즈 -->
					<div class="cb"><!-- 이미지 하단 텍스트영역 -->
						<span class="text"> <i class="fas fa-comments"></i>111<!-- 댓글수 -->&nbsp;&nbsp;
							<i class="far fa-thumbs-up"></i>111<!-- 좋아요 수 -->
						</span>
					</div>
					<a href="#"><img class="img img-mover"
						src="/mimi/resources/images/main/img4.jpg" alt=""></a>
				</div>
				<div class="r-body"><!-- 본문영역 -->
					<table class="r-table"><!-- 본문영역 테이블 지정 -->
						<tr>
							<td>
								<h4>
									<a href="#">일이삼사오육칠팔구십일이삼사오육</a>
								</h4> <!-- 한글 최대 14글자 -->

							</td>
							<td class="td-ast" style="font-size: 12px;">
								08.09<!-- 작성일 -->
							</td>
						</tr>
					</table>
					<p class="r-text">contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents</p>
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-sm-6 portfolio-item">
			<div class="rounded"><!-- 카드 테두리 둥글게 -->
				<div class="img-div"><!-- 이미지사이즈 -->
					<div class="cb"><!-- 이미지 하단 텍스트영역 -->
						<span class="text"> <i class="fas fa-comments"></i>111<!-- 댓글수 -->&nbsp;&nbsp;
							<i class="far fa-thumbs-up"></i>111<!-- 좋아요 수 -->
						</span>
					</div>
					<a href="#"><img class="img img-mover"
						src="/mimi/resources/images/main/img6.jpg" alt=""></a>
				</div>
				<div class="r-body"><!-- 본문영역 -->
					<table class="r-table"><!-- 본문영역 테이블 지정 -->
						<tr>
							<td>
								<h4>
									<a href="#">일이삼사오육칠팔구십일이삼사오육</a>
								</h4> <!-- 한글 최대 14글자 -->

							</td>
							<td class="td-ast" style="font-size: 12px;">
								08.09<!-- 작성일 -->
							</td>
						</tr>
					</table>
					<p class="r-text">contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents contents contents contents contents
						contents contents contents</p>
				</div>
			</div>
		</div>
	</div>
	<!-- /row -->
<hr class="margin1">

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
				<input type="button" class="btn btn-default pull-right" onClick="#"	value="글쓰기" style="outline: none;">
		</td>
	</tr>
</table>
</div><!-- /container -->


<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
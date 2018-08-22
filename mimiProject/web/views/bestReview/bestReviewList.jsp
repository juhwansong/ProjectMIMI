<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../../head.jsp"%>
<script type="text/javascript">

	$(function(){
		
		//체크박스 전체선택,해제 함수
		$("#checkAll").click(function(){
			if ($("#checkAll").is(":checked")) {
				$("input[name=checkOne]").prop("checked", true);
			} else {
				$("input[name=checkOne]").prop("checked", false);
			}	
		})	
		
		
	});//document

	
</script>

<!-- <title>Best리뷰게시판</title> -->

<div class="container" style="width:1150px;">
	<h3>Best 리뷰</h3>
	<hr class="margin1" style="margin: auto auto 5px auto;">
	<form class="form-inline" name="select-category" id="select-category" method="get" action="#">
		<!-- 왼쪽 -->
		<div class="form-group">
			연도 <select class="form-control" name="category_year">
				<option value="2018" selected>2018</option>
				<option value="2017">2017</option>
				<option value="2016">2016</option>
				<option value="2015">2015</option>
			</select>&nbsp;&nbsp;&nbsp;월 <select class="form-control"
				name="category_month">
				<option value="08" selected>08</option>
				<option value="01">01</option>
				<option value="02">02</option>
				<option value="03">03</option>
				<option value="04">04</option>
				<option value="05">05</option>
				<option value="06">06</option>
				<option value="07">07</option>
				<option value="09">09</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
			</select>
		</div>
		<!-- 오른쪽 -->
		<div class="form-group" style="float: right; margin: 1px;">
			<input type="text" class="form-control" name="search-text" id="search-text" size="12" placeholder=" ">​​​​​​​
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
					<!-- 관리자 전용 체크박스 -->
					<th width="8%"><input type="checkbox" name="checkAll" id="checkAll">
						<span style="vertical-align:top;">전체선택</span></th>
					<th width="8%">Rank</th>
					<th width="*" colspan="2">리뷰</th>
					<th width="12%"><i class="fas fa-pen"></i>작성자</th>
					<th width="8%"><i class="far fa-calendar"></i>작성일</th>
					<th width="8%"><i class="far fa-eye"></i>조회수</th>
					<th width="8%"><i class="far fa-thumbs-up"></i>추천</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="checkbox" name="checkOne" id="checkOne"></td>
					<td>1</td>
					<td style="width: 160px"><a href="#"><img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img3.jpg"></a></td>
					<td>
						<table>
							<tr><!-- 제목/댓글 -->
								<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
						<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
							</tr>
							<tr>
								<td><!-- 내용 -->
								<p class="r-text2">contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents </p>
								</td>
							</tr>
						</table>
					</td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<!-- 관리자 전용 체크박스 -->
					<td><input type="checkbox" name="checkOne" id="checkOne"></td>
					<td>2</td>
					<td style="width: 160px"><a href="#"><img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img2.jpg"></a></td>
					<td>
						<table>
							<tr><!-- 제목/댓글 -->
								<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
						<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
							</tr>
							<tr>
								<td><!-- 내용 -->
								<p class="r-text2">contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents </p>
								</td>
							</tr>
						</table>
					</td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<!-- 관리자 전용 체크박스 -->
					<td><input type="checkbox" name="checkOne" id="checkOne"></td>
					<td>3</td>
					<td style="width: 160px"><a href="#"><img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img6.jpg"></a></td>
					<td>
						<table>
							<tr><!-- 제목/댓글 -->
								<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
						<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
							</tr>
							<tr>
								<td><!-- 내용 -->
								<p class="r-text2">contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents </p>
								</td>
							</tr>
						</table>
					</td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<!-- 관리자 전용 체크박스 -->
					<td><input type="checkbox" name="checkOne" id="checkOne"></td>
					<td>4</td>
					<td style="width: 160px"><a href="#"><img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img5.jpg"></a></td>
					<td>
						<table>
							<tr><!-- 제목/댓글 -->
								<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
						<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
							</tr>
							<tr>
								<td><!-- 내용 -->
								<p class="r-text2">contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents </p>
								</td>
							</tr>
						</table>
					</td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<!-- 관리자 전용 체크박스 -->
					<td><input type="checkbox" name="checkOne" id="checkOne"></td>
					<td>5</td>
					<td style="width: 160px"><a href="#"><img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img2.jpg"></a></td>
					<td>
						<table>
							<tr><!-- 제목/댓글 -->
								<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
						<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
							</tr>
							<tr>
								<td><!-- 내용 -->
								<p class="r-text2">contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents </p>
								</td>
							</tr>
						</table>
					</td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<!-- 관리자 전용 체크박스 -->
					<td><input type="checkbox" name="checkOne" id="checkOne"></td>
					<td>6</td>
					<td style="width: 160px"><a href="#"><img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img1.jpg"></a></td>
					<td>
						<table>
							<tr><!-- 제목/댓글 -->
								<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
						<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
							</tr>
							<tr>
								<td><!-- 내용 -->
								<p class="r-text2">contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents </p>
								</td>
							</tr>
						</table>
					</td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<!-- 관리자 전용 체크박스 -->
					<td><input type="checkbox" name="checkOne" id="checkOne"></td>
					<td>7</td>
					<td style="width: 160px"><a href="#"><img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img3.jpg"></a></td>
					<td>
						<table>
							<tr><!-- 제목/댓글 -->
								<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
						<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
							</tr>
							<tr>
								<td><!-- 내용 -->
								<p class="r-text2">contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents </p>
								</td>
							</tr>
						</table>
					</td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<!-- 관리자 전용 체크박스 -->
					<td><input type="checkbox" name="checkOne" id="checkOne"></td>
					<td>8</td>
					<td style="width: 160px"><a href="#"><img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img4.jpg"></a></td>
					<td>
						<table>
							<tr><!-- 제목/댓글 -->
								<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
						<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
							</tr>
							<tr>
								<td><!-- 내용 -->
								<p class="r-text2">contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents </p>
								</td>
							</tr>
						</table>
					</td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<!-- 관리자 전용 체크박스 -->
					<td><input type="checkbox" name="checkOne" id="checkOne"></td>
					<td>9</td>
					<td style="width: 160px"><a href="#"><img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img5.jpg"></a></td>
					<td>
						<table>
							<tr><!-- 제목/댓글 -->
								<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
						<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
							</tr>
							<tr>
								<td><!-- 내용 -->
								<p class="r-text2">contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents </p>
								</td>
							</tr>
						</table>
					</td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
				<tr>
					<!-- 관리자 전용 체크박스 -->
					<td><input type="checkbox" name="checkOne" id="checkOne"></td>
					<td>10</td>
					<td style="width: 160px"><a href="#">
					<img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img6.jpg"></a></td>
					<td>
						<table>
							<tr><!-- 제목/댓글 -->
								<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp">맛집맛집&nbsp;&nbsp;
						<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
							</tr>
							<tr>
								<td><!-- 내용 -->
								<p class="r-text2">contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents </p>
								</td>
							</tr>
						</table>
					</td>
					<td>유저</td>
					<td>07-22</td>
					<td>9999</td>
					<td>999</td>
				</tr>
			</tbody>
		</table>
<hr class="margin1" style="margin: 0px auto 5px auto;">

<table width="100%">
	<tr>
		<td width="25%"></td><!-- 빈칸 -->
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
			<td width="25%" style="vertical-align: top;">
			<!-- 관리자 전용 버튼 -->
			<input type="button" class="btn btn-default pull-right" onClick="#" value="숨기기" style="outline: none; margin:1px;"></td>
		</tr>
</table>
	</form>
</div>

<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>

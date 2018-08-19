<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>

<!-- <title>MIMI</title> -->

<script type="text/javascript">
	$(function() {
		//체크박스 전체선택,해제
		$("#checkAll").click(function() {
			if ($("#checkAll").is(":checked")) {
				$("input[name=checkOne]").prop("checked", true);
			} else {
				$("input[name=checkOne]").prop("checked", false);
			}
		});
	});//document
</script>

<div class="container" style="width:1150px;">
	<h3>즐겨찾기</h3>
	<hr class="margin1" style="margin: auto auto 5px auto;">
	<form class="form-inline" name="select-category" id="select-category" method="get" action="#">
		<!-- 왼쪽 -->
		<div class="form-group">
			<select class="form-control">
				<option value="0" selected>전체</option>
				<option value="1">MIMI리뷰</option>
				<option value="2">유저리뷰</option>
			</select>
		</div>
		<!-- 오른쪽 -->
		<div class="form-group" style="float: right; margin: 1px;">
			<input type="text" class="form-control" name="search-text"
				id="search-text" size="8" placeholder=" ">​​​​​​​
			<button type="button" class="btn" name="btn" style="outline: none;">
				검색&nbsp;<i class="fas fa-search"></i>
			</button>
		</div>
	</form>
<!-- 게시글 -->
	<hr class="margin2">
<table class="table table-hover" id="table-css">
	<thead>
	<tr>
		<th width="8%"><input type="checkbox" name="checkAll" id="checkAll" >
			<span style="vertical-align:bottom;">전체선택</span></th>
		<th width="8%">게시판구분</th><th width="8%">글번호</th><th width="*">제목</th><th width="12%"><i class="fas fa-pen"></i>작성자</th><th width="12%"><i class="far fa-calendar"></i>작성일</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne"></td>
		<td>1<!-- 게시판구분 --></td>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><!-- 썸네일 --><img class="img-thumb img-mover" src="/mimi/resources/images/main/img4.jpg"><!-- 썸네일 -->
		<!-- 제목 -->&nbsp;&nbsp;<a href="#">title
		<!-- 댓글수 -->&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne"></td>
		<td>1<!-- 게시판구분 --></td>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><!-- 썸네일 --><img class="img-thumb img-mover" src="/mimi/resources/images/main/img3.jpg"><!-- 썸네일 -->
		<!-- 제목 -->&nbsp;&nbsp;<a href="#">title
		<!-- 댓글수 -->&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne"></td>
		<td>1<!-- 게시판구분 --></td>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><!-- 썸네일 --><img class="img-thumb img-mover" src="/mimi/resources/images/main/img2.jpg"><!-- 썸네일 -->
		<!-- 제목 -->&nbsp;&nbsp;<a href="#">title
		<!-- 댓글수 -->&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne"></td>
		<td>1<!-- 게시판구분 --></td>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><!-- 썸네일 --><img class="img-thumb img-mover" src="/mimi/resources/images/main/img6.jpg"><!-- 썸네일 -->
		<!-- 제목 -->&nbsp;&nbsp;<a href="#">title
		<!-- 댓글수 -->&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne"></td>
		<td>1<!-- 게시판구분 --></td>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><!-- 썸네일 --><img class="img-thumb img-mover" src="/mimi/resources/images/main/img1.jpg"><!-- 썸네일 -->
		<!-- 제목 -->&nbsp;&nbsp;<a href="#">title
		<!-- 댓글수 -->&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne"></td>
		<td>1<!-- 게시판구분 --></td>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><!-- 썸네일 --><img class="img-thumb img-mover" src="/mimi/resources/images/main/img3.jpg"><!-- 썸네일 -->
		<!-- 제목 -->&nbsp;&nbsp;<a href="#">title
		<!-- 댓글수 -->&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne"></td>
		<td>1<!-- 게시판구분 --></td>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><!-- 썸네일 --><img class="img-thumb img-mover" src="/mimi/resources/images/main/img4.jpg"><!-- 썸네일 -->
		<!-- 제목 -->&nbsp;&nbsp;<a href="#">title
		<!-- 댓글수 -->&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne"></td>
		<td>1<!-- 게시판구분 --></td>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><!-- 썸네일 --><img class="img-thumb img-mover" src="/mimi/resources/images/main/img1.jpg"><!-- 썸네일 -->
		<!-- 제목 -->&nbsp;&nbsp;<a href="#">title
		<!-- 댓글수 -->&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne"></td>
		<td>1<!-- 게시판구분 --></td>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><!-- 썸네일 --><img class="img-thumb img-mover" src="/mimi/resources/images/main/img4.jpg"><!-- 썸네일 -->
		<!-- 제목 -->&nbsp;&nbsp;<a href="#">title
		<!-- 댓글수 -->&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne"></td>
		<td>1<!-- 게시판구분 --></td>
		<td>100<!-- 글번호 --></td>
		<td class="tbl-td-title"><!-- 썸네일 --><img class="img-thumb img-mover" src="/mimi/resources/images/main/img2.jpg"><!-- 썸네일 -->
		<!-- 제목 -->&nbsp;&nbsp;<a href="#">title
		<!-- 댓글수 -->&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;999</span></a></td>
		<td>Nickname<!-- 작성자 --></td>
		<td>2018-07-30<!-- 작성일 --></td>
	</tr>

</tbody>
</table>


<!-- /게시글 -->
<hr class="margin1" style="margin: 0px auto 5px auto;">

<table width="100%">
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
		<!-- 삭제버튼 -->
			<td width="10%" style="vertical-align: top;">
			<input type="button" class="btn btn-default pull-right" value="삭제" style="outline: none;"></td>
		</tr>
</table>
</div><!-- /container -->


<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
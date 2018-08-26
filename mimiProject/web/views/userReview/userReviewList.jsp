<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="./userReviewError.jsp"%>
<%@ page import="common.model.vo.Board, java.util.ArrayList" %>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	//String userId = (String)session.getAttribute("userId");
%>
<%@include file="../../head.jsp"%>


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
				<% for(Board rb : list){ %>
				<tr>
					<td><%= rb.getBoardNo() %></td>
					<td style="width: 90px"><a href="/mimi/userboarddetailview?bnum=<%= rb.getBoardNo() %>&page=<%= currentPage %>"><img class="img-thumb img-mover"
							src="<%if(rb.getThumbnailName() != null){%><%=request.getContextPath()%>/resources/files/userboard/<%=rb.getThumbnailName()%><%}else{%>/mimi/resources/images/logo/default_logo.png<%}%>"></a></td>
					<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/userboarddetailview?bnum=<%= rb.getBoardNo() %>&page=<%= currentPage %>"><%= rb.getTitle() %>&nbsp;&nbsp;
					<span class="span-c"><i class="fas fa-comments"></i>&nbsp;<%= rb.getCommentNum() %></span></a></td>
					<td><%= rb.getNickName() %></td>
					<td><%= rb.getBoardDate() %></td>
					<td><%= rb.getHits() %></td>
					<td><%= rb.getRecommed() %></td>
				</tr>
				<% } %>													
			</tbody>
		</table>
		<hr class="margin1" style="margin: 0px auto 5px auto;">



<table style="width:100%;">
	<tr>
		<td width="30%"></td><!-- 빈칸 -->
		<td width="*"><!-- 페이지 -->
	<!-- Pagination -->
		<ul class="pagination" style="float: center; display: flex; justify-content: center;">
		<% if((currentPage - 10) < startPage && 
				(currentPage - 10) > 1){ %>
			<li>
				<a href="/mimi/userboardlist?page=<%= startPage - 10 %>" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
				<span class="sr-only">Previous</span>
				</a>
			</li>
		<% } %>
		<% for(int p = startPage; p <= endPage; p++){ 
				if(p == currentPage){ %>
			<li><a href="/mimi/userboardlist?page=<%= p %>"><span style="color:red"><%= p %></a></li>
		<% }else{ %>
			<li><a href="/mimi/userboardlist?page=<%= p %>"><%= p %></a></li>
			<% }} %>
		<% if((currentPage + 10) > endPage && 
				(currentPage + 10) < maxPage){ %>
			<li>
				<a href="/mimi/userboardlist?page=<%= maxPage %>" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
				<span class="sr-only">Next</span>
				</a>
			</li>
		<% } %>
		</ul>	
	</td>
		<!-- 버튼 -->
		<td style="width:30%; vertical-align: top;">
			<input type="button" class="btn btn-default pull-right"
			onClick="location.href='/mimi/views/userReview/userReviewInsert.jsp'" value="글쓰기" style="outline: none;"></td>
	</tr>
</table>		
</div>
<!-- 페이징 처리 -->
<div style="text-align: center">
<% if(currentPage <= 1){ %>
	[맨처음]&nbsp;
<% }else{ %>
	<a href="/mimi/userboardlist?page=1">[맨처음]</a>
<% } %>
<% if((currentPage - 10) < startPage && 
		(currentPage - 10) > 1){ %>
	<a href="/mimi/userboardlist?page=<%= startPage - 10 %>">[이전]</a>
<% }else{ %>
	[이전]&nbsp;
<% } %>
<%-- startPage ~ endPage 출력 --%>
<% for(int p = startPage; p <= endPage; p++){ 
		if(p == currentPage){ 
%>
	<font color="red" size="4">[<%= p %>]</font>
<%      }else{ %>
	<a href="/mimi/userboardlist?page=<%= p %>"><%= p %></a>
<% }} %>
<%-- ---------------- --%>
<% if((currentPage + 10) > endPage && 
		(currentPage + 10) < maxPage){ %>
	<a href="/mimi/userboardlist?page=<%= endPage + 10 %>">[다음]</a>
<% }else{ %>
	[다음]&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	[맨끝]&nbsp;
<% }else{ %>
	<a href="/mimi/userboardlist?page=<%= maxPage %>">
	[맨끝]</a>
<% } %>
</div>

<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="boardError.jsp"%>
<%@ page import="java.util.*, common.model.vo.Board" %>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	int totalCount = ((Integer) request.getAttribute("totalCount")).intValue();
	int startPage = ((Integer) request.getAttribute("startPage")).intValue();
	int endPage = ((Integer) request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer) request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer) request.getAttribute("currentPage")).intValue();
%>
<%@include file="../../head.jsp" %>
<%-- <%@include file="../../header.jsp" %> --%>
<%@include file="../../memberHeader.jsp" %>
<%-- <%@include file="../../adminHeader.jsp" %> --%>

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
		
		
		//셀렉트박스 선택시 자동...ajax
		$("#selectReview").change(function(){
			//console.log(this.value + "확인용");
			
/* 			$.ajax({
				type:'post',
				url:url,
				data:this.value,
				dataType:'json'
				success:function(args){
					$("#result").html(args);}, 
				beforeSend:showRequest, 
				error:function(e){
					alert(e.responseText);}
			})//ajax */
			
			
			
			
		});
		
		
	});//document
</script>

<div class="container" style="width:1150px;">
	<h3>즐겨찾기</h3>
	<hr class="margin1" style="margin: auto auto 5px auto;">
	<form class="form-inline" name="select-category" id="select-category" method="post" action="/mimi/bookmarksearch">
		<!-- 왼쪽 -->
		<div class="form-group">
			<select class="form-control" name="selectReview" id="selectReview">
				<option value="allReview" selected>전체</option>
				<option value="mimiReview">MIMI리뷰</option>
				<option value="userReview">유저리뷰</option>
			</select>
		</div>
		<!-- 오른쪽 -->
		<div class="form-group" style="float: right; margin: 1px;">
			<input type="text" class="form-control" name="textSearch"
				id="textSearch" size="8" placeholder="">​​​​​​​
			<button type="submit" class="btn" name="btn" style="outline: none;">
				검색&nbsp;<i class="fas fa-search"></i>
			</button>
		</div>
	</form>
<!-- 게시글 -->
	<hr class="margin2">
	
	
<form method="post" action="/mimi/bookmarkdelete">
<table class="table table-hover" id="table-css">
	<thead>
	<tr>
		<th width="8%"><input type="checkbox" name="checkAll" id="checkAll" >
			<span style="vertical-align:bottom;">전체선택</span></th>
		<th width="8%">게시판구분</th><th width="8%">글번호</th><th width="*">제목</th><th width="12%"><i class="fas fa-pen"></i>작성자</th><th width="12%"><i class="far fa-calendar"></i>작성일</th>
	</tr>
	</thead>
	<tbody>
	
	<% for(Board b : list){ 
		String num = b.getBoardNo().substring(2).replaceAll("^0*","");//글번호만 추출
		String gb = null;
		if(b.getBoardGb().equals("AR"))
			gb = "MIMI리뷰";
		else
			gb = "유저리뷰";
	%>
	
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne" value="<%= b.getBoardNo()%>"></td>
		<td><!-- 게시판구분 --><%= gb %></td>
		<td><!-- 글번호 --><%= num %></td>
		<td class="tbl-td-title"><!-- 썸네일 --><a href="#"><%-- <img class="img-thumb img-mover" src="<%= b.getThumbnailName() %>"> --%>
		<img class="img-thumb img-mover" src="/mimi/resources/images/main/img4.jpg"></a>
		<!-- 제목 -->&nbsp;&nbsp;<a href="#"><%= b.getTitle() %>
		<!-- 댓글수 -->&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;<%= b.getCommentNum() %></span></a></td>
		<td><!-- 작성자 --><%= b.getNickName() %></td>
		<td><!-- 작성일 --><%= b.getBoardDate() %></td>
	</tr>
	
	<% } %>
	


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
			<!-- 맨앞으로 -->
			<li>
			<% if(currentPage <= 1){ %>
				<span style="color:#ccc;">&laquo;</span>
			<% }else{ %>
				<a href="/mimi/bookmarklist?page=1" title="맨처음"><span style="color:#444;">&laquo;</span></a>
			<% } %>
			</li>
			
			<!-- 하나 앞으로 -->
			<li>
				<% if((currentPage - 10) < startPage && (currentPage - 10) > 1){ %>
				<a href="/mimi/bookmarklist?page=<%=startPage - 10%>" title="이전"><span style="color:#444;">&lt;</span></a>	
			<% }else{ %>
				<span style="color:#ccc;">&lt;</span>
			<% } %>
			</li>
			
			<% for(int p = startPage; p <= endPage; p++){
					if(p == currentPage){%>
			<li><span style="color:#ccc;"><%=p %></span></li>
			<% }else{ %>
			<li><a href="/mimi/bookmarklist?page=<%=p%>"><span style="color:#444;"><%=p %></span></a></li>
			<% }} %>
			
			<!-- 하나 뒤 -->
			<% if((currentPage + 10) > endPage && (currentPage + 10) < maxPage){ %>
			<li>
				<a href="/mimi/bookmarklist?page=<%=endPage + 10%>" title="다음"><span style="color:#444;">&gt;</span></a>
			</li>
			<% }else{ %>
			<li><span style="color:#ccc;">&gt;</span></li>
			<!-- 맨뒤 -->
			<% }
				if(currentPage >= maxPage){%>
				<li><span style="color:#ccc;">&raquo;</span></li>
			<% }else{ %>
			<li>
				<a href="/mimi/bookmarklist?page=<%=maxPage%>" title="맨끝"><span style="color:#444;">&raquo;</span></a>
			</li>
			<% } %>
			
		</ul>	
	</td>
		<!-- 삭제버튼 -->
		<td width="10%" style="vertical-align:top;">
		<input type="submit" class="btn btn-default pull-right" value="삭제" style="outline: none;">
		</td>
	</tr>
</table>
		</form>
</div><!-- /container -->


<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
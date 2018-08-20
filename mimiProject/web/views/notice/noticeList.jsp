<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8 errorPage="noticeError.jsp"%>
<%@ page import="java.util.*, notice.model.vo.Notice" %>
<%
	ArrayList<Notice> list = (ArrayList<Notice>)request.getAttribute("noticeList");
	int totalCount = ((Integer) request.getAttribute("totalCount")).intValue();
	int startPage = ((Integer) request.getAttribute("startPage")).intValue();
	int endPage = ((Integer) request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer) request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer) request.getAttribute("currentPage")).intValue();
%>

<%@include file="../../head.jsp" %>

<script type="text/javascript">
	$(function(){
		
		
	})//document
</script>


<div class="container" style="width:1150px;">

<!-- 이미지 슬라이드 -->
<div class="carousel slide" id="myCarousel" data-ride="carousel" style="padding: 5px 10px;">
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
				<form class="form-inline" name="select-category" id="select-category" method="post" action="/mimi/noticesearch">
					<div class="form-group" style="float: right; margin:3px;">
						<input type="text" class="form-control" name="keyword" size="12">
				​​​​​​​  		<button type="submit" class="btn" name="btn" style="outline: none">검색&nbsp;<i class="fas fa-search"></i>
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
	<% for (Notice n : list){
		String num = n.getNoticeNo().substring(2).replaceAll("^0*","");//글번호만 추출 %>
		<tr>
			<td><%=num %></td>
			<td class="tbl-td-title"><a href="/mimi/noticedetail?no=<%=n.getNoticeNo()%>&page=<%=currentPage%>"><%=n.getNoticeTitle() %></a><!-- 제목 --></td>
			<td><%=n.getUserId() %></td>
			<td><%=n.getNoticeDate() %></td>
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
				<a href="/mimi/noticelist?page=1" title="맨처음"><span style="color:#444;">&laquo;</span></a>
			<% } %>
			</li>
			<!-- 하나 앞으로 -->
			<li>
				<% if((currentPage - 10) < startPage && (currentPage - 10) > 1){ %>
				<a href="/mimi/noticelist?page=<%=startPage - 10%>" title="이전"><span style="color:#444;">&lt;</span></a>	
			<% }else{ %>
				<span style="color:#ccc;">&lt;</span>
			<% } %>
			</li>
			
			<% for(int p = startPage; p <= endPage; p++){
					if(p == currentPage){%>
			<li><span style="color:#ccc;"><%=p %></span></li>
			<% }else{ %>
			<li><a href="/mimi/noticelist?page=<%=p%>"><span style="color:#444;"><%=p %></span></a></li>
			<% }} %>
			
			<!-- 하나 뒤 -->
			<% if((currentPage + 10) > endPage && (currentPage + 10) < maxPage){ %>
			<li>
				<a href="/mimi/noticelist?page=<%=endPage + 10%>" title="다음"><span style="color:#444;">&gt;</span></a>
			</li>
			<% }else{ %>
			<li><span style="color:#ccc;">&gt;</span></li>
			<!-- 맨뒤 -->
			<% }
				if(currentPage >= maxPage){%>
				<li><span style="color:#ccc;">&raquo;</span></li>
			<% }else{ %>
			<li>
				<a href="/mimi/noticelist?page=<%=maxPage%>" title="맨끝"><span style="color:#444;">&raquo;</span></a>
			</li>
			<% } %>
			
		</ul>	
	</td>
		<!-- 글쓰기버튼 -->
		<td width="10%" style="vertical-align:top;">
						<input type="button" class="btn btn-default pull-right"
			onclick="location.href='/mimi/views/notice/noticeWrite.jsp'"
			value="글쓰기" style="outline: none;"></td>
	</tr>
</table>
</div><!-- /container -->


<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
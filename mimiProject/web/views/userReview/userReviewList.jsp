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
<script type="text/javascript">


</script>
<script type="text/javascript">
	function callback(data){ //목록, 페이지네이션 처리
		console.log("콜백함수 실행중...");
		var searchText = $("#search-text").val();
		var jsonStr = JSON.stringify(data);			
		var json = JSON.parse(jsonStr);
		
		$("#table").empty(); //기존 목록 전부 지우기
		values = "<thead>"
				+ "<tr><th width=\"8%\">글번호</th>"
				+ "<th width=\"*\" colspan=\"2\">제목</th>"
				+ "<th width=\"12%\"><i class=\"fas fa-pen\"></i>작성자</th>"
				+ "<th width=\"8%\"><i class=\"far fa-calendar\"></i>작성일</th>"
				+ "<th width=\"8%\"><i class=\"far fa-eye\"></i>조회수</th>"
				+ "<th width=\"8%\"><i class=\"far fa-thumbs-up\"></i>추천</th>"
				+ "</tr></thead><tbody>";
		for(var i in json.list){
			values += "<tr><td>"+json.list[i].boardNo+"</td>"
					+ "<td style=\"width: 90px\"><a href=\"/mimi/userboarddetailview?bnum="+json.list[i].boardNo+"&page="+ json.currentPage +"\"><img class=\"img-thumb img-mover\""
					+ " src=\"";
			if(json.list[i].thumbnail != null){
				console.log(json.list[i].thumbnail);
				values += "/mimi" + "/resources/files/userboard/"+ json.list[i].thumbnail + "\"></a></td>"; 
			}else{
				values += "/mimi/resources/images/logo/default_logo.png\"></a></td>";
			}
			values += "<td class=\"tbl-td-title\" style=\"vertical-align: middle;\"><a href=\"/mimi/userboarddetailview?bnum="
				+ json.list[i].boardNo + "&page="+ json.currentPage+"\">"+ json.list[i].title + "&nbsp;&nbsp;"
				+ "<span class=\"span-c\"><i class=\"fas fa-comments\"></i>&nbsp;"+json.list[i].commentNum+"</span></a></td>"
				+ "<td>"+ json.list[i].nickname + "</td>"
				+ "<td>"+ json.list[i].boardDate + "</td>"
				+ "<td>"+ json.list[i].hit + "</td>"
				+ "<td>"+ json.list[i].recommend + "</td>"
				+ "</tr>";
			}												
		values += "</tbody>"

		$("#table-css").html(values); //목록 채우기

		//pagination
		$("#userPagination").empty(); //기존 페이지네이션 지우기
		pageValues = "";
	 	//<< 1
		if(json.currentPage <= 1){
			pageValues += '<li><span style="color:#ccc;">&laquo;</span></li><li>';
		}else{
			pageValues += '<li><a href="javascript:void(0)" onclick="paging(1);" title="맨처음"><span style="color:#444;">&laquo;</span></a></li><li>';
		}
	
	 	//< -10
		if(json.maxPage == 0){ //결과없을때 비활성화
			pageValues += '<span style="color:#ccc;">&lt;</span></li>';
		}else if((json.currentPage - 10) <= json.startPage && (json.currentPage - 10) > 1){
			pageValues += '<a href="javascript:void(0)" onclick="paging(' + (json.currentPage - 10) + ');" title="이전"><span style="color:#444;">&lt;</span></a></li>';	
		}else if(json.currentPage != 1){ //1페이지 아니면 항상 활성화
			pageValues += '<a href="javascript:void(0)" onclick="paging(1);" title="이전"><span style="color:#444;">&lt;</span></a></li>';
		}else{
			pageValues += '<span style="color:#ccc;">&lt;</span></li>';
		}
		
		
	 	//123
		for(var p = json.startPage; p <= json.endPage; p++){
			if(p == json.currentPage){
				pageValues += '<li><span style="color:#ccc;">' + p + '</span></li>';
		 	}else{ 
		 		pageValues += '<li><a href="javascript:void(0)" onclick="paging(' + p + ');"><span style="color:#444;">' + p + '</span></a></li>';
			}}
		
	 	//> +10
		if((json.currentPage + 10) <= json.maxPage){
		 	pageValues += '<li><a href="javascript:void(0)" onclick="paging(' + (json.currentPage + 10) + ');" title="다음"><span style="color:#444;">&gt;</span></a></li>';
		}else if((json.currentPage + 10 ) > json.maxPage && json.currentPage < json.maxPage){ //마지막 페이지 아닐시 항상 활성화
			pageValues += '<li><a href="javascript:void(0)" onclick="paging(' + (json.maxPage) + ');" title="다음"><span style="color:#444;">&gt;</span></a></li>';
		}else{
			pageValues += '<li><span style="color:#ccc;">&gt;</span></li>';
		}
		
		//>> max
		if(json.currentPage >= json.maxPage){
			pageValues += '<li><span style="color:#ccc;">&raquo;</span></li>';
		}else{
			pageValues += '<li><a href="javascript:void(0)" onclick="paging(' + json.maxPage + ');" title="맨끝"><span style="color:#444;">&raquo;</span></a></li>';		
		}
		$("#userPagination").html(pageValues);//페이지네이션
		$('html, body').scrollTop(0); //상단으로 이동
	}//callback function		
	function paging(p){
		if($("#r-sort").children().attr('class') === 'fas fa-sort-down'){//down 내림차순
			var sort = 'down';
		}else if($("#h-sort").children().attr('class') === 'fas fa-sort-down'){
			var sort = 'down';
		}else if($("#d-sort").children().attr('class') === 'fas fa-sort-down'){
			var sort = 'down';
		}else if($("#r-sort").children().attr('class') === 'fas fa-sort-up'){//up 오름차순
			var sort = 'up';
		}else if($("#h-sort").children().attr('class') === 'fas fa-sort-up'){
			var sort = 'up';
		}else if($("#d-sort").children().attr('class') === 'fas fa-sort-up'){
			var sort = 'up';
		}
					
		
		if($("#r-sort").children().attr('class') != 'fas fa-sort'){
			var order = $("#r-sort").children().attr('id');
		}else if($("#h-sort").children().attr('class') != 'fas fa-sort'){
			var order = $("#h-sort").children().attr('id');
		}else if($("#d-sort").children().attr('class') != 'fas fa-sort'){
			var order = $("#d-sort").children().attr('id');
		}
		console.log("sort : " + sort + ", order : " + order);
		$.ajax({		
			url : "userboardsearch",
			data : {category : categoryValue, keyword : searchText, order : order, sort : sort, page : p},
			type : "post",
			dataType : "json",
			success : function(data){	
				callback(data);
			}//success
		})//ajax
	}//paging
</script>
<!-------------같이 두면 인식 못해서 분리----------------------------------------------------------------------->
<script type="text/javascript">
	$(function(){		
		var page = <%= currentPage%>;

		//select box 변경 시 ajax 실행
		$("#select-category").change(function(){
			categoryValue = $("#select-category option:selected").val();
			searchText = $("#search-text").val();
			//console.log("변경된 카테고리 값 : " + categoryValue);

			$.ajax({
				url : "/mimi/userboardsearch",
				data : {category : categoryValue, page : page},
				type : "post",
				dataType : "json",
				success : function(data){					
					callback(data);
				}//success
			});//ajax
			
		})//select box change
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////	 		
		
		//검색버튼 클릭 시 ajax 실행
		$("#submitBtn").on('click', function search(){
			categoryValue = $("#select-category option:selected").val();
			searchText = $("#search-text").val();
			console.log(searchText);
			//console.log("버튼 실행 확인...");
			$.ajax({

				url : "/mimi/userboardsearch",
				data : {category : categoryValue, keyword : searchText, page : page},
				type : "post",
				dataType : "json",
				success : function(data){	
					callback(data);
				}//success
			})//ajax

			//console.log("categoryValue : " + categoryValue + "\nsearchText : " + searchText);
		})//submitBtn click

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
 
		//정렬 선택 시 ajax 실행
		$("#r-sort, #h-sort, #d-sort").on('click', function(){
			var icon = ($(this).children().attr('class') === 'fas fa-sort-down') ? 'fas fa-sort-up' : 'fas fa-sort-down'; 
			
			//현재 선택영역 제외하고 나머지 원래 아이콘으로 변경
			$("#r-sort, #h-sort, #d-sort").children().not($(this).children()).attr('class', 'fas fa-sort');
			$(this).children().prop('class', icon); //아이콘 바꾸기
			
			var sort = $(this).children().attr('class');
			var order = $(this).children().attr('id');
			categoryValue = $("#select-category option:selected").val();
			searchText = $("#search-text").val();
			
			$.ajax({
				url : "/mimi/userboardsearch",
				data : {category : categoryValue, keyword : searchText, order : order, sort : sort, page : page},
				type : "post",
				dataType : "json",
				success : function(data){
					callback(data);					
				}//success
			})//ajax
		})//sort
	});//document close
	
	$(document).ready(function(){
	       $("#search-text").keypress(function (e) {
	        if (e.which == 13){
	        	document.getElementById("submitBtn").click();;  // 실행할 이벤트
	        }
	    });
	});

</script>

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
	<div class="form-inline" name="select" id="select" method="post" action="#">
		<!-- 왼쪽 -->
		<div class="form-group">
			<select class="form-control" id="select-category">
				<option value="C0" selected disabled hidden>Category</option>
				<option value="C0">전체</option>
				<option value="C1">커피/디저트</option>
				<option value="C2">패스트푸드</option>
				<option value="C3">한식</option>
				<option value="C4">양식</option>
				<option value="C5">일식</option>
				<option value="C6">중식</option>
				<option value="C7">분식</option>
				<option value="C8">기타</option>
			</select>&nbsp;&nbsp;&nbsp; <span style="color: #555; font-size: 12px;">
			<a href="javascript:void(0)" id="r-sort">추천수&nbsp;<i id="recommend" class="fas fa-sort"></i></a>&nbsp;&nbsp;&nbsp; 
			<a href="javascript:void(0)" id="h-sort">조회수&nbsp;<i id="hits" class="fas fa-sort"></i></a>&nbsp;&nbsp;&nbsp; 
			<a href="javascript:void(0)" id="d-sort">기간&nbsp;<i id="board_date" class="fas fa-sort"></i></a></span>
			</span>
		</div>
		<!-- 오른쪽 -->
		<div class="form-group" style="float: right; margin: 1px;">
			 <input type="text" class="form-control" name="search-text" id="search-text" size="12">​​​​​​​
			<button type="button" id="submitBtn" class="btn" name="btn" style="outline: none">
				검색&nbsp;<i class="fas fa-search"></i>
			</button>
		</div>
	</div>
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
		<ul class="pagination" id="userPagination" style="float: center; display: flex; justify-content: center;">
		<!--  맨처음 -->
		<%  if(currentPage <= 1){ %>
			<li><span style="color:#ccc;">&laquo;</span></li><li>
		<%  }else{  %>
			<li><a href="/mimi/userboardlist?page=1" aria-label="Previous" title="맨처음"><span style="color:#444;">&laquo;</span></a></li><li>
		<% } %>
	
		<!-- 10페이지 이전 -->
		<% if(maxPage == 0){ //결과없을떄 비활성화 %>
			<span style="color:#ccc;">&lt;</span></li>
		<% }else if((currentPage - 10) <= startPage && (currentPage - 10) > 1){ %>
			<a href="/mimi/userboardlist?page=<%= startPage - 10 %>" title="이전"><span style="color:#444;">&lt;</span></a></li>	
		<% }else if(currentPage != 1){ //1페이지 아니면 항상 활성화%>
			<a href="/mimi/userboardlist?page=1" title="이전"><span style="color:#444;">&lt;</span></a></li>
		<% }else{ %>
			<span style="color:#ccc;">&lt;</span></li>
		<% } %>
		
		<!-- 페이지표시 -->
		<% for(int p = startPage; p <= endPage; p++){ 
				if(p == currentPage){ %>
			<li><a href="/mimi/userboardlist?page=<%= p %>"><span style="color:red"><%= p %></a></li>
		<% }else{ %>
			<li><a href="/mimi/userboardlist?page=<%= p %>"><%= p %></a></li>
			<% }} %>
		
		<!-- 10페이지 다음 -->
		<% if((currentPage + 10) <= maxPage){  %>
		 	<li><a href="/mimi/userboardlist?page=<%= currentPage + 10 %>" title="다음"><span style="color:#444;">&gt;</span></a></li>
		<% }else if((currentPage + 10 ) > maxPage && currentPage < maxPage){ //마지막 페이지 아닐시 항상 활성화  %>
			<li><a href="/mimi/userboardlist?page=<%= maxPage %>" title="다음"><span style="color:#444;">&gt;</span></a></li>
		<% }else{  %>
			<li><span style="color:#ccc;">&gt;</span></li>
		<% }  %>
		
		<!-- 마지막 페이지 -->
		<% if(currentPage >= maxPage){ %>
			<li><span style="color:#ccc;">&raquo;</span></li>
		<% }else{ %>
			<li><a href="/mimi/userboardlist?page=<%= maxPage %>"><span style="color:#444;">&raquo;</span></a></li>
		<% } %>
		</ul>	
	</td>
		<!-- 버튼 -->
		<td style="width:30%; vertical-align: top;">
			<% if(userId != null){ %>
			<input type="button" class="btn btn-default pull-right"
			onClick="location.href='/mimi/views/userReview/userReviewInsert.jsp'" value="글쓰기" style="outline: none;"></td>
			<% } %>
	</tr>
</table>		
</div>

<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>

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

<script type="text/javascript">
	function callback(data){ //목록, 페이지네이션 처리
		//console.log("콜백함수 실행중...");
		var searchText = $("#textSearch").val();
		var jsonStr = JSON.stringify(data);			
		var json = JSON.parse(jsonStr);
		
		$("#row").empty(); //기존 목록 전부 지우기
		values = ""; //변수 선언
		console.log("row html 확인하기  :: " + values);
		
		
		for(var i in json.list){
			var num = json.list[i].boardNo.substring(2).replace(/(^0+)/,"");//글번호만 추출
			//var gb = json.list[i].boardGb === "AR" ? "MIMI리뷰" : "유저리뷰";
			var gb = null;
			var imgsrc = null;
			var link = null;
			if(json.list[i].boardGb === "AR"){
				gb = "MIMI리뷰";
				imgsrc = "/mimi/resources/files/adminboard/";
				link = "/mimi/adminboarddetailview";
			}else{
				gb = "유저리뷰";
				imgsrc = "/mimi/resources/files/userboard/";
				link = "/mimi/userboarddetailview";
			}
			
			values += '<tr><td><input type="checkbox" name="checkOne" id="checkOne" value="' + json.list[i].boardNo + '"></td>'
					+ '<td>' + gb + '</td><td>' + num + '</td><td class="tbl-td-title"><a href="' + link + '?bnum=' + json.list[i].boardNo + '&page=1">'
					+ '<img class="img-thumb img-mover"  src="' + imgsrc + json.list[i].thumbnail + '" onerror="this.onerror=null;this.src=\'/mimi/resources/images/main/img3.jpg\'"></a>'
					+ '&nbsp;&nbsp;<a href="' + link + '?bnum=' + json.list[i].boardNo + '&page=1">' + json.list[i].title
					+ '&nbsp;&nbsp;<span class="span-c"><i class="fas fa-comments"></i>&nbsp;' + json.list[i].commentNum + '</span></a></td>'
					+ '<td>' + json.list[i].nickname + '</td><td>' + json.list[i].boardDate + '</td></tr>'
					
			
		}//for 
		
		$("#row").html(values); //목록 채우기
	
		//pagination
		$("#searchListPagination").empty(); //기존 페이지네이션 지우기
		pageValues = "";

	 	//<< 1
		if(json.currentPage <= 1){
			pageValues += '<li><span style="color:#ccc;">&laquo;</span></li><li>';
		}else{
			pageValues += '<li><a href="javascript:void(0)" onclick="paging(1);" title="맨처음"><span style="color:#444;">&laquo;</span></a></li><li>'
		}
	
	 	//< -10
		if((json.currentPage - 10) <= json.startPage && (json.currentPage - 10) > 1){
			pageValues += '<a href="javascript:void(0)" onclick="paging(' + (json.currentPage - 10) + ');" title="이전"><span style="color:#444;">&lt;</span></a></li>'	
		}else if(json.currentPage != 1){ //1페이지 아니면 항상 활성화
			pageValues += '<a href="javascript:void(0)" onclick="paging(1);" title="이전"><span style="color:#444;">&lt;</span></a></li>'
		}else{
			pageValues += '<span style="color:#ccc;">&lt;</span></li>'
		}
		
		
	 	//123
		for(var p = json.startPage; p <= json.endPage; p++){
			if(p == json.currentPage){
					pageValues += '<li><span style="color:#ccc;">' + p + '</span></li>'
		 	}else{ 
		 		pageValues += '<li><a href="javascript:void(0)" onclick="paging(' + p + ');"><span style="color:#444;">' + p + '</span></a></li>'
			}}
		
	 	//> +10
		if((json.currentPage + 10) <= json.maxPage){
		 	pageValues += '<li><a href="javascript:void(0)" onclick="paging(' + (json.currentPage + 10) + ');" title="다음"><span style="color:#444;">&gt;</span></a></li>'
		}else if((json.currentPage + 10 ) > json.maxPage && json.currentPage < json.maxPage){ //마지막 페이지 아닐시 항상 활성화
			pageValues += '<li><a href="javascript:void(0)" onclick="paging(' + (json.maxPage) + ');" title="다음"><span style="color:#444;">&gt;</span></a></li>'
		}else{
			pageValues += '<li><span style="color:#ccc;">&gt;</span></li>'
		}
		
		//>> max
		if(json.currentPage >= json.maxPage){
			pageValues += '<li><span style="color:#ccc;">&raquo;</span></li>'
		}else{
			pageValues += '<li><a href="javascript:void(0)" onclick="paging(' + json.maxPage + ');" title="맨끝"><span style="color:#444;">&raquo;</span></a></li>'
			
		}
		$("#searchListPagination").html(pageValues);//페이지네이션
		$('html, body').scrollTop(0); //상단으로 이동
		}//callback function		
		
		function paging(p){
			$.ajax({		
				url : "bookmarksearch",
				data : {category : categoryValue, keyword : searchText, page : p},
				type : "post",
				dataType : "json",
				success : function(data){	
					callback(data);
				}//success
			})//ajax
		}//paging
</script>
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
		
		
		var page = <%= currentPage%>;
		//select box 변경 시 ajax 실행
		$("#selectReview").change(function(){
			categoryValue = $("#selectReview option:selected").val();
			searchText = $("#textSearch").val();
			console.log("변경된 카테고리 값 : " + categoryValue);

			$.ajax({
				url : "bookmarksearch",
				data : {category : categoryValue, keyword : searchText, page : page},
				type : "post",
				dataType : "json",
				success : function(data){					
					callback(data);
				}//success
			});//ajax
			
		})//select box change
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////	 		
		
		//검색버튼 클릭 시 ajax 실행
		$("#submitBtn").on('click', function(){
			categoryValue = $("#selectReview option:selected").val();
			searchText = $("#textSearch").val();
			//console.log("버튼 실행 확인...");
			$.ajax({
				
				url : "bookmarksearch",
				data : {category : categoryValue, keyword : searchText, page : page},
				type : "post",
				dataType : "json",
				success : function(data){	
					callback(data);
				}//success
			})//ajax

			//console.log("categoryValue : " + categoryValue + "\nsearchText : " + searchText);
		})//submitBtn click

		
	});//document
</script>

<div class="container" style="width:1150px;">
	<h3>즐겨찾기</h3>
	<hr class="margin1" style="margin: auto auto 5px auto;">
	<form class="form-inline" name="select-category" id="select-category" > <!--method="post" action="/mimi/bookmarksearch" -->
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
				id="textSearch" size="8">​​​​​​​
			<button type="button" class="btn" id="submitBtn" style="outline: none;">
				검색&nbsp;<i class="fas fa-search"></i>
			<!-- <button type="submit" class="btn" name="btn" style="outline: none;">
				검색&nbsp;<i class="fas fa-search"></i> -->
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
	<tbody id="row">
	
	<% for(Board b : list){ 
		String num = b.getBoardNo().substring(2).replaceAll("^0*","");//글번호만 추출
		String gb = null, imgsrc = null, link = null;
		if(b.getBoardGb().equals("AR")){
			gb = "MIMI리뷰";
			imgsrc = "/mimi/resources/files/adminboard/";
			link = "/mimi/adminboarddetailview";
		}else{
			gb = "유저리뷰";
			imgsrc = "/mimi/resources/files/userboard/";
			link = "/mimi/userboarddetailview";
		}
	%>
	
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne" value="<%= b.getBoardNo()%>"></td>
		<td><!-- 게시판구분 --><%= gb %></td>
		<td><!-- 글번호 --><%= num %></td>
		<td class="tbl-td-title"><!-- 썸네일 --><a href="<%= link %>?bnum=<%=b.getBoardNo() %>&page=1">
		<img class="img-thumb img-mover"  src="<%= imgsrc %><%= b.getThumbnailName()%>" onerror="this.onerror=null;this.src='/mimi/resources/images/main/img3.jpg'"></a>
		<!-- 제목 -->&nbsp;&nbsp;<a href="<%= link %>?bnum=<%=b.getBoardNo() %>&page=1"><%= b.getTitle() %>
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
		<ul id="searchListPagination" class="pagination" style="float: center; display: flex; justify-content: center;">
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
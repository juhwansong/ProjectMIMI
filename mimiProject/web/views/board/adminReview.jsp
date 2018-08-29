<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="boardError.jsp"%>
<%@ page import="java.util.*, java.text.*, common.model.vo.Board" %>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("boardList");
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
		var searchText = $("#search-text").val();
		var jsonStr = JSON.stringify(data);			
		var json = JSON.parse(jsonStr);
		
		$("#row").empty(); //기존 목록 전부 지우기
		values = ""; //변수 선언
		//console.log("row html 확인하기  :: " + values);
		
		for(var i in json.list){		
			values += '<div class="col-lg-4 col-sm-6 portfolio-item"><div class="rounded"><div class="img-div"><div class="cb">'
					+ '<span class="text"><i class="fas fa-comments"></i>' + json.list[i].commentNum
					+ '&nbsp;&nbsp;<i class="far fa-thumbs-up"></i>' + json.list[i].recommend
					+ '</span> </div> <a href="#"><img class="img img-mover" src="/mimi/resources/images/main/img3.jpg" alt="/mimi/resources/images/main/img3.jpg"></a>'
					+ '</div> <div class="r-body"> <table class="r-table"><tr><td><h4><a href="#">' + decodeURIComponent(json.list[i].title)
					+ '</a></h4></td><td class="td-ast" style="font-size: 12px;">' + json.list[i].boardDate
					+ '</td></tr></table><p class="r-text">' + decodeURIComponent(json.list[i].contents) + '</p></div></div></div>'
			
		}//for 
		
		$("#row").html(values); //목록 채우기
	
		//pagination
		$("#adminPagination").empty(); //기존 페이지네이션 지우기
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
		$("#adminPagination").html(pageValues);//페이지네이션
		$('html, body').scrollTop(0); //상단으로 이동
		}//callback function		
		
		function paging(p){
			$.ajax({		
				url : "adminboardsearch",
				data : {category : categoryValue, keyword : searchText, page : p},
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
				url : "adminboardsearch",
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
		$("#submitBtn").on('click', function(){
			categoryValue = $("#select-category option:selected").val();
			searchText = $("#search-text").val();
			//console.log("버튼 실행 확인...");
			$.ajax({
				
				url : "adminboardsearch",
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
			
			//값 확인
			//console.log("order : " + order + "\nsort : " + sort);
			//console.log("categoryValue : " + categoryValue + "\nsearchText : " + searchText);
			
			$.ajax({
				
				url : "adminboardsearch",
				data : {category : categoryValue, keyword : searchText, order : order, sort : sort, page : page},
				type : "post",
				dataType : "json",
				success : function(data){
					callback(data);					
				}//success
			})//ajax
		})//sort
		
	})//document close

</script>

<div class="container" style="width:1150px;">
<h3>MIMI 리뷰</h3>
<hr class="margin2">
<!-- 검색 -->

	<form class="form-inline" name="select" id="select" method="post" action="#">
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
		</div>
		<!-- 오른쪽 -->
		<div class="form-group" style="float: right; margin: 1px;">
			 <input type="text" class="form-control" name="search-text" id="search-text" size="12">​​​​​​​
			<button type="button" id="submitBtn" class="btn" name="btn" style="outline: none">
				검색&nbsp;<i class="fas fa-search"></i>
			</button>
		</div>
	</form>

	<!-- 게시물 시작 -->
	<hr class="margin2">
	<div class="row" id="row">
		<% for (Board b : list){ 
			SimpleDateFormat sdf = new SimpleDateFormat("MM.dd");
			String date = sdf.format(b.getBoardDate());
		%>
		<div class="col-lg-4 col-sm-6 portfolio-item">
			<div class="rounded"><!-- 카드 테두리 둥글게 -->
				<div class="img-div"><!-- 이미지사이즈 -->
					<div class="cb"><!-- 이미지 하단 텍스트영역 -->
						<span class="text"> <i class="fas fa-comments"></i><%= b.getCommentNum()%><!-- 댓글수 -->&nbsp;&nbsp;
							<i class="far fa-thumbs-up"></i><%= b.getRecommed()%><!-- 좋아요 수 -->
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
									<a href="#"><%= b.getTitle() %></a>
								</h4> <!-- 한글 최대 14글자 -->

							</td>
							<td class="td-ast" style="font-size: 12px;">
								<%= date%><!-- 작성일 -->
							</td>
						</tr>
					</table>
					<p class="r-text"><%= b.getContents() %></p>
				</div>
			</div>
		</div>
		<% } %>
	
	</div>
	<!-- /row -->
	
	
<hr class="margin1">

<table style="width:100%">
	<tr>
		<td width="10%"></td><!-- 빈칸 -->
		<td width="*"><!-- 페이지 -->
		<!-- Pagination -->
			<ul class="pagination" id="adminPagination" style="float: center; display: flex; justify-content: center;">
				<!-- 맨앞으로 -->
				<li>
				<% if(currentPage <= 1){ %>
					<span style="color:#ccc;">&laquo;</span>
				<% }else{ %>
					<a href="/mimi/adminboardlist?page=1" title="맨처음"><span style="color:#444;">&laquo;</span></a>
				<% } %>
				</li>
				
				<!-- 하나 앞으로 -->
				<li>
				<% if((currentPage - 10) <= startPage && (currentPage - 10) > 1){ %>
					<a href="/mimi/adminboardlist?page=<%=startPage - 10%>" title="이전"><span style="color:#444;">&lt;</span></a>
				<% }else if(currentPage != 1){ %>	
					<a href="/mimi/adminboardlist?page=1" title="이전"><span style="color:#444;">&lt;</span></a>
				<% }else{ %>
					<span style="color:#ccc;">&lt;</span>
				<% } %>
				</li>
				
				<% for(int p = startPage; p <= endPage; p++){
						if(p == currentPage){%>
				<li><span style="color:#ccc;"><%=p %></span></li>
				<% }else{ %>
				<li><a href="/mimi/adminboardlist?page=<%=p%>"><span style="color:#444;"><%=p %></span></a></li>
				<% }} %>
					
				
				<!-- 하나 뒤 -->
				<% if((currentPage + 10) <= maxPage){ %>
				<li><a href="/mimi/adminboardlist?page=<%=currentPage + 10%>" title="다음"><span style="color:#444;">&gt;</span></a></li>
				<% }else if((currentPage + 10) > maxPage && currentPage < maxPage){ %>
				<li><a href="/mimi/adminboardlist?page=<%=maxPage%>" title="다음"><span style="color:#444;">&gt;</span></a></li>
				<% }else{ %>
				<li><span style="color:#ccc;">&gt;</span></li>
				<!-- 맨뒤 -->
				<% }
					if(currentPage >= maxPage){%>
					<li><span style="color:#ccc;">&raquo;</span></li>
				<% }else{ %>
				<li>
					<a href="/mimi/adminboardlist?page=<%=maxPage%>" title="맨끝"><span style="color:#444;">&raquo;</span></a>
				</li>
				<% } %>
				
			</ul>	
		</td>
		<!-- 글쓰기버튼 -->
		<td width="10%" style="vertical-align:top;">
		<% if(authority != null && authority.equals("A")){ %>
			<input type="button" class="btn btn-default pull-right"
			onclick="location.href='/mimi/userReview/userReviewInsert.jsp'"
			value="글쓰기" style="outline: none;">
		<% } %>
			</td>
	</tr>
</table>
</div><!-- /container -->


<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
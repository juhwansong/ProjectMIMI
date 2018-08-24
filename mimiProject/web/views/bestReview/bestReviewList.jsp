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
<%@include file="../../head.jsp"%>

<!-- Best Review -->
<script type="text/javascript">
	$(function(){		
		//select box 변경 시 ajax 실행
		$("#select-category").change(function(){
			year = $("#category-year option:selected").val();
			month = $("#category-month option:selected").val();
			//console.log("변경된 연도 : " + year + ", 월 : " + month);
 
			$.ajax({
				url : "bestboardsearchmonth",
				data : {year : year, month : month},
				type : "post",
				dataType : "json",
				success : function(data){	

					var jsonStr = JSON.stringify(data);			
					var json = JSON.parse(jsonStr);
					
					$("#tbody-contents").empty(); //기존 목록 전부 지우기
					values = ""; //변수 선언
					
					for(var i in json.list){		
						values += '<tr><% if(authority != null && authority.equals("A")){ %><td><input type="checkbox" name="checkOne" id="checkOne"></td><% } %>'
							+ '<td>' + json.list[i].selectedMonth + '</td><td>' + json.list[i].rank + '</td><td style="width: 160px"><a href="' + json.list[i].boardLink + '">'
// 							+ '<img class="img-thumb2 img-mover" src="' + json.list[i].thumbnail + '"></a></td><td><table><tr>' //이미지 주소 나오면 이걸로 변경
							+ '<img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img3.jpg"></a></td><td><table><tr>' //샘플용
							+ '<td class="tbl-td-title" style="vertical-align: middle;"><a href="' + json.list[i].boardLink + '">' + json.list[i].title + '&nbsp;&nbsp;'
							+ '<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;' + json.list[i].commentNum + '</span></a></td></tr>'
							+ '<tr><td><p class="r-text2">' + json.list[i].contents + '</p></td></tr></table></td><td>' + json.list[i].nickname + '</td><td>'
							+ json.list[i].hits + '</td><td>' + json.list[i].recommend + '</td></tr>'
						
					}//for 	
					$("#tbody-contents").html(values); //목록 채우기		
					$('html, body').scrollTop(0); //상단으로 이동
				}//success
			});//ajax
			 
		})//select box change
		
		
		
		//체크박스 전체선택,해제 함수
		$("#checkAll").click(function(){
			if ($("#checkAll").is(":checked")) {
				$("input[name=checkOne]").prop("checked", true);
			} else {
				$("input[name=checkOne]").prop("checked", false);
			}	
		})//checkbox
		
	})//document close
	
	
</script>

<!-- <title>Best리뷰게시판</title> -->

<div class="container" style="width:1150px;">
	<h3>Best 리뷰</h3>
	<hr class="margin1" style="margin: auto auto 5px auto;">
	<form class="form-inline" name="select-category" id="select-category" method="post" action="/mimi/bestboardsearch">
		<!-- 왼쪽 -->
		<div class="form-group">
			연도 <select class="form-control" id="category-year">
				<option value="18" selected>2018</option>
				<option value="17">2017</option>
				<option value="16">2016</option>
				<option value="15">2015</option>
			</select>&nbsp;&nbsp;&nbsp;월 <select class="form-control" id="category-month">
				<option value="01">01</option>
				<option value="02">02</option>
				<option value="03">03</option>
				<option value="04">04</option>
				<option value="05">05</option>
				<option value="06">06</option>
				<option value="07">07</option>
				<option value="08" selected>08</option>
				<option value="09">09</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
			</select>
		</div>
		<!-- 오른쪽 -->
		<div class="form-group" style="float: right; margin: 1px;">
			<input type="text" class="form-control" name="search-text" id="search-text" size="12">​​​​​​​
			<button type="submit" class="btn" style="outline: none;">
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
					<% if(authority != null && authority.equals("A")){ %>
					<th width="8%"><input type="checkbox" name="checkAll" id="checkAll">
						<span style="vertical-align:top;">전체선택</span></th>
					<% } %>
					<th width="8%"><i class="far fa-calendar"></i>선정일</th>
					<th width="8%">Rank</th>
					<th width="*" colspan="2">리뷰</th>
					<th width="12%"><i class="fas fa-pen"></i>작성자</th>
					<th width="8%"><i class="far fa-eye"></i>조회수</th>
					<th width="8%"><i class="far fa-thumbs-up"></i>추천</th>
				</tr>
			</thead>
			<tbody id="tbody-contents">
			<!-- 데이터 삽입부 -->
			<% for (Board b : list){ %>
			
				<tr>
					<!-- 관리자는 check박스 보임 -->
					<% if(authority != null && authority.equals("A")){ %>
					<td><input type="checkbox" name="checkOne" id="checkOne"></td>
					<% } %>
					<td><%= b.getGradeName() %></td><!-- 날짜 -->
					<td><%= b.getLongitude() %></td><!-- 랭크 -->
					<td style="width: 160px"><a href="#"><img class="img-thumb2 img-mover" src="/mimi/resources/images/main/img3.jpg"></a></td>
					<td>
						<table>
							<tr><!-- 제목/댓글 -->
								<td class="tbl-td-title" style="vertical-align: middle;"><a href="/mimi/views/userReview/userReviewView.jsp"><%= b.getTitle() %>&nbsp;&nbsp;
						<span class="span-c" style="margin:5px;"><i class="fas fa-comments"></i>&nbsp;<%= b.getCommentNum() %></span></a></td>
							</tr>
							<tr>
								<td><!-- 내용 -->
								<p class="r-text2"><%= b.getContents() %></p>
								</td>
							</tr>
						</table>
					</td>
					<td><%= b.getNickName() %></td><!-- nickName -->
					<td><%= b.getHits() %></td><!-- hits -->
					<td><%= b.getRecommed() %></td><!-- recommend -->
				</tr>
				
			<% } %>	
			<!-- ----- -->
			</tbody>
		</table>
<hr class="margin1" style="margin: 0px auto 5px auto;">

<table width="100%">
	<tr>
		<td width="25%"></td><!-- 빈칸 -->
		<td width="*"><!-- 페이지 -->
		<!-- Pagination -->
			<ul class="pagination" style="float: center; display: flex; justify-content: center;">
				<!-- 맨앞으로 -->
				<li>
				<% if(currentPage <= 1){ %>
					<span style="color:#ccc;">&laquo;</span>
				<% }else{ %>
					<a href="/mimi/bestboardsearch?page=1" title="맨처음"><span style="color:#444;">&laquo;</span></a>
				<% } %>
				</li>
				
				<!-- 하나 앞으로 -->
				<li>
				<% if((currentPage - 10) <= startPage && (currentPage - 10) > 1){ %>
					<a href="/mimi/bestboardsearch?page=<%=startPage - 10%>" title="이전"><span style="color:#444;">&lt;</span></a>
				<% }else if(currentPage > 1){ %>	
					<a href="/mimi/bestboardsearch?page=1" title="이전"><span style="color:#444;">&lt;</span></a>
				<% }else{ %>
					<span style="color:#ccc;">&lt;</span>
				<% } %>
				</li>
				
				<% for(int p = startPage; p <= endPage; p++){
						if(p == currentPage){%>
				<li><span style="color:#ccc;"><%=p %></span></li>
				<% }else{ %>
				<li><a href="/mimi/bestboardsearch?page=<%=p%>"><span style="color:#444;"><%=p %></span></a></li>
				<% }} %>
					
				
				<!-- 하나 뒤 -->
				<% if((currentPage + 10) <= maxPage){ %>
				<li><a href="/mimi/bestboardsearch?page=<%=currentPage + 10%>" title="다음"><span style="color:#444;">&gt;</span></a></li>
				<% }else if((currentPage + 10) > maxPage && currentPage < maxPage){ %>
				<li><a href="/mimi/bestboardsearch?page=<%=maxPage%>" title="다음"><span style="color:#444;">&gt;</span></a></li>
				<% }else{ %>
				<li><span style="color:#ccc;">&gt;</span></li>
				<!-- 맨뒤 -->
				<% }
					if(currentPage >= maxPage){%>
					<li><span style="color:#ccc;">&raquo;</span></li>
				<% }else{ %>
				<li>
					<a href="/mimi/bestboardsearch?page=<%=maxPage%>" title="맨끝"><span style="color:#444;">&raquo;</span></a>
				</li>
				<% } %>
				
			</ul>	
	</td>
		<!-- 버튼 -->
			<td width="25%" style="vertical-align: top;">
			<!-- 관리자 전용 버튼 -->
			<% if(authority != null && authority.equals("A")){ %>
			<input type="button" class="btn btn-default pull-right" onclick="/mimi/bestboarddelete" value="숨기기" style="outline: none; margin:1px;">
			<% } %>
			</td>
		</tr>
</table>
	</form>
</div>

<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="adminPageError.jsp"%>
<%@ page import="common.model.vo.Board, java.util.ArrayList" %>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	String servletName = (String)request.getAttribute("servletName");
	
	String category = (String)request.getAttribute("category");
	String searchText = (String)request.getAttribute("searchText");
%>
<!-- head -->
<%@include file="../../head.jsp" %>
<!-- body -->
<%@include file="../../adminHeader.jsp" %>
<style>
.sidenav {
    height: 35%; /* 변경 */
    width: 0;
    position: fixed;
    z-index: 0;
    top: 0;
    left: 0;
     background-color: #fff; 
    overflow-x: hidden;
    padding-top: 60px;
    margin-top: 90px;
    /* margin-left: 100px; */
    /* /////////////////////////추가////////////////////////// */
    display: none;
}

.sidenav a {
    padding: 3px 3px 3px 1px;
    text-decoration: none;
    text-align: center;
    font-size: 13px; /*변경*/
    color: #888; /*변경*/
    display: block;
    border: 0px;
    border-radius: 20px 20px 20px 20px;
    margin-bottom: 5px;
    margin-left: 15px;
    margin-right: 15px;
/*     transition: 0.3s; */
}

#menuItem:hover {
    background-color: #eee;
    color: #000;
    text-decoration: none;
}

#menuItem:hover:before {
	content: "▶";
}


/* /////////////////////////사용 안함////////////////////////// */
.sidenav .closebtn { /* x버튼... */
    position: absolute;
    top: 20px; /*변경*/
    right: 25px;
    font-size: 20px; /*변경*/
    margin-left: 50px;
    color: #aaa;  /*추가*/
}
/* /////////////////////////사용 안함////////////////////////// */



#quickMenu {
	width: 300px;
	height: 60px;
	font-size:25px;
    cursor:pointer;
/*     transition: margin-left .5s; */
    padding: 16px;
/*     display: inline-block; */
   /*  float: left; */
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}

#main, #menuTitle {
	position: relative;
}
</style>

<script type="text/javascript">
	$(function(){
		$(".dropdown-menu li a").click(function(){
			$("#selectBtn:first-child").text($(this).text());
	   	});
		
		//column checkbox select all or cancel
		$("input.select-all").click(function() {
			var checked = this.checked;
			$("input.select-item").each(function(index, item) {
				item.checked = checked;
				console.log($(this).val());
			});
		});
	
		//check selected items
		$("input.select-item").click(function() {
			var checked = this.checked;
			console.log(checked);
			console.log($(this).val());
			checkSelected();
		});
	
		//check is all selected
		function checkSelected() {
			/* var all = $("input.select-all")[0]; */
			var all = $("input.select-all");
			var total = $("input.select-item").length;
			var len = $("input.select-item:checked:checked").length;
			console.log("total:" + total);
			console.log("len:" + len);
			all.checked = len === total;
		}
		
		//관리자 메뉴 토글
		$("#quickMenu").click(function(){
			$("#mySidenav").toggle(function(){
 			    console.log("실행됨");
				//$("#mySidenav").css({"width" : "150px"});

			})
			
		})
	});
	
	function deleteRow() {
		var selected = new String();
		
		$("input.select-item").each(function(index, item) {
			if($(this).is(':checked')) {
				selected += $(this).val() + " ";
			}
		});
		
		$.get("/mimi/allboarddelete", {boardNoStr: selected}, function() {
			location.href="/mimi/allboardlist?page=1";
		});
		
		<%-- $.ajax({
			url: "/mimi/allboarddelete",
			type: "get",
			data: {boardNoStr: selected},
			success: function(data) {
				console.log(selected);
			}
		}); --%>
	};
/* 	
	function openNav() {
	    document.getElementById("mySidenav").style.width = "190px";
	    document.getElementById("main").style.marginLeft = "160px";
	    document.getElementById("quickMenu").style.marginLeft = "160px";
	}

	function closeNav() {
	    document.getElementById("mySidenav").style.width = "0";
	    document.getElementById("main").style.marginLeft= "0";
	    document.getElementById("quickMenu").style.marginLeft = "0";
	} */
</script>

<!-- ------------------------------------------------ -->
<div id="mySidenav" class="sidenav" style="width:150px;"><!--추가--><!-- 
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a> -->
  <a href="adminPage.jsp" id="menuItem" style="color: #555; font-weight: 600; font-size:15px;">관리자 메뉴</a>
  <a href="views/admin/userInfoManage.jsp" id="menuItem">전체 회원 관리</a>
  <a href="/mimi/allboardlist" id="menuItem">전체 게시글 관리</a>  
  <a href="/mimi/allcommentlist" id="menuItem">전체 댓글 관리</a>
</div>

<div class="container container-fluid" style="width:1150px;">
	<div class="container-fluid" id="main">
	<table width="100%" border="0">
		<tr>
		<td><h3><span id="quickMenu" title="관리자 메뉴 열기">&#9776;&nbsp;</span>전체 게시글 관리</h3></td>
			<td style="text-align: right; vertical-align: bottom; color: #777">
				<!-- 카테고리 -->
				<form class="form-inline" name="select-category"
					id="select-category" method="get" action="/mimi/allboardsearch?page=1">
					<div class="form-group" style="float: right; margin: 3px;">
						<select name="category" id="category" class="form-control">
							<option value="ALL" selected>전체</option>
							<option value="BOARD_NO">글번호</option>
							<option value="TITLE">제목</option>
							<option value="NICKNAME">작성자</option>
						</select> <input type="text" class="form-control" name="search-text"
							id="search-text" size="8" placeholder=" ">&nbsp; ​​​​​​​
						<button type="submit" class="btn" name="btn" style="outline:none">
							검색&nbsp;<i class="fas fa-search"></i>
						</button>
					</div>
				</form>
			</td>
		</tr>
	</table>
<hr class="margin2">
	<!-- table -->
	<table class="table table-hover" id="table-css">
		<thead>
			<tr>
				<th><input type="checkbox" class="select-all checkbox"
					name="select-all" /></th>
				<th width="*">글번호</th>
				<th width="50%">제목</th>
				<th width="12%"><i class="fas fa-pen"></i>작성자</th>
				<th width="8%"><i class="far fa-calendar"></i>작성일</th>
				<th width="8%"><i class="far fa-eye"></i>조회수</th>
				<th width="8%"><i class="far fa-thumbs-up"></i>추천</th>
			</tr>
		</thead>
		<tbody>
			<% for(Board b : list) { %>
				<tr>
				<td><input type="checkbox" class="select-item checkbox"
					name="select-item" value="<%= b.getBoardNo() %>" /></td>
				<td><%= b.getBoardNo().substring(2).replaceAll("^0*", "") %></td>
				<td class="tbl-td-title"><%= b.getTitle() %></td>
				<td><%= b.getNickName() %></td>
				<td><%= b.getBoardDate() %></td>
				<td><%= b.getHits() %></td>
				<td><%= b.getRecommed() %></td>
				</tr>
			<% } %> 
			<!-- <tr>
				<td><input type="checkbox" class="select-item checkbox"
					name="select-item" value="1000" /></td>
				<td>2</td>
				<td class="tbl-td-title">titleeeeeeeeeeeeeeeeeeeeeee</td>
				<td>admin</td>
				<td>18-07-31</td>
				<td>200</td>
				<td>143</td>
			</tr>
			<tr>
				<td><input type="checkbox" class="select-item checkbox"
					name="select-item" value="1001" /></td>
				<td>2</td>
				<td class="tbl-td-title">titleeeeeeeeeeeeeeeeeeeeeee</td>
				<td>admin</td>
				<td>18-07-31</td>
				<td>200</td>
				<td>143</td>
			</tr>
			<tr>
				<td><input type="checkbox" class="select-item checkbox"
					name="select-item" value="1001" /></td>
				<td>3</td>
				<td class="tbl-td-title">titleeeeeeeeeeeeeeeeeeeeeee</td>
				<td>user01</td>
				<td>18-07-31</td>
				<td>500</td>
				<td>250</td>
			</tr>
			<tr>
				<td><input type="checkbox" class="select-item checkbox"
					name="select-item" value="1001" /></td>
				<td>4</td>
				<td class="tbl-td-title">titleeeeeeeeeeeeeeeeeeeeeee</td>
				<td>user01</td>
				<td>18-07-31</td>
				<td>33</td>
				<td>5</td>
			</tr> -->
		</tbody>
	</table>
<hr class="margin1" style="margin: 0px auto 5px auto;">

<table width="100%">
	<tr>
		<td width="10%"></td><!-- 빈칸 -->
		<td width="*"><!-- 페이지 -->
	<!-- Pagination -->
		<!-- <ul class="pagination" style="float: center; display: flex; justify-content: center;">
			<li>
				<a href="/mimi/allboardlist?page=1" aria-label="Previous">
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
		</ul> -->
		<ul class="pagination" style="float: center; display: flex; justify-content: center;">
         <!-- 맨앞으로 -->
         <li>
         <% if(currentPage <= 1){ %>
            <span style="color:#ccc;">&laquo;</span>
         <% }else{ %>
         	<% if(category == null || category.equals("ALL")) { %>
         		<a href="/mimi/allboardlist?page=1&category=<%=category%>&searchText=<%=searchText%>" title="맨처음"><span style="color:#444;">&laquo;</span></a>
         	<% } else { %>
            	<a href="/mimi/allboardsearch?page=1&category=<%=category%>&searchText=<%=searchText%>" title="맨처음"><span style="color:#444;">&laquo;</span></a>
         	<% } %>
         <% } %>
         </li>
         
         <!-- 하나 앞 -->
         <li>
         <% if((currentPage - 10) < startPage && (currentPage - 10) > 1){ %>
			<% if(category == null || category.equals("ALL")) { %>
         		<a href="/mimi/allboardlist?page=<%=startPage - 10%>&category=<%=category%>&searchText=<%=searchText%>" title="이전"><span style="color:#444;">&lt;</span></a>
         	<% } else { %>
				<a href="/mimi/allboardsearch?page=<%=startPage - 10%>&category=<%=category%>&searchText=<%=searchText%>" title="이전"><span style="color:#444;">&lt;</span></a>  
         	<% } %>
         <% }else{ %>
            <span style="color:#ccc;">&lt;</span>
         <% } %>
         </li>
         
         <% for(int p = startPage; p <= endPage; p++){
               if(p == currentPage){%>
         <li><span style="color:#ccc;"><%=p %></span></li>
         <% }else{ %>
            <% if(category == null || category.equals("ALL")) { %>
         		<li><a href="/mimi/allboardlist?page=<%=p%>&category=<%=category%>&searchText=<%=searchText%>"><span style="color:#444;"><%=p %></span></a></li>
         	<% } else { %>
            	<li><a href="/mimi/allboardsearch?page=<%=p%>&category=<%=category%>&searchText=<%=searchText%>"><span style="color:#444;"><%=p %></span></a></li>
         	<% } %>
         <% }} %>
         
         <!-- 하나 뒤 -->
         <% if((currentPage + 10) > endPage && (currentPage + 10) < maxPage){ %>
         <li>
         	<% if(category == null || category.equals("ALL")) { %>
         		<a href="/mimi/allboardlist?page=<%=endPage + 10%>&category=<%=category%>&searchText=<%=searchText%>" title="다음"><span style="color:#444;">&gt;</span></a>
         	<% } else { %>
				<a href="/mimi/allboardsearch?page=<%=endPage + 10%>&category=<%=category%>&searchText=<%=searchText%>" title="다음"><span style="color:#444;">&gt;</span></a>							                 
         	<% } %>
         </li>
         <% }else{ %>
         <li><span style="color:#ccc;">&gt;</span></li>
         <!-- 맨뒤 -->
         <% }
 			if(currentPage >= maxPage){%>
            <li><span style="color:#ccc;">&raquo;</span></li>
         <% }else{ %>
         <li>
         	<% if(category == null || category.equals("ALL")) { %>
         		<a href="/mimi/allboardlist?page=<%=maxPage%>&category=<%=category%>&searchText=<%=searchText%>" title="맨끝"><span style="color:#444;">&raquo;</span></a>
         	<% } else { %>
            	<a href="/mimi/allboardsearch?page=<%=maxPage%>&category=<%=category%>&searchText=<%=searchText%>" title="맨끝"><span style="color:#444;">&raquo;</span></a>
         	<% } %>
         </li>
         <% } %>
         
      </ul>   	
	</td>
		<!-- 삭제버튼 -->
			<td width="10%" style="vertical-align: top;">
			<input type="button" class="btn btn-default pull-right" onclick="deleteRow();" value="삭제" style="outline: none;"></td>
		</tr>
</table>
</div>
</div><!-- /container -->
<!-- 		</div>
		/.col-xs-12.col-sm-9
	</div>
	/row -->

<!-- ------------------------------------------------ -->
<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
<!-- ------------------------------------------------ -->
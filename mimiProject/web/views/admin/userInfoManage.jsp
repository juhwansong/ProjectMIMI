<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="adminError.jsp"%>
<%@ page import="java.util.*, common.model.vo.Member" %>
<%
	ArrayList<Member> list = (ArrayList<Member>)request.getAttribute("customerList");
	int totalCount = ((Integer) request.getAttribute("totalCount")).intValue();
	int startPage = ((Integer) request.getAttribute("startPage")).intValue();
	int endPage = ((Integer) request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer) request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer) request.getAttribute("currentPage")).intValue();
%>
<!-- head -->
<%@include file="../../head.jsp" %>
<!-- body -->
<!--------------------------------------------------------------------------->
<style>
.sidenav {
    height: 35%;
    width: 0;
    position: fixed;
    z-index: 0;
    top: 0;
    left: 0;
     background-color: #fff; 
    overflow-x: hidden;
    padding-top: 60px;
    margin-top: 90px;
    display: none;
}

.sidenav a {
    padding: 3px 3px 3px 1px;
    text-decoration: none;
    text-align: center;
    font-size: 13px;
    color: #888;
    display: block;
    border: 0px;
    border-radius: 20px 20px 20px 20px;
    margin-bottom: 5px;
    margin-left: 15px;
    margin-right: 15px;
}

#menuItem:hover {
    background-color: #eee;
    color: #000;
    text-decoration: none;
}

#menuItem:hover:before {
	content: "▶";
}

#quickMenu {
	width: 300px;
	height: 60px;
	font-size:25px;
    cursor:pointer;
    padding: 16px;
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
		
		//체크박스 전체선택,해제 함수
		$("#checkAll").on('click', function(){
			if ($("#checkAll").is(":checked")) {
				$("input[name=checkOne]").prop("checked", true);
			} else {
				$("input[name=checkOne]").prop("checked", false);
			}	
		})	
		
		//사이드 메뉴
		$("#quickMenu").on('click', function(){
			$("#mySidenav").toggle(function(){
 			    //console.log("실행됨");
			})
		})
		

		//dropdown 변경시 자동 체크
		$("#table-css tr").on('click', function(){
			var index = $("tr").index(this);
			
			$("#dropdown1, #dropdown2").change(function(){					
				$("input[name=checkOne]").eq(index - 2).prop("checked", true);				
			})
				
		})
		
					
		//버튼 클릭시 체크되어있는 행에 대한 정보를 배열로 저장하여 submit to servlet
		$("#deleteBtn, #updateBtn").on('click', function(){
			//console.log("버튼클릭..."); //확인용
			var dataArr = new Array();
			
			var checkbox = $("input[name=checkOne]:checked");

			checkbox.each(function(i){
				var trr = checkbox.parent().parent().eq(i).children(); //행 전체
					
				var id = trr.eq(1).text();
				//var authority = trr.eq(7).val(); //값을 못 읽음
				
				var checkindex = trr.closest("tr").index(); //selectbox가 안 잡혀서 대체
				var authority = $("select[name=dropdown1]").eq(checkindex).val();
				var state = $("select[name=dropdown2]").eq(checkindex).val();				
				
				dataArr.push(id);
				dataArr.push(authority);
				dataArr.push(state);
				

				//확인용
				//console.log("check index : " + checkindex);
				//console.log("dataArr : " + dataArr);
				})
				
			$("input[name=dataArr]").val(dataArr); //hidden value
			console.log("dataArr outside : " + dataArr); //확인용

		});

		

		
	});//document

	
</script>

<div id="mySidenav" class="sidenav" style="width:150px;">
  <a href="views/admin/adminPage.jsp" id="menuItem" style="color: #555; font-weight: 600; font-size:15px;">관리자 메뉴</a>
  <a href="/mimi/customerlist" id="menuItem">전체 회원 관리</a>
  <a href="/mimi/allboardlist" id="menuItem">전체 게시글 관리</a>  
  <a href="/mimi/allcommentlist" id="menuItem">전체 댓글 관리</a>
</div>

<div class="container container-fluid" style="width:1150px;">
	<div class="container-fluid" id="main">
	<table width="100%" border="0">
		<tr>
		<td><h3><span id="quickMenu" title="관리자 메뉴 열기">&#9776;&nbsp;</span>전체 회원 관리</h3></td>
			<td style="text-align: right; vertical-align: bottom; color: #777">
				<!-- 카테고리 -->
				<form class="form-inline" method="post" action="/mimi/customersearch">
					<div class="form-group" style="float: right; margin: 3px;">
						<select class="form-control" name="select-category">
							<option value="all" selected>전체</option>
							<option value="user_id">아이디</option>
							<option value="nickname">닉네임</option>
							<option value="email">이메일</option>
							<option value="phone">전화번호</option>
							<option value="grade_name">등급명</option>
							<option value="authority">권한</option>
							<option value="state">상태</option>
						</select> <input type="text" class="form-control" name="search-text"
							id="search-text" size="8">&nbsp; ​​​​​​​
						<button type="submit" class="btn" name="btn" style="outline:none">
							검색&nbsp;<i class="fas fa-search"></i>
						</button>
					</div>
				</form>
			</td>
		</tr>
	</table>
	</div>
		<hr class="margin2">
<!-- 게시글 -->
<form name="formtag" method="post">
<input type="hidden" name="dataArr" value="null">
<table class="table table-hover" id="table-css">
	<thead>
	<tr>
	<!-- 순서 : checkbox, 아이디, 닉네임, 이메일, 전화번호, 등급명, 등급포인트, 권한, 상태 -->
		<th width="8%"><input type="checkbox" name="checkAll" id="checkAll">
			<span style="vertical-align:top;">전체선택</span></th>
		<th width="12%">아이디</th>
		<th width="12%">닉네임</th>
		<th width="*%">이메일</th>
		<th width="12%">전화번호</th>
		<th width="8%">등급명</th>
		<th width="8%">등급포인트</th>
		<th width="10%">권한</th>
		<th width="10%">상태</th>
	</tr>
	</thead>
	<tbody>
	<% for (Member member : list) {

		String authority1 = (member.getAuthority().equals("A")) ? "관리자" : "회원";
		String authority2 = (member.getAuthority().equals("A")) ? "회원" : "관리자";

 		String state1 = (member.getState().equals("SN")) ? "일반" : "삭제대기";
 		String state2 = (member.getState().equals("SN")) ? "삭제대기" : "일반";

	%>
	<tr>
		<td><input type="checkbox" name="checkOne" id="checkOne"></td>
		<td><%= member.getUserId() %><!-- 아이디 --></td>
		<td><%= member.getNickName() %><!-- 닉네임 --></td>
		<td><%= member.getEmail() %><!-- 이메일 --></td>
		<td><%= member.getPhone() %><!-- 전화번호 --></td>
		<td><%= member.getGradeName() %><!-- 등급명 --></td>
		<td><%= member.getGradePoint() %><!-- 등급포인트 --></td>
		<td>
		<!-- 권한 -->
		<select class="border-zero" name="dropdown1" id="dropdown1">
			<option value="<%= authority1 %>" selected><%= authority1 %></option>
			<option value="<%= authority2 %>"><%= authority2 %></option>
		</select>
		</td>
		<td><!-- 상태 -->
		<select class="border-zero" name="dropdown2" id="dropdown2">
			<option value="<%= state1 %>" selected><%= state1 %></option>
			<option value="<%= state2 %>"><%= state2 %></option>
		</select>
		</td>
	</tr>

	<% } %> <!-- ArrayList 종료 -->
	</tbody>
</table>


<!-- /게시글 -->
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
				<a href="/mimi/customerlist?page=1" title="맨처음"><span style="color:#444;">&laquo;</span></a>
			<% } %>
			</li>
			
			<!-- 하나 앞으로 -->
			<li>
				<% if((currentPage - 10) < startPage && (currentPage - 10) > 1){ %>
				<a href="/mimi/customerlist?page=<%=startPage - 10%>" title="이전"><span style="color:#444;">&lt;</span></a>	
			<% }else{ %>
				<span style="color:#ccc;">&lt;</span>
			<% } %>
			</li>
			
			<% for(int p = startPage; p <= endPage; p++){
					if(p == currentPage){%>
			<li><span style="color:#ccc;"><%=p %></span></li>
			<% }else{ %>
			<li><a href="/mimi/customerlist?page=<%=p%>"><span style="color:#444;"><%=p %></span></a></li>
			<% }} %>
			
			<!-- 하나 뒤 -->
			<% if((currentPage + 10) > endPage && (currentPage + 10) < maxPage){ %>
			<li>
				<a href="/mimi/customerlist?page=<%=endPage + 10%>" title="다음"><span style="color:#444;">&gt;</span></a>
			</li>
			<% }else{ %>
			<li><span style="color:#ccc;">&gt;</span></li>
			<!-- 맨뒤 -->
			<% }
				if(currentPage >= maxPage){%>
				<li><span style="color:#ccc;">&raquo;</span></li>
			<% }else{ %>
			<li>
				<a href="/mimi/customerlist?page=<%=maxPage%>" title="맨끝"><span style="color:#444;">&raquo;</span></a>
			</li>
			<% } %>
			
		</ul>	
	</td>
		<!-- 버튼 -->
			<td width="25%" style="vertical-align: top;">
			<input type="submit" class="btn btn-default pull-right" id="deleteBtn" onclick="this.form.action='/mimi/customerdelete';" value="삭제" style="outline: none; margin:1px;">
			<input type="submit" class="btn btn-default pull-right" id="updateBtn" onclick="this.form.action='/mimi/customerupdate';" value="수정" style="outline: none; margin:1px;"></td>
			
		</tr>
</table>
</form>
</div><!-- /container -->

<!-- ------------------------------------------------ -->
<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
<!-- ------------------------------------------------ -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, common.model.vo.Member" %>
<%
	ArrayList<Member> list = (ArrayList<Member>)request.getAttribute("customerList");
%>
<!-- head -->
<%@include file="../../head.jsp" %>
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
/*     transition: 0.3s; */ /*변경*/
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
/* transition: margin-left .5s; */
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
		
		//체크박스 전체선택,해제 함수
		$("#checkAll").click(function(){
			if ($("#checkAll").is(":checked")) {
				$("input[name=checkOne]").prop("checked", true);
			} else {
				$("input[name=checkOne]").prop("checked", false);
			}	
		})	
		
		$("#quickMenu").click(function(){
			$("#mySidenav").toggle(function(){
 			    console.log("실행됨");
/* 				$("#mySidenav").css({"width" : "150px"}); */
				/* $("#mySidenav").css({"display" : "block"}); */
				
				
			})
			
		})
		
		
	});//document

	
</script>

<div id="mySidenav" class="sidenav" style="width:150px;">
  <a href="adminPage.jsp" id="menuItem" style="color: #555; font-weight: 600; font-size:15px;">관리자 메뉴</a>
  <a href="userInfoManage.jsp" id="menuItem">전체 회원 관리</a>
  <a href="contentManage.jsp" id="menuItem">전체 게시글 관리</a>  
  <a href="commentManage.jsp" id="menuItem">전체 댓글 관리</a>
</div>

<div class="container container-fluid" style="width:1150px;">
	<div class="container-fluid" id="main">
	<table width="100%" border="0">
		<tr>
		<td><h3><span id="quickMenu" title="관리자 메뉴 열기">&#9776;&nbsp;</span>전체 회원 관리</h3></td>
			<td style="text-align: right; vertical-align: bottom; color: #777">
				<!-- 카테고리 -->
				<form class="form-inline" name="select-category"
					id="select-category" method="get" action="#">
					<div class="form-group" style="float: right; margin: 3px;">
						<select class="form-control">
							<option value="1" selected>전체</option>
							<option value="2">제목</option>
							<option value="3">내용</option>
							<option value="4">글번호</option>
						</select> <input type="text" class="form-control" name="search-text"
							id="search-text" size="8" placeholder=" ">&nbsp; ​​​​​​​
						<button type="button" class="btn" name="btn" style="outline:none">
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
	<% for (Member member : list) { %>
	<tbody>
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
			<option value="<%= member.getAuthority() %>" selected><%= member.getAuthority() %></option>
			<option value="<%--그외값1--%>">관리자</option>
		</select>
		</td>
		<td><!-- 상태 -->
		<select class="border-zero" name="dropdown2" id="dropdown2">
			<option value="<%= member.getState() %>" selected><%= member.getState() %></option>
			<option value="<%--그외값1--%>">삭제대기</option>
		</select>
		</td>
	</tr>
	</tbody>
	<% } %> <!-- ArrayList 종료 -->
</table>


<!-- /게시글 -->
<hr class="margin1" style="margin: 0px auto 5px auto;">

<table width="100%">
	<tr>
		<td width="25%"></td><!-- 빈칸 -->
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
		<!-- 버튼 -->
			<td width="25%" style="vertical-align: top;">
			<input type="button" class="btn btn-default pull-right" onClick="#" value="삭제" style="outline: none; margin:1px;">
			<input type="button" class="btn btn-default pull-right" onClick="#" value="수정" style="outline: none; margin:1px;"></td>
		</tr>
</table>
</div><!-- /container -->

<!-- ------------------------------------------------ -->
<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
<!-- ------------------------------------------------ -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="support.model.vo.Support" %>

<%
	String userId = (String) session.getAttribute("userId");
%>

<%@include file="../../head.jsp" %>
<%@include file="../../header.jsp" %>

<!-- <title>mimi</title> -->

<div class="container" style="width:1150px;">
	<h3>고객센터</h3>
	<div class="form-group">
	<form action="/mimi/supportinsert" method="post" >

		<table class="table" id="table-css2">
		<tr>
				<th width="15%">카테고리</th>
				<td colspan="3" style="text-align: left;">
					&nbsp;&nbsp;<input type="radio" name="ctype" value="0">문의
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="ctype" value="1">신고
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="ctype" value="2">기타
				</td>
			</tr>
		
		
			<tr>
				<th width="15%">제목</th>
				<td><input type="text" name="title" class="form-control" placeholder="제목을 입력해 주세요"></td>
				<th width="15%">작성자</th>
				<td width="20%"><%= userId %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"><textarea class="form-control" name="contents" rows="15" placeholder="내용을 입력해주세요"></textarea></td>
			</tr>
	
		</table>
		
		
</div>
<hr class="margin2">
		<div align="center" style="margin:5px;">
		<input type="submit" class="btn btn-default" name="btn" value ="작성완료" style="outline:none">&nbsp;
		<input type="button" class="btn btn-default" name="btn" onClick="location.href='/mimi/supportlist'" value="취소" style="outline:none">
		</div>
</div>
</form>
<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
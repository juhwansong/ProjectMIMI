<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="support.model.vo.Support,  java.util.*" %>

<%
	Support support = (Support)request.getAttribute("support");
	int currentPage = ((Integer)request.getAttribute("page")).intValue();
	
%>

<%@include file="../../head.jsp" %>


<!-- <title>mimi</title> -->

<div class="container" style="width:1150px;">
	<h3>고객센터 글 수정</h3>
	
	
	<form action="/mimi/updatebtn" method="post">
		<input type="hidden" name="bno" value="<%= support.getBoardNo() %>">
		<input type="hidden" name="writer" value="<%= support.getUserId() %>">
		<input type="hidden" name="page" value="<%= currentPage %>">
		<div class="form-group">
		
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
				<td><input type="text" name="title" class="form-control" value="<%= support.getTitle() %>"></td>
				<th width="15%">작성자</th>
				<td width="20%"><%= support.getUserId() %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"><textarea class="form-control" name="contents" rows="15"><%= support.getContents() %></textarea></td>
			</tr>
	
		</table>
		
</div>
<hr class="margin2">
		<div align="center" style="margin:5px;">
		<input type="submit" class="btn btn-default" name="btn" value ="수정완료" style="outline:none">&nbsp;
		<input type="reset" class="btn btn-default" name="btn" value="취소" style="outline:none">
		</div>
	</form>	
</div>

<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
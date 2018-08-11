<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>
<%@include file="../../header.jsp" %>

<!-- <title>mimi</title> -->

<div class="container" style="width:1150px;">
	<h3>고객센터</h3>
	<div class="form-group">

		<table class="table" id="table-css2">
		<tr>
				<th width="15%">카테고리</th>
				<td colspan="3" style="text-align: left;">
					&nbsp;&nbsp;<input type="radio" name="ctype">문의
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="ctype">신고
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="ctype">기타
				</td>
			</tr>
		
		
			<tr>
				<th width="15%">제목</th>
				<td><input type="text" class="form-control" placeholder="제목을 입력해 주세요"></td>
				<th width="15%">작성자</th>
				<td width="20%">USER ID</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"><textarea class="form-control" rows="15" placeholder="내용을 입력해주세요"></textarea></td>
			</tr>
	
		</table>
</div>
<hr class="margin2">
		<div align="center" style="margin:5px;">
		<button type="button" class="btn btn-default" name="btn" onClick="location.href='/mimi/views/member/customer.jsp'" style="outline:none">작성완료</button>
		<button type="button" class="btn btn-default" name="btn" onClick="location.href='/mimi/views/member/customer.jsp'" style="outline:none">취소</button>
		</div>
</div>
<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
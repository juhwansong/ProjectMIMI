<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>

<!-- <title>MIMI</title> -->


<div class="container" style="width:1150px;">
	<h3>공지사항 작성</h3>
	<div class="form-group">
		<table class="table" id="table-css2">
			<tr>
				<th width="15%">제목</th>
				<td><input type="text" class="form-control" placeholder="제목 입력"></td>
				<th width="15%">작성자</th>
				<td width="20%">관리자24<!-- 작성자명 --></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"><textarea class="form-control" rows="15" placeholder="내용 입력"></textarea></td>
			</tr>
			<tr>
				<th rowspan="2">첨부파일</th>
				<td colspan="3">
				<div class="div-st"><!-- 첨부파일 목록 -->첨부파일 목록</div>
				<button type="button" class="btn pull-right" style="font-size:12px; margin:0; padding:1; outline:none">파일 업로드</button>
				<span class="pull-right">파일 업로드는 최대 5개까지 가능 합니다.</span></td>
			</tr>
	
		</table>
		<hr class="my-hr">
		<div align="center" style="margin:5px;">
		<button type="button" class="btn btn-default" name="btn" onClick="#" style="outline:none">등록</button>
		<button type="button" class="btn btn-default" name="btn" onclick="window.history.back();" style="outline:none">취소</button>
		</div>
	</div>
</div><!-- /container -->



<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
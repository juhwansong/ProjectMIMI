<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>

<!-- <title>MIMI</title> -->


<div class="container" style="width:1150px;">
	<h3>공지사항</h3>
	<div class="form-group">
		<table class="table" id="table-css3">
			<tr>
				<th width="15%"><!-- 글번호 -->No.555</th>
				<th style="text-align:left;"><!-- 제목 -->Title</th>
				<th width="15%"><i class="fas fa-pen"></i><!-- 작성자 -->admin24</th>
				<th width="15%"><i class="far fa-calendar"></i><!-- 작성일 -->18-08-01</th>
			</tr>
			<tr>
				<td colspan="4"><!-- 내용 -->
				<div style="padding:10px 50px 10px 50px; border:0px; min-height:350px; width:100%;">
				
				좌우여백 테스트 좌우여백 테스트 좌우여백 테스트 좌우여백 테스트 좌우여백 테스트 좌우여백 테스트 좌우여백 테스트 좌우여백 테스트 
				
				<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>
				.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>.<br>
				스크롤테스트...
				
				</div>
				</td>
			</tr>
			<tr>
				<td colspan="4"><!-- 첨부파일 -->
				<div class="div-st" style="margin:3px;"><!-- 첨부파일 목록 -->첨부파일 출력</div>
				</td>
			</tr>
	
		</table>
		<hr class="my-hr">
<table width="100%">
	<tr style="vertical-align:top;">
		<!-- 좌측 버튼 -->
		<td>
		<button type="button" class="btn btn-default" name="btnList" style="outline:none; padding: 7px; margin:2px;" onClick="location.href='noticeList.jsp'">목록</button>
		</td>

		<!-- 우측 버튼 -->
		<td>
		<button type="button" class="btn btn-default pull-right" name="btnModify" style="outline:none; padding: 7px; margin:2px;">삭제</button>
		<button type="button" class="btn btn-default pull-right" name="btnDelete" style="outline:none; padding: 7px; margin:2px;">수정</button></td>
	</tr>
</table>
	</div>
</div><!-- /container -->



<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
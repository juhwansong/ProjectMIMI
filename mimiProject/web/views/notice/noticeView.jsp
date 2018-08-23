<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="notice.model.vo.Notice" %>
    <% Notice notice = (Notice)request.getAttribute("notice");
      String num = notice.getNoticeNo().substring(2).replaceAll("^0*","");//글번호만 추출
      int currentPage = ((Integer)request.getAttribute("page")).intValue();
    %>

<%@include file="../../head.jsp" %>
<%-- <%@include file="../../header.jsp" %> --%>
<%@include file="../../memberHeader.jsp" %>
<%-- <%@include file="../../adminHeader.jsp" %> --%>

<!-- <title>MIMI</title> -->


<div class="container" style="width:1150px;">
	<h3>공지사항</h3>
	<div class="form-group">
		<table class="table" id="table-css3">
			<tr>
				<th width="15%">No.<%=num%><!-- 글번호 --></th>
				<th style="text-align:left;"><%= notice.getNoticeTitle()%><!-- 제목 --></th>
				<th width="15%"><i class="fas fa-pen"></i><%= notice.getUserId()%><!-- 작성자 --></th>
				<th width="15%"><i class="far fa-calendar"></i><%= notice.getNoticeDate()%><!-- 작성일 --></th>
			</tr>
			<tr>
				<td colspan="4"><!-- 내용 -->
				<div style="padding:10px 50px 10px 50px; border:0px; min-height:350px; width:100%;">
				<%= notice.getNoticeContents() %>				
				</div>
				</td>
			</tr>
			<% if(notice.getNoticeRealFile() != null){ %>
			<tr>
				<td colspan="4"><!-- 첨부파일 -->
				<div class="div-st" style="margin:3px;">

				<a href="/mimi/filedownload?ofile=<%= notice.getNoticeRealFile()%>&rfile=<%= notice.getNoticeRenameFile()%>"><%= notice.getNoticeRealFile() %></a><!-- 첨부파일 목록 -->
				</div>
				</td>
			</tr>
			<% } %>
		</table>
		<hr class="my-hr">
<table width="100%">
	<tr style="vertical-align:top;">
		<!-- 좌측 버튼 -->
		<td>
		<button type="button" class="btn btn-default" style="outline:none; padding: 7px; margin:2px;" onclick="window.history.back();">목록</button>
		</td>

		<!-- 우측 버튼 -->
		<td>
		<% if(authority != null && authority.equals("A")){ %>
		<button type="button" class="btn btn-default pull-right" style="outline:none; padding: 7px; margin:2px;"
		 onclick="location.href='/mimi/noticedelete?no=<%= notice.getNoticeNo()%>'">삭제</button>
		<button type="submit" class="btn btn-default pull-right" style="outline:none; padding: 7px; margin:2px;"
		 onclick="location.href='/mimi/noticeupdatepage?no=<%= notice.getNoticeNo()%>&page=<%= currentPage%>'">수정</button>
		 <% } %></td>
	</tr>
</table>
	</div>
</div><!-- /container -->



<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="support.model.vo.Support, java.util.*" %>
<%
	Support support =(Support) request.getAttribute("support");
	
	String userId = (String) session.getAttribute("userId");
	
%>

<%@include file="../../head.jsp" %>
<%-- <%@include file="../../header.jsp" %> --%>
<%@include file="../../memberHeader.jsp" %>
<%-- <%@include file="../../adminHeader.jsp" %> --%>

<!DOCTYPE html>
<meta charset="UTF-8">
<title>customerView</title>

<div class="container" style="width:1150px;">
	<h3>고객센터</h3>
	<div class="form-group">	
		<table class="table" id="table-css3">
		
			<tr>
				<th width="15%"><%= support.getBoardNo() %></th>
				<th width="15%"><%= support.getCategory() %></th>
				<th style="text-align:left;"><%= support.getTitle() %></th>
				<th width="15%"><i class="fas fa-pen"></i><%= support.getUserId() %></th>
				<th width="15%"><i class="far fa-calendar"></i><%= support.getWriteDate() %></th>
			</tr>
			<tr>
				<td colspan="5"><!-- 내용 -->
				<div style="padding:10px 50px 10px 50px; border:0px; min-height:350px; width:100%;">
				<%= support.getContents() %>
				</div>
				</td>
			</tr>
		
		</table>
		<hr class="my-hr">
<table width="100%">
	<tr style="vertical-align:top;">
		<!-- 좌측 버튼 -->
		<td>
		<button type="button" class="btn btn-default" name="btnList" style="outline:none; padding: 7px; margin:2px;" onClick="location.href='/mimi/supportlist'">목록</button>
		</td>

		<!-- 우측 버튼 -->
		<td>
		<button type="button" class="btn btn-default pull-right"  onClick="location.href='/mimi/sdelete?sno=<%= support.getBoardNo() %>'" name="btnDelete" style="outline:none; padding: 7px; margin:2px;">삭제</button>
		<button type="button" class="btn btn-default pull-right" onClick="location.href='/mimi/supdate?sno=<%= support.getBoardNo() %>'" name="btnModify" style="outline:none; padding: 7px; margin:2px;">수정</button></a>
		<button type="button" class="btn btn-default pull-right" name="btnReple" style="outline:none; padding: 7px; margin:2px;">답글달기</button>
		</td>
	</tr>
</table>
	</div>
</div><!-- /container -->



<%@include file="../../footer.jsp" %> 
<%@include file="../../end.jsp" %> 	





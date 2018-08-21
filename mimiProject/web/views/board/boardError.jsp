<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<%
	String message = (String)request.getAttribute("message");
%>
<!-- head -->
<%@include file="../../head.jsp" %>
<!-- body -->
<!--------------------------------------------------------------------------->
<h3>게시판 오류</h3>
<%if(message != null){ %>
	<h4> 에러 메세지 : <%= message %></h4>
<% }else{ %>
	<h4>예외 발생 : <%= exception.getMessage() %></h4>
<% } %>
<br>
<input type="button" class="btn btn-default" onclick="window.history.back();" value="뒤로가기" style="outline: none;">

<!-- ------------------------------------------------ -->
<%@include file="../../end.jsp" %> 
<!-- ------------------------------------------------ -->
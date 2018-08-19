<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />


<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<link rel="stylesheet" href="/mimi/resources/css/bootstrap.css">
<script type="text/javascript" src="/mimi/resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/mimi/resources/css/admin-review-thema.css">
</head>
<body>
<!-- 바디 태그 시작 -->

<%
	String userId = (String)session.getAttribute("userId");
	String authority = (String)session.getAttribute("authority");
	
	if(userId == null){
%>		
		<%@include file="header.jsp" %>
<% 		
	}
	else if(authority.equals("U")){
%>		
		<%@include file="memberHeader.jsp" %>
<%	
	}
	else if(authority.equals("A")){
%>		
		<%@include file="adminHeader.jsp" %>
<%		
	}
%>

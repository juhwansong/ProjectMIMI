<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//String nickName = (String)session.getAttribute("nickname"); //head.jsp 에 있음
	//String userId = (String)session.getAttribute("userid");  //head.jsp 에 있음
%>

<%@include file="../../head.jsp" %>

<style type="text/css">
.filebox input[type="file"] { 
	position: absolute; 
	width: 1px; 
	height: 1px; 
	padding: 0; 
	margin: -1px; 
	overflow: hidden; 
	clip:rect(0,0,0,0); 
	border: 0; 
} 
.filebox label { 
	display: inline-block; 
	padding: .5em .75em; 
	color: #999; 
	font-size: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: #fdfdfd; 
	cursor: pointer; 
	border: 1px solid #ebebeb; 
	border-bottom-color: #e2e2e2; 
	border-radius: .25em;
} 

.upload-name { 
	width : 90%;
	height: 100%;
	display: inline-block; 
	padding: .5em .75em;
	font-size: inherit; 
	font-family: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: #f5f5f5; 
	border: 1px solid #ebebeb; 
	-webkit-appearance: none;
	-moz-appearance: none; 
	appearance: none; 
}
</style>
<script type="text/javascript">
	$(function(){ 
		var fileTarget = $('.filebox .upload-hidden'); 
		fileTarget.on('change', function(){
			if(window.FileReader){
				var filename = $(this)[0].files[0].name; 
			} else {
				var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
			}
		$(this).siblings('.upload-name').val(filename); 
		}); 
	}); 

</script>

<!-- <title>MIMI</title> -->

<div class="container" style="width:1150px;">
	<h3>공지사항 작성</h3>
	<div class="form-group">
	<form action="/mimi/noticeinsert" method="post" enctype="multipart/form-data">
	<input type="hidden" name="userid" value="<%-- <%=userId%> --%>admin1"><!-- userid로 join이라 가져가야함 -->
		<table class="table" id="table-css2">
			<tr>
				<th width="15%">제목</th>
				<td><input type="text" name="title" class="form-control" placeholder="제목 입력"></td>
				<th width="15%">작성자</th>
				<td id="notice-nickname-input" width="20%"><%=nickName%><!-- 닉네임 --></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"><textarea name="contents" class="form-control" rows="15" placeholder="내용 입력"></textarea></td>
			</tr>
			<tr>
				<th rowspan="2">첨부파일</th>
				<td colspan="3">
				<div class="filebox">
				<input class="upload-name" value="" disabled="disabled"><label for="ex_filename" class="pull-right">파일 첨부</label>
				<input type="file" name="upfile" id="ex_filename" class="upload-hidden"> </div></td>
			</tr>
	
		</table>
		<hr class="my-hr">
		<div align="center" style="margin:5px;">
		<button type="submit" class="btn btn-default" name="btn" style="outline:none">등록</button>
		<button type="button" class="btn btn-default" name="btn" onclick="window.history.back();" style="outline:none">취소</button>
		</div>
		</form>
	</div>
</div><!-- /container -->


<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
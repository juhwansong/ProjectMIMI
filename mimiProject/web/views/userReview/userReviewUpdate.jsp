<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="common.model.vo.Board" %>
<%
	Board board = (Board)request.getAttribute("board");
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	//String userId = (String)session.getAttribute("userId");
%>

<%@include file="../../head.jsp"%>
<%-- <%@include file="../../header.jsp"%> --%>
<script type="text/javascript">
var openWin;

$(function cateread(){	//카테고리 받아오기
	$("#" + "<%= board.getCategoryNo() %>").addClass("btn-success");
	document.getElementById("categoryNo").value = "<%= board.getCategoryNo() %>";
});

function openAddress()
{
    // window.open("open할 window", "자식창 이름", "팝업창 옵션");
    openWin = window.open('/mimi/views/userReview/storeAddress.jsp','_blank'
			, 'toolbar=no, location=no, status=no, menubar=no, scrollbars=auto, resizable=yes,directories=no, width=1100, height=850, top=70, left=100');
}

function cateSelect(btnVal){
	$("#"+ document.getElementById("categoryNo").value).removeClass("btn-success");
	$("#"+ btnVal).addClass("btn-success");        // a 태그에 클래스 명 test를 추가
	document.getElementById("categoryNo").value = btnVal;
}
	
</script>

<style type="text/css">

#text_store {
	cursor: pointer;
}
</style>

<!-- <title>리뷰쓰기</title> -->


<div class="container" style="width:1150px;">
	<h3>리뷰 작성</h3>
	<form action="/mimi/userboardupdateorigin?bnum=<%= board.getBoardNo() %>&page=<%= currentPage %>" method="post" enctype="multipart/form-data">
	<div id="inner">
		<table class="table table-borderless" id="table-css3">
			<tr>
				<th width="15%">제목</th>
				<td width="*"><input type="text" class="form-control"
					id="user_title" placeholder="제목" name="title" value="<%= board.getTitle() %>"></td>
				<th width="15%">작성자</th>
				<td width="15%"><%= board.getNickName() %></td>
			</tr>
			<tr>
				<th><label for="text_category" class="control-label">카테고리</label></th>
				<td id="text_category">
					<input type="hidden" readonly="readonly" name="categoryNo" id="categoryNo" value="C1">
					<div class="btn-toolbar" role="toolbar" aria-label="버튼 그룹이 있는 툴바">
						<div class="btn-group mr-2" role="group" aria-label="카테고리1">
							<button type="button" class="btn" style="width: 110px" id="C1" onclick="cateSelect('C1')">커피/디저트</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="카테고리2">
							<button type="button" class="btn" style="width: 110px" id="C2" onclick="cateSelect('C2')">패스트푸드</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="카테고리3">
							<button type="button" class="btn" style="width: 110px" id="C3" onclick="cateSelect('C3')">양식</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="카테고리4">
							<button type="button" class="btn" style="width: 110px" id="C4" onclick="cateSelect('C4')">한식</button>
						</div>
						<br> <br>
						<div class="btn-group mr-2" role="group" aria-label="카테고리5">
							<button type="button" class="btn" style="width: 110px" id="C5" onclick="cateSelect('C5')">일식</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="카테고리6">
							<button type="button" class="btn" style="width: 110px" id="C6" onclick="cateSelect('C6')">중식</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="카테고리7">
							<button type="button" class="btn" style="width: 110px" id="C7" onclick="cateSelect('C7')">7</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="카테고리8">
							<button type="button" class="btn" style="width: 110px" id="C8" onclick="cateSelect('C8')">8</button>
						</div>
					</div>
				</td>
				<td style="width: 300px" rowspan="4" colspan="2">
				<input type="hidden" readonly="readonly" name="latitude" id="latitude" value="10">
				<input type="hidden" readonly="readonly" name="longitude" id="longitude" value="10">
				<img
					src="/mimi/resources/images/userReview/map.jpg" width=300
					height=300></td>
			</tr>
			<tr>
				<th><label for="text_store" class="control-label">매장명</label></th>
				<td><input type="text" class="form-control"
					placeholder="내용을 입력하세요" id="store_name" readonly
					onClick="openAddress()" name="shopName" value="<%= board.getShopName() %>"></td>
			</tr>
			<tr>
				<th><label for="text_store_phone" class="control-label">매장연락처</label></th>
				<td><input type="text" class="form-control"
					placeholder="내용을 입력하세요" id="store_phone" readonly
					onClick="openAddress()" name="shopCall" value="<%= board.getShopCall() %>"></td>
			</tr>
			<tr>
				<th><label for="text_store_address" class="control-label">매장주소</label></th>
				<td><input type="text" class="form-control"
					placeholder="내용을 입력하세요" id="store_address" readonly
					onClick="openAddress()" name="shopAddress" value="<%= board.getShopAddress()%>"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
				<input type="hidden" readonly="readonly" name="thumbnailName" id="thumbnailName" value="썸네일">
				<textarea class="form-control" rows="20"
						id="texta_content" name="content_tag"><%= board.getContentsTag()%></textarea>
				</td>
			</tr>
		</table>
	</div>
	<hr class="margin2">
	<div style="text-align: center;">
		<button type="submit" class="btn btn-default" style="outline: none;">작성
			완료</button>
		<input type="button" class="btn btn-default"
			onclick="window.history.back();" value="취소" style="outline: none;">
	</div>
	</form>
</div>


<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>

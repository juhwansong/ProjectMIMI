<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../../head.jsp"%>


<style type="text/css">

#text_store {
	cursor: pointer;
}
</style>

<!-- <title>리뷰쓰기</title> -->


<div class="container" style="width:1150px;">
	<h3>리뷰 작성</h3>
	<div id="inner">
		<table class="table table-borderless" id="table-css3">
			<tr>
				<th width="15%">제목</th>
				<td width="*"><input type="text" class="form-control"
					id="user_title" placeholder="제목"></td>
				<th width="15%">작성자</th>
				<td width="15%">NICKNAME</td>
			</tr>
			<tr>
				<th><label for="text_category" class="control-label">카테고리</label></th>
				<td id="text_category">
					<div class="btn-toolbar" role="toolbar" aria-label="버튼 그룹이 있는 툴바">
						<div class="btn-group mr-2" role="group" aria-label="첫번째 그룹">
							<button type="button" class="btn" style="width: 110px">카페</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="두번째 그룹">
							<button type="button" class="btn" style="width: 110px">패스트푸드</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="첫번째 그룹">
							<button type="button" class="btn" style="width: 110px">한식</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="두번째 그룹">
							<button type="button" class="btn" style="width: 110px">4</button>
						</div>
						<br> <br>
						<div class="btn-group mr-2" role="group" aria-label="첫번째 그룹">
							<button type="button" class="btn" style="width: 110px">5</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="두번째 그룹">
							<button type="button" class="btn" style="width: 110px">6</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="첫번째 그룹">
							<button type="button" class="btn" style="width: 110px">7</button>
						</div>
						<div class="btn-group mr-2" role="group" aria-label="두번째 그룹">
							<button type="button" class="btn" style="width: 110px">8</button>
						</div>
					</div>
				</td>
				<td style="width: 300px" rowspan="4" colspan="2"><img
					src="/mimi/resources/images/userReview/map.jpg" width=300
					height=300></td>
			</tr>
			<tr>
				<th><label for="text_store" class="control-label">매장명</label></th>
				<td><input type="text" class="form-control"
					placeholder="내용을 입력하세요" id="text_store" readonly
					onClick="window.open('/mimi/views/userReview/storeAddress.jsp','_blank'
							, 'toolbar=no, location=no, status=no, menubar=no, scrollbars=auto, resizable=yes,directories=no, width=1100, height=850, top=70, left=100')"></td>
			</tr>
			<tr>
				<th><label for="text_store_phone" class="control-label">매장
						연락처</label></th>
				<td><input type="text" class="form-control"
					placeholder="내용을 입력하세요" id="text_store_address" readonly
					onClick="window.open('/mimi/views/userReview/storeAddress.jsp')"></td>
			</tr>
			<tr>
				<th><label for="text_store_address" class="control-label">매장
						주소</label></th>
				<td><input type="text" class="form-control"
					placeholder="내용을 입력하세요" id="text_store_address" readonly
					onClick="window.open('/mimi/views/userReview/storeAddress.jsp')"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"><textarea class="form-control" rows="20"
						id="texta_content"></textarea> <br> <textarea
						class="form-control" rows="3" id="texta_content"></textarea> <br>
					<input type="button" class="btn btn-default pull-right"
					value="이미지업로드" style="outline: none;"> <br></td>
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
</div>


<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>

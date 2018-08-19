<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %> 

<title>상세 주소</title>

<div class="container">
<h3>상세 주소</h3>
<hr style="width:1000px;">
	<div id="map_image" class="text-center" style="width:100%; height:500px; overflow:hidden;">
		<!-- 지도 -->
		<img src="/mimi/resources/images/userReview/map.jpg" width=100% height=100%>
	</div>
<hr>
		<form>
			<div class="row">
				<div class="col-xs-6">
					<label for="store_name">매장명</label> <input type="text" class="form-control" id="store_name"  placeholder="미미 카페">
				</div>
				<div class="col-xs-6">
					<label for="store_phone">매장 연락처</label> <input type="tel" class="form-control" id="store_phone" placeholder="02-123-4567">
				</div>
				<br><br><br><br>
				<div class="col-xs-12">
					<label for="store_address">매장 주소</label> <input type="text" class="form-control" id="store_address" placeholder="주소 입력">
				</div>
			</div>
			<br>
			<div style="text-align:center;">
			<button type="submit" class="btn btn-default">확인</button>
			<input type="button" class="btn btn-default"
				onClick='self.close()'
				value="취소">
			</div>
		</form>

	</div>
<%-- <%@include file="../../footer.jsp" %> 	 --%>
<%@include file="../../end.jsp" %> 
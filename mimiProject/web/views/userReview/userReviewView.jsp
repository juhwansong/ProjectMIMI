<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../../head.jsp"%>


<!-- ---------------------- -->


<script src="/mimi/resources/js/kakao.min.js"></script>

<style type="text/css">

#text_context {
	font-family: "Helvetica Nene", Helvetica, Arial, sans-serif;
	font-size: 14px;
	line-height: 1.42857143;
	color: #333;
}

#good_qta {
	font-family: "Helvetica Nene", Helvetica, Arial, sans-serif;
	font-size: 12px;
	line-height: 1.42857143;
	color: #333;
	background-color: #fff;
}

#comment {
	font-family: "Helvetica Nene", Helvetica, Arial, sans-serif;
	font-size: 14px;
	line-height: 1.42857143;
	color: #333;
	background-color: #fff;
}

#table-css2 th{
	background:#fff;
	font-size: 13px;
	color: #666;
}

#table-css2 td{
	text-align:left;
}

.margin5{
	width: 100%;
	margin: 15px 15px 10px 15px;
}

</style>
<script type="text/javascript">
	$(function(){
		
		new Clipboard('.copyBtn', {text: function() {
			alert("클립보드에 복사되었습니다.");
		    return document.location.href;
		  }
		});
	});//onload
	
	
</script>

<!-- <title>유저리뷰보기</title> -->
<div class="container" style="width:1150px;">
	<h3>유저리뷰</h3>
	<div id="inner">
		<table class="table table-borderless" id="table-css2">
			<tr>
				<th width="12%">No.9999</th>
				<th width="*" style="text-align:left;">제목제목제목제목제목제목제목제목제목</th>
				<th width="28%">
				<i class="fas fa-pen"></i>글쓴이&nbsp;Lv.1
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="far fa-eye"></i>99999
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="far fa-calendar"></i>07-22</th>
				<th width="8%"><button type="button" class="btn btn-default btn-lg" id="favorites" onclick="imgToggle()">
						<span class="glyphicon glyphicon-star" aria-hidden="true" style="color: yellow"></span>
					</button></th>
			</tr>
			<tr>
				<th>카테고리</th>
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
				<td style="width: 300px; align:center;" rowspan="4" colspan="2"><img
					src="/mimi/resources/images/userReview/map.jpg" width=100%
					height=300></td>
			</tr>
			<tr>
				<th>매장명</th>
				<td>미미카페</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>02-123-4567</td>
			</tr>
			<tr>
				<th>매장 주소</th>
				<td>서울시 00구 00동 232-23</td>
			</tr>

		</table>
	</div>
	<hr class="margin2">
	<div style="margin:20px;">
	<p id="text_context">
		숙소에서 추천받아 방문하였습니다.<br> 주민분들이 많이 찾는 곳이라고 합니다.<br> 목살 2 먹고 고기
		질과 맛이 뛰어나 삼겹살도 1인분 추가 주문하였습니다.<br> 우선 모든 고기 한면에 칼집이 있으며<br>
		두께가 참 두툼하니 먹음직스럽습니다.<br> 고기는 축협 고기라 합니다.<br> 밑반찬으로 파절이와
		분홍소세지 등이 나오며,<br> 공깃밥에는 된장찌개가 함께 나옵니다.<br> 된장찌개가 평범하진 않게
		맛있습니다.<br> 고추장과 된장을 좀 섞은 맛입니다.<br> 무엇보다 고기가 매우 좋아서<br>
		흑돼지던 아니던 상관 없었습니다.<br>
	</p>
	</div>
	<hr>
	<div style="text-align: right;">
	<button class="btn" id="btn" type="submit" style="background:#fff; padding:1px; outline: none;" title="페이스북에 공유하기" onclick="window.open('http://www.facebook.com/sharer.php?u=hjl822.cafe24.com')"><img class="btn-img" width=40px src="/mimi/resources/images/icon/icon_facebook.png"></button>
	<button class="btn" id="btn" type="submit" style="background:#fff; padding:1px; outline: none;" title="트위터에 공유하기" onclick="window.open('https://twitter.com/intent/tweet?text=리뷰제목&url=리뷰주소')"><img class="btn-img" width=40px src="/mimi/resources/images/icon/icon_twitter.png"></button>
	<button class="btn" id="btn" type="submit" style="background:#fff; padding:1px; outline: none;" title="라인에 공유하기" onclick="window.open('http://line.naver.jp/R/msg/text/')"><img class="btn-img" width=40px src="/mimi/resources/images/icon/icon_line.png"></button>
	<!-- <button class="btn" id="btn" type="submit" style="background:#fff; padding:1px; outline: none;" title="카카오톡에 공유하기"><img width=40px src="/mimi/resources/images/icon/icon_kakao.png"></button> -->
	<a id="kakaoLink-btn" href="javascript:;"><img src="/mimi/resources/images/icon/icon_kakao.png" width=40px title="카카오톡에 공유하기"></a>
	<button class="btn copyBtn" id="kakaoLink-btn" type="submit" style="background:#fff; padding:1px; outline: none;" title="url 복사하기"><img class="btn-img" width=40px src="/mimi/resources/images/icon/icon_copy.png"></button>
	</div>
	<hr>
	<div id="image_l" style="text-align: center;">
		<img src="/mimi/resources/images/userReview/s_1.jpg" width=400
			height=300><br>
	</div>
	<br>
	<div id="image_s" style="text-align: center;">
		<img src="/mimi/resources/images/userReview/s_1.jpg" width=150
			height=100> <img
			src="/mimi/resources/images/userReview/s_3.jpg" width=150 height=100>
		<img src="/mimi/resources/images/userReview/s_1.jpg" width=150
			height=100>
	</div>
	<br>
	<hr>
	<div style="text-align: center;">
			<img class="btn-img"
				src="/mimi/resources/images/icon/icon_thumb_up.png" width=100
				 onclick="#">
		<p id="good_qta">111</p>
	</div>
	
	<!-- comment -->
	<div style="text-align: center;">
		<!-- 기존 댓글 -->
		<table class="table table-borderless" style="width:100%">
			<tr>
				<td><table id="comment" style="width:100%">
					<tr>
						<td style="width: 40px"><img src="/mimi/resources/images/icon/icon_human.ico" width=40 height=40></td>
						<td class="text-left">&nbsp;user01 <span style="font-size: 8px">&nbsp;&nbsp;2018-08-02 00:02:25</span></td>
						<td style="width: 50px" class="text-center"><a href="/mimi/views/userReview/userReviewList.jsp">수정</a></td>
						<td style="width: 50px" class="text-center"><a href="#">삭제</a></td>
					</tr>
					<tr><!-- 댓글 본문 -->
						<td colspan="4" class="text-left"><div class="margin5">추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? ??fffffffffffffffff아니 왤케 끝없이 늘어나??????</div></td>
					</tr>
				</table></td>
			</tr>
			<tr>
				<td><table id="comment" style="width:100%">
					<tr>
						<td style="width: 40px"><img src="/mimi/resources/images/icon/icon_human.ico" width=40 height=40></td>
						<td class="text-left">&nbsp;user01 <span style="font-size: 8px">&nbsp;&nbsp;2018-08-02 00:02:25</span></td>
						<td style="width: 50px" class="text-center"><a href="/mimi/views/userReview/userReviewList.jsp">수정</a></td>
						<td style="width: 50px" class="text-center"><a href="#">삭제</a></td>
					</tr>
					<tr><!-- 댓글 본문 -->
						<td colspan="4" class="text-left"><div class="margin5">추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? ??fffffffffffffffff아니 왤케 끝없이 늘어나??????</div></td>
					</tr>
				</table></td>
			</tr>
			<tr>
				<td><table id="comment" style="width:100%">
					<tr>
						<td style="width: 40px"><img src="/mimi/resources/images/icon/icon_human.ico" width=40 height=40></td>
						<td class="text-left">&nbsp;user01 <span style="font-size: 8px">&nbsp;&nbsp;2018-08-02 00:02:25</span></td>
						<td style="width: 50px" class="text-center"><a href="/mimi/views/userReview/userReviewList.jsp">수정</a></td>
						<td style="width: 50px" class="text-center"><a href="#">삭제</a></td>
					</tr>
					<tr><!-- 댓글 본문 -->
						<td colspan="4" class="text-left"><div class="margin5">추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? ??fffffffffffffffff아니 왤케 끝없이 늘어나??????</div></td>
					</tr>
				</table></td>
			</tr>
			<tr>
				<td><table id="comment" style="width:100%">
					<tr>
						<td style="width: 40px"><img src="/mimi/resources/images/icon/icon_human.ico" width=40 height=40></td>
						<td class="text-left">&nbsp;user01 <span style="font-size: 8px">&nbsp;&nbsp;2018-08-02 00:02:25</span></td>
						<td style="width: 50px" class="text-center"><a href="/mimi/views/userReview/userReviewList.jsp">수정</a></td>
						<td style="width: 50px" class="text-center"><a href="#">삭제</a></td>
					</tr>
					<tr><!-- 댓글 본문 -->
						<td colspan="4" class="text-left"><div class="margin5">추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? ??fffffffffffffffff아니 왤케 끝없이 늘어나??????</div></td>
					</tr>
				</table></td>
			</tr>
			<tr>
				<td><table id="comment" style="width:100%">
					<tr>
						<td style="width: 40px"><img src="/mimi/resources/images/icon/icon_human.ico" width=40 height=40></td>
						<td class="text-left">&nbsp;user01 <span style="font-size: 8px">&nbsp;&nbsp;2018-08-02 00:02:25</span></td>
						<td style="width: 50px" class="text-center"><a href="/mimi/views/userReview/userReviewList.jsp">수정</a></td>
						<td style="width: 50px" class="text-center"><a href="#">삭제</a></td>
					</tr>
					<tr><!-- 댓글 본문 -->
						<td colspan="4" class="text-left"><div class="margin5">추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? ??fffffffffffffffff아니 왤케 끝없이 늘어나??????</div></td>
					</tr>
				</table></td>
			</tr>
			<tr>
				<td><table id="comment" style="width:100%">
					<tr>
						<td style="width: 40px"><img src="/mimi/resources/images/icon/icon_human.ico" width=40 height=40></td>
						<td class="text-left">&nbsp;user01 <span style="font-size: 8px">&nbsp;&nbsp;2018-08-02 00:02:25</span></td>
						<td style="width: 50px" class="text-center"><a href="/mimi/views/userReview/userReviewList.jsp">수정</a></td>
						<td style="width: 50px" class="text-center"><a href="#">삭제</a></td>
					</tr>
					<tr><!-- 댓글 본문 -->
						<td colspan="4" class="text-left"><div class="margin5">추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? ??fffffffffffffffff아니 왤케 끝없이 늘어나??????</div></td>
					</tr>
				</table></td>
			</tr>

		</table>
				


		<hr class="margin2">
		
		
		<!-- 댓글 작성부분 -->
		<form>
		<table style="width:100%;">
			<tr>
				<td width="15%"><img src="/mimi/resources/images/icon/icon_human.ico" width=40
				height=40>&nbsp;&nbsp;<label>user03</label></td>
				<td width="*"><textarea style="width: 100%;" rows="3" id="texta_content"></textarea></td>
				<td width="8%"><button type="submit" class="btn btn-default" style="outline: none;">등록</button></td>
			</tr>
		</table>
		</form>
		<!-- /댓글 작성부분 -->
	</div>
	<hr>
	<div class="row">
		<div class="col-xs-6 text-left">
			<input type="button" class="btn btn-default"
				onClick="location.href='/mimi/views/userReview/userReviewList.jsp'"
				value="목록">
		</div>
		<div class="col-xs-6 text-right">
			<input type="submit" class="btn btn-default" value="수정" style="outline: none;"> <input
				type="submit" class="btn btn-default" value="삭제" style="outline: none;">
		</div>
	</div>
	<br>
</div>

<!-- 카톡공유용 -->
<script type='text/javascript'>
	Kakao.init('86bba96268a8b3515e937b123d69953a'); //kakao 키번호
	var url = document.location.href;
    
    Kakao.Link.createDefaultButton({
      container: '#kakaoLink-btn',
      objectType: 'feed',
      content: {
        title: '제목',
        description: '내용..........',
        imageUrl: 'http://hjl822.cafe24.com/mimi/resources/images/main/img3.jpg',	//이미지주소..http로 시작해야 뜸 X절대경로,상대경로X
        link: {
          mobileWebUrl: 'url',	//주소..url 가져다 쓰면되는데....웹서버에 올려야함
          webUrl: 'http://hjl822.cafe24.com/mimi/views/userReview/userReviewView.jsp'
        }
      },
      social: {
        likeCount: 286, //좋아요 수
        commentCount: 45, //댓글 수
        viewCount: 999	//조회수
      }
      
    });
</script>


<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>

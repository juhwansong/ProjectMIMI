<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="./userReviewError.jsp"%>
<%@ page import="common.model.vo.Board" %>
<%
	Board board = (Board)request.getAttribute("board");
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	//int currentPage = 1; //1로 초기화 (파라미터 currentPage 없을땐 목록버튼 눌렀을 시 1페이지로 가게)
	//if(request.getAttribute("currentPage") != null){
		
	//}	
	//String userId = (String)session.getAttribute("userId");
%>

<%@include file="../../head.jsp"%>


<!-- ---------------------- -->



<script type="text/javascript">
	$(function(){
		$.ajax({
			url : "/mimi/userboardreplylist",
			type : "get",
			dataType : "json",
			success : function(data){				
				//console.log("success : " + data);			
				var jsonStr = JSON.stringify(data);
				//console.log(jsonStr);
				var json = JSON.parse(jsonStr);
				//console.log(json);
				
				var values = "";
				for(var i in json.list){
					values += "<tr>"
						+ "<td><table id='comment' style='width:100%'>"
							+ "<tr>"
								+ "<td style='width: 40px'><img src='/mimi/resources/images/icon/icon_human.ico' width=40 height=40></td>"
								+ "<td class='text-left'>&nbsp;" + json.list[i].cmtNo + "<span style='font-size: 8px'>&nbsp;&nbsp;" + json.list[i].cmtDate + "</span></td>"
								+ "<td style='width: 50px' class='text-center'><a href='/mimi/views/userReview/userReviewList.jsp'>수정</a></td>"
								+ "<td style='width: 50px' class='text-center'><a href='#'>삭제</a></td>"
							+"</tr>"
						+"<tr>"
							+"<td colspan='4' class='text-left'><div class='margin5'>" + json.list[i].cmtContents + "</div></td>"
						+"</tr>"
						+"</table></td>"
					+"</tr>"
				}
				
				$("#cmtlist").html(values);
			},
			error : function(jqXHR, textstatus, errorThrown){
				console.log("error : " + jqXHR + ", " + 
						textstatus + ", " + errorThrown);
			}
		});  //ajax close
	});
</script>
<style type="text/css">

#text_context{
	/* font-family: "Helvetica Nene", Helvetica, Arial, sans-serif;
	font-size: 14px; 
	line-height: 1.42857143;
	color: #333; */
	width:952px;
	margin-left: auto; 
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
				<th width="12%">No.<%= board.getBoardNo() %></th>
				<th width="*" style="text-align:left;"><%= board.getTitle() %></th>
				<th width="28%">
				<i class="fas fa-pen"></i><%= board.getNickName() %>&nbsp;<%= board.getGradeName() %>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="far fa-eye"></i><%= board.getHits() %>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="far fa-calendar"></i><%= board.getBoardDate() %></th>
				<th width="8%"><button type="button" class="btn btn-default btn-lg" id="favorites" onclick="imgToggle()">
						<span class="glyphicon glyphicon-star" aria-hidden="true" style="color: yellow"></span>
					</button></th>
			</tr>
			<tr>
				<th>카테고리</th>
				<td id="text_category">
				<span class="badge badge-primary"><%= board.getCategoryName() %></span>
				</td>			
				<td style="width: 300px; align:center;" rowspan="5" colspan="2">
				<input type="hidden" readonly="readonly" name="latitude" id="latitude" value="<%=board.getLatitude()%>" >
				<input type="hidden" readonly="readonly" name="longitude" id="longitude" value="<%=board.getLongitude()%>">	
				
				<div class="map_wrap" >
	    			<div id="map" style="width:350px;height:230px;position:relative;overflow:hidden;"></div>
	    		</div></td>
			</tr>
			<tr>
				<th>매장명</th>
				<td><%= board.getShopName() %></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td><%= board.getShopCall() %></td>
			</tr>
			<tr>
				<th>매장 주소</th>
				<td><%= board.getShopAddress() %></td>
			</tr>

		</table>
	</div>
	
	<hr class="margin2">
	<div id="text_context">			
		<p>
			<%= board.getContentsTag()%>
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
	<br>
	<hr>
	</div>
	<!--  이미지영역
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
	-->
	<!-- comment -->
	<div style="text-align: center;">
		<!-- 기존 댓글 -->
		<table class="table table-borderless" style="width:100%" id="cmtlist">
			 <!-- <tr>
				<td><table id="comment" style="width:100%">
					<tr>
						<td style="width: 40px"><img src="/mimi/resources/images/icon/icon_human.ico" width=40 height=40></td>
						<td class="text-left">&nbsp;user01 <span style="font-size: 8px">&nbsp;&nbsp;2018-08-02 00:02:25</span></td>
						<td style="width: 50px" class="text-center"><a href="/mimi/views/userReview/userReviewList.jsp">수정</a></td>
						<td style="width: 50px" class="text-center"><a href="#">삭제</a></td>
					</tr>
					<tr>
					 	<td colspan="4" class="text-left"><div class="margin5">추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? 추천요11 1111111 1111?? ??fffffffffffffffff아니 왤케 끝없이 늘어나??????</div></td>
					</tr>
				</table></td>
			</tr>  -->
		</table>

		<hr class="margin2">
		
		<!--<textarea style="width: 100%;" rows="3" id="texta_content"> -->
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
				onClick="location.href='/mimi/userboardlist?page=<%=currentPage%>';" value="목록">
		</div>
		<div class="col-xs-6 text-right">
			<input type="submit" class="btn btn-default" value="수정" style="outline: none;" onClick="location.href='/mimi/userboardupdate?bnum=<%= board.getBoardNo() %>&page=<%= currentPage %>'">
			<button type="button" id="user-delete-btn" class="btn btn-default" style="outline: none;">삭제</button>
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

<script type = "text/javascript">
//마커를 담을 배열입니다
var markers = [];
var geocoder = new daum.maps.services.Geocoder(); //주소-좌표 변환 객체 생성
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 6 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new daum.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
/* var infowindow = new daum.maps.InfoWindow({
	zIndex:1
}); */

var count; //지도에 직접 표기하기 버튼 클릭시 값 변화
var placelistclicked = -1; //초기값 -1
//인포윈도우에 장소명을 표시합니다
var infowindow = new Array();
////////////////////////처음 불러올때 본인 위치를 표시
// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
var locPosition = null;

if ($("#latitude").val() !== ""){
	locPosition = new daum.maps.LatLng($("#latitude").val(), $("#longitude").val()); 
	addMarker(locPosition, 0);
   	
  //현재 위치 표시
	map.setCenter(locPosition);
}
else if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        
        locPosition = new daum.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
     
       	
     	//현재 위치 표시
    	map.setCenter(locPosition);
	      
      });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때
    
    locPosition = new daum.maps.LatLng(33.450701, 126.570667),    
  	//현재 위치 표시
	map.setCenter(locPosition);//맵 중심좌표 설정
   
}




function addMarker(position, i) {
	
	var imageSrc ="/mimi/resources/images/icon/if_map-marker.png",
		imageSize = new daum.maps.Size(48, 48), //마커 이미지 크기
		imageOption = {offset:new daum.maps.Point(25, 45)}; //마커이미지의 옵션. 이미지 안에서의 좌표
    
	var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption),
		markerPosition = position; //마커 표시 위치
	
	//마커 생성
	var marker = new daum.maps.Marker({
		position:markerPosition,
		image: markerImage // 마커 이미지 설정
	});
	
    marker.setMap(map);	   // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
    
    return marker;
}

$(function(){
	$(document).on("click", "#user-delete-btn", function(){
		//자바스크립트에서 post 방식으로 보내기
		var form = document.createElement("form");
		var input = new Array();
		var parm = new Array(); //input 태그안의 name,value값 설정
		//파라미터 추가
		parm.push(["bnum", "<%=board.getBoardNo()%>"]);
		parm.push(["content_tag", '<%=board.getContentsTag()%>']);
		
		for(var i=0; i<parm.length; i++){
			input[i]=document.createElement("input");
			input[i].setAttribute("type", "hidden");
			input[i].setAttribute("name", parm[i][0]);
			input[i].setAttribute("value", parm[i][1]);
			form.appendChild(input[i]);
		}
		
		form.method = "post";
		form.action = "/mimi/userboarddelete";
		
		document.body.appendChild(form);
		form.submit();
		
		board.getContentsTag()
	});	
});

</script>

<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>

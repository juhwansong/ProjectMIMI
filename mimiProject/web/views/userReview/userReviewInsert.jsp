<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../../head.jsp"%>



<script type="text/javascript">
var openWin;
//var cateVal = "카페";

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
#mapcheck-btn{
	position: absolute;
	top:2%;
	left:66%;
	z-index: 6;
	height: 40px;
	width: 110px;
	opacity: 0.8;
	
}
</style>

<!-- <title>리뷰쓰기</title> -->


<div class="container" style="width:1150px;">
	<h3>리뷰 작성</h3>
	<form action="/mimi/userboardinsert" method="post" enctype="multipart/form-data">
	<div id="inner">
		<table class="table table-borderless" id="table-css3">
			<tr>
				<th width="15%">제목</th>
				<td width="*"><input type="text" class="form-control"
					id="user_title" placeholder="제목" name="title"></td>
				<th width="15%">작성자</th>
				<td width="15%">NICKNAME</td>
			</tr>
			<tr>
				<th><label for="text_category" class="control-label">카테고리</label></th>
				<td id="text_category">
					<input type="hidden" readonly="readonly" name="categoryNo" id="categoryNo" value="C1">
					<div class="btn-toolbar" role="toolbar" aria-label="버튼 그룹이 있는 툴바">
						<div class="btn-group mr-2" role="group" aria-label="카테고리1">
							<button type="button" class="btn btn-success" style="width: 110px" id="C1" onclick="cateSelect('C1')">커피/디저트</button>
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
				<td style="width: 300px" rowspan="5" colspan="2">
				<input type="hidden" readonly="readonly" name="latitude" id="latitude" value="" >
				<input type="hidden" readonly="readonly" name="longitude" id="longitude" value="">
				
				<div class="map_wrap" >
	    			<div id="map" style="width:350px;height:230px;position:relative;overflow:hidden;"></div>
	    			<button type="button" id="mapcheck-btn" class="btn btn-info" onclick="openAddress();">지도에 위치 표시</button>
	    		</div></td> 
				 <!-- <img
					src="/mimi/resources/images/userReview/map.jpg" width=300
					height=300></td>  -->
			</tr>
			<tr>
				<th><label for="text_store" class="control-label">매장명</label></th>
				<td><input type="text" class="form-control"
					placeholder="내용을 입력하세요" id="store_name" readonly
					onClick="openAddress()" name="shopName"></td>
			</tr>
			<tr>
				<th><label for="text_store_phone" class="control-label">매장연락처</label></th>
				<td><input type="text" class="form-control"
					placeholder="내용을 입력하세요" id="store_phone" readonly
					onClick="openAddress()" name="shopCall"></td>
			</tr>
			<tr>
				<th><label for="text_store_address" class="control-label">매장주소</label></th>
				<td><input type="text" class="form-control"
					placeholder="내용을 입력하세요" id="store_address" readonly
					onClick="openAddress()" name="shopAddress"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
				<input type="hidden" readonly="readonly" name="thumbnailName" id="thumbnailName" value="썸네일">
				<textarea class="form-control" rows="20"
						id="texta_content" name="content_tag"></textarea>
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





function mapRefresh(){ // 팝업창에서 확인 버튼 누를시 부모창에서 맵 객체 생성 후 적용
	if($("#latitude").val() !== ""){
		markers = [];
		geocoder = new daum.maps.services.Geocoder(); //주소-좌표 변환 객체 생성
		mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
		};  
		// 지도를 생성합니다    
		map = new daum.maps.Map(mapContainer, mapOption);   
		
		locPosition = new daum.maps.LatLng($("#latitude").val(), $("#longitude").val()); 
		addMarker(locPosition, 0);
	   	
	  	//현재 위치 표시
		map.setCenter(locPosition);
	}
}
</script>

<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>

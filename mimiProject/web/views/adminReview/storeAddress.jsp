<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- <%@include file="../../head.jsp" %>  --%>
<%@include file="../../nonHeaderHead.jsp" %> 
<!-- head.jsp에 header.jsp가 들어가 있기때문에 header.jsp가 미포함된 head.jsp추가  -->

<!-- 다음맵 인증키 (직접 발급받아야됨) -->
<script type = "text/javascript" src = "//dapi.kakao.com/v2/maps/sdk.js?appkey=86bba96268a8b3515e937b123d69953a&libraries=services,clusterer,drawing"></script>

<!-- 커스텀 오버레이 꾸미기 -->
<style>  
	.wrap {position: absolute;left:0;bottom: 40px;width: 0px;height: 0px;margin-left: -144px;text-align: left;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .infowin {position:relative;top:-62px;left:40px;width: 206px;height: 40px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;background: #2b2d36; overflow: hidden; opacity:0.9}
    .wrap .infowin:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .infowin .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .infowin .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .infowin .close:hover {cursor: pointer;}
    .infowin .body {position: relative;overflow: hidden;}
    .infowin .desc {position: relative;left:-48px;text-align:center;margin: 13px 0 0 90px;height: 75px;background: #2b2d36;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .infowin .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    /* .wrap:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom:10px;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_black.png')} */ 
    .wrap:after 
	{
		content: '';
		position: absolute;
		border-style: solid;	
		margin-left: -12px;
		left : 50%;
		border-width: 15px 13px 0;
		border-color: #2b2d36 transparent;
		opacity:0.9;
		display: block;
		width: 22px;
		height: 12px;
		z-index: 1;
		bottom: 7px;
		left: 143px;
	}
    .infowin .link {color: #5085BB;} 
</style>

<title>상세 주소</title>

<div class="container">
<h3>상세 주소</h3>
<hr style="width:1000px;">
	<!-- 지도 부분 시작 -->
	<div class="map_wrap">
	    	<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	    	<div id="menu_wrap" class="bg_white">
	        	<div class="option">
	            	<div>
	                	<form onsubmit="searchPlaces(); return false;">
	                         키워드 : 	<input type="text" id="keyword" size="15"> 
	                    <button id = "search" type="submit">검색하기</button> 
	               		</form>
	            	</div>
	        	</div>
	        	<hr>
	        	<ul id="placesList"></ul>
	        	<div id="pagination"></div>
	    	</div>
		</div>
		<div style="margin-top:20px;">
			<button class="btn btn-info" id = "direct">위치 직접 표시하기</button>
		</div>
		<!-- 지도 부분 끝 -->
<hr>
		<form action="getParentText()">
			<input type="hidden" readonly="readonly" name="latitude" id="latitude" value="" >
			<input type="hidden" readonly="readonly" name="longitude" id="longitude" value="">
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
					<input type="hidden" id="latitude" name="latitude" value=""> <!-- 위도값 저장 -->
					<input type="hidden" id="longitude" name="longitude" value=""> <!-- 경도값 저장 -->
				</div>
			</div>
			<br>
			<div style="text-align:center;">
			<input type="button" class="btn btn-default" onclick="setParentText()" value="확인">
			<input type="button" class="btn btn-default"
				onClick='self.close()'
				value="취소">
			</div>
		</form>
	</div>
	
<script>

$(function getParentText(){
	document.getElementById("store_name").value = opener.document.getElementById("store_name").value;
	document.getElementById("store_phone").value = opener.document.getElementById("store_phone").value;
	document.getElementById("store_address").value = opener.document.getElementById("store_address").value;
	document.getElementById("latitude").value = opener.document.getElementById("latitude").value;
	document.getElementById("longitude").value = opener.document.getElementById("longitude").value;
 });
//팝업창 확인버튼 누를 시 팝업창에 입력된 데이터 값을 부모 페이지에 넘기는 함수 
function setParentText(){
	opener.document.getElementById("store_name").value = document.getElementById("store_name").value;
	opener.document.getElementById("store_phone").value = document.getElementById("store_phone").value;
	opener.document.getElementById("store_address").value = document.getElementById("store_address").value;
	opener.document.getElementById("latitude").value = document.getElementById("latitude").value;
	opener.document.getElementById("longitude").value = document.getElementById("longitude").value;
	window.opener.mapRefresh();
	self.close()
 }
 
	//마커를 담을 배열입니다
	var markers = [];
	var geocoder = new daum.maps.services.Geocoder(); //주소-좌표 변환 객체 생성
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
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
	var lat, lon;
	
	if(opener.document.getElementById("latitude").value != ""){
		lat = opener.document.getElementById("latitude").value;
		lon = opener.document.getElementById("longitude").value;
		
	    locPosition = new daum.maps.LatLng(lat, lon),    
	  	//현재 위치 표시
	  	addClickMarker(locPosition, 0);
		map.setCenter(locPosition);//맵 중심좌표 설정
	} else if(navigator.geolocation){
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
			lat = position.coords.latitude; // 위도
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



// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;
	
    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB);     
    	     
}

function searchAddrFromCoords(coords, callback) { //좌표로 행정동 주소 정보를 요청
    // 좌표로 행정동 주소 정보를 요청합니다
    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}

//특정 inputbox에 특정 좌표에 대한 주소정보를 표출하는 함수
function displayCenterInfo(result, status) {
    if (status === daum.maps.services.Status.OK) {
        var infoDiv = document.getElementById('store_address');

        for(var i = 0; i < result.length; i++) {
            // 행정동의 region_type 값은 'H' 이므로
            if (result[i].region_type === 'H') {
            	infoDiv.value = result[i].address_name;
           
                break;
            }
        }
    }    
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
	count = count +1; //검색 클릭 시 지도에 직접 마크 표시하기 버튼 초기화
	map.setCursor(""); //버튼 기능 초기화 됐으니  커서모양도 초기화 (직접 지도에 마커 표시 클릭시 변하는 커서모양 초기화)
	
    if (status === daum.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);
		
        
     	//검색시  자동으로 1번 마커를 표시
        daum.maps.event.trigger(markers[0], "click"); //강제로 클릭 발생
        displayInfowindow(markers[0], data[0].place_name, 0);   //처음엔 인포창 생성해야 함 (mouseover 이벤트로 발생되는게 아니기 때문에)
		
        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === daum.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === daum.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new daum.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new daum.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);
		
        
        
        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
               
            daum.maps.event.addListener(marker, 'click', function(){
            	///////////////여기에 주소입력창에 자동으로 주소 삽입 추가
            	var titleDiv = document.getElementById('store_name');//매장 이름 입력input
            	titleDiv.value = title;
            	
            	var addressDiv = document.getElementById('store_address');//매장 주소 입력input
            	var telDiv = document.getElementById('store_phone'); //매장 전화번호 입력input
            	
       
            	
            	for(var i=0; i<places.length; i++){  //places배열에서 클릭한 마크의 title과 같은 정보의 주소와 전화번호를 뽑아내기 위해
            		if(places[i].place_name === title){
            			addressDiv.value = places[i].address_name;
            			telDiv.value = places[i].phone;
            			$("#latitude").val(places[i].y); //위도 저장
            			$("#longitude").val(places[i].x); //경도 저장	
            			$("#placesList > .item").eq(i).css("background","#F99A86");//list목록
            			map.setCenter(new daum.maps.LatLng(places[i].y, places[i].x));
            			
            			//addressDiv.value = $(this).find("> div > span").first().text();
            			//telDiv.value = $(this).find(" .tel").text();
						
            			if(placelistclicked !== -1 && placelistclicked != i){ //초기값일땐 클릭을 안했으니
							infowindow[placelistclicked].setMap(null);
						}
            			
						placelistclicked = i;  //클릭했을때 인덱스 저장
            		}
            		else{
            			$("#placesList > .item").eq(i).css("background","none");
            			          			
            		}         
            		
            	}  
            });  
            //.find(" div.info")
            daum.maps.event.addListener(marker, 'mouseover', function(){
            	
            	for(var i=0; i<places.length; i++){
	            	if(places[i].place_name === title && placelistclicked !== i){
	        			$("#placesList > .item").eq(i).css("background","#FBE2E2");//list목록	
	        			displayInfowindow(marker,title, i);
	        		}	
            	}
            }); 

            daum.maps.event.addListener(marker, 'mouseout', function() {
            	
                for(var i=0; i<places.length; i++){
	                if(places[i].place_name === title && placelistclicked !== i){
	        			$("#placesList > .item").eq(i).css("background","none");//list목록
	        			infowindow[i].setMap(null);
	 		
	        		}
                }
            });
            
            itemEl.onmousedown = function () {
    	        daum.maps.event.trigger(marker, "click"); //강제로 클릭 발생	       
            };

            itemEl.onmouseover =  function () {                 	
            	daum.maps.event.trigger(marker, "mouseover");  //강제로 마우스 오버 발생               
            };
            
            itemEl.onmouseout =  function () { 	
            	daum.maps.event.trigger(marker, "mouseout");  //강제로 마우스 아웃 발생    
            };
            
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

var selectedMarker = null; //클릭한 마커를 담을 변수
var MARKER_WIDTH = 33, // 기본, 클릭 마커의 너비
	MARKER_HEIGHT = 36, // 기본, 클릭 마커의 높이
	OFFSET_X = 12, // 기본, 클릭 마커의 기준 X좌표
	OFFSET_Y = MARKER_HEIGHT, // 기본, 클릭 마커의 기준 Y좌표
	OVER_MARKER_WIDTH = 45, // 오버 마커의 너비
	OVER_MARKER_HEIGHT = 42, // 오버 마커의 높이
	OVER_OFFSET_X = 16, // 오버 마커의 기준 X좌표
	OVER_OFFSET_Y = OVER_MARKER_HEIGHT, // 오버 마커의 기준 Y좌표
	SPRITE_MARKER_URL = 'http://t1.daumcdn.net/localimg/localimages/07/2012/img/marker_normal.png', // 스프라이트 마커 이미지 URL
	SPRITE_WIDTH = 644, // 스프라이트 이미지 너비
	SPRITE_HEIGHT = 946, // 스프라이트 이미지 높이
	SPRITE_GAP = 10; // 스프라이트 이미지에서 마커간 간격
var markerSize = new daum.maps.Size(MARKER_WIDTH, MARKER_HEIGHT), // 기본, 클릭 마커의 크기
	markerOffset = new daum.maps.Point(OFFSET_X, OFFSET_Y), // 기본, 클릭 마커의 기준좌표
	overMarkerSize = new daum.maps.Size(50, 50), // 오버 마커의 크기
	overMarkerOffset = new daum.maps.Point(OVER_OFFSET_X, 48), // 오버 마커의 기준 좌표
	spriteImageSize = new daum.maps.Size(SPRITE_WIDTH, SPRITE_HEIGHT); // 스프라이트 이미지의 크기
// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, i) {
	var gapX = (MARKER_WIDTH + SPRITE_GAP), // 스프라이트 이미지에서 마커로 사용할 이미지 X좌표 간격 값
    originY = (46 * i) + SPRITE_GAP, // 스프라이트 이미지에서 기본, 클릭 마커로 사용할 Y좌표 값
    overOriginY = (OVER_MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 오버 마커로 사용할 Y좌표 값
    normalOrigin = new daum.maps.Point(53, originY-2), // 스프라이트 이미지에서 기본 마커로 사용할 영역의 좌상단 좌표
    clickOrigin = new daum.maps.Point(138, originY-2), // 스프라이트 이미지에서 마우스오버 마커로 사용할 영역의 좌상단 좌표
    overOrigin = new daum.maps.Point(316, overOriginY); // 스프라이트 이미지에서 클릭 마커로 사용할 영역의 좌상단 좌표
    
    // 기본 마커이미지, 오버 마커이미지, 클릭 마커이미지를 생성합니다
    var normalImage = createMarkerImage(markerSize, markerOffset, normalOrigin),
        overImage = createMarkerImage(overMarkerSize, overMarkerOffset, overOrigin),
        clickImage = createMarkerImage(markerSize, markerOffset, clickOrigin);
    
    // 마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
    var marker = new daum.maps.Marker({
        position: position,
        image: normalImage
    });
    

    
	// 마커 객체에 마커아이디와 마커의 기본 이미지를 추가합니다
    marker.normalImage = normalImage;

    // 마커에 mouseover 이벤트를 등록합니다
    daum.maps.event.addListener(marker, 'mouseover', function() {

        // 클릭된 마커가 없고, mouseover된 마커가 클릭된 마커가 아니면
        // 마커의 이미지를 오버 이미지로 변경합니다
        if (!selectedMarker || selectedMarker !== marker) {
            marker.setImage(overImage);
        }
    });

    // 마커에 mouseout 이벤트를 등록합니다
    daum.maps.event.addListener(marker, 'mouseout', function() {

        // 클릭된 마커가 없고, mouseout된 마커가 클릭된 마커가 아니면
        // 마커의 이미지를 기본 이미지로 변경합니다
        if (!selectedMarker || selectedMarker !== marker) {
            marker.setImage(normalImage);
        }
    }); 

    // 마커에 click 이벤트를 등록합니다
    daum.maps.event.addListener(marker, 'click', function() {

        // 클릭된 마커가 없고, click 마커가 클릭된 마커가 아니면
        // 마커의 이미지를 클릭 이미지로 변경합니다
        if (!selectedMarker || selectedMarker !== marker) {

            // 클릭된 마커 객체가 null이 아니면
            // 클릭된 마커의 이미지를 기본 이미지로 변경하고
            !!selectedMarker && selectedMarker.setImage(selectedMarker.normalImage);

            // 현재 클릭된 마커의 이미지는 클릭 이미지로 변경합니다
            marker.setImage(clickImage);
        }

        // 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
        selectedMarker = marker;
    });
    
    

    marker.setMap(map);	   // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
    
    return marker;
}

//MakrerImage 객체를 생성하여 반환하는 함수입니다
function createMarkerImage(markerSize, offset, spriteOrigin) {
    var markerImage = new daum.maps.MarkerImage(
        SPRITE_MARKER_URL, // 스프라이트 마커 이미지 URL
        markerSize, // 마커의 크기
        {
            offset: offset, // 마커 이미지에서의 기준 좌표
            spriteOrigin: spriteOrigin, // 스트라이프 이미지 중 사용할 영역의 좌상단 좌표
            spriteSize: spriteImageSize // 스프라이트 이미지의 크기
        }
    );
    
    return markerImage;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 
	
    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

/*<div class="title"><div class="body"><div class="desc"></div></div></div>*/
function displayInfowindow(marker, title, index) {   //윈도우인포(커스텀 오버레이) 꾸미기
    var content = '<div class="wrap"><div  class="infowin"><div class="desc" style="color:white">' + title + '</div></div></div>';
	
    //인포윈도우를 담는 배열 선언
    infowin = new daum.maps.CustomOverlay({
		content: content,
		map: map,
		position: marker.getPosition()
	});
    //infowin.setContent(content);   
    //infowin.open(map, marker);
    //infowin.setMap(map);
 	infowindow[index] = infowin;
    
    
}
 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
 
function addClickMarker(position, i) {
	
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

//직접 표시하기 버튼 눌렀을때
$("#direct").click(function(){
	map.setCursor("crosshair"); //위치 표시하기 버튼 누를씨 cursor 모양 변경
	count = 0;
	daum.maps.event.addListener(map, 'click', function(mouseEvent) {
		
		if(count === 0){ //직접 마커표시 버튼 클릭 시			
			//리스트에 표시된 목록을 전부 제거합니다.
			removeAllChildNods(document.getElementById('placesList'));
		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker();
		    // 리스트에 페이지네이션 표시가 있을시 전부 삭제합니다.
		    while (document.getElementById('pagination').hasChildNodes()){
		    	document.getElementById('pagination').removeChild(document.getElementById('pagination').lastChild);
		    }
		    //지도에 표시되있는 윈도우인포 닫기
		    for(var i=0; i<infowindow.length; i++){
		    	if(infowindow[i] !== undefined){  //이미 지워진 인덱스의 값을 또 close()할경우 undefinded 발생 (안닫힌 info창만 제거)
		    		infowindow[i].setMap(null);
		    	} 
		    }
		    
		    //인풋창 초기화
		    $("#keyword").val("");		//검색창 input 초기화
			$("#store_address").val("");//기존 매장 주소 입력input 초기화
			$("#store_name").val("");	//기존 매장 이름 입력input 초기화
			$("#store_phone").val(""); //기존 매장 전화번호 입력 input 초기화 
			
			
			map.setCursor(""); //위치 클릭시 기존 커서로 돌아옴
	        // 마커를 클릭한 위치에 표시합니다   	
	        addClickMarker(mouseEvent.latLng, 0);	       	
	        //////////////// 이제 찍은 위도 경도를 저장 시킬 공간 필요//////////////////////////////
	        map.setCenter(new daum.maps.LatLng(mouseEvent.latLng.jb, mouseEvent.latLng.ib)); //클릭시 중심좌표
	        
	        $("#latitude").val(mouseEvent.latLng.jb); //위도 저장
	        $("#longitude").val(mouseEvent.latLng.ib); //경도 저장
	        //markers.push(marker); ////markers배열에 추가해야 removeMaker()호출 시 삭제됨

	        count = count+1;  // 마커 표시 후 if문 제어
	        
	        //지정한 좌표로 주소를 검색해서 inputbox에 표시
	        searchAddrFromCoords(mouseEvent.latLng, displayCenterInfo);	        
		}
	});	
}); 	
</script>	
<%-- <%@include file="../../footer.jsp" %> 	 --%>
<%@include file="../../end.jsp" %> 
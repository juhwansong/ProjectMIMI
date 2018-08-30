<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>


<!-- 추가 -->

<title>MIMI</title>

<!-- 커스텀 오버레이 꾸미기 -->
<style>  
	.wrap {opacity:1;position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .infowin {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .infowin:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .infowin .title {padding: 1px 0 0 10px;height: 30px;background: #2b2d36;color:white;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .infowin .body {position: relative;overflow: hidden; }
    .infowin .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap; position:relative; top:-4px;left:0px; margin-right: 2px; font-size: 16px; font-weight:bold;color:#666;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .infowin .img {position: absolute;top: 10px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .infowin:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .infowin .link {color: #5085BB;}
    /* .wrap:after 
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
	} */
	.imgcontents-box {
	    /* Over flow hidden hides the text if it is more than N lines  */
	    overflow: hidden;
	    /* To set '...' in absolute position */
	    position: relative; 
	    color:#666;
	    /* Use this value to count block height */
	    height:50px;
	    white-space: normal;
    	word-break:break-all;
	    line-height: 1.2em;
	    /* Max-height = line-height (1.2) * lines max number (2) */
	    max-height: 3.6em; 
	    /* If the last visible word doesn't adjoin right side then this will fix the problem */
	    text-align: justify !important;  
	    /* place for '...' */
	    padding-right: 20px;
	    padding-left: 0px;
    }

    /* create the ... */
    .imgcontents-box:before {
	    /* points in the end */
	    content: '...';
	    /* absolute position */
	    position: absolute;
	    /* set position to right bottom corner of block */
	    right: 13px;
	    bottom: 0;
    }
    /* hide ... if we have text, which is less than or equal to max lines */
    .imgcontents-box:after {
	    /* points in the end */
	    content: '';
	    /* absolute position */
	    position: absolute;
	    /* set position to right bottom corner of text */
	    right: 0px;
	    /* set width and height */
	    width: 50px;
	    height: 50px;
	    margin-top: 0px;
	    /* bg color = bg color under block */
	    background: white;
    }
	
</style>

<div class="container" style="width:1150px;">
	<table width="100%" border="0">
		<tr>
			<td><h3>내 주변 매장</h3></td>
			<td style="text-align: right; vertical-align:bottom; color:#777">
			<h6 >현재 위치 정보&nbsp;:&nbsp;<label id="currentposition">현재위치 검색중입니다...</label><!-- 위치정보 --></h6></td>
		</tr>
	</table>
	<hr style="margin: 0px;">
	
	
		
	<!-------------              API               ------------->	
		<div class="map_wrap">
	    	<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	    	<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
    		<div class="custom_zoomcontrol radius_border" style="top:30px;right:30px;opacity:0.8;"> 
       			<span onclick="zoomIn()"><img style="position:relative;right:1px;height:100%;" src="http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
        		<span onclick="zoomOut()"><img style="position:relative;right:1px;height:100%;" src="http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
    		</div>
	    	<div id="menu_wrap" class="bg_white">
	        	<div class="option">
	        	</div>
	        	<ul id="placesList"></ul>
	        	<div id="pagination"></div>
	    	</div>
		</div>
	<hr style="margin: 0px;">
	<h6 style="text-align: right; color:#999">사진 클릭 시 해당 리뷰 상세보기 페이지로 이동합니다.</h6><br>
</div>

<script>
	
	var page;
	var lat = 37.566826;
	var lon = 126.9786567;
	var geocoder = new daum.maps.services.Geocoder(); //주소-좌표 변환 객체 생성
	var markers = [];
	var mapContainer = document.getElementById('map'); //지도 표시할 div
	var mapOption = {
		center: new daum.maps.LatLng(lat, lon), // 지도의 중심좌표
		level: 3 // 지도의 확대 레벨
	}; 
	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption);
	var placelistclicked = -1; //초기값 -1	
	//인포윈도우에 장소명을 표시합니다
	var infowindow = new Array();
	var page = null;
	if(navigator.geolocation){
		navigator.geolocation.getCurrentPosition(function(position) {
	        
	        lat = position.coords.latitude, // 위도
	        lon = position.coords.longitude; // 경도
	      	
	        //지정한 좌표로 주소를 검색해서 inputbox에 표시
	        searchAddrFromCoords(position.coords, displayCenterInfo);
	        
	        locPosition = new daum.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	     	//현재 위치 표시
	    	map.setCenter(locPosition);
	        
	        loadPlaces(lat, lon);
	    }, function(error){
	    	var errorTypes = 
	    	{
	    		0: "알려지지 않은 에러입니다",
	    		1: "회원님이 권한을 거부하셨습니다.",
	    		2: "위치를 찾을 수 없습니다",
	    		3: "요청 응답 시간이 초과되었습니다."
	    	};
	    	var errormsg = errorTypes[error.code];
	    	if(error.code==0 || error.code == 2){
	    		errormsg = errormsg + " : " + error.message;
	    	}
	    	alert(errormsg);
	    	$("#currentposition").html("현재 위치를 찾지 못했습니다.");
	    });	
	}
	else{// HTML5의 GeoLocation을 사용할 수 없을때
		lat = 33.450701;
		lon = 126.570667;
		
		locPosition = new daum.maps.LatLng(lat, lon),    
	  	//현재 위치 표시
		map.setCenter(locPosition);//맵 중심좌표 설정
	}
	
	function loadPlaces(lat, lon){
		$.ajax({
	     		url : "/mimi/nearshoplist",
	     		type : "post",
	        	data : 
	        	{
	        		"latitude" : lat,
	        		"longitude" : lon
	        	},
	        	success : function(data){	      		
	          	if(data.list !== undefined){ //결과들을 마커로 생성하기
	          		for(var i=0; i<data.list.length; i++){
	          			data.list[i].place_name = decodeURIComponent(data.list[i].place_name);	          				          			
	          			data.list[i].address_name = decodeURIComponent(data.list[i].address_name);	          				          				          			
	          			data.list[i].title = decodeURIComponent(data.list[i].title);	          			          
	          			data.list[i].contents = decodeURIComponent(data.list[i].contents);
	          			data.list[i].thumbnail_name = decodeURIComponent(data.list[i].thumbnail_name);
	          		}
	          		
	          		var currentPage = Number(data.list[0].currentPage);
	          		var maxPage = Number(data.list[0].maxPage);
	          		var startPage = Number(data.list[0].startPage);
	          		var endPage = Number(data.list[0].endPage);
	          		var totalCount = Number(data.list[0].totalCount);
	          		          		
	          		//페이지 번호를 표출합니다
	          		page = new pagination(data.list, currentPage, maxPage, startPage, endPage, totalCount);
	          		displayPlaces(data.list); //처음에 보여줄땐 바로 1페이지 목록 보이게
	          		
	          		//검색시  자동으로 1번 마커를 표시
	                daum.maps.event.trigger(markers[0], "click"); //강제로 클릭 발생
	                displayInfowindow(markers[0], data.list[0].place_name, data.list[0].boardNo, data.list[0].thumbnail_name, data.list[0].title, data.list[0].contents, 0);   //처음엔 인포창 생성해야 함 (mouseover 이벤트로 발생되는게 아니기 때문에)          		
	          		displayPagination(page);
	          	
	          	}
	          	else{ //해당 반경의 거리에 값이 없을때    
	          		alert("10km 반경으로 맛집이 존재하지 않습니다.")
	          	}
	      	}                     
		});
	}
	class pagination{  //디비에 있는 정보를 뽑아서 보여주기위해 직접 페이지네이션 객체 선언
		constructor(list, current, max, start, end, total){
			this.list = list;
			this.current = current;
			this.start = start;
			this.end = end;
			this.total = total;
			this.max = max;
			
		}
		gotoPage(i){
			if(this.current !== i){
								
				placelistclicked = -1; //페이지 전환 시 클릭한 인덱스 값 초기화 
				
				$.ajax({
		     		url : "/mimi/nearshoplist",
		     		type : "post",
		        	data : 
		        	{
		        		"latitude" : lat,
		        		"longitude" : lon,
		        		"page" : i
		        	},
		        	success : function(data){
		
		        		//화면에 뿌리기전에  인포윈도우를 지워서 초기화
		    	    	for(var i=0; i<infowindow.length; i++){
		    	    		if(infowindow[i] !== undefined){
		    	    			infowindow[i].setMap(null);	
		    	    			infowindow[i]= null; 
		    	    		}
		    	    	}
		    	    	infowindow = new Array();
		        		
			          	if(data.list !== undefined){ //결과들을 마커로 생성하기
			          		for(var i=0; i<data.list.length; i++){
			          			data.list[i].place_name = decodeURIComponent(data.list[i].place_name);	          				          			
			          			data.list[i].address_name = decodeURIComponent(data.list[i].address_name);	          				          				          			
			          			data.list[i].title = decodeURIComponent(data.list[i].title);	          			          
			          			data.list[i].contents = decodeURIComponent(data.list[i].contents);
			          			data.list[i].thumbnail_name = decodeURIComponent(data.list[i].thumbnail_name);
			          		}
			          		  		
			          		page.current = Number(data.list[0].currentPage);
			          		page.max = Number(data.list[0].maxPage);
			          		page.start = Number(data.list[0].startPage);
			          		page.end = Number(data.list[0].endPage);
			          		page.total = Number(data.list[0].totalCount);          		    		
			          		displayPlaces(data.list); 
			          		//검색시  자동으로 1번 마커 클릭 표시
			                daum.maps.event.trigger(markers[0], "click"); //강제로 클릭 발생
			                displayInfowindow(markers[0], data.list[0].place_name, data.list[0].boardNo, data.list[0].thumbnail_name, data.list[0].title, data.list[0].contents, 0);   //처음엔 인포창 생성해야 함 (mouseover 이벤트로 발생되는게 아니기 때문에)          		
			          		displayPagination(page);
			                    	
			          	}
			          	else{ //해당 반경의 거리에 값이 없을때    
			          		alert("10km 반경으로 맛집이 존재하지 않습니다.")
			          	}
			       		
			          		
		      		}                     
				});	
			}		
		}	
	}
	
	//페이지 클릭 이벤트
	$(document).on("click","#pagination a", function(){
		console.log($(this));
	    if($(this).hasClass("tofirstpage")){				    
	    	page.gotoPage(Number(1));
	    	return false;
	    }
	    if($(this).hasClass("tolastpage")){
	    	page.gotoPage(Number(page.max));
	    	return false;
	    }
	    if($(this).hasClass("toprevpage")){
	    	page.gotoPage(Number(page.start-5));
	    	return false;
	    }
	    if($(this).hasClass("tonextpage")){
	    	page.gotoPage(Number(page.start+5));
	    	return false;
	    }
	  
		page.gotoPage(Number($(this).html()));
	 	
	});
	
	
	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 
		
	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }
	    
	    var el = document.createElement('a');
	    el.href="#";
	    el.innerHTML = "&laquo;";
	    $(el).addClass("tofirstpage");
	    if(pagination.current <= 1){
	    	$(el).addClass("on");
	    	$(el).css("pointer-events", "none");
	    }	    	    
	    fragment.appendChild(el);
	    	    
	    var el = document.createElement('a');
	    el.href="#";
	    el.innerHTML = "&lt;";
	    $(el).addClass("toprevpage");
	    if(!((pagination.current-5)<pagination.start && (pagination.current-5)>=1)){
	    	$(el).addClass("on");	    	
	    	$(el).css("pointer-events", "none");
	    }	    	    
	    fragment.appendChild(el);
	    
	    for (i=pagination.start; i<=pagination.end; i++) {
	    	
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;
	       	if(pagination.current === i){
	       		$(el).addClass("on");
	       		$(el).css("pointer-events", "none");
	       	}	     
	        fragment.appendChild(el);
	    }
	    
	    var el = document.createElement('a');
	    el.href="#";
	    el.innerHTML = "&gt;";
	    $(el).addClass("tonextpage");
	    if(!((pagination.current+5)>pagination.end && (pagination.start + 5)<=pagination.max)){
	    	$(el).addClass("on");	    	
	    	$(el).css("pointer-events", "none");   	
	    }
	    fragment.appendChild(el);    
	    
	    var el = document.createElement('a');
	    el.href="#";
	    el.innerHTML = "&raquo;";
	    $(el).addClass("tolastpage");
	    if(pagination.current >= pagination.max){
	    	$(el).addClass("on");	    	
	    	$(el).css("pointer-events", "none");
	    }	    	    
	    fragment.appendChild(el);
	    paginationEl.appendChild(fragment);
	  
	    
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
	        (function(marker, title, boardNo, thumbnail_name, titleContent, contents) {
	               
	            daum.maps.event.addListener(marker, 'click', function(){

	            	for(var i=0; i<places.length; i++){  //places배열에서 클릭한 마크의 title과 같은 정보의 주소와 전화번호를 뽑아내기 위해
	            		if(places[i].boardNo === boardNo){
	            			
	            			$("#placesList > .item").eq(i).css("background","#F99A86");//list목록
	            			map.setCenter(new daum.maps.LatLng(places[i].y, places[i].x));
	            			
	            			//addressDiv.value = $(this).find("> div > span").first().text();
	            			//telDiv.value = $(this).find(" .tel").text();
							
	            			if(placelistclicked !== -1 && placelistclicked != i){ //초기값일땐 클릭을 안했으니
	            				if(infowindow[placelistclicked] !== undefined){
	            					infowindow[placelistclicked].setMap(null);
	            				}							
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
		            	if(places[i].boardNo === boardNo && placelistclicked !== i){
		        			$("#placesList > .item").eq(i).css("background","#FBE2E2");//list목록	
		        			displayInfowindow(marker, title, boardNo, thumbnail_name, titleContent, contents, i);
		        		}	
	            	}
	            }); 

	            daum.maps.event.addListener(marker, 'mouseout', function() {
	            	
	                for(var i=0; i<places.length; i++){
		                if(places[i].boardNo === boardNo && placelistclicked !== i){
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
	            
	        })(marker, places[i].place_name, places[i].boardNo, places[i].thumbnail_name, places[i].title, places[i].contents);

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
	        markers[i] = null;
	    }   
	    markers = [];
	}

	
	
	/*<div class="title"><div class="body"><div class="desc"></div></div></div>*/
	function displayInfowindow(marker, title, boardNo, thumbnail_name, titleContent, contents, index) {   //윈도우인포(커스텀 오버레이) 꾸미기
		if(thumbnail_name === "undefined"){  //해당 게시물에 썸네일이 없을때
			thumbnail_name = '/mimi/resources/images/logo/default_logo.png';
		}
		else{
			thumbnail_name = '<%=request.getContextPath()%>/resources/files/userboard/' + thumbnail_name;
		}
		var content = '<div class="wrap">' + 
        '    <div class="infowin">' + 
        '        <div class="title">' + 
        					title	  + 
        '        </div>' + 
        '        <div class="body">' + 
        '			<a target="_blank" href="/mimi/userboarddetailview?bnum=' + boardNo + '">' + 
        '            <div class="img img-thumb img-mover">' +
        '                <img src="' + thumbnail_name + '" width="73" height="70">' +
        '           </div></a>' + 
        '            <div class="desc">' + 
        '                <div class="ellipsis">' + titleContent + '</div>' +   
        '                <div class="imgcontents-box" >' + contents + '</div>' + 
        '            </div>' + 	
        '        </div>' + 
        '    </div>' +    
        '</div>';
        
	    //var content = '<div class="wrap"><div  class="infowin"><a target="_blank" href="/mimi/userboarddetailview?bnum=' + boardNo +'"><div class="desc" style="color:white">' + title + '</div></a></div></div>';
		
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
	
	function searchAddrFromCoords(coords, callback) { //좌표로 행정동 주소 정보를 요청
	    // 좌표로 행정동 주소 정보를 요청합니다
	    geocoder.coord2RegionCode(coords.longitude, coords.latitude, callback);         
	}

	//오른쪽 상단 텍스트에 현재 위치 좌표에 대한 주소정보를 표출하는 함수
	function displayCenterInfo(result, status) {
	    if (status === daum.maps.services.Status.OK) {			
	        for(var i = 0; i < result.length; i++) {
	            // 행정동의 region_type 값은 'H' 이므로
	            if (result[i].region_type === 'H') {
	            	$("#currentposition").html(result[i].address_name);	           		
	                break;
	            }
	        }
	    }    
	} 
	
	//지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
	function zoomIn() {
	    map.setLevel(map.getLevel() - 1);
	}

	// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
	function zoomOut() {
	    map.setLevel(map.getLevel() + 1);
	}
	
</script>


<%@include file="../../footer.jsp" %> 
<%@include file="../../end.jsp" %>
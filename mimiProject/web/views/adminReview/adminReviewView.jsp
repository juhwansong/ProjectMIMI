<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="./adminReviewError.jsp"%>
<%@ page import="common.model.vo.Board" %>
<%
	Board board = (Board)request.getAttribute("board");
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();	
%>

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
<!-- 다음맵 인증키 (직접 발급받아야됨) -->
<script type = "text/javascript" src = "//dapi.kakao.com/v2/maps/sdk.js?appkey=795b33c97453a44f73949c94f447f347&libraries=services,clusterer,drawing"></script>
 
<link rel="stylesheet" type = "text/css" href = "/mimi/resources/css/mapPage.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.4.0/clipboard.min.js"></script>
<script type="text/javascript" src="/mimi/resources/js/kakao.min.js"></script>
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

#recommendbtn:hover{
	cursor:pointer;
}

</style>
</head>
<body onload="commentList(1);recommendCheck();bookmarkCheck();menuDisplay();">
<!-- 바디 태그 시작 -->
<%
	String ssuserId = (String)session.getAttribute("userId");
	String authority = (String)session.getAttribute("authority");
	String nickName = (String)session.getAttribute("nickName");
	String gradeName = (String)session.getAttribute("gradeName");
	
	if(ssuserId == null){
%>		
		<%@include file="../../header.jsp" %>
<% 		
	}
	else if(authority.equals("U")){
%>		
		<%@include file="../../memberHeader.jsp" %>
<%	
	}
	else if(authority.equals("A")){
%>		
		<%@include file="../../adminHeader.jsp" %>
<%		
	}
%>

<!-- ---------------------- -->
<script src="//code.jquery.com/jquery.min.js"></script>


<script type="text/javascript">
//로그인에 따라 메뉴 비활성화 처리
function menuDisplay(){
	<% if(ssuserId == null){ %>
		$("#cmtArea").hide();
	<% } %>
}
</script>


<script type="text/javascript">
function cmtedit(obj, cmtNo){
    var checkBtn = $(obj);
	//var trashParam = $(obj).parent().attr('id');
    //var index = $( "#comment" ).index( obj );
    var table = checkBtn.parent().parent().parent();
    var tr = table.children()
    var td = tr.children()
    
    var d0 = td.eq(0).text();
    var d1 = td.eq(1).text();
    var d2 = td.eq(2).text();
    var d3 = td.eq(3).text();
    var d4 = td.eq(4).text();
    
    var cmtcontent= td.eq(4).text();
    
    td.eq(2).empty();
    td.eq(3).empty();
    td.eq(4).empty();
    td.eq(2).append("<td style='width: 50px' class='text-center'><a href='javascript:void(0);' onclick='cmtupdate(\""+ cmtNo + "\");'>완료</a></td>");
    td.eq(3).append("<td style='width: 50px' class='text-center'><a href='javascript:void(0);' onclick='commentList(currentPage);'>취소</a></td>");
    td.eq(4).append("<textarea style=\"width: 100%;\" rows=\"3\" class=\"cmtEditcontent\" name=\"cmtEditcontent\">"+cmtcontent+"</textarea>");
}

function cmtupdate(cmtNo){
    var cmtEditcontent = $(".cmtEditcontent").val();
    console.log("cmtEditcontent : " + cmtEditcontent);
    console.log("cmtNo : " + cmtNo); 
	$.ajax({
		url : "/mimi/adminboardreplyupdate",
		type : "post",
		data : {cmtNo : cmtNo, cmtEditcontent : cmtEditcontent},
		success : function(data){		
			commentList(1); 
		},
		error : function(jqXHR, textstatus, errorThrown){
			console.log("error : " + jqXHR + ", " + 
					textstatus + ", " + errorThrown);
		}
	});  //ajax close
}

function cmtdelete(cmtNo){
	if (confirm("삭제 하시겠습니까?")){ 
		$.ajax({
			url : "/mimi/adminboardreplydelete",
			type : "post",
			data : {cmtNo : cmtNo},
			success : function(data){		
				commentList(1); 
			},
			error : function(jqXHR, textstatus, errorThrown){
				console.log("error : " + jqXHR + ", " + 
						textstatus + ", " + errorThrown);
			}
		});  //ajax close
		}else{ 
		return; 
	} 
} 

</script>
<script type="text/javascript">
	//var listCount = json.listCount;
	//var startPage = json.startPage;
	//var endPage = json.endPage;
	var maxPage = "";
	var currentPage = "";
	function commentList(page){	
	var cmtgradeicon = document.getElementById("cmtgradeicon");
	$.ajax({
		url : "/mimi/adminboardreplylist",
		type : "get",
		dataType : "json",
		data : {bnum : "<%= board.getBoardNo() %>", page : page},
		success : function(data){					
			var jsonStr = JSON.stringify(data);
			var json = JSON.parse(jsonStr);
			var values = "";
			var pageValues = "";

			var level0 = "/mimi/resources/images/icon/icon_human.ico";
			var level1 = "/mimi/resources/images/icon/icon_level1.png";
			var level2 = "/mimi/resources/images/icon/icon_level2.png";
			var level3 = "/mimi/resources/images/icon/icon_level3.png";
			var level4 = "/mimi/resources/images/icon/icon_level4.png";
			
			var a =1;
			
			if("<%= gradeName %>"=="손님")
				cmtgradeicon.src=level0;
			else if("<%= gradeName %>"=="종업원")
				cmtgradeicon.src=level1;
			else if("<%= gradeName %>"=="주방보조")
				cmtgradeicon.src=level2;
			else if("<%= gradeName %>"=="주방장")
				cmtgradeicon.src=level3;
			else
				cmtgradeicon.src=level4;		
			
			for(var i in json.list){
				values += "<tr>"
					+ "<td><table id='comment' style='width:100%'>"
						+ "<tr>";
							if(json.list[i].cmtGradename=="손님")
								values += "<td style='width: 40px'><img src='"+level0+"' width=40 height=40></td>";
							else if(json.list[i].cmtGradename=="종업원")
								values += "<td style='width: 40px'><img src='"+level1+"' width=40 height=40></td>";
							else if(json.list[i].cmtGradename=="주방보조")
								values += "<td style='width: 40px'><img src='"+level2+"' width=40 height=40></td>";
							else if(json.list[i].cmtGradename=="주방장")
								values += "<td style='width: 40px'><img src='"+level3+"' width=40 height=40></td>";
							else
								values += "<td style='width: 40px'><img src='"+level4+"' width=40 height=40></td>";
							values += "<td class='text-left'>&nbsp;" + json.list[i].cmtNickname + "<span style='font-size: 8px'>&nbsp;&nbsp;" + json.list[i].cmtDate + "</span></td>"
							//+ "<td style='width: 50px' class='text-center' id=\"abc\"><a href='#a' class='cmtedit'>수정</a></td>"
							+ "<td style='width: 50px' class='text-center'>";
			if(json.list[i].cmtUserId=="<%= ssuserId %>"){
				values += "<a href='javascript:void(0);' onclick=\"cmtedit(this, \'"+ json.list[i].cmtNo + "\');\">수정</a></td>"
			}
				values += "</td><td style='width: 50px' class='text-center'>";
			if(json.list[i].cmtUserId=="<%= ssuserId %>"){
				values += "<a href='javascript:void(0);' onclick=\"cmtdelete('"+ json.list[i].cmtNo + "');\">삭제</a>"
			}		
				values +="</td></tr>"
					+"<tr>"
					+"<td colspan='4' class='text-left' id='cmtContentsview'><div class='margin5'>" + json.list[i].cmtContents + "</div></td>"
					+"</tr>"
					+"</table></td>"
				+"</tr>";
			}	
			$("#cmtlist").html(values);
			//$("#paging").paging();
			maxPage = json.maxPage;
			currentPage = json.currentPage;
			$("#pagination").empty();

			//<< 1
			if(json.currentPage <= 1){
				pageValues += '<li><span style="color:#ccc;">&laquo;</span></li><li>';
			}else{
				pageValues += '<li><a href="javascript:void(0)" onclick="paging(1);" title="맨처음"><span style="color:#444;">&laquo;</span></a></li><li>'
			}
			
			//< -10
			if((json.currentPage - 10) <= json.startPage && (json.currentPage - 10) > 1){
				pageValues += '<a href="javascript:void(0)" onclick="commentList(' + (json.currentPage - 10) + ');" title="이전"><span style="color:#444;">&lt;</span></a></li>'	
			}else if(json.currentPage != 1){ //1페이지 아니면 항상 활성화
				pageValues += '<a href="javascript:void(0)" onclick="commentList(1);" title="이전"><span style="color:#444;">&lt;</span></a></li>'
			}else{
				pageValues += '<span style="color:#ccc;">&lt;</span></li>'
			}
			 	//123
			for(var p = json.startPage; p <= json.endPage; p++){
				if(p == json.currentPage){
						pageValues += '<li><span style="color:#ccc;">' + p + '</span></li>'
			 	}else{ 
					pageValues += '<li><a href="javascript:void(0)" onclick="commentList(' + p + ');"><span style="color:#444;">' + p + '</span></a></li>'
				}
			}
				
			//> +10
			if((json.currentPage + 10) <= json.maxPage){
		 		pageValues += '<li><a href="javascript:void(0)" onclick="commentList(' + (json.currentPage + 10) + ');" title="다음"><span style="color:#444;">&gt;</span></a></li>'
			}else if((json.currentPage + 10 ) > json.maxPage && json.currentPage < json.maxPage){ //마지막 페이지 아닐시 항상 활성화
				pageValues += '<li><a href="javascript:void(0)" onclick="commentList(' + (json.maxPage) + ');" title="다음"><span style="color:#444;">&gt;</span></a></li>'
			}else{
				pageValues += '<li><span style="color:#ccc;">&gt;</span></li>'
			}
				
			//>> max
			if(json.currentPage >= json.maxPage){
				pageValues += '<li><span style="color:#ccc;">&raquo;</span></li>'
			}else{
				pageValues += '<li><a href="javascript:void(0)" onclick="commentList(' + json.maxPage + ');" title="맨끝"><span style="color:#444;">&raquo;</span></a></li>'	
			}
			$("#pagination").html(pageValues);//페이지네이션
			},
			error : function(jqXHR, textstatus, errorThrown){
				console.log("error : " + jqXHR + ", " + 
						textstatus + ", " + errorThrown);
			}
		});  //ajax close
	}
</script>

<script type="text/javascript">
function recommendCheck(){
	//추천 상태 체크
    var bnum = $("#bnum").val();
    var recommendbtn = document.getElementById("recommendbtn");
    var recommendState = document.getElementById("recommedState");
	$.ajax({
		url : "/mimi/recommendcheck",
		type : "get",
		dataType : "json",
		data : {bnum : "<%= board.getBoardNo() %>"},
		success : function(data){
			var jsonStr = JSON.stringify(data);
			var json = JSON.parse(jsonStr);
			if(json.result==1){
				recommendbtn.src="/mimi/resources/images/icon/icon_thumb_up.png"
				recommendState.value = "up";
			} else{
				recommendbtn.src="/mimi/resources/images/icon/icon_thumb_down.png"
				recommendState.value = "down";
			}
			$('#good_qta').text(json.recommendCount);
		},
		error : function(jqXHR, textstatus, errorThrown){
			console.log("error : " + jqXHR + ", " + 
					textstatus + ", " + errorThrown);
		}
	});  //ajax close
}
function recommendInsert(){
	//추천 업
    var bnum = $("#bnum").val();
    var recommendbtn = document.getElementById("recommendbtn");
	$.ajax({
		url : "/mimi/recommendinsert",
		type : "get",
		data : {bnum : "<%= board.getBoardNo() %>"},
		success : function(data){	
			recommendCheck();
		},
		error : function(jqXHR, textstatus, errorThrown){
			console.log("error : " + jqXHR + ", " + 
					textstatus + ", " + errorThrown);
		}
	});  //ajax close
}

function recommendDown(){
	//추천 다운
    var bnum = $("#bnum").val();
    var recommendbtn = document.getElementById("recommendbtn");
	$.ajax({
		url : "/mimi/recommenddelete",
		type : "get",
		data : {bnum : "<%= board.getBoardNo() %>"},
		success : function(data){	
			recommendCheck();
		},
		error : function(jqXHR, textstatus, errorThrown){
			console.log("error : " + jqXHR + ", " + 
					textstatus + ", " + errorThrown);
		}
	});  //ajax close
}

function recommendClick(){
	//추천버튼클릭
	<% if(ssuserId == null){ %>
		alert("로그인이 필요합니다!");
	<% } else{ %>
	if(document.getElementById("recommedState").value == "down"){
		recommendInsert();
	} else{
		recommendDown();
	}
	<% } %>
}
</script>

<script type="text/javascript">
function cmtinsert(){
    var bnum = $("#bnum").val();
    var cmtContent = $("#cmtContent").val();
	$.ajax({
		url : "/mimi/adminboardreplyinsert",
		type : "post",
		data : {userid : "ssuserId", bnum : $("#bnum").val(), cmtContent : $("#cmtContent").val()},
		success : function(data){		
			commentList(maxPage); 
		},
		error : function(jqXHR, textstatus, errorThrown){
			console.log("error : " + jqXHR + ", " + 
					textstatus + ", " + errorThrown);
		}
	});  //ajax close
}
</script>

<!-- 즐겨찾기 -->
<script type="text/javascript">
function bookmarkCheck(){
	//즐겨찾기 상태 체크
	var addbook = 'fas fa-star';
	var subbook = 'far fa-star';
	$.ajax({
		url : "/mimi/bookmarkCheck",
		type : "get",
		data : {bnum : "<%= board.getBoardNo() %>"},
		success : function(data){
			if(data==1){
				$("#bookmarkBtn").children().prop('class', addbook); //즐겨찾기 등록 아이콘
			} else{
			    $("#bookmarkBtn").children().prop('class', subbook); //즐겨찾기 미등록 아이콘
			}
		},
		error : function(jqXHR, textstatus, errorThrown){
			console.log("error : " + jqXHR + ", " + 
					textstatus + ", " + errorThrown);
		}
	});  //ajax close
}
</script>

<script type="text/javascript">

function bookmarkAdd(){
	//즐겨찾기 추가
	<% if(ssuserId == null){ %>
		alert("로그인이 필요합니다!");
	<% } else{ %>
    var bnum = $("#bnum").val();
    var urlstr = "/mimi/bookmarkinsert";
    var i = 0;
    if($("#bookmarkBtn").children().attr('class') === 'far fa-star')
    	urlstr = "/mimi/bookmarkinsert";
    else
    	urlstr = "/mimi/bookmarkdeleteAjax";
	$.ajax({
		url : urlstr,
		type : "get",
		data : {bnum : "<%= board.getBoardNo() %>"},
		success : function(data){	
			bookmarkCheck();
		},
		error : function(jqXHR, textstatus, errorThrown){
			console.log("error : " + jqXHR + ", " + 
					textstatus + ", " + errorThrown);
		}
	});  //ajax close
	<% }%>
}

function bookmarkSub(){
	//추천 업
    var bnum = $("#bnum").val();
	$.ajax({
		url : "/mimi/recommenddelete",
		type : "get",
		data : {bnum : "<%= board.getBoardNo() %>"},
		success : function(data){	
			recommendCheck();
		},
		error : function(jqXHR, textstatus, errorThrown){
			console.log("error : " + jqXHR + ", " + 
					textstatus + ", " + errorThrown);
		}
	});  //ajax close
}

</script>

<script type="text/javascript">
function cmtinsert(){
    var bnum = $("#bnum").val();
    var cmtContent = $("#cmtContent").val();
	$.ajax({
		url : "/mimi/adminboardreplyinsert",
		type : "post",
		data : {userid : "ssuserId", bnum : $("#bnum").val(), cmtContent : $("#cmtContent").val()},
		success : function(data){		
			commentList(maxPage); 
		},
		error : function(jqXHR, textstatus, errorThrown){
			console.log("error : " + jqXHR + ", " + 
					textstatus + ", " + errorThrown);
		}
	});  //ajax close
}
</script>
<script type="text/javascript">
/*
   $(function(){
      //버튼 클릭시 즐겨찾기 작동
      $("#bookmarkBtn").on('click', function(){   
         var icon = ($(this).children().attr('class') === 'fas fa-star') ? 'far fa-star' : 'fas fa-star';
         $(this).children().prop('class', icon); //아이콘 변경

          var urlValue = "";         
         if($(this).children().attr('class') === 'fas fa-star'){ //추가
            urlValue = "bookmarkinsert";
         }else{//삭제
            urlValue = "bookmarkdelete";
         }
         //console.log("url값 : " + urlValue);
		$.ajax({
			url : "/mimi/user",
			type : "post",
			data : {userid : "ssuserId", bnum : $("#bnum").val(), cmtContent : $("#cmtContent").val()},
			success : function(data){		
				commentList(maxPage); 
			},
			error : function(jqXHR, textstatus, errorThrown){
				console.log("error : " + jqXHR + ", " + 
						textstatus + ", " + errorThrown);
			}
		});  //ajax close
      
   })//document*/
</script>


<script type="text/javascript">
	//$(function(){
		
		new Clipboard('.copyBtn', {text: function() {
			alert("클립보드에 복사되었습니다.");
		    return document.location.href;
		  }
		});
	//});//onload
	
</script>


<div class="container" style="width:1150px;">
	<h3>MIMI리뷰</h3>
	<div id="inner">
		<table class="table table-borderless" id="table-css2">
			<tr>
				<th width="12%">No.<%= board.getBoardNo().substring(2).replaceAll("^0*","") %></th>
				<th width="*" style="text-align:left;"><%= board.getTitle() %></th>
				<th width="28%">
				<i class="fas fa-pen"></i><%= board.getNickName() %>&nbsp;<img src="/mimi/resources/images/icon/icon_level4.png" style="width:25px; height:25px;">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="far fa-eye"></i><%= board.getHits() %>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="far fa-calendar"></i><%= board.getBoardDate() %></th>
				<th width="8%"><button type="button" class="btn btn-default btn-lg" id="bookmarkBtn" style="outline: none;" onclick="bookmarkAdd();">
				<span class="far fa-star" aria-hidden="true" style="color: #fd0"></span>
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
				
				
	    		<div id="map" style="width:350px;height:230px;position:relative;overflow:hidden;">
	    				<div class="custom_zoomcontrol radius_border" style="z-index:5; opacity:0.8;top:20px; right:20px;"> 
       						<span onclick="zoomIn()" ><img style="position:relative;right:1px;height:100%;" src="http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
        					<span onclick="zoomOut()"><img style="position:relative;right:1px;height:100%;" src="http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
    					</div>
	    		</div>
	    	
			</tr>
			<tr>
				<th>매장명</th>
				<td><%= board.getShopName() %></td>
			</tr>
			<tr>
				<th>연락처</th><% String call = (board.getShopCall() != null) ? board.getShopCall() : "-"; %>
				<td><%= call %></td>
			</tr>
			<tr>
				<th>매장 주소</th>
				<td><%= board.getShopAddress() %></td>
			</tr>

		</table>
	</div>
	
	<hr class="margin2">
	<div id="text_context" style="min-height:300px;">			
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
	<!-- 추천 영역 -->
	<div style="text-align: center;" id="recommed">
		<input type="hidden" id="recommedState" value="down" >
		<img class="btn-img"
			src="/mimi/resources/images/icon/icon_thumb_down.png" width=50 onclick="recommendClick();" id="recommendbtn">
		<p id="good_qta"><%= board.getRecommed() %></p>
	</div>
	<!-- comment -->
	<div style="text-align: center;">
		<!-- 기존 댓글 -->
		<table class="table table-borderless" style="width:100%" id="cmtlist">
		
		</table>

		<hr class="margin2">
		<table style="width:100%">
	<tr>
		<td width="10%"></td><!-- 빈칸 -->
		<td width="*"><!-- 페이지 -->
		<!-- Pagination -->
			<ul class="pagination" id="pagination" style="float: center; display: flex; justify-content: center;">
			</ul>	
		</td>
	</tr>
</table>
		<!-- 댓글 작성부분 -->
		<!--<form>-->
		<div id="cmtArea">
		<input type="hidden" id="bnum" name="bnum" value="<%= board.getBoardNo() %>">
		<input type="hidden" id="userid" name="userid" value="<%= ssuserId %>"><!-- -------------------------------------------------------------------------------------------------------- -->
		<table style="width:100%;">
			<tr>
				<td width="15%"><img src="/mimi/resources/images/icon/icon_human.ico" width=40
				height=40 id="cmtgradeicon">&nbsp;&nbsp;<label><%= nickName %></label></td>
				<td width="*"><textarea style="width: 100%;" rows="3" id="cmtContent" name="cmtContent"></textarea></td>
				<td width="8%"><button class="btn btn-default" style="outline: none;" value="등록" id="cmtsubmit" onclick="cmtinsert()">등록</button></td>
			</tr>
		</table>
		</div>
		<!--</form>->
		<!-- /댓글 작성부분 -->
	</div>
	<hr>
	<div class="row">
		<div class="col-xs-6 text-left">
			<input type="button" class="btn btn-default"
				onClick="location.href='/mimi/adminboardlist'" value="목록">
		</div>
		<% if(board.getUserId().equals(ssuserId)){ %>
		<div class="col-xs-6 text-right">
			<input type="submit" class="btn btn-default" value="수정" style="outline: none;" onClick="location.href='/mimi/adminboardupdate?bnum=<%= board.getBoardNo() %>&page=<%= currentPage %>'">
			<input type="submit" id="user-delete-btn" class="btn btn-default" value="삭제" style="outline: none;">
		</div>
		<% } %>
	</div>
	<br>
</div>
<!-- 페이징 처리 -->
<div style="text-align: center" id="paging">

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
          webUrl: 'http://hjl822.cafe24.com/mimi/views/adminReview/userReviewView.jsp'
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

//지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomIn() {
    map.setLevel(map.getLevel() - 1);
}

// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomOut() {
    map.setLevel(map.getLevel() + 1);
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
		form.action = "/mimi/adminboarddelete";
		
		document.body.appendChild(form);
		form.submit();
		
		board.getContentsTag()
	});	
});

</script>

<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>

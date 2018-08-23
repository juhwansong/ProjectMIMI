<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="./userReviewError.jsp"%>
<%@ page import="common.model.vo.Board" %>
<%
	Board board = (Board)request.getAttribute("board");
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	//String userId = (String)session.getAttribute("userId");
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
</head>
<body onload="commentList()">
<!-- 바디 태그 시작 -->

<%
	String userId = (String)session.getAttribute("userId");
	String authority = (String)session.getAttribute("authority");
	String nickName = (String)session.getAttribute("nickName");
	
	if(userId == null){
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
//var listCount = json.listCount;
//var startPage = json.startPage;
//var endPage = json.endPage;
//var maxPage = json.maxPage;
//var currentPage = json.currentPage;
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
    //td.eq(2).append("<td style='width: 50px' class='text-center'><a href='javascript:void(0);' onclick='cmtupdate();'>완료</a></td>");
	td.eq(3).append("<td style='width: 50px' class='text-center'><a href='javascript:void(0);' onclick='commentList();'>취소</a></td>");
    td.eq(4).append("<textarea style=\"width: 100%;\" rows=\"3\" class=\"cmtEditcontent\" name=\"cmtEditcontent\">"+cmtcontent+"</textarea>");
}

function cmtupdate(cmtNo){
    var cmtEditcontent = $(".cmtEditcontent").val();
    console.log("cmtEditcontent : " + cmtEditcontent);
    console.log("cmtNo : " + cmtNo); 
	$.ajax({
		url : "/mimi/userboardreplyupdate",
		type : "post",
		data : {cmtNo : cmtNo, cmtEditcontent : cmtEditcontent},
		success : function(data){		
			commentList(); 
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
			url : "/mimi/userboardreplydelete",
			type : "post",
			data : {cmtNo : cmtNo},
			success : function(data){		
				commentList(); 
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

	function commentList(){
	$.ajax({
		url : "/mimi/userboardreplylist?bnum=<%= board.getBoardNo() %>",
		type : "get",
		dataType : "json",
		success : function(data){					
			var jsonStr = JSON.stringify(data);
			//console.log(jsonStr);
			var json = JSON.parse(jsonStr);
			//console.log(json);
			//listCount = json.listCount;
			//startPage = json.startPage;
			//endPage = json.endPage;
			//maxPage = json.maxPage;
			//currentPage = json.currentPage;
			var values = "";
			for(var i in json.list){
				values += "<tr>"
					+ "<td><table id='comment' style='width:100%'>"
						+ "<tr>"
							+ "<td style='width: 40px'><img src='/mimi/resources/images/icon/icon_human.ico' width=40 height=40></td>"
							+ "<td class='text-left'>&nbsp;" + json.list[i].cmtNickname + "<span style='font-size: 8px'>&nbsp;&nbsp;" + json.list[i].cmtDate + "</span></td>"
							//+ "<td style='width: 50px' class='text-center' id=\"abc\"><a href='#a' class='cmtedit'>수정</a></td>"
							+ "<td style='width: 50px' class='text-center'>";
							if(json.list[i].cmtNickname=="양은주"){
								values += "<a href='javascript:void(0);' onclick=\"cmtedit(this, \'"+ json.list[i].cmtNo + "\');\">수정</a></td>"
							}
							values += "</td>"
							+ "<td style='width: 50px' class='text-center'><a href='javascript:void(0);' onclick=\"cmtdelete('"+ json.list[i].cmtNo + "');\">삭제</a></td>"
						+"</tr>"
					+"<tr>"
						+"<td colspan='4' class='text-left' id='cmtContentsview'><div class='margin5'>" + json.list[i].cmtContents + "</div></td>"
					+"</tr>"
					+"</table></td>"
				+"</tr>";
			}	
				$("#cmtlist").html(values);
				//$("#paging").paging();
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
  	var userid = $("#userid").val();
    var bnum = $("#bnum").val();
    var cmtContent = $("#cmtContent").val();
	$.ajax({
		url : "/mimi/userboardreplyinsert",
		type : "post",
		data : {userid : $("#userid").val(), bnum : $("#bnum").val(), cmtContent : $("#cmtContent").val()},
		success : function(data){		
			commentList(); 
		},
		error : function(jqXHR, textstatus, errorThrown){
			console.log("error : " + jqXHR + ", " + 
					textstatus + ", " + errorThrown);
		}
	});  //ajax close
}

</script>

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
				<td style="width: 300px; align:center;" rowspan="4" colspan="2"><img
					src="/mimi/resources/images/userReview/map.jpg" width=100%
					height=300></td>
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
	<div style="margin:20px;">
	<p id="text_context">
		<%= board.getContentsTag() %><br>
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
		
		
		<!-- 댓글 작성부분 -->
		<!--<form>-->
		<input type="hidden" id="bnum" name="bnum" value="<%= board.getBoardNo() %>">
		<input type="hidden" id="userid" name="userid" value="user02">
		<table style="width:100%;">
			<tr>
				<td width="15%"><img src="/mimi/resources/images/icon/icon_human.ico" width=40
				height=40>&nbsp;&nbsp;<label>user03</label></td>
				<td width="*"><textarea style="width: 100%;" rows="3" id="cmtContent" name="cmtContent"></textarea></td>
				<td width="8%"><button class="btn btn-default" style="outline: none;" value="등록" id="cmtsubmit" onclick="cmtinsert()">등록</button></td>
			</tr>
		</table>
		<!--</form>->
		<!-- /댓글 작성부분 -->
	</div>
	<hr>
	<div class="row">
		<div class="col-xs-6 text-left">
			<input type="button" class="btn btn-default"
				onClick="window.history.back();" value="목록">
		</div>
		<div class="col-xs-6 text-right">
			<input type="submit" class="btn btn-default" value="수정" style="outline: none;" onClick="location.href='/mimi/userboardupdate?bnum=<%= board.getBoardNo() %>&page=<%= currentPage %>'">
			<input type="submit" class="btn btn-default" value="삭제" style="outline: none;" onClick="location.href='/mimi/userboarddelete?bnum=<%= board.getBoardNo() %>'">
		</div>
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

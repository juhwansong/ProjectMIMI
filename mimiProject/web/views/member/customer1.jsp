<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="support.model.vo.Support, java.util.*" %>
<%
	ArrayList<Support> slist =(ArrayList<Support>) request.getAttribute("slist");
 	int listCount = ((Integer) request.getAttribute("listCount")).intValue();
	int startPage = ((Integer) request.getAttribute("startPage")).intValue();
	int endPage = ((Integer) request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer) request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer) request.getAttribute("currentPage")).intValue();
	String column = (String)request.getAttribute("col"); 
	String keword = (String)request.getAttribute("keword");
%>

<%@include file="../../head.jsp"%>
<!-- ----------- -->

<!-- <title>adminPage</title> -->



<script type="text/javascript">
	 function FaqToggleDetail ( id ){
		var latestToggleObj = null;
		var oObj = document.getElementById( id );	

		if( this.latestToggleObj != null ){
			this.latestToggleObj.className = (this.latestToggleObj.className + " none");
		}
		if( this.latestToggleObj == oObj ){
			this.latestToggleObj = null;
			return;
		}
		this.latestToggleObj = null;

		if( oObj.className.indexOf( "none" ) != -1 ){
			console.log(id.substr(4));   
			commentList(id.substr(4));	/////////클릭했을때 댓글 목록 불러오기
			oObj.className = oObj.className.replace( "none", "" );			
		}else{
			//접혔을때
			
			oObj.className = (oObj.className + " none");
		}
		this.latestToggleObj = oObj;
	 }
	 
	 function gourl(url){
		  location.href=url;
		 }
		 
		/*  function searchCheck(){
		  var form = document.searchForm;
		  if (form.word.value == '' || form.word.value == null){
		   alert('검색어를 입력하세요.');
		   form.word.focus();
		   return false;
		  } else {
		   form.submit;
		  }
		 } */
	 
</script>


<style>
.none{ display:none; }
.pointer{ cursor:pointer; }

#td-title{
	text-align: left;
	font-size: 15px;
}
.detailview-box td:HOVER {
	background: white!important;
}
/* 
@media screen and (max-width: 700px) {
	table, tr, td {
		display: block;
	}
} */
</style>
<!-- ------------------------------------------------ -->

<div class="container" style="width:1150px;">

<!-- 상단 이미지 -->
	<div class="img-div2" style="padding: 5px 10px;">
		<a href="#"><img src="/mimi/resources/images/intro/mimi_service_header.jpg" class="img2" alt=""></a>
	</div>


<!-- 게시판 시작 -->
	<table style="width: 100%; border: 0;">
		<tr>
			<td><h3>고객센터</h3></td>
			<td style="text-align: right; vertical-align: bottom; color: #777">
				<!-- 카테고리 -->
				<form class="form-inline" name="select-category" id="select-category" method="post" action="/mimi/supportsearch">
					<div class="form-group" style="float: right; margin: 3px;">
						<SELECT class="form-control" id="col" name="col"> <!-- 검색 컬럼 -->
							<OPTION value="title">제목</OPTION>
							<OPTION value="contents">내용</OPTION>	
							<OPTION value="user_id">작성자</OPTION>	
						</SELECT>				
							
						<input type="text" class="form-control" name="keword"
							id="keword" size="15" placeholder="내용을 입력해 주세요">
							​​​​​​​
						<button type="submit" class="btn" name="searchbtn" style="outline: none">
							검색&nbsp;<i class="fas fa-search"></i>
						</button>
					</div>
				</form>
			</td>
		</tr>
	</table>
	<!-- 게시글 -->
<hr class="margin2">
<table class="table table-hover" id="table-css">
	<thead>
		<tr>
			<th width="8%">글번호</th>
			<th width="10%">종류</th>
			<th width="10%">처리상태</th>
			<th width="*">제목</th>
			<th width="12%">작성자</th>
			<th width="12%">작성일</th>
		</tr>
		<% for(Support s : slist) { %>
		<tr align="center" onclick="FaqToggleDetail( 'row_<%= s.getBoardNo() %>' )">
		<% } %>

		</thead>
		
		<tbody>
		<% for(Support s : slist) { %>
			<tr onclick="FaqToggleDetail( 'row_<%= s.getBoardNo() %>' )">
				<td><%= s.getBoardNo() %></td>
				<td><%= s.getCategory() %></td>
				<td><%= s.getState() %></td>
				<td id="td-title"><span id="td_row_1"><%= s.getTitle() %></span></td>
				<td><%= s.getUserId() %></td>
				<td><%= s.getWriteDate() %></td>
			</tr>
			<tr class="none detailview-box" id="row_<%= s.getBoardNo() %>">
	<td colspan="6"><!-- 내용 불러오기 -->
				<br><div class="pointer"  style="padding:10px 50px 10px 50px; border:0px; min-height:auoto; width:100%; text-align:left;" ><%= s.getContents() %></div>	<br><br>
				<button type="button" class="btn btn-default pull-right"  onClick="location.href='/mimi/sdelete?sno=<%= s.getBoardNo() %>'" name="btnDelete" style="outline:none; padding: 7px; margin:2px;">삭제</button>
				<button type="button" class="btn btn-default pull-right" onClick="location.href='/mimi/supdate?sno=<%= s.getBoardNo() %>&page=<%= currentPage %>'" name="btnModify" style="outline:none; padding: 7px; margin:2px;">수정</button>
	<br><br>
				<!-- 댓글 불러오기 -->
				<div class="comment<%=s.getBoardNo()%>"></div>
				<!-- 내용 입력창 -->	
				<div><textarea id="<%=s.getBoardNo()%>" class="form-control" name="contents" rows="5" style="width:90%; float:left" placeholder="내용을 입력해주세요"></textarea>
						<input type="button" class="btn btn-default"  onclick="commentInsert('<%=s.getBoardNo()%>');"   value="댓글작성" style="outline:none"></div>
											
	</td>
		
<!--  <tr><td colspan="5"><textarea class="form-control" name="contents" rows="5" placeholder="내용을 입력해주세요"></textarea></td>
	<td><input type="button" class="btn btn-default" name="btn" value="댓글작성" style="outline:none"></td></tr>  -->
	
</tr>
		<% } %>	
		</tbody>
		
</table>
	
	
	
												<script>
												//댓글 등록
												function commentInsert(insertData){													
													var comment = $("#" + insertData).val();
													$.ajax({        
														url : '/mimi/supportreplyinsert',        
														type : 'post',        
														data : 
														{
															"board_no" : insertData,
															"comment_contents" : comment
														},        
														success : function(data){     
															console.log(data);
															if(data === "1") {                
																//commentList(); //댓글 작성 후 댓글 목록 reload                
																$("#" + insertData).val('');   
																console.log(data);
																console.log(insertData);
																commentList(insertData);
																
																
															}     
														}   
													});
												}
												//댓글 목록 
												function commentList(insertData){    
													$.ajax({        
													url : '/mimi/supportreplylist',       
													type : 'get',        
													data : {'bno':insertData},        
													success : function(data){            
														if(data.clist !== undefined){///////////////////////////////////////////////
																							
															var a ='';      
															for(var i = 0; i < data.clist.length; i++){
																a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px; text-align:left; padding:10px 50px 10px 50px;">';               
																
																a += '<div class="commentInfo'+data.clist[i].cno+'">'+data.clist[i].cwriter+'&nbsp &nbsp'+data.clist[i].cdate;                 
														       
																a += '<div class="commentContent'+data.clist[i].cno+'"> <p> &nbsp &nbsp &nbsp ' + decodeURIComponent(data.clist[i].comment) +'</p>';                
																a += '</div></div></div>';     
															}
															
																													
															
															
															/* $.each(data, function(key, value){                 
																a += '<div style="padding:10px 50px 10px 50px; border:0px; min-height:auoto; width:100%;">';               
																a += '<div class="commentInfo'+value.cno+'">'+'댓글번호 : '+value.cno+' / 작성자 : '+value.cwriter;                
																a += '<a onclick="commentUpdate('+value.cno+',\''+value.comment+'\');"> 수정 </a>';                
																a += '<a onclick="commentDelete('+value.cno+');"> 삭제 </a> </div>';                
																a += '<div class="commentContent'+value.cno+'"> <p> 내용 : '+value.comment +'</p>';                
																a += '</div></div>';     
															});     
															 */
															$(".comment" + insertData).html(a);     
														}
														else{ 
															//댓글 목록이 없을때
														}
													}
													});
												}
											/* 	$(function({
													
													
													 
														
														var bno = ""; //게시글 번호 
														var insertData = $('#comment').val(); //comment의 내용을 가져옴    
														commentInsert(insertData); //Insert 함수호출(아래)});   //댓글 목록 
														
														
														//댓글 등록
														
												}); */
									
										
										/* //댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
														function commentUpdate(cno, content){   
														var a ='';       
														
														a += '<div class="input-group">';    
														a += '<input type="text" class="form-control" name="content_'+cno+'" value="'+content+'"/>';    
														a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="commentUpdateProc('+cno+');">수정</button> </span>';    
														a += '</div>';        
														$('.commentContent'+cno).html(a);    }
										
										
														function commentUpdateProc(cno){    
															var updateContent = $('[name=content_'+cno+']').val();        
															$.ajax({        url : '/comment/update',        
																type : 'post',        
																data : {'content' : updateContent, 'cno' : cno},        
																success : function(data){           
																	if(data == 1)
																		commentList(bno); //댓글 수정후 목록 출력  
																	} 
																});
															} 
														
														//댓글 삭제 
														function commentDelete(cno){   
															$.ajax({        
																url : '/comment/delete/'+cno,       
																type : 'post',       
																success : function(data){         
																	if(data == 1) commentList(bno); //댓글 삭제후 목록 출력      
																	}  
															});
															}    */
															
														/* $(document).ready(function(){    
															commentList(); //페이지 로딩시 댓글 목록 출력
														});   */
														
														</script>

				


<hr class="margin1" style="margin: 0px 0 5px 0;">

<table style="width:100%;">
	<tr>
		<td width="10%"></td><!-- 빈칸 -->
		<td width="*"><!-- 페이지 -->
   <!-- Pagination -->
      <ul class="pagination" style="float: center; display: flex; justify-content: center;">
         <!-- 맨앞으로 -->
         <li>
         <% if(currentPage <= 1){ %>
            <span style="color:#ccc;">&laquo;</span>
         <% }else{ %>
         		<%if(column != null) {%>
         			<a href="/mimi/supportsearch?page=1&col=<%=column%>&keword=<%=keword%>" title="맨처음"><span style="color:#444;">&laquo;</span></a>
         		<%}else{ %>
            		<a href="/mimi/supportlist?page=1" title="맨처음"><span style="color:#444;">&laquo;</span></a>
            	<%} %>
         <% } %>
         </li>
         
         <!-- 하나 앞 -->
         <li>
            <% if((currentPage - 10) < startPage && (currentPage - 10) > 1){ %>
            	<%if(column != null) {%>
            		<a href="/mimi/supportsearch?page=<%=startPage - 10%>&col=<%=column%>&keword=<%=keword%>" title="이전"><span style="color:#444;">&lt;</span></a> 
         		<%}else{%>
            		<a href="/mimi/supportlist?page=<%=startPage - 10%>" title="이전"><span style="color:#444;">&lt;</span></a> 
            	<%} %>  
         <% }else{ %>
            <span style="color:#ccc;">&lt;</span>
         <% } %>
         </li>
         
         <% for(int p = startPage; p <= endPage; p++){
               if(p == currentPage){%>
         <li><span style="color:#ccc;"><%=p %></span></li>
         <% }else{ %>
         		<%if(column != null) {%>
         			<li><a href="/mimi/supportsearch?page=<%=p%>&col=<%=column%>&keword=<%=keword%>"><span style="color:#444;"><%=p %></span></a></li>
         		<%}else{%>
         			<li><a href="/mimi/supportlist?page=<%=p%>"><span style="color:#444;"><%=p %></span></a></li>
         		<%} %>
         <% }} %>
         
         <!-- 하나 뒤 -->
         <% if((currentPage + 10) > endPage && (currentPage + 10) < maxPage){ %>
         <li>
         	<%if(column != null) {%>
         		<a href="/mimi/supportsearch?page=<%=endPage + 10%>&col=<%=column%>&keword=<%=keword%>" title="다음"><span style="color:#444;">&gt;</span></a>
         	<%}else{%>
            	<a href="/mimi/supportlist?page=<%=endPage + 10%>" title="다음"><span style="color:#444;">&gt;</span></a>
            <%} %>
         </li>
         <% }else{ %>
         <li><span style="color:#ccc;">&gt;</span></li>
         <!-- 맨뒤 -->
         <% }
            if(currentPage >= maxPage){%>
            <li><span style="color:#ccc;">&raquo;</span></li>
         <% }else{ %>
         <li>
         		<%if(column != null) {%>
         			<a href="/mimi/supportsearch?page=<%=maxPage%>&col=<%=column%>&keword=<%=keword%>" title="맨끝"><span style="color:#444;">&raquo;</span></a>
         		<%}else{%>
            		<a href="/mimi/supportlist?page=<%=maxPage%>" title="맨끝"><span style="color:#444;">&raquo;</span></a>
            	<%} %>
         </li>
         <%}%>
         
      </ul>   
	</td> 
		<!-- 글쓰기버튼 -->
		<td width="10%" style="vertical-align:top;">
				<input type="button" class="btn btn-default pull-right"
			onClick="location.href='/mimi/views/member/cwritepage.jsp'"
			value="글쓰기" style="outline: none;">
		</td>
	</tr>
</table>
</div>
<!-- ------------------------------------------------ -->
<%@include file="../../footer.jsp"%>
<%@include file="../../end.jsp"%>
<!-- ------------------------------------------------ -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../../head.jsp" %>
<%-- <%@include file="../../header.jsp" %> --%>
<%@include file="../../memberHeader.jsp" %>
<%-- <%@include file="../../adminHeader.jsp" %> --%>
<!-- ----------- -->
<!-- <title>adminPage</title> -->

<style>
/* 	h1 { border-bottom: 1px solid rgba(0, 0, 0, 1) }
	
	#menuTitle { 
		width: 360px;
		height: 50px;
		margin-left: 30px; 
	}
	
	#search { 
		float: right; 
		display: inline; 
		margin-bottom: 10px;
	}
	
	#delete { 
		float: right;
		display: inline;
		margin-bottom: 10px;
	}
	
	.sidenav {
	    height: 50%;
	    width: 200px;
	    position: fixed;
	    z-index: 1;
	    top: 0;
	    left: 0;
	    background-color: #ffffff;
	    overflow-x: hidden;
	    padding-top: 120px; 
	}
	
	.sidenav a {
	    padding: 6px 6px 6px 6px;
	    text-decoration: none;
	    text-align: center;
	    font-size: 12px;
	    color: #000000;
	    display: block;
	    border: 1px solid #000000;
	    border-radius: 20px 20px 20px 20px;
	    margin-bottom: 5px;
	    margin-left: 15px;
	    margin-right: 15px;
	}
	
	.sidenav a:hover {
	    background-color: #ffff99;
	    text-decoration: none;
	}
	
	#main {
	    margin-left: 200px; //Same as the width of the sidenav
	    max-width: 1200px;
	    max-height: 800px;
	}
	
	table { width: 100% }
	
	table td, table th {
	  	color: #2b686e;
	  	padding: 10px;
	}
	
	table td {
	  	text-align: center;
	  	vertical-align: middle;
	}
		
	table th {
	  	font-weight: 300;
	  	text-align: center;
	}
	 */
	@media screen and (max-width: 700px) {
  		table, tr, td {
    		display: block;
  		}

  		td:first-child {
	    	border-bottom: 1px solid #91ced4;
	    	border-radius: 10px 10px 0 0;
	    	position: relative;
	    	top: 0;
	    	-webkit-transform: translateY(0);
	            	transform: translateY(0);
	    	width: 100%;
	  	}
  
  		td:not(:first-child) {
	    	margin: 0;
	    	padding: 5px 1em;
	    	width: 100%;
	  	}
	  	
	  	td:last-child { padding-bottom: 1rem !important; }		
  	
  		td:nth-child(2):before { content: '글번호:'; }
  		td:nth-child(3):before { content: '글제목:'; }
  		td:nth-child(4):before { content: '작성자:'; }
  		td:nth-child(5):before { content: '작성일:'; }
  		td:nth-child(6):before { content: '조회수:'; }
  		td:nth-child(7):before { content: '추천수:'; }
/* 
  		tr {
	    	border: 1px solid #6cbec6;
	    	border-radius: 10px;
	    	box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
	    	margin: 0.5rem 0;
	    	padding: 0;
	  	} */
	  	.left{
	  		text-align: left;
	  	}
	}
</style>
<script type="text/javascript">
	$(function(){
		$(".dropdown-menu li a").click(function(){
			$("#selectBtn:first-child").text($(this).text());
	   	});

		//column checkbox select all or cancel
		$("input.select-all").click(function() {
			var checked = this.checked;
			$("input.select-item").each(function(index, item) {
				item.checked = checked;
			});
		});
	
		//check selected items
		$("input.select-item").click(function() {
			var checked = this.checked;
			console.log(checked);
			checkSelected();
		});
	
		//check is all selected
		function checkSelected() {
			var all = $("input.select-all")[0];
			var total = $("input.select-item").length;
			var len = $("input.select-item:checked:checked").length;
			console.log("total:" + total);
			console.log("len:" + len);
			all.checked = len === total;
		}
	});
</script>

<!-- body -->


<div class="container" id="main" style="width:1150px;">
	<!-- 	<div class="row">
		<div class="col-xs-12 col-sm-9"> -->
	<!-- 상단 메뉴 -->
	<table width="100%" border="0">
		<tr>
			<td><h3>내가 쓴 댓글</h3></td>
			<td style="text-align: right; vertical-align: bottom; color: #777">
				<!-- 카테고리 -->
				<form class="form-inline" name="select-category"
					id="select-category" method="get" action="#">
					<div class="form-group" style="float: right; margin: 3px;">
						<select class="form-control">
							<option value="1" selected>전체</option>
							<option value="2">제목</option>
							<option value="3">내용</option>
							<option value="4">글번호</option>
						</select> <input type="text" class="form-control" name="search-text"
							id="search-text" size="8" placeholder=" ">&nbsp; ​​​​​​​
						<button type="button" class="btn" name="btn">
							검색&nbsp;<i class="fas fa-search"></i>
						</button>
					</div>
				</form>
			</td>
		</tr>
	</table>
<hr class="margin2">
	<!-- table -->
	<table class="table table-hover" id="table-css">
		<thead>
			<tr>
				<th><input type="checkbox" class="select-all checkbox"
					name="select-all" /></th>
					<th width="8%">글번호</th>
					<th width="8%">작성자</th>
					<th width="*">댓글내용</th>
					<th width="8%">작성일</th>
					<th width="30%">글제목</th>
				</tr>
    			<tbody>
	   				<tr>
						<td>
							<input type="checkbox" class="select-item checkbox" name="select-item" value="1000" />
						</td>
						<td>1</td>
						<td>user01</td>
						<td class="tbl-td-title">Contensssssssssssssss</td>
						<td>18-07-31</td>
						<td class="left">titleeeeeeeeeeeeeeeeeeeeeeee</td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" class="select-item checkbox" name="select-item" value="1001" />
						</td>
						<td>2</td>
						<td>user01</td>
						<td class="tbl-td-title">Contensssssssssssssss</td>
						<td>18-07-31</td>
						<td class="left">titleeeeeeeeeeeeeeeeeeeeeeee</td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" class="select-item checkbox" name="select-item" value="1001" />
						</td>
						<td>3</td>
						<td>user01</td>
						<td class="tbl-td-title">Contensssssssssssssss</td>
						<td>18-07-31</td>
						<td class="left">titleeeeeeeeeeeeeeeeeeeeeeee</td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" class="select-item checkbox" name="select-item" value="1001" />
						</td>
						<td>4</td>
						<td>user01</td>
						<td class="tbl-td-title">Contensssssssssssssss</td>
						<td>18-07-31</td>
						<td class="left">titleeeeeeeeeeeeeeeeeeeeeeee</td>
					</tr>
    			</tbody>
			</table>
<hr class="margin1" style="margin: 0px auto 5px auto;">

<table width="100%">
	<tr>
		<td width="10%"></td><!-- 빈칸 -->
		<td width="*"><!-- 페이지 -->
	<!-- Pagination -->
		<ul class="pagination" style="float: center; display: flex; justify-content: center;">
			<li>
				<a href="#" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
				<span class="sr-only">Previous</span>
				</a>
			</li>
			<li><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li>
				<a href="#" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
				<span class="sr-only">Next</span>
				</a>
			</li>
		</ul>	
	</td>
		<!-- 삭제버튼 -->
			<td width="10%" style="vertical-align: top;">
			<input type="button" class="btn btn-default pull-right" onClick="#" value="삭제" style="outline: none;"></td>
		</tr>
</table>
</div><!-- /container -->
<!-- 		</div>
		/.col-xs-12.col-sm-9
	</div>
	/row -->

<!-- ------------------------------------------------ -->
<%@include file="../../footer.jsp" %> 	
<%@include file="../../end.jsp" %> 
<!-- ------------------------------------------------ -->

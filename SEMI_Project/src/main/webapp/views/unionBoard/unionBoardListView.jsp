<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
#board-area tr:hover{
	cursor: pointer;
	background-color: gray;
}

#recommedClick:hover{
	cursor: pointer;
}
</style>

</head>
<body>
	<%@ include file="/views/common/menuBar.jsp"%>

	<div class="outer">
		<br> <br>
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item">
					<button type="button" onclick="goToUnion();" class="btn btn-dark">통합</button>
				</li>
				<li class="nav-item">
					<button type="button" onclick="goToFree();" class="btn btn-dark">자유</button>
				</li>
				<li class="nav-item">
					<button type="button" onclick="goToEat();" class="btn btn-dark">식단</button>
				</li>
				<li class="nav-item">
					<button type="button" onclick="goToChall();" class="btn btn-dark">챌린지</button>
				</li>
				<li class="nav-item">
					<button type="button" onclick="goToExp();" class="btn btn-dark">전문가</button>
				</li>
				<li class="nav-item">
					<button type="button" onclick="goToReq();" class="btn btn-dark">문의</button>
				</li>
			</ul>
			<form class="form-inline" action="/semi/searchKeyword.un?currentPage=1" method="post">
				<input class="form-control mr-sm-2" type="text" name="keyword" placeholder="Search">
				<button class="btn btn-success" type="submit">Search</button>
			</form>
			<div class="writeBtn-area" align="center">
				<input type="hidden" name=userNo value="${loginUser.userNo}">
				<button type="button" onclick="writeBoard();"
					class="btn btn-outline-secondary" style="margin-left:20px;">글작성</button>
			</div>
		</nav>

		<script>
			function writeBoard(){
				var userNo = $("input[name=userNo]").val();
				location.href="/semi/boardEnrollForm.un?userNo=" + userNo;
			};
		
			function goToUnion(){
				location.href="/semi/unionBoardListView.un?currentPage=1";
			};
			
			function goToFree(){
				location.href="/semi/categoeyListView.un?currentPage=1&type=free";
			};
			
			function goToEat(){
				location.href="/semi/categoeyListView.un?currentPage=1&type=eat";
			};
			
			function goToChall(){
				location.href="/semi/categoeyListView.un?currentPage=1&type=challange";
			};
			
			function goToExp(){
				location.href="/semi/categoeyListView.un?currentPage=1&type=expert";
			};
			
			function goToReq(){
				location.href="/semi/categoeyListView.un?currentPage=1&type=request";
			};
		</script>

		<div align="center">
			<table class="table table-dark table-striped">
				<thead>
					<tr>
						<th>No.</th>
						<th>카테고리</th>
						<th width="400px">제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th width="80px">조회수</th>
						<th width="80px">추천</th>
					</tr>
				</thead>
				<tbody id="board-area">
					<c:choose>
						<c:when test="${empty bList}">
							<tr align="center">
								<td colspan="7">게시물이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="b" items="${bList}">
								<tr>
									<td>${b.boardNo}</td>
									<td>${b.categoryName}</td>
									<td>${b.boardTitle}</td>
									<td>${b.boardWriter}</td>
									<td>${b.createDate}</td>
									<td>${b.count}</td>
									<td>${b.recommend}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div class="pageBtn-area" align="center">
			<c:forEach var="i" begin="${p.startPage}" end="${p.endPage}">
				<button type="button" class="btn btn-outline-secondary">${i}</button>
			</c:forEach>
		</div>
	</div>

	<script>
	
		$("#board-area").on("click","tr",function(){
			var boardNo = $(this).children().first().text();
			
			if(boardNo != '게시물이 없습니다.'){
				var userNo = $("input[name=userNo]").val();
				
				location.href="/semi/boardDetailView.un?boardNo=" + boardNo + "&userNo=" + userNo;
			}
		});
		
		$(".pageBtn-area button").click(function(){
			
			$.ajax({
				url : "/semi/paging.us",
				data : {
					type : "unionBoard",
					currentPage : $(this).text()
				},
				success : function(bList){
					
					$("#board-area tr").remove();
					
					for(var board of bList){
						
						var tr = $("<tr>");
						
						tr.append($("<td>").text(board.boardNo));
						tr.append($("<td>").text(board.categoryName));
						tr.append($("<td>").text(board.boardTitle));
						tr.append($("<td>").text(board.boardWriter));
						tr.append($("<td>").text(board.createDate));
						tr.append($("<td>").text(board.count));
						tr.append($("<td>").text(board.recommend));
						
						$("#board-area").append(tr);
					}
				},
				error : function(){
					alert("요청 오류");
				}
			});
		});
	</script>



	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
</body>
</html>
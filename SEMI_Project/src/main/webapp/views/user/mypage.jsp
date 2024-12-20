<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
#rList-tbody tr:hover {
	cursor: pointer;
	background-color: orange;
}

#iList-tbody tr:hover {
	cursor: pointer;
	background-color: orange;
}

#wList-tbody tr:hover {
	cursor: pointer;
	background-color: orange;
}
.fixed-td {
    word-wrap: break-word;  /* 긴 단어도 자동 줄바꿈 */
}
</style>
</head>
<body>
	<%@ include file="/views/common/menuBar.jsp"%>

	<div class="outer">

		<br> <br>
		<h3 align="center">User Information</h3>
		<br>

		<div class="userInfo-area">
			<table class="table table-dark table-striped">
				<thead>
					<tr align="center">
						<th width="200px">GRADE</th>
						<th>POINT</th>
						<th width="200px">LOGIN COUNT</th>
					</tr>
				</thead>
				<tbody>
					<tr align="center">
						<td>${user.gradeName}</td>
						<td>${user.point}</td>
						<c:choose>
							<c:when test="${loginCount != 0}">
								<td>${loginCount}</td>
							</c:when>
							<c:otherwise>
								<td>-</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</tbody>
			</table>
		</div>
		
		<br> <br>
		<h3 align="center">TODAY QUEST LIST</h3>
		<br>

		<div class="userInfo-area">
			<table class="table table-dark table-striped">
				<thead>
					<tr align="center">
						<th width="600px">퀘스트명</th>
						<th width="120px">목표횟수</th>
						<th width="200px">지급포인트</th>
						<th width="200px">보상받기</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
		</div>
		
		<script>
			
		</script>
		
		<br><br>
		<h3 align="center">댓글 확인</h3>
		<br>
		<div class="total-reply">
			<table class="table table-dark table-striped" style="table-layout: fixed;">
				<thead>
					<tr align="center">
						<th width="100px">작성자</th>
						<th width="120px">게시글번호</th>
						<th width="540px">내용</th>
						<th width="120px">날짜</th>
					    <th width="100px" >삭제</th> <!-- 삭제 버튼 열 추가 -->
					</tr>
				</thead>
				<tbody>
					<c:forEach var="r" items="${reList}">
						<tr>
							<td style="display: none;" align="center">${r.replyNo}</td>
							<td align="center">${r.nickname}</td>
							<td align="center">${r.refBno}</td>
							<td class="fixed-td">${r.replyContent}</td>
							<td>${r.replyDate}</td>
							<td><button type="button" onclick="deleteComment(this);" class="btn btn-outline-danger">삭제</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<script>
			function deleteComment(a){
				var replyNo = $(a).closest("tr").children().first().text();
				
				$.ajax({
					url : "/semi/deleteReply.un",
					data : {
						replyNo : replyNo
					},
					success : function(msg){
						if(msg == 'NNNNN'){
							console("처리 오류");
						}
						else{
							alert("삭제되었습니다.");
							window.location.reload();
						}
						replyUpdate();
					},
					error : function(){
						alert("요청 오류");
					}
				});
				
				
			}
			
		
		</script>
		<div class="rePageBtn-area" align="center">
			<c:forEach var="i" begin="${p3.startPage}" end="${p3.endPage}">
				<button type="button" class="btn btn-outline-secondary">${i}</button>
			</c:forEach>
		</div>
		
		<br> <br>
		<h3 align="center">My Item List</h3>
		<br>

		<div class="itemList-area">
			<table class="table table-dark table-striped">
				<thead>
					<tr align="center">
						<th>ITEM CODE</th>
						<th>ITEM NAME</th>
						<th>COUNT</th>
					</tr>
				</thead>
				<tbody id="iList-tbody">
					<c:choose>
						<c:when test="${empty iList}">
							<tr align="center">
								<td>-</td>
								<td>구매하신 아이템이 없습니다.</td>
								<td>0</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="m" items="${iList}">
								<tr align="center">
									<td>${m.proNo}</td>
									<td>${m.proName}</td>
									<td>${m.proCount}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<script>
			$("#iList-tbody").on("click","tr",function(){
				
				if(${not empty iList}){
					if(confirm("아이템을 사용하시겠습니까?")){
						$.ajax({
							url : "/semi/deleteItem.us",
							data : {
								proNo : $(this).children().first().text(),
								userNo : ${user.userNo}
							},
							success : function(alertMsg){
								alert(alertMsg);	
								window.location.reload();
							},
							error : function(){
								alert("요청 오류");	
							}
						});
					}
				}
				else{
					if(confirm("상점페이지로 이동하시겠습니까?")){
						location.href="/semi/list.sh?currentPage=1";
					}
				}
			});
		</script>

		<br> <br>
		<h3 align="center">My Workout List</h3>
		<br>

		<!-- 운동 내용 모달창 -->
		<div class="modal" id="workoutContentModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- 운동 내용 머리글 -->
					<div class="modal-header">
						<h4 class="modal-title">운동기록</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- 운동 내용 본문 -->
					<div class="modal-body" align="center">
						<table>
							<tr>
								<th id="workoutTitle"></th>
								<th id="workoutDate"></th>
							</tr>
							<tr>
								<th id="workoutContent"></th>
							</tr>
							<tr style="display:none;">
								<th id="workoutNo"></th>
							</tr>
						</table>
					</div>

					<!-- 운동기록 삭제 버튼 구역 -->
					<div id="workoutListDelete-footer" class="modal-footer">
						<button type="button" onclick="deleteWorkout();"
							class="btn btn-danger">삭제</button>
					</div>

				</div>
			</div>
		</div>

		<script>
			function deleteWorkout(){
				
				if(confirm("정말 삭제하시겠습니다. 삭제 후 복구가 불가능합니다.")){
					
					$.ajax({
						url : "/semi/deleteWorkout.us",
						method : "post",
						data : {
							workoutNo : $("#workoutNo").text(),
							userNo : "${user.userNo}"
						},
						success : function(alertMsg){
							alert(alertMsg);
							workoutListGet();
						},
						error : function(){
							alert("요청 오류");
						}
					});
				}
			};
			
			function workoutListGet(){
				
				$("<form>", {
					method : "post",
					action : "/semi/mypage.us"
				}).appendTo($("body")).submit();
			};
		</script>

		<div class="wList-area" width="500px">
			<table class="table table-dark table-striped">
				<thead>
					<tr align="center">
						<th width="800px">TITLE</th>
						<th width="120px">DATE</th>
						<th width="120px">
							<button type="button" onclick="workoutEnrollBtn();"
								class="btn btn-outline-secondary btn-sm" style="margin-left:20px;">글작성</button>
						</th>
					</tr>
				</thead>
				<tbody id="wList-tbody">
					<c:choose>
						<c:when test="${empty wList}">
							<tr align="center">
								<td>기록된 운동을 찾을 수 없습니다.</td>
								<td colspan="2">-</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="i" items="${wList}">
								<tr align="center">
									<td style="display: none;">${i.workoutContent}</td>
									<td style="display: none;">${i.workoutNo}</td>
									<td>${i.workoutTitle}</td>
									<td colspan="2">${i.workoutDate}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<div class="woPageBtn-area" align="center">
			<c:forEach var="i" begin="${p1.startPage}" end="${p1.endPage}">
				<button type="button" class="btn btn-outline-secondary">${i}</button>
			</c:forEach>
		</div>

		<br> <br>
		<h3 align="center">My Request List</h3>
		<br>

		<!-- 문의글 작성 모달창 -->
		<div class="modal" id="requestModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- 문의 머리글 -->
					<div class="modal-header">
						<h4 class="modal-title">관리자에게 문의하기</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- 문의 본문 -->
					<div class="modal-body" align="center">
						<table>
							<tr>
								<th><label for="requestTitle">제목</label></th>
							</tr>
							<tr>
								<td><textarea cols="50" name="requestTitle"
										id="requestTitle" style="resize: none;" required></textarea></td>
							</tr>
							<tr>
								<th><label for="requestContent">내용</label></th>
							</tr>
							<tr>
								<td><textarea cols="50" rows="10" name="requestContent"
										id="requestContent" style="resize: none;" required></textarea></td>
							</tr>
						</table>
					</div>

					<!-- 문의 버튼구역 -->
					<div id="request-footer" class="modal-footer">
						<button type="button" class="btn btn-danger">Request</button>
					</div>

				</div>
			</div>
		</div>

		<!-- 문의글 보여줄 모달창 -->
		<div class="modal" id="outputRModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- 문의 머리글 -->
					<div class="modal-header">
						<h4 class="modal-title">문의사항</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- 문의 본문 -->
					<div class="modal-body" align="center">
						<table border="1">
							<tr>
								<th width="150px">번호 :</th>
								<td id="outputRno"></td>
							</tr>
							<tr>
								<th width="150px">제목 :</th>
								<td id="outputRtitle"></td>
							</tr>
							<tr>
								<th>작성자 :</th>
								<td id="outputRwriter"></td>
							</tr>
							<tr>
								<th>작성일 :</th>
								<td id="outputRdate"></td>
							</tr>
							<tr>
								<th>내용 :</th>
								<td id="outputRcontent"></td>
							</tr>
							<tr>
								<th>관리자 확인 :</th>
								<td id="outputRcheck"></td>
							</tr>
						</table>

						<br>

						<div class="adminReply-area">
							<table border="1">
								<tr>
									<th width="150px">작성자 :</th>
									<td id="adminReplyWriter">-</td>
								</tr>
								<tr>
									<th width="150px">작성일 :</th>
									<td id="adminReplyDate">-</td>
								</tr>
								<tr>
									<th width="150px">내용 :</th>
									<td id="adminReplyContent">아직 답변이 없습니다.</td>
								</tr>
							</table>
						</div>
					</div>

					<div id="requestDelete-footer" class="modal-footer">
						<button type="button" onclick="deleteRequest();"
							class="btn btn-danger">요청 취소</button>
					</div>
				</div>
			</div>
		</div>

		<script>
			function deleteRequest(){
				var requestNo = $("#outputRno").text();
				
				if(confirm("요청을 취소하시겠습니까?")){
					$.ajax({
						url : "/semi/deleteRequest.rq",
						data : {
							requestNo : requestNo,
							userNo : "${user.userNo}"
						},
						success : function(alertMsg){
							alert(alertMsg);
							window.location.reload();
							
						},
						error : function(){
							console.log("요청 오류")
						}
					});
				}
			};
		</script>

		<div class="rList-area" width="500px">

			<div class="requset-write_btn" align="center">
				<button type="button" class="btn btn-outline-danger"
					data-toggle="modal" data-target="#requestModal">문의</button>
			</div>
			<br>

			<table class="table table-dark table-striped">
				<thead>
					<tr align="center">
						<th width="100px">NO.</th>
						<th width="600px">TITLE</th>
						<th>DATE</th>
						<th>CHECK_STATUS</th>
					</tr>
				</thead>
				<tbody id="rList-tbody">
					<c:choose>
						<c:when test="${empty rList}">
							<tr>
								<td>-</td>
								<td>작성된 문의글이 없습니다</td>
								<td>-</td>
								<td>none</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="i" items="${rList}">
								<tr align="center">
									<td>${i.requestNo}</td>
									<td>${i.requestTitle}</td>
									<td>${i.requestDate}</td>
									<td><c:choose>
											<c:when test="${i.checkStatus == 'Y'}">
												<input type="checkbox" checked disabled>
											</c:when>
											<c:otherwise>
												<input type="checkbox" disabled>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>

			<div class="rqPageBtn-area" align="center">
				<c:forEach var="i" begin="${p2.startPage}" end="${p2.endPage}">
					<button type="button" class="btn btn-outline-secondary">${i}</button>
				</c:forEach>
			</div>
		</div>
		
		<!-- 티어이미지 설정창 -->
		<div class="modal" id="tierModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<form action="" >
						<!-- 티어이미지 설정창 헤더 -->
						<div class="modal-header">
							<h4 class="modal-title">USER TIER IMG MANAGEMENT</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- 티어 이미지 설정 바디 -->
						<div class="modal-body" align="center">
							<table border="1">
								<thead>
									<tr align="center">
										<th width="120px">티어명</th>
										<th width="200px">티어 이미지</th>
									</tr>
								</thead>
								<tbody id="tierImg-area">
									<c:forEach var="tierImg" items="${tList}">
										<tr align="center">
											<td>${tierImg.gradeName}</td>
											<td>
												<img src="/semi${tierImg.tierPath}${tierImg.tierOriginFileName}" width="100px" height="100px">
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<!-- 티어 이미지 설정 버튼 구역 -->
						<div class="modal-footer">
							
						</div>
					</form>
				</div>
			</div>
		</div>

		<br> <br> <br>
		<div class="updateUser-area" align="center">
			<button type="button" data-toggle="modal" data-target="#tierModal"
				class="btn btn-outline-warning">회원 티어 정보</button>
			<button type="button" onclick="updateUserInfo();"
				class="btn btn-outline-warning">회원정보 변경</button>
			<button type="button"
				class="btn btn-outline-warning" data-toggle="modal" data-target="#pwdModal">비밀번호 변경</button>
		</div>

		<!-- 비밀번호 변경 모달창 -->
		<div class="modal" id="pwdModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- 비밀번호 변경 머리글 -->
					<div class="modal-header">
						<h4 class="modal-title">비밀번호 변경</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- 비밀번호 변경 본문 -->
					<form action="/semi/updatePwd.us" method="post">
						<input type="hidden" name="userId" value="${user.userId}">
						<div class="modal-body" align="center">
							<table>
								<tr>
									<th><label for="requestTitle">기존 비밀변호</label></th>
								</tr>
								<tr>
									<td><input type="password" name="userPwd" id="userPwd" required></td>
								</tr>
								<tr>
									<th><label for="requestTitle">비밀변호 변경</label></th>
								</tr>
								<tr>
									<td><input type="password" name="newPwd" id="newPwd" required></td>
								</tr>
								<tr>
									<th><label for="requestContent">비밀번호 확인</label></th>
								</tr>
								<tr>
									<td><input type="password" name="checkPwd" id="checkPwd" required></td>
								</tr>
								<tr>
									<td style="font-size:10px;"><br>4~15자까지 가능(첫글자 특수기호 가능)</td>
								</tr>
								<tr id="checkText-area">
								
								</tr>
							</table>
						</div>

						<!-- 비밀번호 변경 버튼구역 -->
						<div id="pwd-footer" class="modal-footer">
							<button type="submit" onclick="return checkchangePwd();" class="btn btn-danger">변경</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		
		<script>
			function checkchangePwd(){
				var userPwd = $("#userPwd").val();
				var newPwd = $("#newPwd").val();
				var checkPwd = $("#checkPwd").val();
				
				var pwRegExp = /^[0-9a-zA-Z!@#$%^&*]{4,15}$/;
				
				if(userPwd != null && newPwd != null && checkPwd != null){
					if(newPwd == checkPwd){
						if(pwRegExp.test(newPwd)){
							return true;
						}
						else{
							$("#checkText-area").append($("<td style='font-size:10px;'>").text("비밀번호 형식에 맞게 입력해주세요."));
							$("#newPwd").val("");
							$("#checkPwd").val("");
							return false;
						}
					}
					else{
						$("#checkText-area").append($("<td>").text("비밀번호가 일치하지 않습니다."));
						$("#checkPwd").val("");
						return false;
					}
				}
				else{
					alert("빈칸을 모두 입력해주세요.");
				}
			};
		</script>

		<br> <br>
		<div class="deleteUser-area" align="center">
			<button type="button" onclick="deleteUser();" class="btn btn-outline-danger">회원 탈퇴</button>
		</div>
	</div>

	<script>
		function deleteUser(){
			
			if(confirm("정말 삭제하시겠습니까?")){
				if(prompt("'회원삭제'를 입력해주세요.") == "회원삭제"){
					
					$("<form>", {method:"post",action:"/semi/deleteUser.us"
					}).append($("<input>", {type:"hidden",name:"userId",value:"${user.userId}"
						})).appendTo($("body")).submit();
				}
			}
		};
	
		function updateUserInfo(){
			
			location.href="/semi/updateUserInfoPage.us?userId=${user.userId}"; // 로그인 기능 구현 후 변경
		};
	
		$("#wList-tbody").on("click","tr", function(){
			
			if(${not empty wList}){
				var workoutContent = $(this).children().first().text();
				var workoutNo = $(this).children().eq(1).text();
				var workoutTitle = $(this).children().eq(2).text();
				var workoutDate = $(this).children().eq(3).text();
				
				$("#workoutNo").text(workoutNo);
				$("#workoutContent").html(workoutContent.replace(/\n/g, "<br>"));
				$("#workoutTitle").text(workoutTitle);
				$("#workoutDate").text(workoutDate);
				
				$("#workoutContentModal").modal("show");
			}
			else{
				if(confirm("운동을 기록하시겠습니까?")){
					var userNo = "${user.userNo}"
					location.href="/semi/workoutEnrollForm.un?userNo=" + userNo;
				}
			}
		});
		
		function workoutEnrollBtn(){
			var userNo = "${user.userNo}"
			location.href="/semi/workoutEnrollForm.un?userNo=" + userNo;
		}
	
		$("#rList-tbody").on("click", "tr", function() {
			var requestNo = $(this).children().first().text();
			
			if(${not empty rList}){
				$.ajax({
					url : "/semi/requestList.rq",
					method : "post",
					data : {
						requestNo : requestNo,
						userNo : "${user.userNo}"
					},
					success : function(map){
						
						for(var key in map){
							
							var req = map[key];
							
							if(req.requestNo != null){
								$("#outputRno").text(req.requestNo);
								$("#outputRtitle").text(req.requestTitle);
								$("#outputRwriter").text(req.requestWriter);
								$("#outputRdate").text(req.requestDate);
								$("#outputRcontent").text(req.requestContent);
								
								$("#outputRcheck input").remove();
								
								if(req.checkStatus == 'Y'){
									$("#outputRcheck").append($("<input type='checkBox' checked disabled>"));
								}
								else{
									$("#outputRcheck").append($("<input type='checkBox' disabled>"));
								}
							}
							
							if(req.answerWriter != null){
								$("#adminReplyWriter").text(req.answerWriter);
								$("#adminReplyDate").text(req.answerDate);
								$("#adminReplyContent").text(req.answerContent);
							}
						}
						
						$("#outputRModal").modal("show");
						
					},
					error : function(){
						alert("요청 오류");
					}
				});
			}
		});
	
		$("#request-footer>button").click(function(){
			
			$.ajax({
				url : "/semi/insertRequest.rq",
				method : "post",
				data : {
					userNo : "${user.userNo}",
					requestTitle : $("#requestTitle").val(),
					requestContent : $("#requestContent").val()
				},
				success : function(alertMsg){
					alert(alertMsg);
					window.location.reload();
				},
				error : function(){
					alert("요청 오류");
				}
			});
		});
	
		$(".woPageBtn-area button").click(function(){
			$.ajax({
				url : "/semi/paging.us",
				data : {
					type : "workout",
					userNo : "${user.userNo}",
					currentPage : $(this).text()
				},
				success : function(wList){
					
					$("#wList-tbody tr").remove();
					
					for(var wo of wList){
						
						var tr = $("<tr align='center'>");
						tr.append($("<td>").text(wo.workoutTitle));
						tr.append($("<td>").text(wo.workoutDate));
						$(".wList-area tbody").append(tr);
					}
					
				},
				error : function(){
					console.log("N")
				}
			});
		});
		
		$(".rqPageBtn-area button").click(function(){
			$.ajax({
				url : "/semi/paging.us",
				data : {
					type : "request",
					userNo : "${user.userNo}",
					currentPage : $(this).text()
				},
				success : function(rList){
					
					$("#rList-tbody tr").remove();
					
					for(var r of rList){
						
						var tr = $("<tr align='center'>");
						tr.append($("<td>").text(r.requestNo));
						tr.append($("<td>").text(r.requestTitle));
						tr.append($("<td>").text(r.requestDate));
						
						var td;
						if(r.checkStatus == 'Y'){
							td = $("<td>").append($("<input type='checkBox' checked disabled>"));
						}
						else{
							td = $("<td>").append($("<input type='checkBox' disabled>"));
						}
						
						tr.append(td);
						$("#rList-tbody").append(tr);
					}
					
				},
				error : function(){
					console.log("N")
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
	<br>
</body>
</html>
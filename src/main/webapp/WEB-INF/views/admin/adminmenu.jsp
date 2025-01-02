<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" href="${path }/resources/images/favicon.jpeg">
	<title>티꿀모아</title>
	
    <!-- 2. 외부 CSS 파일들 -->
    <!-- 2-1. Bootstrap CSS (다른 CSS보다 먼저) -->
    <!-- 2-2. Bootstrap Icons (필요한 경우) -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- 2-3. 직접 제작한 CSS 파일들 (Bootstrap CSS 보다 아래 위치시켜야 함) -->
	<link rel="stylesheet" href="${path }/resources/css/common/layout.css">
	<link rel="stylesheet" href="${path }/resources/css/common/header.css">
	<link rel="stylesheet" href="${path }/resources/css/common/sidebar.css">
	<link rel="stylesheet" href="${path }/resources/css/common/footer.css">
    <!-- 3. 컴포넌트 CSS (각 요소) -->
    <!-- 4. 페이지별 CSS -->
    <link rel="stylesheet" href="${path}/resources/css/board/boardList.css">
    <link rel="stylesheet" href="${path}/resources/css/admin/manageMember.css">
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
    <!-- 7. 내부 style 태그 -->
    <style>
	.mypage-card-container{
		margin-top: 40px;
		gap: 20px;
	}
	.mypage-card {
		width : 90%;
		height : 400px;
		padding : 20px;
		box-shadow: 0 0 5px rgba(0,0,0,0.3);
		border-radius: 15px;
		display : flex;
		flex-direction: column;
		align-items : center;
	}
	.mypage-card {
		width : 90%;
		height : 400px;
		padding : 20px;
		box-shadow: 0 0 5px rgba(0,0,0,0.3);
		border-radius: 15px;
		display : flex;
		flex-direction: column;
		align-items : center;
	}
	.mypage-card:hover {
   		transform: scale(1.015);
   		cursor: pointer;
   	}
    </style>
    
    <!-- 공지사항 게시판 관련 css -->
	<style>
	.admin-table {
		width: 100%;
		border-collapse: collapse;
		margin-top: 20px;
	}
	
	.admin-table th, .admin-table td {
		padding: 12px;
		border-bottom: 1px solid #ddd;
		text-align: center;
	}
	
	.admin-table th {
		background-color: #fff6c2;
		font-weight: bold;
		border-top: 1px solid #ddd;
	}
	
	.admin-table tr:hover {
		background-color: #f5f5f5;
	}
	
	.fix-toggle {
		padding: 5px 10px;
		border-radius: 4px;
		cursor: pointer;
		border: 1px solid #ddd;
	}
	
	.fix-toggle.fixed {
		background-color: #4CAF50;
		color: white;
		border: none;
	}
	
	.fix-toggle:not(.fixed) {
		background-color: #f1f1f1;
	}
	
	/* 관리 버튼 스타일 */
	.admin-table button {
		margin: 0 2px;
		padding: 5px 10px;
		border: 1px solid #ddd;
		border-radius: 4px;
		background: white;
		cursor: pointer;
	}
	
	.admin-table button:hover {
		background: #f0f0f0;
	}
</style>
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 헤더 include -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<!-- 메인 콘텐츠 -->
<main class="main">
	<div class="main-container">
		<!-- sidebar include -->
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
        
		<!-- 콘텐츠 영역 -->
		<div class="main-content">
			<section class="main-section">
				<div>
					<div>
						<h2>관리자 페이지</h2>
						<hr style="border:2px solid #fff6c2;">
						<p>회원님의 개인정보 수정 및 나의 글에 대해 설정하실 수 있습니다:)</p>
					</div>
					<div class="row mypage-card-container">
						<div class="mypage-card">
							<h3>내 정보</h3>
							<div><i class="bi bi-person-vcard" style="font-size: 10rem; color: #ffcc00;"></i></div>
							<div>
								<p>개인정보를 수정할 수 있는<p>
								<p>내 정보 페이지로 이동합니다.</p>
							</div>
							<div>
								<p style="margin-top:0px;border-bottom: 1px solid black;">내 정보 확인하기</p>
							</div>
						</div>
						<div class="mypage-card">
							<h3>전체 글 관리</h3>
							<div><i class="bi bi-layout-text-window-reverse" style="font-size: 10rem; color: #ffcc00;"></i></div>
							<div>
								<p>회원들이 작성한 글을 관리하는</p>
								<p>글 관리 페이지로 이동합니다.</p>
							</div>
							<div>
								<p style="margin-top:0px;border-bottom: 1px solid black;">전체 글 확인하기</p>
							</div>
						</div>	
						<div class="mypage-card">
							<h3>결제 정보 관리</h3>
							<div><i class="bi bi-credit-card" style="font-size: 10rem; color: #ffcc00;"></i></div>
							<div>
								<p>결제 정보를 확인하고 관리하는</p>
								<p>결제 정보 페이지로 이동합니다.</p>
							</div>
							<div>
								<p style="margin-top:0px;border-bottom: 1px solid black;">결제 정보 확인하기</p>
							</div>
						</div>
						<div class="mypage-card">
							<h3>회원 관리</h3>
							<div><i class="bi bi-person-fill-gear" style="font-size: 10rem; color: #ffcc00;"></i></div>
							<div>
								<p>신고 처리 등 회원을 관리하는</p>
								<p>회원관리 페이지로 이동합니다.</p>
							</div>
							<div>
								<p style="margin-top:0px;border-bottom: 1px solid black;">회원 목록 확인가기</p>
							</div>
						</div>
					</div>
				</div>
			</section>
			<section>
				<div>
					<div>
						<div style="display:flex; justify-content: space-between; align-items: center; width: 100%;">
						<h2>공지사항 관리</h2>
						<p id="writePostNotify" style="cursor:pointer;">+ 글쓰기</p>
						</div>
						<hr style="border:2px solid #fff6c2;">
						<p>공지사항을 작성하거나 관리할 수 있습니다.</p>
					</div>
					<div class="row mypage-card-container">
					</div>
				</div>
				<!-- 공지사항 목록 테이블 -->
				<table id="tbl-board" class="admin-table">
					<colgroup>
						<col style="width: 60px;">  <!-- 번호 -->
						<col style="width: 400px;"> <!-- 제목 -->
						<col style="width: 100px;"> <!-- 작성자 -->
						<col style="width: 120px;"> <!-- 작성일 -->
						<col style="width: 80px;">  <!-- 조회수 -->
						<col style="width: 100px;"> <!-- 상단고정 -->
						<col style="width: 120px;"> <!-- 관리 -->
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
							<th>상단고정</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty posts}">
							<tr>
								<td colspan="7" style="text-align: center;">등록된 공지사항이
									없습니다.</td>
							</tr>
						</c:if>
						<c:forEach var="post" items="${posts}">
							<tr>
								<td>${post.post_no}</td>
								<td style="text-align: left; padding-left: 20px;">${post.post_title}</td>
								<td>${post.member_id}</td>
								<td><fmt:formatDate value="${post.reg_date}"
										pattern="yyyy-MM-dd" /></td>
								<td>${post.view_count}</td>
								<td>
									<button type="button"
										class="fix-toggle ${post.is_fix ? 'fixed' : ''}"
										onclick="toggleFix(${post.post_no}, this)">
										${post.is_fix ? '고정' : '일반'}</button>
								</td>
								<td>
									<button type="button" onclick="editNotice(${post.post_no})">수정</button>
									<button type="button" onclick="deleteNotice(${post.post_no})">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
		        <div id="pageBar">
		        	${pageBar }
		        </div>
			</section>
		</div>
	</div>
</main>

<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<!-- wrap 태그 종료 -->
</div>

<!-- 8. 공통 JavaScript -->
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
<script>
	//내 정보 카드
	$(".mypage-card-container .mypage-card:nth-child(1)").click(function() {
		location.assign("${path}/member/myinfo/detail");
	});

	// 전체 글 관리 카드
	$(".mypage-card-container .mypage-card:nth-child(2)").click(function() {
		location.assign("${path}/admin/manage/post");
	});

	// 결제 정보 관리 카드
	$(".mypage-card-container .mypage-card:nth-child(3)").click(function() {
		location.assign("${path}/admin/manage/payment");
	});

	// 회원 관리 카드
	$(".mypage-card-container .mypage-card:nth-child(4)").click(function() {
		location.assign("${path}/admin/manage/member");
	});
	
	// 공지사항 작성
	$("#writePostNotify").click(function() {
		location.assign("${path}/admin/notify/write");
	});
</script>


<!-- 상단고정 토글을 위한 JavaScript -->
<script>
	function toggleFix(postNo, btn) {
		// AJAX 요청으로 상단고정 상태 토글
		$.ajax({
			url : 'toggleNoticeFix.do',
			type : 'POST',
			data : {
	            postNo: postNo
			},
			success : function(response) {
				if (response.success) {
					// 버튼 상태 및 텍스트 업데이트
					$(btn).toggleClass('fixed');
					$(btn).text($(btn).hasClass('fixed') ? '고정' : '일반');
				} else {
					alert('상태 변경에 실패했습니다.');
				}
			},
			error : function() {
				alert('서버와의 통신 중 오류가 발생했습니다.');
			}
		});
	}

	// 공지사항 수정 함수
	function editNotice(postNo) {
		location.href = 'editNotice.do?post_no=' + postNo;
	}

	// 공지사항 삭제 함수
	function deleteNotice(postNo) {
		if (confirm('정말 삭제하시겠습니까?')) {
			location.href = 'deleteNotice.do?post_no=' + postNo;
		}
	}
</script>
</body>
</html>
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
						<p>회원님의 개인정보 수정 및 나의 글에 대해 설정하실 수 있습니다:)</p>
					</div>
					<div class="row mypage-card-container">
						<div class="mypage-card">
							<h3>개인정보</h3>
							<div><i class="bi bi-person-vcard" style="font-size: 10rem; color: #ffcc00;"></i></div>
							<div>
								<p>개인정보를 수정할 수 있는<p>
								<p>내정보 페이지로 이동합니다.</p>
							</div>
							<div>
								<a href="${path}/admin/myinfo">개인정보 보러가기</a>
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
								<a href="${path}/admin/managePost">전체 글 보러가기</a>
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
								<a href="${path}/admin/managePayment">결제 정보 보러가기</a>
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
								<a href="${path}/admin/manageMember">회원 목록 보러가기</a>
							</div>
						</div>
					</div>
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
</body>
</html>
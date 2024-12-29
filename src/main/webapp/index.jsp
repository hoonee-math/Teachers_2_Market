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
    <!-- 2-3. 직접 제작한 CSS 파일들 (Bootstrap CSS 보다 아래 위치시켜야 함) -->
	<link rel="stylesheet" href="${path }/resources/css/common/layout.css">
	<link rel="stylesheet" href="${path }/resources/css/common/header.css">
	<link rel="stylesheet" href="${path }/resources/css/common/sidebar.css">
	<link rel="stylesheet" href="${path }/resources/css/common/footer.css">
    <!-- 3. 컴포넌트 CSS (각 요소) -->
	<link rel="stylesheet" href="${path }/resources/css/component/card.css">
    <!-- 4. 페이지별 CSS -->
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 7. 내부 style 태그 -->
    <style>
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
			<!-- 섹션 1 : 배너 -->
			<section class="row main-section">
				<div class="main-banner" >
					<img
						src="${path }/resources/images/banner.png"
						alt="검색" width="100%">
				</div>
			</section>
			<!-- 나중에 ajax 통신할 때는 append 이용해서 진행해야함 -->
			<c:forEach var="i" begin="1" end="2">
			<%-- <c:forEach var="item" items="${post }" varStatus="status"> --%>
			<section class="row card-section">
				<c:forEach var="j" begin="1" end="4">
				<div class="card-container">
					<!-- 백엔드 작업할 때 사용하기 위한 부분은 주석처리해 둠 -->
					<div class="card-img">
						<img src="${path }/resources/images/logo.jpeg">
						<!-- <img width="150px" height="150px" src="${path }/resources/images/${item.image.renamed}"> -->
					</div>
					<div class="card-content">
						<p>판매자명</p>
						<!-- <p>${item.member.memberName}</p> -->
							<!-- 판매물품 제목은 10글자까지, 
								프론트 구현할 때 c:if 사용해서 10글자가 넘는 경우 9 글자까지 출력하고 뒤에 ...붙이기 
								ex) 하나둘셋넷다섯여섯...-->
						<p><strong>판매물품 제목</strong></p>
						<!-- <p><strong>${item.postTitle}</strong></p> -->
						<p>₩ 판매금액</p>
						<!-- <p>₩ ${item.price}</p> -->
					</div>
				</div>
				</c:forEach>
			</section>
			</c:forEach>
			<!-- 섹션 4 -->
			<section class="row main-section">
				<!-- 로그인 페이지로 이동 -->
				<a href="${path}/member/login">로그인 페이지로 이동</a>
				<a href="${path}/member/logincheck">약관동의 페이지로 이동</a>
				<a href="${path}/member/enroll">회원가입 정보 입력 페이지로 이동</a>
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
	$('.card-container').click(function() {
		location.assign("${path}/post/viewpost");
	});
</script>
</body>
</html>
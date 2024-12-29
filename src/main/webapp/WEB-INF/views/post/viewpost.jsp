<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String currentDate = sdf.format(new java.util.Date());
    request.setAttribute("currentDate", currentDate);
%>
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
    <!-- 4. 페이지별 CSS -->
	<link rel="stylesheet" href="${path }/resources/css/post/viewpost.css">
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
    <!-- 7. 내부 style 태그 -->
    <style>
    	*{border:1px solid pink}
    	p{margin:0px;}
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
		<div id="view-main-content" class="main-content" >
			<section class="row post-main-section">
				<!-- 섹션 1 -->
				<div id="post-img-div">
					<div id="post-img-bigSize">big</div>
					<div id="post-img-minislide">mini</div>
					<div id="post-mini-dashboard" style="display:flex;">
						<div></div>
					</div>
				</div>
				<div>
					<div id="post-seller-nick">
						<c:set var="memberNick" value="sellerNick"/>
						${memberNick }
					</div>
					<div id="post-title">
						<c:set var="postTitle" value="postTitle"/>
						${postTitle }			
					</div>
					<div id="post-item-price">
						<c:set var="stockCount" value="1"/> <!-- 재고가 0이 되면 판매 종료로 바뀜 -->
						<%-- <c:set var="salePeriod" value="${'2025-01-25'}" /> --%> <!-- 판매기간이 지나면 판매 종료로 바귐 -->
						<c:choose>
							<c:when test="${stockCount > 0 || salePeriod >= currentDate}"> <!-- 판매 종료로 바뀌는 조건문, *** 서버에서 두 값은 초기화 후에 저장시켜야함. -->
								<c:set var="isFree" value="0"/>
								<c:if test="${isFree eq 0 }">
									<c:set var="productPrice" value="30000"/>
									<p><fmt:formatNumber value="${productPrice }" pattern="###,###,###"/>
									원</p>
								</c:if>
								<c:if test="${isFree eq 1 }">
									<p>무료나눔</p>
								</c:if>
							</c:when>
							<c:otherwise>
								<p>판매종료</p>
							</c:otherwise>
						</c:choose>
					</div>
					<c:set var="type" value="postTitle"/>
					<c:if test=""></c:if>
				</div>
			</section>
			<section class="row post-info-section">
				<!-- 섹션 2 -->
			</section>
			<section class="row post-board-section">
				<!-- 섹션 3 -->
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
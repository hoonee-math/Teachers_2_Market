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
    <link rel="stylesheet" href="${path }/resources/css/board/boardList.css">
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
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
			<section class="row main-section">
				<!-- 섹션 1 -->
				<div id="notice-div">
					<p><strong>[공지] 이것은 공지사항입니다.</strong></p>
					<p><strong>[공지] 이것은 두번째 공지사항입니다.</strong></p>
				</div>
			</section>
			<section class="row card-section">
				<!-- 나중에 ajax 통신할 때는 append 이용해서 진행해야함 -->
				<c:forEach var="i" begin="1" end="4">
				<%-- <c:forEach var="item" items="${post }" varStatus="status"> --%>
					<div class="card-container">
						<!-- 백엔드 작업할 때 사용하기 위한 부분은 주석처리해 둠 -->
						<div class="card-img">
							<img src="${path }/resources/common/images/logo.jpeg">
							<%-- <img width="150px" height="150px" src="${path }/resources/board/images/${item.image2.renamed}"> --%>
						</div>
						<div class="card-content">
							<p>판매자명</p>
							<%-- <p>${item.member2.memberName}</p> --%>
								<!-- 판매물품 제목은 10글자까지, 
									프론트 구현할 때 c:if 사용해서 10글자가 넘는 경우 9 글자까지 출력하고 뒤에 ...붙이기 
									ex) 하나둘셋넷다섯여섯...-->
							<p><strong>판매물품 제목</strong></p>
							<%-- <p><strong>${item.postTitle}</strong></p> --%>
							<p>₩ 판매금액</p>
<%-- 							<!-- 상품 타입이 물품인 경우 -->
							<c:if test="${item.productType==1 }">
								<!-- stockCount 변수에 재고 넣음 -->
								<c:set var="stockCount" value="${item.product2.stockCount }"/>
								<c:choose>
									<c:when test="${stockcount>0 }">
										<!-- isFree 변수에 무료나눔 여부 -->
										<c:set var="isFree" value="${item.product2.isFree }"/>
										<!-- 무료나눔이 아닌 경우 -->
										<c:if test="${isFree eq 0 }">
											<p>₩ <fmt:formatNumber value=${item.product2.productPrice } pattern="###,###,###"/></p>
										</c:if>
										<!-- 무료나눔인 경우 -->
										<c:if test="${isFree eq 1 }">
											<p style="color:#2ecc71; font-weight:bold;">무료나눔</p>
										</c:if>
									</c:when>
									<!-- 재고가 0인 경우 -->
									<c:otherwise>
										<p style="color:#e74c3c; font-weight:bold;">판매종료</p>
									</c:otherwise>
								</c:choose>
							</c:if>
							<!-- 상품 타입이 파일인 경우 -->
							<c:if test="${item.productType==2 }">
								<!-- salePeriod 변수에 판매기간 넣음 -->
								<c:set var="salePeriod" value="${item.file2.salePeriod }"/>
								<c:choose>
									<!-- servlet에서 today를 넘겨받음 -->
									<c:when test="${salePeriod>=today }">
										<!-- isFree 변수에 무료나눔 여부 -->
										<c:set var="isFree" value="${item.file2.isFree }"/>
										<!-- 무료나눔이 아닌 경우 -->
										<c:if test="${isFree eq 0 }">
											<p>₩ <fmt:formatNumber value=${item.file2.filePrice } pattern="###,###,###"/></p>
										</c:if>
										<!-- 무료나눔인 경우 -->
										<c:if test="${isFree eq 1 }">
											<p style="color:#2ecc71; font-weight:bold;">무료나눔</p>
										</c:if>
									</c:when>
									<!-- 판매기간이 오늘보다 작은 수인 경우 -->
									<c:otherwise>
										<p style="color:#e74c3c; font-weight:bold;">판매종료</p>
									</c:otherwise>
								</c:choose>
							</c:if> --%>
						</div>
					</div>
				</c:forEach>
			</section>
			<section class="row main-section">
				<!-- 섹션 2 -->
				<ul class="pagination">
					<li class="page-item">
						<a class="page-link" href="#">이전</a>
						<%-- <a class="page-link" href="?cPage=&numPerPage=">이전</a> --%>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">1</a>
						<%-- <a class="page-link" href="?cPage=&numPerPage=&postNo="></a> --%>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">2</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">3</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">4</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">5</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">다음</a>
						<%-- <a class="page-link" href="?cPage=&numPerPage=&postNo=">다음</a> --%>
					</li>
				</ul>
			</section>
			<section class="row main-section">
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
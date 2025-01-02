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
    <!-- 4. 페이지별 CSS -->
    <link rel="stylesheet" href="${path }/resources/css/board/purchaseHistory.css">
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
        
		<div class="main-content">
			<p><img width="20px" src="${path}/resources/images/board/folder.png"> 구매 내역 </p>
			<div id="main-box">
			
			<!-- 구매 유형 선택 -->
			<section class="main-section">
				<div class="type-selector">
					<input type="radio" id="typeFile" name="type" value="file" checked>
					<label for="typeFile">파일</label>
					<input type="radio" id="typeProduct" name="type" value="product">
					<label for="typeProduct">상품</label>
				</div>
			</section>
			<!-- 상품 여러개 출력할 땐 section 전체를 추가해야함 -->
			<section class="row main-section">
				<!-- 섹션 1 -->
				<div class="list-container">
				<%-- <div class="list-container" data-post-no="${post.postNo }"> --%>
					<table class="product-container">
						<tr>
							<td class="list-img">
								<img src="${path }/resources/images/ohaeone.jpg">
							</td>
							<td class="list-content">
								<div>
									<input type="text" value="구매 글 제목" readOnly><br>
									<input type="text" value="₩ 10,000원" readOnly><br>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</section>
			<section class="row main-section">
				<!-- 섹션 2 -->
				<div class="list-container">
				<%-- <div class="list-container" data-post-no="${post.postNo }"> --%>
					<table class="product-container">
						<tr>
							<td class="list-img">
								<img src="${path }/resources/images/ohaeone.jpg">
							</td>
							<td class="list-content">
								<div>
									<input type="text" value="구매 글 제목" readOnly><br>
									<input type="text" value="₩ 10,000원" readOnly><br>
									<!-- 상품 타입이 파일인 경우 -->
									<%-- <c:if test="${post2.productType==2 }">
										<!-- 파일 다운로드 기한 변수로 저장 -->
										<c:set val="fileDownloadPeriod" value="${post2.payment2.paymentDate+7 }"/>
										<!-- 파일 다운로드 기한이 오늘보다 크거나 같은 경우 -->
										<c:if test="${fileDownloadPeriod>=today }">
											<p>${fileDownloadPeriod }까지 파일 다운 가능</p>
											<a id="fileDownload-btn" href="${path }/${post2.file2.renamed }" download>
												<button>파일 다운로드</button>
											</a>
										</c:if>
										<c:if test="${fileDownloadPeriod<today }">
											<p style="color:red; font-weight:bold;">파일 다운 기한 만료</p>
										</c:if>
									</c:if> --%>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</section>
			<section class="row main-section">
				<!-- 섹션 3 -->
			</section>
		</div>
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
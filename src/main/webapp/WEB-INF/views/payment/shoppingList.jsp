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
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
    <!-- 7. 내부 style 태그 -->
    <style>
    	#main-box {
    		box-shadow: 0 0 5px rgba(0,0,0,0.2);
    		padding: 20px;
    		width: 1140px;
    	}
	    .list-container {
	    	display: flex;  /* Flexbox 사용 */
	        align-items: start;  /* 세로 정렬 */
	        gap: 10px;  /* 체크박스와 테이블 사이 간격 */
	        margin: 15px;
	        padding: 15px;
	    	width: 1100px;
	    	background: #eeeeee;
	    	box-shadow: 0 0 5px rgba(0,0,0,0.2);
	    	border-radius: 15px;
	    }
	    .select-btn {
	        width: 25px;
	        height: 25px;
	        accent-color: #6f6f6f;
	    }
	    .product-container {
	        border-collapse: collapse;
	    }
	    .list-img {
	        width: 120px;
	        height: 120px;
	        overflow: hidden;
	        padding: 0;  /* 패딩 제거 */
	    }
	    .list-img img {
	        width: 100%;
	        height: 100%;
	        object-fit: cover;  /* 비율 유지하며 영역 채우기 */
	        object-position: center;  /* 이미지 중앙 정렬 */
	    }
	    .list-content {
	        padding-left: 15px;
	    }
	    .list-content input {
	        margin: 5px 0;
	        border: none;
	        font-size: 11pt;
	        background-color: #eeeeee;
	    }
	   	.amount {
	   		font-weight: bold;
	   	}
	   	#purchase-btn {
	   		padding: 12px;
	   		background-color: white;
	   		border: 1px solid #cccccc;
	   		border-radius: 15px;
	   		color: #6f6f6f;
	   		font-size: larger;
	   		height: 50px;
	   		width: 120px;
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
			<div id="main-box">
			<section class="row main-section">
				<!-- 섹션 1 -->
				<div class="list-container">
					<input type="checkbox" class="select-btn">
					<table class="product-container">
						<tr>
							<td class="list-img">
								<img src="${path }/resources/images/ohaeone.jpg">
							</td>
							<td class="list-content">
								<div>
									<input type="text" value="구매 글 제목"><br>
									<input type="text" value="₩ 10,000원"><br>
									<input type="text" value="배송비 3,000원"><br>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</section>
			<section class="row main-section">
				<!-- 섹션 2 -->
				<div class="payment-info">
					<p>상품 총 금액 <span class="amount" id="total-product-price">10,000</span>원 + 배송비 <span class="amount" id="total-delivery-price">3,000</span>원</p>
					<p>= 총 <span class="amount" id="total-price">13,000</span>원</p>
				</div>
			</section>
			<section class="row main-section">
				<!-- 섹션 3 -->
				<button id="purchase-btn">결제하기</button>
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
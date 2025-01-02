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
    <link rel="stylesheet" href="${path }/resources/css/payment/shoppingList.css">
    
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
			<p><img width="20px" src="${path}/resources/images/payment/shoppingCart.png"> 장바구니 </p>
			<div id="main-box">
			<button id="checkAll" onclick="checkAll();">전체선택</button>
			<button id="checkDelete">선택삭제</button>
			<!-- 상품 여러개 출력할 땐 section 전체를 추가해야함 -->
			<section class="row main-section">
				<!-- 섹션 1 -->
				<div class="list-container">
				<%-- <div class="list-container" data-post-no="${post.postNo }"> --%>
					<input type="checkbox" class="select-btn">
					<table class="product-container">
						<tr>
							<td class="list-img">
								<img src="${path }/resources/images/ohaeone.jpg">
							</td>
							<td class="list-content">
								<div>
									<input type="text" name="postTitle" value="구매 글 제목" readOnly><br>
									<input type="text" name="salePrice" value="₩ 10,000원" readOnly><br>
									<input type="text" name="deliveryFee" value="배송비 3,000원" readOnly><br>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</section>
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
									<input type="text" value="구매 글 제목" readOnly><br>
									<input type="text" value="₩ 10,000원" readOnly><br>
									<input type="text" value="파일전송 상품" readOnly><br>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</section>
			<section class="row main-section">
				<!-- 섹션 2 -->
				<br>
				<div class="payment-info">
					<p>상품 총 금액 <span class="amount" id="total-product-price">10,000</span>원 + 배송비 <span class="amount" id="total-delivery-price">3,000</span>원</p>
					<p>= 총 <span class="amount" id="total-price">13,000</span>원</p>
				</div>
			</section>
			<!-- <section class="row main-section">
				섹션 3
			</section> -->
			<div id="purchase">
				<button id="purchase-btn">결제하기</button>
			</div>
			</div>
		</div>
	</div>
</main>

<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<!-- wrap 태그 종료 -->
</div>

<!-- 8. 공통 JavaScript -->
<script>
	//구매하기 버튼 누르면 구매창으로 연결 -> 나중에 정보까지 넘겨주도록 수정해야함
	$('#purchase-btn').click(function() {
		location.href="${path}/payment/purchase";
	})
	
	//전체 선택, 전체 취소
	function checkAll() {
		const checks = document.querySelectorAll(".list-container>[type='checkbox']")
		//모든 체크박스가 선택되어있는지 확인
		const allChecked = Array.from(checks).every(check => check.checked);
		//allChecked== true -> 전체 취소 / false -> 전체 선택
		checks.forEach(check => check.checked = !allChecked);
	}
	
	//장바구니 리스트의 회색 박스 영역 클릭시, 해당 상품의 상세 페이지로 이동
	$('.list-container').click(function(e) {
		if (!$(e.target).is('.select-btn')) {
			const postNo = $(this).data('post-no');
			location.assign(`${path}/post/viewpost`);
			//location.assign(`${path}/post/viewpost?postNo=`+postNo);
		}	
	})
</script>
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
</body>
</html>
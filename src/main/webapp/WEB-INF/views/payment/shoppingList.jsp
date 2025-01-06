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
			<div id="main-box" style="width:1100px;">
			<form action="${path }/payment/deletecart" method="POST" id="cartForm">
				<button type="button" id="checkAll" onclick="toggleCheckAll();">전체선택</button>
				<button type="submit" id="checkDelete">선택삭제</button>
			
			<c:forEach var="item" items="${carts }" varStatus="status">
				<section class="row main-section">
					<div class="list-container" 
						 data-post-no="${item.post.postNo }"
						 data-product-type="${item.post.productType }"
						 data-product-price="${item.product2.productPrice }"
						 data-delivery-fee="${item.product2.deliveryFee }"
						 data-file-price="${item.file2.filePrice }"
						 data-cart-no="${item.cartNo }">
						<input type="checkbox" class="select-btn" name="cartNo" value="${item.cartNo }">
						<table class="product-container">
							<tr>
								<td class="list-img">
									<img src="${path}/resources/images/upload/${item.postImg[0].renamed}">
								</td>
								<td class="list-content">
									<div>
										<!-- 판매 상품 제목 -->
										<p><strong>${item.post.postTitle}</strong></p><br>
										
										<!-- 판매 상품 금액 -->
										<c:if test="${item.post.productType==1 }">
										<!-- stockCount 변수에 재고 넣음 -->
										<c:set var="stockCount" value="${item.product2.stockCount }"/>
										<c:choose>
											<c:when test="${stockCount>0 }">
												<c:set var="price" value="${item.product2.productPrice }"/>
												<c:if test="${price>0 }">
													<p><strong>₩ <fmt:formatNumber value="${price }" pattern="###,###,###"/></strong></p>
												</c:if>
												<c:if test="${price==0 }">
													<p style="color:#2ecc71; font-weight:bold;">무료나눔</p>
												</c:if>
												
												<!-- 상품 배송비 -->
												<c:if test="${item.product2.hasDeliveryFee == 1}">
													<p><strong>무료배송</strong></p>
												</c:if>
												<c:if test="${item.product2.hasDeliveryFee == 0}">
													<p><strong>
														배송비: 
														<fmt:formatNumber value="${item.product2.deliveryFee}" pattern="#,###" />
														원
													</strong></p>
												</c:if>
											</c:when>
											<c:otherwise>
												<p style="color:#e74c3c; font-weight:bold;">판매종료</p>
											</c:otherwise>
										</c:choose>
									</c:if>
									<!-- 상품 타입이 파일인 경우 -->
									<c:if test="${item.post.productType==2 }">
										<!-- salePeriod 변수에 판매기간 넣음 -->
										<c:set var="salePeriod" value="${item.file2.salePeriod }"/>
										<c:choose>
											<c:when test="${salePeriod.compareTo(today) >= 0 }">
												<c:set var="price" value="${item.file2.filePrice }"/>
												<c:if test="${price>0 }">
													<p><strong>₩ <fmt:formatNumber value="${price }" pattern="###,###,###"/></strong></p>
												</c:if>
												<c:if test="${price==0 }">
													<p style="color:#2ecc71; font-weight:bold;">무료나눔</p>
												</c:if>
											</c:when>
											<c:otherwise>
												<p style="color:#e74c3c; font-weight:bold;">판매종료</p>
											</c:otherwise>
										</c:choose>
									</c:if><br>
									
										<br>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</section>
			</c:forEach>
			</form> 
			
			
			<form action="${path }/payment/purchase" method="POST" id="purchaseForm">
			<section class="row main-section">
				<!-- 섹션 2 -->
				<br>
				<div class="payment-info">
					<p>상품 총 금액 <span class="amount" id="total-product-price">0</span>원 + 배송비 <span class="amount" id="total-delivery-fee">0</span>원</p>
					<p>= 총 <span class="amount" id="total-price">0</span>원</p>
				</div>
			</section>
			<!-- <section class="row main-section">
				섹션 3
			</section> -->
			<div id="purchase">
				<button type="button" id="purchase-btn">구매하기</button>
			</div>
			</form>
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
	//전체 선택, 전체 취소
	function toggleCheckAll() {
		//모든 체크박스가 체크되어있는지 확인
		const isAllChecked = $('.select-btn:checked').length === $('.select-btn').length;
		//전체 체크박스 상태 변경
		$('.select-btn').prop('checked', !isAllChecked);
		
		//체크 상태 변경 후, 전체 금액 계산 실행
		calculateTotalPrice();
	}
	
	//선택 삭제 버튼 클릭 시,
	document.getElementById('cartForm').addEventListener('submit', function(e) {
		e.preventDefault(); //기본 제출 동작 중지
		
		const checked = document.querySelectorAll('input[name="cartNo"]:checked');
		
		if(checked.length === 0) {
			alert('삭제할 상품을 선택해주세요.');
			return;
		}
		if(confirm('선택한 상품을 삭제하시겠습니까?')) {
			this.submit();
		}
	});
	
	//장바구니 리스트의 회색 박스 영역 클릭 시, 해당 상품의 상세 페이지로 이동
	$('.list-container').click(function(e) {
		if (!$(e.target).is('.select-btn')) {
			const postNo = $(this).data('post-no');
			location.assign(`${path}/post/viewpost?postNo=`+postNo);
		}	
	})
	
	//선택된 상품의 총 금액 자동 계산
	function calculateTotalPrice() {
		let totalPrice = 0;
		let totalDeliveryFee = 0;
		
		$("#purchase").parent().find("input").remove();
		
		//체크된 상품들만 계산
		$('.select-btn:checked').each(function() {
			const container = $(this).closest('.list-container');
			const productType = container.data('product-type');
			
			//상품 가격 계산
			if(productType == 1) {
				const price = parseInt(container.data('product-price')) || 0;
				const deliveryFee = parseInt(container.data('delivery-fee')) || 0;
				
				totalPrice += price;
				totalDeliveryFee += deliveryFee;
			} else if (productType == 2) {
				const filePrice = parseInt(container.data('file-price')) || 0;
				
				totalPrice += filePrice;
			}
		})
		
		console.log(totalPrice);
		console.log(totalDeliveryFee);
		
		//천 단위 콤마 포맷팅
		$('#total-product-price').text(totalPrice.toLocaleString());
		$('#total-delivery-fee').text(totalDeliveryFee.toLocaleString());
		$('#total-price').text((totalPrice + totalDeliveryFee).toLocaleString());
		
		$('#purchaseForm').append('<input type="hidden" name="totalProductPrice" value=' + totalPrice + '>');
		$('#purchaseForm').append('<input type="hidden" name="totalDeliveryFee" value=' + totalDeliveryFee + '>');
		$('#purchaseForm').append('<input type="hidden" name="totalPrice" value=' + (totalPrice+totalDeliveryFee) + '>');
	}
	
	//체크박스 변경 시, 가격 다시 계산
	$(document).on('change', '.select-btn', calculateTotalPrice);
	
	//페이지 로드 시, 초기 계산
	$(document).ready(function() {
		calculateTotalPrice();
	});
	
	//구매하기 버튼 누르면 구매창으로 연결
	$('#purchase-btn').click(function() {
	    
		//선택된 체크박스 확인
		const checkedItems = $('.select-btn:checked');
		
		//선택된 상품이 없는 경우
		if(checkedItems.length === 0) {
			alert('구매할 상품을 선택해주세요.');
			return;
		}
	    
		//선택된 각 상품의 정보를 폼에 추가
		checkedItems.each(function() {
			const cartNo = $(this).val();
			$('#purchaseForm').append('<input type="hidden" name="cartNo" value="' + cartNo + '">');
		});
	    
		//폼 제출 직전 최종 확인
	    console.log('최종 폼 내용:');
	    console.log($('#purchaseForm').html());
	    
		//폼 제출
		$('#purchaseForm').submit();
	});
	
	
	
	
</script>
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
</body>
</html>
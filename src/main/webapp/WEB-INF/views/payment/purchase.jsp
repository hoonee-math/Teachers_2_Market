<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- jQuery 주소로 로드 / 파일로 로드시 현재 오류 발생 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 다음 우편번호 서비스 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
    <link rel="stylesheet" href="${path }/resources/css/payment/purchase.css">
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
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
			<p><img width="20px" src="${path}/resources/images/payment/dollar.png"> 결제하기</p>
			<div id="main-box" style="width:1100px;">
			<c:forEach var="item" items="${carts }" varStatus="status">
				<section class="row main-section">
					<div class="list-container" >
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
			<section class="row main-section">
				<!-- 섹션 2 -->
				<div class="payment-info">
				    <p>상품 총 금액 <span class="amount" id="total-product-price">
				        <fmt:formatNumber value="${totalProductPrice}" pattern="#,###" />
				    </span>원 + 배송비 <span class="amount" id="total-delivery-fee">
				        <fmt:formatNumber value="${totalDeliveryFee}" pattern="#,###" />
				    </span>원</p>
				    <p>= 총 <span class="amount" id="total-price">
				        <fmt:formatNumber value="${totalPrice}" pattern="#,###" />
				    </span>원</p>
				</div>
			</section>
			<section class="row main-section">
				<!-- 섹션 3 -->
				<div id="delivery-info">
					<table>
						<tr>
							<th>아이디</th>
							<td>
								<input type="text" name="memberId" id="memberId" value="${sessionScope.loginMember.memberId }">
							</td>
						</tr>			
						<tr>
							<th>핸드폰 번호</th>
							<td>
								<input type="text" name="phone" id="phone" value="${sessionScope.loginMember.phone }">
							</td>
						</tr>
						<tr>
							<th>이메일 주소</th>
							<td>
								<input type="text" name="email" id="email" value="${sessionScope.loginMember.email }">
							</td>
						</tr>
						<tr>
							<th>집 주소</th>
							<td>
								<div style="margin-bottom:10px">
									<input type="text" id="sample4_postcode" name="addressNo" placeholder="우편번호">
									<input type="button" id="postcodeFindBtn" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
									</div>
									<div>
									<input type="text" id="sample4_roadAddress" name="addressRoad" placeholder="도로명주소" style="width: 300px;">
									<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소" style="width: 300px;"> -->
									<span id="guide" style="color:#999;display:none"></span>
									<input type="text" id="sample4_detailAddress" name="addressDetail" placeholder="상세주소" style="width: 200px;">
									<!-- <input type="text" id="sample4_extraAddress" placeholder="참고항목" style="width: 150px;"> -->
								</div>
							</td>
						</tr>
						<tr>
							<th>구매 요청사항</th>
							<td>
								<input type="text" name="sellerRequest" id="sellerRequest">
							</td>
						</tr>
						<tr>
							<th>배송 요청사항</th>
							<td>
								<select name="deliveryRequest" id="deliveryRequest" onchange="toggleInput()">
									<option value=""></option>
									<option value="배송 전에 미리 연락바랍니다.">배송 전에 미리 연락바랍니다.</option>
									<option value="부재 시 경비실에 맡겨주세요.">부재 시 경비실에 맡겨주세요.</option>
									<option value="부재 시 문 앞에 놓아주세요.">부재 시 문 앞에 놓아주세요.</option>
									<option value="빠른 배송 부탁드립니다.">빠른 배송 부탁드립니다.</option>
									<option value="택배함에 보관해주세요.">택배함에 보관해주세요.</option>
									<option value="직접 입력">직접 입력</option>
								</select>
								<div id="customInput" style="display:none;">
									<input type="text" name="customDeliveryRequest" id="customDeliveryRequest"
										placeholder="요청사항을 입력해주세요.">
								</div>
							</td>
						</tr>
						<tr>
							<th>결제방식 선택</th>
							<td>
								<input type="radio" name="paymentMethod" id="paymentMethod0" value="무통장 입금">
								<label for="paymentMethod0">무통장 입금</label>
								<input type="radio" name="paymentMethod" id="paymentMethod1" value="카드 결제">
								<label for="paymentMethod1">카드 결제</label>
								<input type="radio" name="paymentMethod" id="paymentMethod2" value="휴대폰 결제">
								<label for="paymentMethod2">휴대폰 결제</label>
							</td>
						</tr>
					</table>
				</div>
				<br>
			</section>
			<div id="purchase">
				<button id="purchase-btn" onclick="requestPay()">결제하기</button>
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
	/* 집주소 입력 관련 js */
	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            const roadAddr = data.roadAddress;
	            let extraRoadAddr = '';

	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
	                extraRoadAddr += data.bname;
	            }
	            if(data.buildingName !== '' && data.apartment === 'Y') {
	                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            
	            // 우편번호와 주소 정보 입력
	            $("#sample4_postcode").val(data.zonecode);
	            $("#sample4_roadAddress").val(roadAddr);
	            $("#sample4_detailAddress").val('');

	            // 안내 텍스트 처리
	            const $guide = $("#guide");
	            if(data.autoRoadAddress) {
	                $guide.html('(예상 도로명 주소 : ' + data.autoRoadAddress + extraRoadAddr + ')').show();
	            } else {
	                $guide.html('').hide();
	            }
	        }
	    }).open();
	}
	/* 배송 요청사항으로 '직접 입력'선택시 입력창 나타나도록하는 함수 */
	function toggleInput() {
		const select = $('#deliveryRequest').val();
		if (select == "직접 입력") {
			$('#customInput').show();
		} else {
			$('#customInput').hide();
			$('#customDeliveryRequest').val('');
		}
	}
	
	function requestPay() {
	    // 사용자 입력값 가져오기
	    const orderName = document.getElementById("orderName").value;
	    const totalAmount = document.getElementById("totalAmount").value;

	    // 필수 데이터 확인
	    if (!orderName || !totalAmount) {
	        alert("모든 값을 입력해주세요!");
	        return;
	    }
	    
	      PortOne.requestPayment({
	        storeId: "store",
	        paymentId: "test",
	        orderName: $("#postTitle").val(),
	        totalAmount: 1000,
	        currency: "KRW",
	        channelKey: "channel-key",
	        payMethod: "CARD",
	        card: {},
	        customer: {
	          customerId: "user_m5f69vse",
	          fullName: "123",
	          firstName: "123",
	          phoneNumber: "010-1111-1111",
	          email: "123@gmail.com",
	        },
	      });
	    }
</script>
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
</body>
</html>
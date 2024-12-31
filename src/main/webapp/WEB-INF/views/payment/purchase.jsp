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
			<div id="main-box">
			<section class="row main-section">
				<!-- 섹션 1 -->
				<div class="list-container">
					<table class="product-container">
						<tr>
							<td class="list-img">
								<img src="${path }/resources/images/ohaeone.jpg">
							</td>
							<td class="list-content">
								<div>
									<input type="text" name="postTitle" value="구매 글 제목"><br>
									<input type="text" name="salePrice" value="₩ 10,000원"><br>
									<input type="text" name="deliveryFee" value="배송비 3,000원"><br>
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
								<input type="text" name="phone" id="phone" value="핸드폰 번호">
							</td>
						</tr>
						<tr>
							<th>이메일 주소</th>
							<td>
								<input type="text" name="email" id="email" value="이메일 주소">
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
			<button id="purchase-btn">결제하기</button>
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
	
</script>
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
</body>
</html>
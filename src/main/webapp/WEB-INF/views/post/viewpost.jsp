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
			<!-- 섹션 1: 상품 기본 정보 -->
			<section class="row post-main-section">
				<!-- 상품 이미지 영역 -->
				<div id="post-img-div">
					<!-- 메인 이미지 -->
					<c:if test="${not empty images}">
						<!-- 첫 번째 이미지를 기본 메인 이미지로 설정 -->
						<div id="post-img-bigSize">
							<img src="${path}/resources/upload/${images[0].rename}" alt="상품 메인 이미지" id="main-image">
						</div>
					</c:if>
					<!-- 썸네일 슬라이드 -->
					<div id="post-img-minislide">
						<c:forEach var="img" items="${images}" varStatus="vs">
							<div class="thumbnail" onclick="changeMainImage(this)" data-src="${path}/resources/upload/${img.rename}">
								<img src="${path}/resources/upload/${img.rename}" alt="상품 이미지 ${vs.count}">
							</div>
						</c:forEach>
					</div>
					<div id="post-mini-dashboard" style="display:flex;">
						<div></div>
					</div>
				</div>
				
				
				<!-- 상품 정보 영역 -->
				<div class="post-info">
					<!-- 판매자 정보 -->
					<div class="post-seller-nick">
						<c:set var="memberNick" value="sellerNick"/>
						${memberNick }
					</div>
					<div class="post-title">
						<c:set var="postTitle" value="postTitle"/>
						${postTitle }			
					</div>
					<!-- 상품/파일 가격 -->
					<div class="post-item-price">
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
									<p style="color: #2ecc71;">무료나눔</p>
								</c:if>
							</c:when>
							<c:otherwise>
								<p style="color: #e74c3c;">판매종료</p>
							</c:otherwise>
						</c:choose>
					</div>
					<!-- 배송 정보 -->
					<div class="post-delivery-info">
						<c:set var="hasDeliveryFee" value="1"/>
						<c:if test="${hasDeliveryFee eq 0}">
							<p>무료배송</p>
						</c:if>
						<c:if test="${hasDeliveryFee eq 1}">
							<p>
								배송비: ₩
								<fmt:formatNumber value="${deliveryFee}" pattern="#,###" />
							</p>
						</c:if>
					</div>

					<!-- 구매 버튼 영역 -->
					<div class="post-purchase-buttons">
						<button class="post-cart-btn">장바구니</button>
						<button class="post-buy-btn">바로구매</button>
					</div>
				</div>
			</section>
			
			<!-- 섹션 2: 상품 상세 정보 -->
			<section class="row post-info-section">
				<div class="post-tabs top-tabs">
					<button class="tab-btn active" data-tab="detail">상세정보</button>
					<button class="tab-btn" data-tab="qna">상품문의</button>
					<button class="tab-btn" data-tab="review">상품후기</button>
				</div>

				<!-- 상세정보 탭 -->
				<div id="detail" class="tab-content active">
					<div id="detail" class="tab-content">
						<!-- 상품 이미지가 있는 경우 -->
						<c:if test="${not empty detailImages}">
							<div class="detail-images">
								<c:forEach var="img" items="${detailImages}">
									<img src="${path}/resources/upload/${img.rename}"
										alt="상세 이미지">
								</c:forEach>
							</div>
						</c:if>
						<!-- 상세 정보 내용 -->
						<div class="post-content">${postContent}</div>
					</div>
			</section>
			
			<!-- 하단 탭 -->
			<section class="row post-board-section" id="board-section">
				<div class="post-tabs bottom-tabs">
					<button class="tab-btn" data-tab="detail">상세정보</button>
					<button class="tab-btn" data-tab="qna">상품문의</button>
					<button class="tab-btn" data-tab="review">상품후기</button>
				</div>

				<!-- QnA 탭 컨텐츠 -->
				<div id="qna" class="tab-content" style="display: none;">
					<div class="qna-list">
						<!-- QnA 내용 -->
						<c:forEach var="qna" items="${qnaList}">
							<div class="qna-item">
								<p class="q-title">${qna.qnaTitle}</p>
								<p class="q-content">${qna.qnaContent}</p>
								<c:if test="${not empty qna.answerContent}">
									<div class="answer">
										<p>↳ ${qna.answerContent}</p>
										<p class="answer-date">
											<fmt:parseDate value="${qna.answerDate}"
												pattern="yyyy-MM-dd" var="parsedDate" />
											<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" />
										</p>
									</div>
								</c:if>
							</div>
						</c:forEach>
						<button class="write-qna-btn">문의하기</button>
					</div>
				</div>

				<!-- 리뷰 탭 컨텐츠 -->
				<div id="review" class="tab-content" style="display: none;">
					<div class="review-list">
						<!-- 리뷰 내용 -->
						<c:forEach var="review" items="${reviewList}">
							<div class="review-item">
								<div class="review-header">
									<span class="review-rating">★ ${review.rating}</span> <span
										class="review-date"> <fmt:parseDate
											value="${review.reviewDate}" pattern="yyyy-MM-dd"
											var="parsedDate" /> <fmt:formatDate value="${parsedDate}"
											pattern="yyyy-MM-dd" />
									</span>
								</div>
								<p class="review-content">${review.reviewContent}</p>
								<c:if test="${not empty review.reviewImg}">
									<div class="review-images">
										<img
											src="${path}/resources/images/${review.reviewImg}"
											alt="리뷰 이미지">
									</div>
								</c:if>
								<div class="review-footer">
									<button class="like-btn" data-review-no="${review.reviewNo}">
										♥ ${review.reviewLikeCount}</button>
								</div>
							</div>
						</c:forEach>
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
<script>
	$(document).ready(function() {

		// 기존 코드 삭제하고 새로운 함수로 대체
		window.changeMainImage = function(element) {
			const imgSrc = $(element).data('src');
			$('#main-image').attr('src', imgSrc);

			// 선택된 썸네일에 시각적 표시를 위한 클래스 추가
			$('.thumbnail').removeClass('selected');
			$(element).addClass('selected');
		};

		// 페이지 로드 시 첫 번째 썸네일을 선택된 상태로 표시
		$('.thumbnail:first').addClass('selected');

		//////////////////
		/*   탭 전환 함수  */
		/////////////////
	
		// 상단의 상세정보 탭은 항상 활성화
		$('.top-tabs .tab-btn[data-tab="detail"]').addClass('active');

		// 하단 탭에서는 상품문의를 기본값으로 설정
		$('.bottom-tabs .tab-btn[data-tab="qna"]').addClass('active');
		$('#detail').show(); // 상세정보 내용 표시
		$('#qna').show(); // 상품문의 내용 표시
		$('#review').hide(); // 상품후기 내용 숨김

		// 상단 탭 클릭 이벤트
		$('.top-tabs .tab-btn').click(
			function() {
				const tab = $(this).data('tab');

				// 상세정보는 항상 활성화 상태 유지
				$('.top-tabs .tab-btn').removeClass('active');
				$('.top-tabs .tab-btn[data-tab="detail"]').addClass('active');

				// detail이 아닌 경우 하단 섹션으로 스크롤
				if (tab !== 'detail') {
					// 하단 탭의 해당 컨텐츠 표시 및 탭 활성화
					$('.bottom-tabs .tab-btn').removeClass('active');
					$('.bottom-tabs .tab-btn[data-tab="' + tab + '"]').addClass('active');

					// 컨텐츠 전환
					$('.post-board-section .tab-content').hide();
					$('#' + tab).show();

					// 스크롤 이동
					let targetPosition = $('.bottom-tabs').offset().top;
					$('html, body').animate( { scrollTop : targetPosition - 100 }, 500 );
				}
			}
		);

		// 하단 탭 클릭 이벤트
		$('.bottom-tabs .tab-btn').click(
			function() {
				const tab = $(this).data('tab');

				if (tab === 'detail') {
					// 상세정보 탭 클릭 시 상단으로 스크롤만 수행
					$('html, body').animate( { scrollTop : $('.post-info-section').offset().top - 100 }, 500 );
				} else {
					// 다른 탭들은 일반적인 탭 전환
					$('.bottom-tabs .tab-btn') .removeClass('active');
					$(this).addClass('active');

					// 컨텐츠 전환
					$('.post-board-section .tab-content').hide();
					$('#' + tab).show();
				}
			}
		);

		// 장바구니 버튼 클릭
		$('.cart-btn').click(function() {
			// Ajax로 장바구니 추가 처리
		});

		// 구매 버튼 클릭
		$('.buy-btn').click(function() {
			// 구매 페이지로 이동
		});

		// 좋아요 버튼 클릭
		$('.like-btn').click(function() {
			const reviewNo = $(this).data('review-no');
			// Ajax로 좋아요 처리
		});
	});
</script>
</body>
</html>
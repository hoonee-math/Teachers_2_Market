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
	<link rel="stylesheet" href="${path}/resources/css/post/writepost.css">
    <!-- Toast UI Editor CDN -->
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
	
	<!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
	<!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
	<!-- Toast UI Editor CDN -->
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
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
			<form id="writeForm" method="post" enctype="multipart/form-data">
				<!-- Hidden Fields -->
				<input type="hidden" name="memberNo" value="${loginMember.memberNo}">
				<input type="hidden" name="isTemp" value="0">
				<input type="hidden" name="isDeleted" value="0">
				
				<!-- 판매 유형 선택 -->
				<div class="section-container">
					<h3>판매 유형</h3>
					<div class="type-selector">
						<input type="radio" id="typeProduct" name="type" value="product" checked>
						<label for="typeProduct">상품</label>
						<input type="radio" id="typeFile" name="type" value="file">
						<label for="typeFile">파일</label>
					</div>
				</div>
				
				<!-- 기본 정보 -->
				<div class="section-container">
					<h3>기본 정보</h3>
					<div class="input-group">
						<label for="title">제목</label>
						<input type="text" id="title" name="postTitle" required>
					</div>
					
					<div class="input-group">
						<label for="category">카테고리</label>
						<select id="category" name="categoryNo" required> <!-- js객체 활용해서 categoryNo 전달 -->
							<option value="">카테고리 선택</option>
						</select>
					</div>
					
					<div class="input-group">
						<label for="subject">과목</label>
						<select id="subject" name="subjectNo" required> <!-- js객체 활용해서 subjectNo 전달 -->
							<option value="">과목 선택</option>
						</select>
					</div>
					
					<div class="price-section">
						<div class="input-group">
							<input type="checkbox" id="isFree" name="isFree" value="1">
							<label for="isFree">무료나눔</label>
						</div>
						
						<div class="input-group" id="priceGroup">
							<label for="price">가격</label>
							<input type="number" id="price" name="productPrice" min="0">
						</div>
						
						<div class="input-group product-only">
							<label for="stock">수량</label>
							<input type="number" id="stock" name="stockCount" min="1" value="1">
						</div>
						
						<div class="input-group product-only">
							<input type="checkbox" id="hasDeliveryFee" name="hasDeliveryFee" value="1">
							<label for="hasDeliveryFee">배송비 포함</label>
							<input type="number" id="deliveryFee" name="deliveryFee" min="0" disabled>
						</div>
					</div>
				</div>
				
				<!-- 이미지 업로드 -->
				<div class="section-container">
					<h3>상품 이미지</h3>
					<div class="image-upload-container">
						<div id="imagePreviewContainer" class="image-preview-container">
							<div class="image-upload-box">
								<!-- input을 label로 감싸서 처리 -->
								<label for="imageUpload" class="upload-label">
									<input type="file" id="imageUpload" multiple accept="image/*" style="display: none;">
									<span>이미지 추가</span>
								</label>
							</div>
						</div>
						<p class="help-text">* 첫 번째 이미지가 대표 이미지로 사용됩니다.</p>
						<p class="help-text">* 드래그하여 이미지 순서를 변경할 수 있습니다.</p>
					</div>
				</div>
				<!-- 판매 파일 업로드 (파일 판매 시에만 표시) -->
				<div class="section-container file-only" style="display: none;">
				    <div class="file-header">
				        <h3>판매할 파일</h3>
				        <div class="file-upload-box">
				            <label for="fileUpload" class="simple-upload-label">
				                <input type="file" id="fileUpload" multiple accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.zip">
				                <i class="bi bi-plus"></i> 파일추가
				            </label>
				        </div>
				    </div>
				    <div class="file-upload-wrapper">
				        <div class="file-list"></div>
				        <p class="help-text">* pdf, doc(x), ppt(x), xls(x), zip 파일 가능 / 파일당 최대 100MB</p>
				    </div>
				</div>
				<!-- 상세 내용 -->
				<div class="section-container">
					<h3>상세 내용</h3>
					<div id="editor"></div>
				</div>
				
				<!-- 버튼 영역 -->
				<div class="button-container">
					<button type="button" id="tempSaveBtn">임시저장</button>
					<button type="submit" id="submitBtn">등록하기</button>
					<button type="button" id="cancelBtn">취소</button>
				</div>
			</form>
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
<script src="${path}/resources/js/post/writepost.js"></script>
</body>
</html>
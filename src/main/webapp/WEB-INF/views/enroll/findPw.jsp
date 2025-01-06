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
    body {
    	background-color : #fffadd;
    	background : linear-gradient(to right, #fffadd, #ffffff);
    	margin: 0;
    }
    #find-main-container {
		display : flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		min-height: 90vh;
		padding: 20px;
	}
	#find-container{
		cursor: pointer;
	}
	#find-content {
		display: flex;
		flex-direction: column;
		gap:10px;
		width: 100%;
	}
    
    #find-content {
	    width: 610px;
        border: 1px solid #ddd;
        border-radius: 20px;
        background-color: #fff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    #find-tab {
    	display: flex;
        border-bottom: 1px solid #ddd;
    }
    #find-tab>div {
    	width: 305px;
    	display : flex;
		align-items: center;
		justify-content: center;
    }
    #find-id,
    #find-pw {
        flex: 1;
        padding: 20px;
        text-align: center;
        cursor: pointer;
        font-size: 14px;
        background-color: #f9f9f9;
        color: #6f6f6f;
    }
    #find-id {
    	background-color: white;
    	border-radius: 20px;
    }
    #find-pw {
	    background-color: #fffadd;
        border-bottom: 2px solid #fff6c2;
        font-weight: bold;
        border-radius: 20px 0 0 0;
    }
    
    #input-info {
        text-align: center;
        font-size: 14px;
        color: #666;
        height: 300px;
        margin-top: 100px;
    }
    #input-id {
    	width: 300px;
    	border: 1px solid #cccccc;
    	border-radius: 5px;
    	padding: 10px;
    }
    #email-check {
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #fffadd;
        color: #6f6f6f;
        border: 1px solid #cccccc;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
    }
    #email-check:hover {
    	background-color: #fff6c2;
    }
    </style>
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 헤더 include -->
<!-- 메인 콘텐츠 -->
<main class="main">
	<div id="find-main-container">
		<div id="find-container">
			<img src="${path}/resources/images/logo(NoBackGround).png" style="width:150px; height:150px;">
		</div>
		<!-- 콘텐츠 영역 -->
		<div id="main-content">
			<section class="row main-section">
				<!-- 섹션 1 -->
				<div id="find-content">
					<div id="find-tab">
						<div id="find-id">아이디 찾기</div>
						<div id="find-pw">비밀번호 찾기</div>
					</div>
					<div id="input-info">
						<input type="text" id="input-id" placeholder="아이디를 입력하세요.">
						<br>
						<button id="email-check">이메일 인증</button>
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
	$("#find-container").click(function () {
		location.assign("${path}");
	});
	
	$("#find-id").click(function () {
		location.assign("${path}/member/findid");
	})
</script>
</body>
</html>
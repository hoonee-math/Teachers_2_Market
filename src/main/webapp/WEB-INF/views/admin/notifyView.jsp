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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
		/* *{border:1px solid pink} */
		p{margin:0px;}
		/* viewpost.css */
		.post-content {
		    padding: 20px;
		    line-height: 1.6;
		}
		
		/* Toast UI Editor의 스타일을 유지하기 위한 CSS */
		.post-content img {
		    max-width: 100%;
		    height: auto;
		}
		
		.post-content p {
		    margin: 1em 0;
		}
		
		.post-content h1,
		.post-content h2,
		.post-content h3,
		.post-content h4,
		.post-content h5,
		.post-content h6 {
		    margin: 1.5em 0 0.5em;
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
		<div id="view-main-content" class="main-content" >
		
			<div class="post-seller-id">
				${post.member.memberId }
			</div>
			<div class="post-title">
				${post.postTitle }			
			</div>
			
			<hr style="border:2px solid #fff6c2; width:100%;"/>
			
			<!-- viewpost.jsp -->
			<div class="post-content">
				${post.postContent}
				<!-- HTML 형태로 저장된 내용이 그대로 출력됨 -->
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
<script>

	const formData = new FormData($('#writeForm')[0]);
	formData.append('content', editor.getHTML());  // HTML 형태로 저장

</script>
</body>
</html>
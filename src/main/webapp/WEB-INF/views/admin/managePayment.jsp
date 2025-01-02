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
		table {
			margin-top: 40px;
			table-layout: fixed;
			width: 100%;
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
			<!-- 섹션 1: 회원 목록이 출력되는 section -->
			<section class="main-section">
				<div>
					<div>
						<h2>회원 목록</h2>
						<hr style="border:2px solid #fff6c2;">
						<p>회원을 조회, 경고, 정지 등 관리할 수 있는 페이지 입니다.</p>
					</div>
				</div>
				<div id="board-container">
					<table id="tbl-board">
						<colgroup>
							<col style="width: 50px;">
							<col style="width: 100px;">
							<col style="width: 100px;">
							<col style="width: 100%;">
							<col style="width: 50px;">
							<col style="width: 100px;">
							<col style="width: 100px;">
						</colgroup>
						<thead>
							<tr>
									<th>번호</th>
									<th>아이디</th>
									<th>닉네임</th>
									<th>이메일</th>
									<th>경고</th>
									<th>가입일</th>
									<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty boards }">
				            	<tr>
				            		<td colspan="5" style="text-align: center;">
				            			죄회된 결과가 없습니다.
				            		</td>
				            	</tr>
				            </c:if>
							<c:if test="${not empty boards }">
								<c:forEach var="m" items="${members }">
								<tr>
									<td>${m.memberNo }</td>
									<td>${m.memberId }</td>
									<td>${m.memberNick }</td>
									<td>${m.email}</td>
									<td>${m.reportCount }</td> <!-- join table로 횟수 계산 필요 -->
									<td>
										<fmt:formatDate var="postDate" value="${p.createDate}" pattern="yyyyMMdd" />
									</td>
									<td>
										<p id="manageTistMember">자세히 보기</p>
									</td>
								</tr>
								</c:forEach>
				            </c:if>
						</tbody>
					</table>
			
			        <div id="pageBar">
			        	${pageBar }
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
</body>
</html>
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
			<!-- 섹션 1: 공지사항 게시판, 글 목록이 출력되는 section -->
			<section class="main-section">
				<div>
					<div>
						<h2>공지사항</h2>
						<hr style="border:2px solid #fff6c2;">
						<p>티꿀모아 이용관련 공지사항을 항상 확인해주세요.</p>
					</div>
				</div>
				<div id="board-container">
					<table id="tbl-board">
						<colgroup>
							<col style="width: 50px;">
							<col style="width: 100%;">
							<col style="width: 100px;">
							<col style="width: 100px;">
							<col style="width: 100px;">
						</colgroup>
						<thead>
							<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>조회수</th>
									<th>시간</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty boards }">
				            	<tr>
				            		<td colspan="5" style="text-align: center;">
				            			조회된 결과가 없습니다.
				            		</td>
				            	</tr>
				            </c:if>
							<c:if test="${not empty boards }">
								<c:forEach var="p" items="${boards }">
								<tr>
									<td>${p.postNo }</td>
									<td class="title">
										<a href="${path }/post/viewpost?postNo=${p.postNo}">
											${p.postTitle}
											<c:if test="${p.status==1 && p.isPublic==0 }"><span style="color:red">[임시저장됨]</span></c:if>
										</a>
										<span class="highlight">2</span></td>
									</td>
									<td>${p.member.memberNick }</td>
									<td class="view-count">${p.viewCount }</td>
									<td class="time">
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
										<fmt:formatDate var="postDate" value="${p.createDate}" pattern="yyyyMMdd" />
										
										<!-- 오늘 작성한 글인 경우 시:분 으로 그 외의 경우에는 월/일 로 데이터 출력 -->
										<c:choose>
										    <c:when test="${today eq postDate}">
										        <fmt:formatDate value="${p.createDate}" pattern="HH:mm"/>
										    </c:when>
										    <c:otherwise>
										        <fmt:formatDate value="${p.createDate}" pattern="MM/dd"/>
										    </c:otherwise>
										</c:choose>
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
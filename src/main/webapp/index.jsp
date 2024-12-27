<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.jpeg">
	<title>티꿀모아</title>
	
    <!-- 2. 공통 CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/header.css">
    <!-- 3. 컴포넌트 CSS -->
    <!-- 4. 페이지별 CSS -->
    <!-- 5. 외부 라이브러리 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
		
	<!-- head 영역에 들어갈 style -->
	<style>
	/* 전체 레이아웃 설정 */
	*{
		border: 2px solid pink
	}
	#wrap {
	    min-height: 100vh;
	    display: flex;
	    flex-direction: column;
	}
	
	/* main 영역 전체 스타일 */
	.main {
	    width: 100%;
	    flex: 1; /* footer를 위한 공간 확보 */
	}
	
	/* main 컨테이너 - header와 동일한 너비(880px) 유지 */
	.main-container {
	    width: 850px;
	    margin: 0 auto;
	    display: flex;
	    gap: 30px; /* sidebar와 콘텐츠 사이 간격 조정 */
	    padding-left: 22px; /* sidebar를 살짝 오른쪽으로 이동 */
	}
	
	/* 메인 콘텐츠 영역 */
	.main-content {
	    flex: 1;
	    display: flex;
	    flex-direction: column;
	    gap: 20px; /* 섹션 간 간격 */
	}
	
	/* 각 섹션 스타일 */
	.main-section {
	    width: 100%;
	    min-height: 200px; /* 임시 높이 - 실제 콘텐츠에 맞게 조정 필요 */
	}
	
	/* footer 스타일 */
	footer {
	    width: 100%;
	    padding: 20px 0;
	    margin-top: auto; /* 컨텐츠가 적을 때 하단에 고정 */
	    background-color: #fffadd;
	    border-top: 1px solid #eee;
	    text-align: center;
	    font-size: 14px;
	    color: #6f6f6f;
	}
	
	footer p {
	    margin: 0;
	}
	</style>
</head>
<body>
    <!-- 콘텐츠 영역 -->
    <div id="wrap">
        <!-- 헤더 include -->
        <header class="header">
			<div class="header-container">
				<a href="#" id="homeButton"> <img
					src="${pageContext.request.contextPath }/resources/images/logo.jpeg"
					alt="home으로">
				</a>
				<div class="search-bar">
					<input type="text" placeholder="검색어를 입력해주세요.">
					<button onclick="search();">
						<img
							src="https://img.icons8.com/?size=100&id=7695&format=png&color=cccccc"
							alt="검색" width="25px" height="100%">
					</button>
				</div>
				<div class="personal-container">
					<table id="personal-info">
						<tr rowspan="2">
							<td id="member-name" colspan="2">OOO님</td>
							<td>
								<button id="cart">
									<img width="30px" height="100%"
										src="https://img.icons8.com/?size=100&id=85080&format=png&color=6f6f6f" />
								</button>
							</td>
						</tr>
						<tr id="personal-btn">
							<td>
								<button id="write-btn">글쓰기</button>
							</td>
							<td>
								<button id="logout-btn">로그아웃</button>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</header>
        
        <!-- 메인 콘텐츠 -->
        <main class="main">
		    <div class="main-container">
		        <!-- sidebar include -->
		        <jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
		        
		        <!-- 콘텐츠 영역 -->
		        <div class="main-content">
		            <section class="row main-section">
		                <!-- 섹션 1 -->
		            </section>
		            <section class="row main-section">
		                <!-- 섹션 2 -->
		            </section>
		            <section class="row main-section">
		                <!-- 섹션 3 -->
		            </section>
		        </div>
		    </div>
        </main>

        <!-- 푸터 include -->
        

		
		
		<footer class="footer footer-contnet">
			<p>© 2025 티꿀모아 | 이용 약관 | 개인정보 보호 정책 | 청소년 보호 정책</p>
		</footer>
			
    </div>

    <!-- 6. 공통 JavaScript -->
    <!-- 7. API/Ajax 관련 JavaScript -->
    <!-- 8. 컴포넌트 JavaScript -->
    <!-- 9. 페이지별 JavaScript -->
</body>
</html>






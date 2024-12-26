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
	<title>Honey T</title>
	
    <!-- 2. 공통 CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/header.css">
    <!-- 3. 컴포넌트 CSS -->
    <!-- 4. 페이지별 CSS -->
    <!-- 5. 외부 라이브러리 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
</head>
<body>
    <!-- 콘텐츠 영역 -->
    <div id="wrap">
        <!-- 헤더 include -->
        <div class="header">
			<div class="main">
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
		</div>
        
        <!-- 메인 콘텐츠 -->
        <main style="height:500px;">
            <!-- 페이지 내용 -->
            <section>
				<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
            </section>
			
        </main>

        <!-- 푸터 include -->
        

		<style>
		body {
		    min-height: 100vh; /* 최소 높이를 뷰포트 높이로 설정 */
		    display: flex;
		    flex-direction: column;
		}
		
		footer {
		    width: 100%;
		    margin-top: auto; /* 컨텐츠가 적을 때 아래로 밀어줌 */
		    padding: 20px;
		    text-align: center;
		    font-size: 14px;
		    color: #6f6f6f;
		    background-color: #fffadd;
		    border-top: 1px solid #eee;
		}
		
		footer p {
		    margin: 0;
		}
		
		*{
			border : 2px solid pink;
		}
		</style>
		
		<footer>
			<p>© 2025 티꿀모아 | 이용 약관 | 개인정보 보호 정책 | 청소년 보호 정책</p>
		</footer>
			
    </div>

    <!-- 6. 공통 JavaScript -->
    <!-- 7. API/Ajax 관련 JavaScript -->
    <!-- 8. 컴포넌트 JavaScript -->
    <!-- 9. 페이지별 JavaScript -->
</body>
</html>






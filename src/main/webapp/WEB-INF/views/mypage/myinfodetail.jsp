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
			
		<section id=enroll-container>
			<h2>내 정보</h2>
			<!-- onsubmit 발생했을 때 action 속성을 이용해 enrollmemberend.do 로 post 요청. onsubmit 속성을 통해 유효성검사 실시-->
			<!-- onsubmit 값의 return 값이 true 일때 post 로 요청! -->
			<form action="${path}/member/enrollend" method="post"
				onsubmit="return fn_invalidate();">
				<table>
					<tr>
						<th>아이디 *</th>
						<td>
							<input type="text" name="memberId" id="memberId" style="width: 150px;" required>
							<input type="button" value="ID 중복확인" id="idCheckBtn" onclick="checkId()">
						</td>
					</tr>
					<tr>
						<th>이메일 *</th>
						<td>
							<input type="text" name="emailId" id="emailId" style="width: 150px;" required>
							@ 
							<input type="text" name="emailDomain" id="emailDomain" style="width: 150px;" required>
							<select id="emailSelect">
								<option value="">직접입력</option>
								<option value="gmail.com">gmail.com</option>
								<option value="naver.com">naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="nate.com">nate.com</option>
							</select>
							<input type="button" value="이메일 인증" id="emailCheckBtn">
						</td>
					</tr>
					<tr>
						<th>패스워드 *</th>
						<td>
							<input type="password" name="memberPw" id="password_" placeholder="대소문자, 숫자, 특수문자 포함" required><br>
						</td>
					</tr>
					<tr>
						<th>패스워드확인 *</th>
						<td>
							<input type="password" id="password_2" required><br>
							<span id="checkResult"></span>
						</td>
					</tr>
					<tr>
						<th>이름 *</th>
						<td>
							<input type="text" name="memberName" id="userName" required><br>
						</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td>
							<input type="text" name="memberNick" id="memberNick" placeholder="다른 사용자에게 보여줄 닉네임을 입력하세요."><br>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<div style="margin-bottom: 10px">
								<input type="text" id="sample4_postcode" name="addressNo" placeholder="우편번호">
								<input type="button" id="postcodeFindBtn"  value="우편번호 찾기"><br>
							</div>
							<div>
								<input type="text" id="sample4_roadAddress" name="addressRoad" placeholder="도로명주소" style="width: 300px;">
								<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소" style="width: 300px;"> -->
								<span id="guide" style="color: #999; display: none"></span>
								<input type="text" id="sample4_detailAddress" name="addressDetail" placeholder="상세주소" style="width: 200px;">
								<!-- <input type="text" id="sample4_extraAddress" placeholder="참고항목" style="width: 150px;"> -->
							</div>
						</td>
					</tr>
					<tr>
						<th>
							<!-- 회원 구분 * -->
						</th>
						<td>
							<input type="hidden" name="memberType" id="student" value="1" ${memberType == '1' ? 'checked' : ''}>
							<label for="student"></label>
							<input type="hidden" name="memberType" id="teacher" value="2" ${memberType == '2' ? 'checked' : ''}>
							<label for="teacher"></label>
						</td>
					</tr>
				</table>
				<div class="enrollsubmit">
					<input type="reset" value="취소"> <input type="submit"
						value="가입">
				</div>
			</form>
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
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
	<link rel="stylesheet" href="${path }/resources/css/enroll/enrollMember.css">
	<link rel="stylesheet" href="${path }/resources/css/enroll/termsofservice.css">
	<link rel="stylesheet" href="${path }/resources/css/common/footer.css">
    <!-- 3. 컴포넌트 CSS (각 요소) -->
    <!-- 4. 페이지별 CSS -->
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
    <!-- 7. 내부 style 태그 -->
    <style>
    button, input, select, textarea {
	    margin: 0;
	    padding: 0;
	}
	
	/* 입력 필드 텍스트 스타일 */
	button, input, select, td, textarea, th {
	    font-size: 14px;
	    line-height: 1.5;
	   	width:90px;
	    font-family: 'Malgun Gothic','맑은 고딕',sans-serif;
	    color: #222;
	}
	
	/* IE 브라우저 clear 버튼 숨김 */
	input[type=text]::-ms-clear {
	    display: none;
	}
	
	/* 입력 필드 검색 취소 버튼 숨김 */
	input[type=search]::-webkit-search-cancel-button {
	    -webkit-appearance: none;
	}
	
	/* 우편번호 입력 필드 */
	#sample4_postcode {
	    width: 100px;  /* 우편번호는 짧게 */
	}
    body {
    	background-color : #fffadd;
    	background : linear-gradient(to right, #fffadd, #ffffff);
    	margin: 0;
    }
    #enroll-main-container {
		display : flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		height: auto;
		min-height: 900px;
		padding: 40px 20px;
	}
	.main-content {
		margin-top:0px;
		background: #fff;
	    padding: 45px 30px;
	    border-radius: 30px;
	    box-shadow: 0 8px 12px rgba(0, 0, 0, 0.3);
	    width: 600px;
	    height : auto;
	    text-align: center;
	}
	#login-font {
		font-family:Sans-serif;
		font-style: italic;
		font-size: 40px;
		color : grey;
	}
	
	.main-section {
		display: flex;
		flex-direction: column;
	}
	#agree-button {
		display: flex;
		justify-content: center;
		margin-top: 20px;
		padding: 20px;
		gap: 30px;
		margin-top:20px;
	}
	#enroll-inner-header {
		display:flex;
		justify-content: center;
		align-items:center;
	}
    </style>
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 메인 콘텐츠 -->
	<div id="enroll-main-container">
		<!-- 콘텐츠 영역 -->
		<div class="main-content">
			<section class="row main-section">
				<!-- 섹션 1 -->
					<div id="enroll-inner-header">
						<img class="logo-container" src="${path}/resources/images/logo(NoBackGround).png" style="width:100px; height:100px;">
						<p id="login-font">Join</p>
					</div>
			<!-- onsubmit 발생했을 때 action 속성을 이용해 enrollmemberend.do 로 post 요청. onsubmit 속성을 통해 유효성검사 실시-->
			<!-- onsubmit 값의 return 값이 true 일때 post 로 요청! -->
			<form action="${path}/member/enroll" method="post"
				onsubmit="return fn_invalidate();">
				<table>
					<tr>
						<th>아이디 *</th>
						<td>
							<input type="text" name="memberId" id="memberId" style="width: 230px;" required>
							<input type="button" value="ID 중복확인" id="idCheckBtn" onclick="checkId()">
						</td>
					</tr>
					<tr>
						<th>이메일 *</th>
						<td>
							<input type="text" name="emailId" id="emailId" style="width: 90px;" required>
							@ 
							<input type="text" name="emailDomain" id="emailDomain" style="width:90px;" required>
							<input type="button" value="이메일 인증" id="emailCheckBtn">
							<select id="emailSelect" style="margin-left:32px;">
								<option value="">직접입력</option>
								<option value="gmail.com">gmail.com</option>
								<option value="naver.com">naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="nate.com">nate.com</option>
							</select>
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
							<input type="text" name="memberNick" id="memberNick" style="width:320px;" placeholder="다른 사용자에게 보여줄 닉네임을 입력하세요."><br>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<div style="margin-bottom: 10px">
								<input type="text" id="sample4_postcode" name="addressNo" style="width:200px;" placeholder="우편번호">
								<input type="button" id="postcodeFindBtn"  value="우편번호 찾기"><br>
							</div>
							<div>
								<input type="text" id="sample4_roadAddress" name="addressRoad" placeholder="도로명주소" style="width: 320px;">
								<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소" style="width: 300px;"> -->
								<span id="guide" style="color: #999; display: none"></span>
								<input type="text" id="sample4_detailAddress" name="addressDetail" placeholder="상세주소" style="width: 320px;">
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
				<div id="agree-button">
					<div id="canclediv">
						<input type="reset" id="cancle" style="cursor: pointer; height:50px; border:none;" value="메인으로">
					</div>
					<div id="joindiv">
						<input type="submit" style="cursor: pointer; height:50px; background-color:#fffadd; border:none;" value="회원가입">
					</div>
				</div>
			</form>
		</section>
			</div>	
		</div>
		<!-- wrap 태그 종료 -->
	</div>
<script>
//서블릿에서 유효성 검사 후 알람 띄우기
	<c:if test="${errorMessage != null}">
		alert('${errorMessage}');
	</c:if>
	//메인으로 버튼 클릭시 메인페이지로 이동
	$("#cancle").click(function() {
		location.assign("${path}/home");
	});
	//로고 버튼 클릭시 메인페이지로 이동
	$(".logo-container").click(function() {
		location.assign("${path}");
	});
</script>
<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<!-- 8. 공통 JavaScript -->
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
</body>
</html>
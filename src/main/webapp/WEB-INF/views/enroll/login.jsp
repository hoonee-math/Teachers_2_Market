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
	#login-main-container {
		display : flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		min-height: 90vh;
		padding: 20px;
	}
	#login-container{
		cursor: pointer;
	}
	#main-content {
		margin-top:30px;
		margin-left:0px;
		background: #fff;
	    padding: 45px 30px;
	    border-radius: 30px;
	    box-shadow: 0 8px 12px rgba(0, 0, 0, 0.3);
	    width: 550px;
	    height:600px;
	    text-align: center;
	}
	#login-inner-container {
		display: flex;
		flex-direction: column;
		gap:10px;
		width: 100%;
	}
	#login-font {
		font-family:Sans-serif;
		font-style: italic;
		font-size: 40px;
		color : grey;
	}
	#login-id, #login-pw {
		width: 60%;
	    padding: 12px;
	    border: 2px solid #cccccc;
	    border-radius: 8px;
	    font-size: 16px;
	    outline: none;
	}
	#login-btn {
		margin-top:60px;
		color:#6f6f6f;
	}
	#login-btn, #login-find {
		background-color: #fffadd;
		width: 60%;
	    padding: 12px;
	    border:none;
	    color:#6f6f6f;
	}
	#login-join {
		text-decoration:none;
		color:#6f6f6f;
	}
    </style>
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">	
<!-- 메인 콘텐츠 -->
<main class="main">
	<div id="login-main-container">
		<div id="login-container">
			<img src="${path}/resources/images/logo(NoBackGround).png" style="width:150px; height:150px;">
		</div>
		<!-- 콘텐츠 영역 -->
		<div id="main-content">
			<section class="row main-section">
				<!-- 섹션 1 -->
				<div id="login-inner-container">
					<div><p id="login-font">Login</p></div>
					<div><input type="text" id="login-id" name="memberId" placeholder="아이디"></div>
					<div><input type="password" id="login-pw" name="memberPw" placeholder="비밀번호"></div>
					<div><input type="button" id="login-btn" value="로그인"></div>
					<div><input type="button" id="login-find" value="ID/PW찾기"></div>
					<div><a href="${path}/member/enroll/termsofservice" id="login-join">회원가입</a></div>
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
	$("#login-container").click(function () {
		location.assign("${path}");
	});
	
    // 로그인 버튼 클릭 시
    $("#login-btn").click(function() {
        // 입력값 가져오기
        const memberId = $("#login-id").val();
        const memberPw = $("#login-pw").val();
        
        // 폼 동적 생성 및 전송
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${path}/member/login.do';
        
        const idField = document.createElement('input');
        idField.type = 'hidden';
        idField.name = 'memberId';
        idField.value = memberId;
        
        const pwField = document.createElement('input');
        pwField.type = 'hidden';
        pwField.name = 'memberPw';
        pwField.value = memberPw;
        
        form.appendChild(idField);
        form.appendChild(pwField);
        document.body.appendChild(form);
        form.submit();
    });

    // ID/PW 찾기 버튼 클릭 시
    $("#login-find").click(function() {
        // ID/PW 찾기 페이지로 이동
        location.assign("${path}/member/findIdPw");  // 실제 경로로 수정 필요
    });
</script>
</body>
</html>
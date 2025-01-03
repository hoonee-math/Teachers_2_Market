<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="${path }/resources/images/favicon.jpeg">
<title>티꿀모아</title>

<!-- CSS 파일 연결 -->
<link rel="stylesheet" href="${path }/resources/css/common/layout.css">
<link rel="stylesheet"
	href="${path }/resources/css/enroll/enrollMember.css">
<link rel="stylesheet"
	href="${path }/resources/css/enroll/termsofservice.css">
<link rel="stylesheet" href="${path }/resources/css/common/footer.css">
<!-- 스크립트 연결 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${path}/resources/js/enroll/enrollMember.js"></script>
<script src="${path}/resources/js/enroll/enrollendMember.js"></script>
<style>
/* 입력 필드 스타일 추가 */
button, input, select, textarea {
	margin: 0;
	padding: 0;
}

button, input, select, td, textarea, th {
	font-size: 14px;
	line-height: 1.5;
	font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
	color: #222;
}

/* 배경 색상 그라데이션 적용 */
body {
	background-color: #fffadd;
	background: linear-gradient(to right, #fffadd, #ffffff);
	margin: 0;
}

/* 메인 컨테이너 스타일 */
#enroll-main-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: auto;
	min-height: 900px;
	padding: 40px 20px;
}

/* 콘텐츠 영역 스타일 */
.main-content {
	margin-top: 0px;
	background: #fff;
	padding: 45px 30px;
	border-radius: 30px;
	box-shadow: 0 8px 12px rgba(0, 0, 0, 0.3);
	width: 600px;
	height: auto;
	text-align: center;
}

/* 로고와 텍스트 헤더 스타일 */
#enroll-inner-header {
	display: flex;
	justify-content: center;
	align-items: center;
}

#login-font {
	font-family: Sans-serif;
	font-style: italic;
	font-size: 40px;
	color: grey;
}

/* 섹션 스타일 */
.main-section {
	display: flex;
	flex-direction: column;
}

/* 버튼 컨테이너 스타일 */
#agree-button {
	display: flex;
	justify-content: center;
	margin-top: 20px;
	padding: 20px;
	gap: 30px;
}

#enroll-inner-header {
	gap: 30px;
}

table {
	width: 100%;
	border-spacing: 0;
	margin: 20px 0;
}

td {
	padding: 15px;
	text-align: left;
	border-bottom: 1px solid #ddd;
	vertical-align: initial;
}

th {
	width: 150px;
	font-weight: normal;
	vertical-align: initial;
}

/* input 관련 스타일 수정 */
input[type="text"], input[type="password"] {
	padding: 8px;
	border: 2px solid rgb(192, 192, 192);
	border-radius: 4px;
	background-color: #F9F9F9;
}

/* select 스타일 추가 */
select {
	padding: 6px 12px 11px 12px;
	border: 2px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
	margin-left: 5px;
	cursor: pointer;
	background-color: #F9F9F9;
}

input[type="radio"] {
	margin-right: 5px;
	margin-left: 15px;
}

input[type="radio"]:first-child {
	margin-left: 0;
}

/* 학교/학원 선택 셀렉트 박스 스타일 */
.school-name select {
	margin-right: 10px;
	width: 150px;
}

.school-check-btn {
	padding: 6px 12px;
	background-color: #F9F9F9;
	border: 2px solid #ddd;
	border-radius: 4px;
	cursor: pointer;
}
</style>
</head>
<body>
	<div id="wrap">
		<div id="enroll-main-container">
			<div class="main-content">
				<section class="row main-section">
					<!-- 로고와 Join 텍스트 -->
					<div id="enroll-inner-header">
						<img class="logo-container"
							src="${path}/resources/images/favicon.jpeg"
							style="width: 60px; height: 60px;">
						<p id="login-font">회원 정보 입력</p>
						<img class="logo-container"
							src="${path}/resources/images/favicon.jpeg"
							style="width: 60px; height: 60px;">
					</div>

					<!-- 회원가입 폼 -->
					<form action="${path}/member/enrollend" method="post"
						onsubmit="return fn_invalidate();">
						<input type="hidden" name="idCheckYN" value="N">
   						<input type="hidden" name="emailVerified" value="N">
						<table>
							<tr>
								<th>이름 입력 *</th>
								<td><input type="text" id="memberName" name="memberName"
									style="width: 230px;" required></td>
							</tr>
							<tr>
								<th>아이디 *</th>
								<td><input type="text" name="memberId" id="memberId"
									style="width: 230px;" required> <input type="button"
									value="ID 중복확인" id="idCheckBtn" onclick="checkId()"></td>
							</tr>
							<tr>
								<th>이메일 *</th>
								<td><input type="text" name="emailId" id="emailId"
									style="width: 90px;" required> @ <input type="text"
									name="emailDomain" id="emailDomain" style="width: 90px;"
									required> <input type="button" value="이메일 인증"
									id="emailCheckBtn"> <!-- margin-left 값을 32px에서 더 늘려서 조정 -->
									<select id="emailSelect" style="margin-left: 130px;">
										<option value="">직접입력</option>
										<option value="gmail.com">gmail.com</option>
										<option value="naver.com">naver.com</option>
										<option value="daum.net">daum.net</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="nate.com">nate.com</option>
								</select></td>
							</tr>
							<tr>
								<th>패스워드 *</th>
								<td><input type="password" name="memberPw" id="password_"
									placeholder="대소문자, 숫자, 특수문자 포함" required><br></td>
							</tr>
							<tr>
								<th>패스워드확인 *</th>
								<td><input type="password" id="password_2" required><br>
									<span id="checkResult"></span></td>
							</tr>
							<tr>
								<th>닉네임</th>
								<td><input type="text" name="memberNick" id="memberNick"
									style="width: 320px;" placeholder="다른 사용자에게 보여줄 닉네임을 입력하세요."><br>
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<div style="margin-bottom: 10px">
										<input type="text" id="sample4_postcode" name="addressNo"
											style="width: 200px;" placeholder="우편번호"> <input
											type="button" id="postcodeFindBtn" value="우편번호 찾기"><br>
									</div>
									<div>
										<input type="text" id="sample4_roadAddress" name="addressRoad"
											placeholder="도로명주소"
											style="width: 320px; margin-bottom: 10px;"> <span
											id="guide" style="color: #999; display: none"></span> <input
											type="text" id="sample4_detailAddress" name="addressDetail"
											placeholder="상세주소" style="width: 320px;">
									</div>
								</td>
							</tr>
							<tr>
								<th>회원구분 *</th>
								<td><input type="radio" name="eduType" id="school"
									value="1" checked> <label for="school">학교 교사</label> <input
									type="radio" name="eduType" id="institute" value="2"> <label
									for="institute">학원 강사</label></td>
							</tr>
							<tr class="school-name">
								<th>학교/학원 이름 *</th>
								<td>
									<!-- 학교 선택용 select 그룹 -->
									<div id="school-select-group">
										<select name="region" id="region"
											onchange="districtSearch(event);">
											<option value="">지역 선택</option>
										</select> <select name="district" id="district"
											onchange="schoolSearch(event);">
											<option value="">구/군 선택</option>
										</select> <select name="schoolNo" id="school-name" required>
											<option value="">학교명</option>
										</select> <input type="button" value="확인" class="school-check-btn">
									</div> <!-- 학원명 입력용 input -->
									<div id="academy-input-group" style="display: none;">
										<input type="text" name="academyName" id="academyName"
											style="width: 320px;" placeholder="학원명을 입력하세요">
									</div>
								</td>
							</tr>
						</table>
						<div id="agree-button">
							<div id="canclediv">
								<input type="reset" id="cancle"
									style="cursor: pointer; height: 50px; border: none;"
									value="메인으로">
							</div>
							<div id="joindiv">
								<input type="submit"
									style="cursor: pointer; height: 50px; background-color: #fffadd; border: none;"
									value="회원가입">
							</div>
						</div>
					</form>
				</section>
			</div>
		</div>
		<!-- 푸터 include -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
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
$('input[name="eduType"]').on('change', function() {
    const selectedType = $(this).val();
    const schoolSelectGroup = $('#school-select-group');
    const academyInputGroup = $('#academy-input-group');
    
    if(selectedType === '1') {  // 학교 선택 시
        // 학교 선택 그룹 표시, 학원 입력 숨김
        schoolSelectGroup.show();
        academyInputGroup.hide();
        // 학교 선택 필드 초기화
        $('#school-name').html('<option value="">학교명</option>');
    } else {  // 학원 선택 시
        // 학교 선택 그룹 숨김, 학원 입력 표시
        schoolSelectGroup.hide();
        academyInputGroup.show();
        // 학원명 입력 필드 초기화
        $('#academyName').val('');
    }
});
</script>
</body>
</html>
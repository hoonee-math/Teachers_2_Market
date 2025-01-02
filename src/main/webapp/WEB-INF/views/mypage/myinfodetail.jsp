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
     <link rel="stylesheet" href="${path }/resources/css/board/purchaseHistory.css">
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
    <!-- 7. 내부 style 태그 -->
    <style>
    /* 입력 필드 스타일 추가 */
    button, input, select, textarea {
        margin: 0;
        padding: 0;
    }
    
    button, input, select, td, textarea, th {
        font-size: 14px;
        line-height: 1.5;
        width: 90px;
        font-family: 'Malgun Gothic','맑은 고딕',sans-serif;
        color: #222;
    }
    
    /* 메인 컨테이너 스타일 */
    #enroll-main-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: auto;
        min-height: 900px;
        padding: 0px;
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
    table {
    width: 100%;
    border-spacing: 0;
    margin: 20px 0;
	}
	
	th, td {
	    padding: 15px;
	    text-align: left;
	    border-bottom: 1px solid #ddd;
	}
	
	th {
	    width: 150px;
	    font-weight: normal;
	}
	
	/* input 관련 스타일 수정 */
	input[type="text"],
	input[type="password"] {
	    padding: 8px;
	    border: 2px solid rgb(192, 192, 192);
	    border-radius: 4px;
	    background-color: #F9F9F9;
	    width:250px;
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
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 헤더 include -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<!-- 메인 콘텐츠 -->
<main class="main">
    <div class="main-container">
        <!-- sidebar include는 유지 -->
        <jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
        
        <!-- 콘텐츠 영역 수정 -->
        <div id="enroll-main-container">
        <p><img width="20px" src="${path}/resources/images/board/folder.png"> 내정보 수정</p>
            <div class="main-content">
                <section class="row main-section">
                    <!-- enrollmain.jsp와 동일한 form -->
                    <form action="${path}/member/update" method="post" onsubmit="return fn_invalidate2();">
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
                                    <select id="emailSelect" style="margin-left:90px;">
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
                                        <span id="guide" style="color: #999; display: none"></span>
                                        <input type="text" id="sample4_detailAddress" name="addressDetail" placeholder="상세주소" style="width: 320px;">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>회원구분 *</th>
                                <td>
                                    <input type="radio" name="eduType" id="school" value="1" checked>
                                    <label for="school">학교 교사</label>
                                    <input type="radio" name="eduType" id="institute" value="2">
                                    <label for="institute">학원 강사</label>
                                </td>
                            </tr>
                            <tr class="school-name">
                                <th>학교/학원 이름 *</th>
                                <td>
                                    <select name="region" id="region" onchange="districtSearch(event);">
                                        <option value="">지역 선택</option>
                                    </select>
                                    <select name="district" id="district" onchange="schoolSearch(event);">
                                        <option value="">구/군 선택</option>
                                    </select>
                                    <select name="schoolNo" id="school-name" required>
                                        <option value="">학교명</option>
                                    </select>
                                    <input type="button" value="확인" class="school-check-btn">
                                </td>
                            </tr>
                        </table>
                        <div id="agree-button">
                            <div id="canclediv">
                                <input type="reset" id="cancle" style="cursor: pointer; height:50px; border:none;" value="메인으로">
                            </div>
                            <div id="saveiv">
                                <input type="submit" style="cursor: pointer; height:50px; background-color:#fffadd; border:none;" value="저장">
                            </div>
                        </div>
                    </form>
                </section>
            </div>
        </div>
    </div>
</main>
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
<!-- wrap 태그 종료 -->
</div>

<!-- 8. 공통 JavaScript -->
<!-- 9. API/Ajax 관련 JavaScript -->
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
</body>
</html>
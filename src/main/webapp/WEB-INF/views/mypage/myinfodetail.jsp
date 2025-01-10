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
<link rel="stylesheet" href="${path }/resources/css/enroll/enrollMember.css">
<link rel="stylesheet" href="${path }/resources/css/enroll/termsofservice.css">
<!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
<!-- js코드 연결 -->
<script src="${path}/resources/js/enroll/enrollMember.js"></script>
<!-- 7. 내부 style 태그 -->
<style>
/* 입력 필드 스타일 추가 */
</style>
</head>
<body>
	<!-- 콘텐츠 영역 -->
	<div id="wrap">
		<!-- 헤더 include -->
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<!-- 메인 콘텐츠 -->
		<main class="main">
			<div class="main-container">
				<!-- sidebar include -->
				<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

				<div class="main-content">
					<p>
						<img width="20px" src="${path}/resources/images/common/profile.png">
						회원 정보 수정
					</p>
					<div id="main-box">
						<section id="mainsection">
							<!-- 회원가입 폼 -->
							<form action="${path}/member/enroll" method="post"
								onsubmit="return fn_invalidate();">
								<!-- form 태그 내부의 table 부분을 다음과 같이 완성합니다 -->
								<table>
									<tr>
										<th>이름 *</th>
										<td>
											<input type="text" id="memberName" name="memberName" value=${loginMember.memberName } style="width: 230px;" readOnly>
										</td>
									</tr>
									<tr>
										<th>아이디 *</th>
										<td>
											<input type="text" name="memberId" id="memberId" value="${loginMember.memberId }"style="width: 230px;" readOnly>
										</td>
									</tr>
									<tr>
										<th>이메일</th>
										<td>
											<input type="text" name="emailId" id="emailId" value="${loginMember.email}" style="width: 230px;" readonly> 
										</td>
									</tr>
									<tr>
										<th>패스워드</th>
										<td>
											<input type="password" name="memberPw" id="password_" placeholder="대소문자, 숫자, 특수문자 포함" required><br>
										</td>
									</tr>
									<tr>
										<th>패스워드확인</th>
										<td>
											<input type="password" id="password_2" required><br>
											<span id="checkResult"></span>
										</td>
									</tr>
									<tr>
										<th>전화번호</th>
										<td><input type="text" name="phone" id="phone" value="${loginMember.phone}" placeholder="예)01055556666"><br>
										</td>
									</tr>
									<tr>
										<th>주소</th>
										<td>
											<div style="margin-bottom:10px">
											<input type="text" id="sample4_postcode" name="addressNo" style="width:200px;" value="${addressNo != null ? addressNo : ''}" placeholder="우편번호">
											<input type="button" id="postcodeFindBtn" value="우편번호 찾기"><br>
											</div>
											<div>
											<input type="text" id="sample4_roadAddress" name="addressRoad" value="${addressRoad != null ? addressRoad : ''}" placeholder="도로명주소" style="width:200px;">
											<span id="guide" style="color:#999;display:none"></span>
											<input type="text" id="sample4_detailAddress" name="addressDetail" value="${addressDetail != null ? addressDetail : ''}" placeholder="상세주소" style="width: 200px;">
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
											value="정보수정">
									</div>
								</div>
							</form>
						</section>


					</div>
				</div>
			</div>
		</main>

		<!-- 푸터 include -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		<!-- wrap 태그 종료 -->
	</div>
<script>
	//DOM이(페이지가) 로드되면 이벤트 리스너 초기화
	$(document).ready(function() {
	    initializeEventListeners();
	    initializeFormValidation();
	});
	
	/**
	 * 기본 이벤트 리스너 초기화 함수
	 */
	function initializeEventListeners() {
	    // 로고 클릭시 메인으로 이동
	    $(".logo-container").off("click").click(() => location.assign(contextPath));
	    
		// 비밀번호 일치여부 확인 이벤트
		$("#password_2").off("keyup").keyup(validatePasswordMatch);
	    
	    // 주소 검색 이벤트
	    $("#postcodeFindBtn").off("click").click(sample4_execDaumPostcode);
	}
	
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

	// 우편번호 검색
	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            const roadAddr = data.roadAddress;
	            let extraRoadAddr = '';

	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
	                extraRoadAddr += data.bname;
	            }
	            if(data.buildingName !== '' && data.apartment === 'Y') {
	                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            
	            // 우편번호와 주소 정보 입력
	            $("#sample4_postcode").val(data.zonecode);
	            $("#sample4_roadAddress").val(roadAddr);
	            $("#sample4_detailAddress").val('');

	            // 안내 텍스트 처리
	            const $guide = $("#guide");
	            if(data.autoRoadAddress) {
	                $guide.html('(예상 도로명 주소 : ' + data.autoRoadAddress + extraRoadAddr + ')').show();
	            } else {
	                $guide.html('').hide();
	            }
	        }
	    }).open();
	}
</script>
	<!-- 8. 공통 JavaScript -->
	<!-- 9. API/Ajax 관련 JavaScript -->
	<!-- 10. 컴포넌트 JavaScript -->
	<!-- 11. 페이지별 JavaScript -->
</body>
</html>
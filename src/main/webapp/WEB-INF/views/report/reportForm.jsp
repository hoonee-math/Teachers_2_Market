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
	<title>신고하기</title>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
	<style>
		body {
			font-family: Arial, sans-serif;
			padding: 20px;
			margin: 0;
			background-color: #f8f9fa;
		}
		.report-container {
			background-color: white;
			padding: 20px;
			border-radius: 5px;
			box-shadow: 0 0 10px rgba(0,0,0,0.1);
		}
		.report-post-info {
			background-color: #fff6c2;
			padding: 15px;
			margin: 15px 0;
			border-radius: 5px;
		}
		.form-group {
			margin-bottom: 15px;
		}
		.form-group label {
			display: block;
			margin-bottom: 5px;
			font-weight: bold;
		}
		.form-group select,
		.form-group textarea {
			width: 100%;
			padding: 8px;
			border: 1px solid #ddd;
			border-radius: 4px;
			box-sizing: border-box;
		}
		.form-group textarea {
			height: 100px;
			resize: vertical;
		}
		.form-buttons {
			text-align: center;
			margin-top: 20px;
		}
		.submit-btn,
		.cancel-btn {
			padding: 8px 20px;
			margin: 0 5px;
			border: none;
			border-radius: 4px;
			cursor: pointer;
		}
		.submit-btn {
			background-color: #dc3545;
			color: white;
		}
		.cancel-btn {
			background-color: #6c757d;
			color: white;
		}
	</style>
</head>

<body>

	<div class="report-container">
		<h3>신고하기</h3>
		<!-- 신고 대상 게시글 정보 요약 -->
		<div class="report-post-info">
			<%-- UI 개발용 테스트 데이터 --%>
			<c:if test="${empty post}">
				<p><strong>게시글 제목:</strong> [테스트] 중고 교과서 판매합니다</p>
				<p><strong>작성자:</strong> 테스트사용자</p>
			</c:if>
			<c:if test="${not empty post}">
				<p><strong>게시글 제목:</strong> ${post.postTitle}</p>
				<p><strong>작성자:</strong> ${post.memberName}</p>
			</c:if>
		</div>
		<form id="reportForm" method="post">
			<!-- 히든 필드: 신고 관련 기본 정보 (UI 개발용 테스트 데이터) -->
			<input type="hidden" name="postNo" value="${empty post ? '1' : post.postNo}">
			<input type="hidden" name="reportedNo" value="${empty post ? '1' : post.memberNo}">
			<input type="hidden" name="authorNo" value="${empty sessionScope.loginMember ? '2' : sessionScope.loginMember.memberNo}">
			
			<!-- 신고 유형 선택 -->
			<div class="form-group">
				<label for="reportType">신고 유형</label>
				<select name="reportTypeNo" id="reportType" required>
					<option value="">신고 유형을 선택하세요</option>
					<option value="1">부적절한 내용</option>
					<option value="2">사기 의심</option>
					<option value="3">전문판매업자 의심</option>
					<option value="4">거래 중 분쟁 발생</option>
				</select>
			</div>
			
			<!-- 신고 내용 -->
			<div class="form-group">
				<label for="reportContent">신고 내용</label>
				<textarea name="reportContent" id="reportContent" 
					placeholder="구체적인 신고 사유를 작성해주세요." required></textarea>
			</div>
			
			<div class="form-buttons">
				<button type="submit" class="submit-btn">신고하기</button>
				<button type="button" class="cancel-btn" onclick="window.close();">취소</button>
			</div>
		</form>
	</div>

	<script>	
	$(document).ready(function() {
		$("#reportForm").submit(function(e) {
			e.preventDefault();
			
			// UI 테스트용 - 실제 AJAX 호출 대신 alert로 대체
			alert("신고가 접수되었습니다.");
			window.close();
			// opener.location.reload(); // 실제 운영시에는 필요할 수 있음
			
			// 실제 운영 코드는 주석처리
			$.ajax({
				url: "${path}/report/submit",
				type: "POST",
				data: $(this).serialize(),
				success: function(response) {
					if(response.success) {
						alert("신고가 접수되었습니다.");
						window.close();
						opener.location.reload();
					} else {
						alert("신고 접수에 실패했습니다. " + response.message);
					}
				},
				error: function() {
					alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
				}
			});
			
		});
	});
	</script>

</body>

</html>
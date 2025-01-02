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
    <link rel="stylesheet" href="${path }/resources/css/board/boardList.css">
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
    <!-- 7. 내부 style 태그 -->
	<style>
	/* 게시글 관리 페이지 스타일 */
	.mp-container {
		background-color: white;
		border-radius: 10px;
	}
	
	.mp-header {
		padding: 20px;
	}
	
	.mp-control-bar {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 15px 20px;
		background: #f8f9fa;
		border-radius: 5px;
	}
	
	.mp-actions button {
		padding: 5px 10px;
		border: 1px solid #ddd;
		border-radius: 4px;
		background: white;
		cursor: pointer;
		margin-right: 5px;
	}
	
	.mp-search-sort {
		display: flex;
		gap: 10px;
	}
	
	.mp-search-sort select, .mp-search-sort input {
		padding: 5px;
		border: 1px solid #ddd;
		border-radius: 4px;
	}
	
	.mp-table {
		width: 100%;
		border-collapse: collapse;
	}
	
	.mp-table th {
		background-color: #fff6c2;
		padding: 12px;
		text-align: center;
		border-top: 1px solid #ddd;
		border-bottom: 1px solid #ddd;
	}
	
	.mp-table td {
		padding: 12px;
		text-align: center;
		border-bottom: 1px solid #ddd;
	}
	
	.mp-table tr:hover {
		background-color: #f5f5f5;
	}
	
	.mp-checkbox-cell {
		width: 30px;
	}
	
	.mp-status {
		padding: 3px 8px;
		border-radius: 12px;
		font-size: 12px;
	}
	
	.mp-status-active {
		background-color: #e8f5e9;
		color: #2e7d32;
	}
	
	.mp-status-deleted {
		background-color: #ffebee;
		color: #c62828;
	}
	
	.mp-post-type {
		padding: 3px 8px;
		border-radius: 12px;
		font-size: 12px;
	}
	
	.mp-type-product {
		background-color: #e3f2fd;
		color: #1565c0;
	}
	
	.mp-type-file {
		background-color: #f3e5f5;
		color: #6a1b9a;
	}
	</style>
	
	<style>
	/* 페이징 스타일 */
	#pageBar {
		margin-top: 20px;
		display: flex;
		justify-content: center;
	}
	
	.pagination {
		list-style-type: none;
		display: flex;
		align-items: center;
		justify-content: center;
		background-color: #fffadd;
		padding: 10px;
	}
	
	.page-item {
		margin: 0 10px;
		font-size: 13pt;
	}
	
	.page-link {
		padding: 10px;
		text-decoration: none;
		color: #6f6f6f;
		background-color: #fffadd;
		width: 50px;
		height: 50px;
	}
	
	.page-link:hover {
		background-color: white;
		border-radius: 50%;
		font-size: larger;
		font-weight: bold;
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
		<div class="main-content mp-container">
			<div class="mp-header">
				<h2>게시글 관리</h2>
				<hr style="border: 2px solid #fff6c2;">
				<p>게시글을 검토하고 관리할 수 있는 페이지입니다.</p>
			</div>

			<!-- 컨트롤 바 -->
			<div class="mp-control-bar">
				<div class="mp-actions">
					<button onclick="handleSelectedPosts('hide')">숨김처리</button>
					<button onclick="handleSelectedPosts('delete')">삭제</button>
					<button onclick="handleSelectedPosts('restore')">복원</button>
				</div>

				<div class="mp-search-sort">
				
					<select id="postType" onchange="filterPosts()">
						<option value="0">전체</option>
   						<option value="1" ${postType == '1' ? 'selected' : ''}>상품</option>
						<option value="2" ${postType == '2' ? 'selected' : ''}>파일</option>
					</select>
					<select id="categoryNo" onchange="filterPosts()">
						<option value="0">전체 카테고리</option>
						<option value="1" ${categoryNo == '1' ? 'selected' : ''}>미취학아동</option>
						<option value="2" ${categoryNo == '2' ? 'selected' : ''}>초등</option>
						<option value="3" ${categoryNo == '3' ? 'selected' : ''}>중등</option>
						<option value="4" ${categoryNo == '4' ? 'selected' : ''}>고등</option>
						<option value="5" ${categoryNo == '5' ? 'selected' : ''}>수험생</option>
					</select>
					
					<input type="text" id="searchKeyword" placeholder="검색어 입력">
					<button onclick="searchPosts()">검색</button>
				</div>
			</div>

			<!-- 게시글 목록 테이블 -->
			<table class="mp-table">
				<colgroup>
					<col style="width: 30px;"> <!-- 체크박스 -->
					<col style="width: 60px;"> <!-- 번호 -->
					<col style="width: 80px;"> <!-- 유형 -->
					<col style="width: 90px;"> <!-- 카테고리 -->
					<col> <!-- 제목 -->
					<col style="width: 100px;"> <!-- 작성자 -->
					<col style="width: 80px;"> <!-- 조회수 -->
					<col style="width: 120px;"> <!-- 작성일 -->
					<col style="width: 70px;"> <!-- 상태 -->
				</colgroup>
				<thead>
					<tr>
						<th>
							<input type="checkbox" id="selectAll" onclick="toggleAllCheckboxes()">
						</th>
						<th>번호</th>
						<th>유형</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="post" items="${posts}">
						<tr>
							<td class="mp-checkbox-cell">
								<input type="checkbox" name="selectedPosts" value="${post.postNo}">
							</td>
							<td>${post.postNo}</td>
							<td>
								<span class="mp-post-type ${post.productType == 1 ? 'mp-type-product' : 'mp-type-file'}">
									${post.productType == 1 ? '상품' : '파일'} 
								</span>
							</td>
							<td>
								<c:choose>
									<c:when test="${post.categoryNo == 1}">미취학</c:when>
									<c:when test="${post.categoryNo == 2}">초등</c:when>
									<c:when test="${post.categoryNo == 3}">중등</c:when>
									<c:when test="${post.categoryNo == 4}">고등</c:when>
									<c:when test="${post.categoryNo == 5}">수험생</c:when>
								</c:choose>
							</td>
							<td style="text-align: left;">${post.postTitle}</td>
							<td>${post.member.memberNick}</td>
							<td>${post.viewCount}</td>
							<td><fmt:formatDate value="${post.postDate}" pattern="yyyy-MM-dd" /></td>
							<td>
								<span class="mp-status ${post.isDeleted == 1 ? 'mp-status-deleted' : 'mp-status-active'}">
									${post.isDeleted == 1 ? '삭제' : '정상'}
								</span>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div id="pageBar">${pageBar}</div>
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
// 전체 체크박스 토글
function toggleAllCheckboxes() {
    const checkboxes = document.getElementsByName('selectedPosts');
    const selectAllCheckbox = document.getElementById('selectAll');
    checkboxes.forEach(checkbox => {
        checkbox.checked = selectAllCheckbox.checked;
    });
}

// 선택된 게시글 처리
function handleSelectedPosts(action) {
    const selectedPosts = Array.from(document.getElementsByName('selectedPosts'))
        .filter(checkbox => checkbox.checked)
        .map(checkbox => checkbox.value);
    
    if(selectedPosts.length === 0) {
        alert('선택된 게시글이 없습니다.');
        return;
    }
    
    let message;
    switch(action) {
        case 'hide':
            message = '선택된 게시글을 숨김 처리하시겠습니까?';
            break;
        case 'delete':
            message = '선택된 게시글을 삭제하시겠습니까?';
            break;
        case 'restore':
            message = '선택된 게시글을 복원하시겠습니까?';
            break;
    }
    
    if(confirm(message)) {
        // Ajax 요청 구현 예정
        $.ajax({
            url: '${path}/admin/posts/manage',
            method: 'POST',
            data: {
                action: action,
                postNos: selectedPosts
            },
            success: function(response) {
                alert('처리되었습니다.');
                location.reload();
            },
            error: function(xhr, status, error) {
                alert('처리 중 오류가 발생했습니다.');
            }
        });
    }
}

// 게시글 필터링
function filterPosts() {
    const postType = document.getElementById('postType').value;
    const categoryNo = document.getElementById('categoryNo').value;
    const keyword = document.getElementById('searchKeyword').value;
    
    location.href = `${path}/admin/manage/post?postType=\${postType}&categoryNo=\${categoryNo}&keyword=\${keyword}`;
}

// 게시글 검색
function searchPosts() {
    filterPosts(); // 검색도 필터링과 동일한 로직 사용
}
</script>
</body>
</html>
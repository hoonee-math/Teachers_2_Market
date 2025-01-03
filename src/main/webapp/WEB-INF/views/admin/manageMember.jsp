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
    <link rel="stylesheet" href="${path}/resources/css/board/boardList.css">
    <link rel="stylesheet" href="${path}/resources/css/admin/manageMember.css">
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
    <!-- 7. 내부 style 태그 -->
    <style>
		table {
			margin-top: 40px;
			table-layout: fixed;
			width: 100%;
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
		<div class="main-content">
			<!-- 섹션 1: 회원 목록이 출력되는 section -->
			<section class="main-section mm-container">
				<div>
					<div>
						<h2>회원 목록</h2>
						<hr style="border:2px solid #fff6c2;">
						<p>회원을 조회, 경고, 정지 등 관리할 수 있는 페이지 입니다.</p>
					</div>
				</div>
				
				<!-- 컨트롤 바 -->
                <div class="mm-control-bar">
                    <!-- 회원 관리 액션 -->
                    <div class="mm-actions">
                        <button onclick="handleSelectedMembers('warning')">경고</button>
                        <button onclick="handleSelectedMembers('suspend')">활동정지</button>
                        <button onclick="handleSelectedMembers('delete')">회원삭제</button>
                    </div>
                    
                    <!-- 검색 및 정렬 -->
                    <div class="mm-search-sort">
                        <select id="numPerPage" onchange="changeNumPerPage(this.value)">
                            <option value="5" ${param.numPerPage == 5 ? 'selected' : ''}>5명씩 보기</option>
                            <option value="10" ${param.numPerPage == 10 ? 'selected' : ''}>10명씩 보기</option>
                            <option value="20" ${param.numPerPage == 20 ? 'selected' : ''}>20명씩 보기</option>
                        </select>
                        <select id="sortBy" onchange="changeSortBy(this.value)">
                            <option value="memberNo">회원번호순</option>
                            <option value="warningCount">경고횟수순</option>
                            <option value="enrollDate">가입일순</option>
                        </select>
                        <input type="text" id="searchKeyword" placeholder="검색어 입력">
                        <button onclick="searchMembers()">검색</button>
                    </div>
                </div>
                
				<div id="board-container">
					<table id="tbl-board">
						<colgroup>
							<col style="width: 20px;">
							<col style="width: 50px;">
							<col style="width: 60px;">
							<col style="width: 60px;">
							<col style="width: 180px;">
							<col style="width: 60px;">
							<col style="width: 60px;">
							<col style="width: 60px;">
							<col style="width: 60px;">
							<col style="width: 30px;">
						</colgroup>
						<thead>
							<tr>
									<th class="checkbox-cell">
										<input type="checkbox" id="selectAll" onclick="toggleAllCheckboxes()">
									</th>
									<th>회원번호</th>
									<th>아이디</th>
									<th>이름</th>
									<th>이메일</th>
									<th>신고접수</th>
									<th>유효신고</th>
									<th>경고횟수</th>
									<th>가입일</th>
									<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty members }">
				            	<tr>
				            		<td colspan="8" style="text-align: center;">
				            			죄회된 결과가 없습니다.
				            		</td>
				            	</tr>
				            </c:if>
							<c:forEach var="m" items="${members }">
								<tr>
									<td class="checkbox-cell">
										<input type="checkbox" name="selectedMembers" value="${m.memberNo}" >
									</td>
									<td>${m.memberNo}</td>
									<td>${m.memberId}</td>
									<td>${m.memberName}</td>
									<td>${m.email}</td>
									<td class="warning-count">${m.reportCheckCount}</td>
									<td class="warning-count">${m.reportValidCount}</td>
									<td class="warning-count">${m.warningCount}</td>
									<td>
										<fmt:formatDate value="${m.enrollDate}" pattern="yyyy-MM-dd" />
									</td>
									<td>
										<c:choose>
										<c:when test="${m.isDeleted == 1}">탈퇴</c:when>
										<c:otherwise>정상</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
			
			        <div id="pageBar">
			        	${pageBar }
			        </div>
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
// 페이지 변경
function changePage(page) {
    const numPerPage = document.getElementById('numPerPage').value;
    const sortBy = document.getElementById('sortBy').value;
    const keyword = document.getElementById('searchKeyword').value;
    
    location.href = `${path}/admin/manage/member?cPage=\${page}&numPerPage=\${numPerPage}&sortBy=\${sortBy}&keyword=\${keyword}`;
}

// 페이지당 표시 개수 변경
function changeNumPerPage(num) {
    const sortBy = document.getElementById('sortBy').value;
    const keyword = document.getElementById('searchKeyword').value;
    
    location.href = `${path}/admin/manage/member?cPage=1&numPerPage=\${num}&sortBy=\${sortBy}&keyword=\${keyword}`;
}

// 정렬 기준 변경
function changeSortBy(sort) {
    const numPerPage = document.getElementById('numPerPage').value;
    const keyword = document.getElementById('searchKeyword').value;
    
    location.href = `${path}/admin/manage/member?cPage=1&numPerPage=\${numPerPage}&sortBy=\${sort}&keyword=\${keyword}`;
}

// 회원 검색
function searchMembers() {
    const numPerPage = document.getElementById('numPerPage').value;
    const sortBy = document.getElementById('sortBy').value;
    const keyword = document.getElementById('searchKeyword').value;
    
    location.href = `${path}/admin/manage/member?cPage=1&numPerPage=\${numPerPage}&sortBy=\${sortBy}&keyword=\${keyword}`;
}

// 전체 체크박스 토글
function toggleAllCheckboxes() {
    const checkboxes = document.getElementsByName('selectedMembers');
    const selectAllCheckbox = document.getElementById('selectAll');
    
    checkboxes.forEach(checkbox => {
        checkbox.checked = selectAllCheckbox.checked;
    });
}

// 선택된 회원 처리
function handleSelectedMembers(action) {
    const selectedMembers = Array.from(document.getElementsByName('selectedMembers'))
        .filter(checkbox => checkbox.checked)
        .map(checkbox => checkbox.value);
    
    if(selectedMembers.length === 0) {
        alert('선택된 회원이 없습니다.');
        return;
    }
    
    // 실제 구현 시에는 서버로 Ajax 요청
    let message;
    switch(action) {
        case 'warning':
            message = '선택된 회원들에게 경고를 부여하시겠습니까?';
            break;
        case 'suspend':
            message = '선택된 회원들의 활동을 정지시키겠습니까?';
            break;
        case 'delete':
            message = '선택된 회원들을 삭제하시겠습니까?';
            break;
    }
    
    if(confirm(message)) {
        // 추후 실제 Ajax 통신으로 대체
        console.log(`Action: ${action}, Selected members:`, selectedMembers);
        alert('처리되었습니다.');
    }
}
</script>
</body>
</html>
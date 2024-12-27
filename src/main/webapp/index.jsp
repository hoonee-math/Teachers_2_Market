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
	<link rel="stylesheet" href="${path }/resources/css/component/card.css">
    <!-- 4. 페이지별 CSS -->
    <!-- 5. 외부 라이브러리 ex: jQuery (Bootstrap JS가 jQuery에 의존하므로 먼저 로드) -->
    <!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
    <!-- 6. Bootstrap JS (jQuery 다음, 내부 스타일 전에) 또는 외부 라이브러리 -->
    <!-- 7. 내부 style 태그 -->
    <style>
    </style>
</head>
<body>
<!-- 콘텐츠 영역 -->
<div id="wrap">
<!-- 헤더 include -->>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<!-- 메인 콘텐츠 -->
<main class="main">
	<div class="main-container">
		<!-- sidebar include -->
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
        
		<!-- 콘텐츠 영역 -->
		<div class="main-content">
			<section class="row main-section">
				<!-- 섹션 1 -->
				<div class="main-banner" >
					<img
						src="${path }/resources/images/banner.png"
						alt="검색" width="100%">
				</div>
			</section>
			<section class="row card-section">
				<div id=card-container>
					<div id="card-img">
						<img width="150px" height="150px" src="${path }/resources/images/logo.jpeg">
					</div>
					<div id="card-content">
						<p>판매자명</p>
							<!-- 판매물품 제목은 10글자까지, 
								프론트 구현할 때 c:if 사용해서 10글자가 넘는 경우 9 글자까지 출력하고 뒤에 ...붙이기 
								ex) 하나둘셋넷다섯여섯...-->
						<p><strong>판매물품 제목</strong></p>
						<p>₩ 판매금액</p>
					</div>
				</div>
				<!-- 섹션 2 -->
			</section>
			<section class="row main-section">
				<!-- 섹션 3 -->
				<!-- 로그인 페이지로 이동 -->
				<a href="${path}/member/login">로그인 페이지로 이동</a>
				<a href="${path}/member/logincheck">약관동의 페이지로 이동</a>
			</section>
		</div>
	</div>
</main>

<!-- 푸터 include -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<!-- wrap 태그 종료 -->
</div>

<!-- 8. 공통 JavaScript -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 9. API/Ajax 관련 JavaScript -->
<script>// 카드 DOM 요소 생성 함수를 Promise를 반환하도록 수정
async function createCardElement(cardData) {
    // 이미지 로드를 위한 Promise 생성
    const loadImage = (src) => {
        return new Promise((resolve) => {
            const img = new Image();
            img.onload = () => resolve(img.src);
            img.src = src;
        });
    };

    // 이미지 로드 대기
    try {
        const imgSrc = await loadImage(cardData.imgSrc);
        return `
            <div id="card-container">
                <div id="card-img">
                    <img width="150px" height="150px" src="${imgSrc}" alt="상품이미지">
                </div>
                <div id="card-content">
                    <p>${cardData.sellerId}</p>
                    <p><strong>${cardData.title.length > 10 ? cardData.title.substring(0, 9) + '...' : cardData.title}</strong></p>
                    <p>₩ ${cardData.price.toLocaleString()}</p>
                </div>
            </div>
        `;
    } catch (error) {
        console.error('이미지 로드 실패:', error);
        return ''; // 이미지 로드 실패시 빈 문자열 반환
    }
}

// 메인 실행 코드도 async로 수정
document.addEventListener('DOMContentLoaded', async function() {
    const TOTAL_CARDS = 8; // 전체 카드 수
    const CARDS_PER_SECTION = 4; // 섹션당 카드 수
    
    // 기존의 정적 카드 섹션 삭제
    const existingCardSections = document.querySelectorAll('.card-section');
    existingCardSections.forEach(section => section.remove());
    
    // 더미데이터 생성
    const dummyData = generateDummyData(TOTAL_CARDS);
    
    // 필요한 섹션 수 계산
    const sectionCount = Math.ceil(TOTAL_CARDS / CARDS_PER_SECTION);
    
    // 메인 섹션 찾기
    const mainSection = document.querySelector('.main-section');
    
    // 섹션별로 카드 생성
    for(let i = 0; i < sectionCount; i++) {
        // 새로운 섹션 생성
        const newSection = document.createElement('section');
        newSection.className = 'row card-section';
            
        // 현재 섹션의 카드 데이터
        const sectionCards = dummyData.slice(i * CARDS_PER_SECTION, (i + 1) * CARDS_PER_SECTION);
        
        // 카드 요소들을 비동기적으로 생성
        const cardPromises = sectionCards.map(cardData => createCardElement(cardData));
        const cardElements = await Promise.all(cardPromises);
        
        // 생성된 카드들을 섹션에 추가
        newSection.innerHTML = cardElements.join('');
        
        // 메인 섹션 다음에 새로운 섹션 추가
        mainSection.after(newSection);
    }
    
    console.log('카드 섹션 생성 완료:', document.querySelectorAll('.card-section').length);
});

// 이미지 경로도 수정
function generateDummyData(count) {
    const dummyData = [];
    const words = ['수학', '과학', '영어', '국어', '한국사', '사회', '물리', '화학', '생물'];
    const types = ['문제집', '워크북', '교과서', '참고서', '요약노트'];
    
    for(let i = 0; i < count; i++) {
        const randomTitle = `${words[Math.floor(Math.random() * words.length)]} ${types[Math.floor(Math.random() * types.length)]}`;
        const price = Math.floor(Math.random() * 40000) + 10000;
        
        dummyData.push({
            sellerId: `판매자${i + 1}`,
            title: randomTitle,
            price: price,
            // 절대 경로로 이미지 경로 설정
            imgSrc: contextPath + '/resources/images/logo.jpeg'
        });
    }
    return dummyData;
}

</script>
<!-- 10. 컴포넌트 JavaScript -->
<!-- 11. 페이지별 JavaScript -->
</body>
</html>
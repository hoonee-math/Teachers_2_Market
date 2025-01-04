<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
	
	
<header class="header">
	<div class="header-container">
		<a href="${path }" id="home-btn">
			<img src="${path }/resources/images/common/logo.jpeg" alt="home으로">
		</a>
		<div class="search-container">		
			<div id="search-bar">
				<input type="text" placeholder="검색어를 입력해주세요." style="background-color:white;">
				<button onclick="search();">
					<img src="${path }/resources/images/common/search.png"
						alt="검색" width="25px" height="100%">
				</button>
			</div>
		</div>
		<!-- 로그인 하지 않은 회원 -->
		<c:if test="${sessionScope.loginMember == null }">
			<div class="login-container">
				<button id="login-btn">로그인/회원가입</button>
			</div>
		</c:if>
		<!-- 로그인한 회원 -->
		<c:if test="${sessionScope.loginMember != null }">
			<div class="personal-container">
				<input type="text" id="personal-name" value="${sessionScope.loginMember.memberId }" style="background-color:white;">
				<button id="personal-btn-write">글쓰기</button>
				<button id="personal-btn-logout">로그아웃</button>
				<button id="personal-btn-cart">
					<img width="30px" height="30px"
						src="${path }/resources/images/common/cart.png" />
				</button>
			</div>
		</c:if>
	</div>
</header>

<script>
	//로그인 버튼 연결 링크
	$("#login-btn").click(function() {
	    location.assign("${path}/member/login");
	});
	//글쓰기 버튼 연결 링크
	$("#personal-btn-write").click(function() {
	    location.assign("${path}/post/write/form");
	});
	//장바구니 버튼 연결 링크
	$('#personal-btn-cart').click(function() {
		location.assign("${path}/payment/shoppinglist");
	})
</script>

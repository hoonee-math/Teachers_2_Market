<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
	
	
<header class="header">
	<div class="header-container">
		<a href="#" id="home-btn">
			<img src="${path }/resources/images/logo.jpeg" alt="home으로">
		</a>
		<div class="search-container">		
			<div id="search-bar">
				<input type="text" placeholder="검색어를 입력해주세요.">
				<button onclick="search();">
					<img src="${path }/resources/images/search.png"
						alt="검색" width="25px" height="100%">
				</button>
			</div>
		</div>
		<div class="personal-container">
			<input type="text" id="personal-name" value="OOO님">
			<button id="personal-btn-write">글쓰기</button>
			<button id="personal-btn-logout">로그아웃</button>
			<button id="personal-btn-cart">
				<img width="30px" height="30px"
					src="${path }/resources/images/cart.png" />
			</button>
		</div>
	</div>
</header>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. JSP/JSTL 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
	
	
<header class="header">
	<div class="header-container">
		<a href="#" id="homeButton"> <img
			src="${path }/resources/images/logo.jpeg"
			alt="home으로">
		</a>
		<div class="search-bar">
			<input type="text" placeholder="검색어를 입력해주세요.">
			<button onclick="search();">
				<img
					src="https://img.icons8.com/?size=100&id=7695&format=png&color=cccccc"
					alt="검색" width="25px" height="100%">
			</button>
		</div>
		<div class="personal-container">
			<table id="personal-info">
				<tr rowspan="2">
					<td id="member-name" colspan="2">OOO님</td>
					<td>
						<button id="cart">
							<img width="30px" height="100%"
								src="https://img.icons8.com/?size=100&id=85080&format=png&color=6f6f6f" />
						</button>
					</td>
				</tr>
				<tr id="personal-btn">
					<td>
						<button id="write-btn">글쓰기</button>
					</td>
					<td>
						<button id="logout-btn">로그아웃</button>
					</td>
				</tr>
			</table>
		</div>
	</div>
</header>

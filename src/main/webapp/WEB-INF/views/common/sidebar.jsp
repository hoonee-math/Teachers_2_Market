<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="side-container" style="width:60px">
	<div class="container">
		<div class="side-button">
			<img src="${path }/resources/images/fire.png" alt="인기글" class="side-img-icon"/>
		</div>
		<div class="side-btn-text">인기글</div>
		<div class="side-button">
			<img src="${path }/resources/images/exam.png" alt="n수생" class="side-img-icon">
		</div>
		<div class="side-btn-text">n수생</div>
		<div class="side-button">
			<img src="${path }/resources/images/school.png" alt="고등" class="side-img-icon">
		</div>
		<div class="side-btn-text">고등</div>
		
		<div class="side-button">
				<img src="${path }/resources/images/school.png" alt="중등" class="side-img-icon">
		</div>
		<div class="side-btn-text">중등</div>
		<div class="side-button">
				<img src="${path }/resources/images/kid.png" alt="초등" class="side-img-icon">
		</div>
		<div class="side-btn-text">초등</div>
		<div class="side-button">
				<img src="${path }/resources/images/kid.png" alt="미취학" class="side-img-icon">
		</div>
		<div class="side-btn-text">미취학</div>
		<div class="side-button">
				<img src="${path }/resources/images/file.png" alt="내 자료실" class="side-img-icon">
		</div>
		<div class="side-btn-text">내 자료실</div>
	
	</div>
</div>
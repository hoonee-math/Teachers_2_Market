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
		<div class="side-btn-text" data-path="/board/mylibrary">내 자료실</div>
		<c:if test="${sessionScope.loginMember.memberId=='admin' }">
			<div class="side-button">
				<img src="${path }/resources/images/admin.png" alt="관리자 페이지" class="side-img-icon">
			</div>
			<div class="side-btn-text">관리자<br>페이지</div>
		</c:if>
		<!-- 개발 과정 중 확인용 버튼들, 개발 완료 후 삭제 -->
		<div class="side-button" data-path="/board/list"></div>
		<div class="side-btn-text">임시 게시판</div>
		
		<div class="side-button" data-path="/payment/shoppinglist"></div>
		<div class="side-btn-text">임시 장바구니</div>
		<div class="side-button" data-path="/admin/menu">
			<img src="${path }/resources/images/admin.png" alt="관리자 페이지" class="side-img-icon">
		</div>
		<div class="side-btn-text">임시 관리자메뉴</div>
	</div>
</div>

	<script>
	    // HTML5 History API를 사용한 URL 변경
		$('div.side-button').click(function() {
		    var categoryNo = $(this).data('category');
		    var post = $(this).data('post');
		    var path = $(this).data('path');
		    
		    if(categoryNo>=0){
			    // 페이지 이동
			    location.href = "${path}/board/list?categoryNo=" + categoryNo;
		    }
		    else if(post){
		    	location.href = "${path}" + post;
		    } else if(path){
		    	location.href = "${path}" + path;
		    }
		});
	</script>
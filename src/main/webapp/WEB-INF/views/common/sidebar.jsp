<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<div class="side-container" style="width:60px">
	<div class="container">
		
		<div class="side-button" data-category="5">
			<img src="${path }/resources/images/common/exam.png" alt="n수생" class="side-img-icon">
		</div>
		<div class="side-btn-text">n수생</div>
		
		<div class="side-button" data-category="4">
			<img src="${path }/resources/images/common/school.png" alt="고등" class="side-img-icon">
		</div>
		<div class="side-btn-text">고등</div>
		
		<div class="side-button" data-category="3">
			<img src="${path }/resources/images/common/school.png" alt="중등" class="side-img-icon">
		</div>
		<div class="side-btn-text">중등</div>
		
		<div class="side-button" data-category="2">
			<img src="${path }/resources/images/common/kid.png" alt="초등" class="side-img-icon">
		</div>
		<div class="side-btn-text">초등</div>
		
		<div class="side-button" data-category="1">
			<img src="${path }/resources/images/common/kid.png" alt="미취학" class="side-img-icon">
		</div>
		<div class="side-btn-text">미취학</div>
		
		<c:if test="${sessionScope.loginMember != null && sessionScope.loginMember.memberId != 'admin'}">
			<div class="side-button" data-path="/member/myinfo">
				<img src="${path }/resources/images/common/profile.png" alt="마이 페이지" class="side-img-icon">
			</div>
			<div class="side-btn-text">마이 페이지</div>
		</c:if>
		<c:if test="${sessionScope.loginMember.memberId=='admin' }">
			<div class="side-button" data-path="/admin/menu">
				<img src="${path }/resources/images/common/admin.png" alt="관리자 페이지" class="side-img-icon">
			</div>
			<div class="side-btn-text">관리자<br>페이지</div>
		</c:if>
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
			    location.href = "${path}/board/list?categoryNo=" + categoryNo + "&cPage=1";
		    }
		    else if(post){
		    	location.href = "${path}" + post;
		    } else if(path){
		    	location.href = "${path}" + path;
		    }
		});
	</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/sidebar.css">


    <div class="sidecontainer">
        <div class="container">
            <div class="category">
                <ul>
                    <li>
                        <a href="#" class="button">
                            <div class="icon-container">
                                <img src="${pageContext.request.contextPath }/resources/images/fire.png" alt="인기글" class="icon">
                            </div>
                        </a>
                        <div class="text">인기글</div>
                    </li>
                    <li>
                        <a href="#" class="button">
                            <div class="icon-container">
                                <img src="${pageContext.request.contextPath }/resources/images/exam.png" alt="n수생" class="icon">
                            </div>
                        </a>
                        <div class="text">n수생</div>
                    </li>
                    <li>
                        <a href="#" class="button">
                            <div class="icon-container">
                                <img src="${pageContext.request.contextPath }/resources/images/school.png" alt="고등" class="icon">
                            </div>
                        </a>
                        <div class="text">고등</div>
                    </li>
                    <li>
                        <a href="#" class="button">
                            <div class="icon-container">
                                <img src="${pageContext.request.contextPath }/resources/images/school.png" alt="중등" class="icon">
                            </div>
                        </a>
                        <div class="text">중등</div>
                    </li>
                    <li>
                        <a href="#" class="button">
                            <div class="icon-container">
                                <img src="${pageContext.request.contextPath }/resources/images/kid.png" alt="초등" class="icon">
                            </div>
                        </a>
                        <div class="text">초등</div>
                    </li>
                    <li>
                        <a href="#" class="button">
                            <div class="icon-container">
                                <img src="${pageContext.request.contextPath }/resources/images/kid.png" alt="미취학" class="icon">
                            </div>
                        </a>
                        <div class="text">미취학</div>
                    </li>
                    <li>
                        <a href="#" class="button">
                            <div class="icon-container">
                                <img src="${pageContext.request.contextPath }/resources/images/file.png" alt="내 자료실" class="icon">
                            </div>
                        </a>
                        <div class="text">내 자료실</div>
                    </li>
                </ul>
            </div>
        </div>
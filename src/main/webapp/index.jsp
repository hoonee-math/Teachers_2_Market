<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<c:set var="path" value="${pageContext.request.contextPath}" />

<button id="toTemplate">to template</button>
<script>
	$("#toTemplate").click(function() {
		location.assign("${path}/template");
	});
</script>











<style>
body {
    min-height: 100vh; /* 최소 높이를 뷰포트 높이로 설정 */
    display: flex;
    flex-direction: column;
}

footer {
    width: 100%;
    margin-top: auto; /* 컨텐츠가 적을 때 아래로 밀어줌 */
    padding: 20px;
    text-align: center;
    font-size: 14px;
    color: #6f6f6f;
    background-color: #fffadd;
    border-top: 1px solid #eee;
}

footer p {
    margin: 0;
}

*{
	border : 2px solid pink;
}
</style>

<footer>
	<p>© 2025 티꿀모아 | 이용 약관 | 개인정보 보호 정책 | 청소년 보호 정책</p>
</footer>
	

</body>
</html>



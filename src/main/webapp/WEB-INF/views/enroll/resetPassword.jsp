<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 재설정</title>
    <style>
        .password-reset-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #D9776A;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .submit-btn {
            width: 100%;
            padding: 10px;
            background-color: #D9776A;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #C0655D;
        }
    </style>
</head>
<body>
    <div class="password-reset-container">
        <h2>비밀번호 재설정</h2>
        <form id="resetPasswordForm" action="${path}/member/updatePassword.do" method="POST">
            <input type="hidden" name="email" value="${sessionScope.email}">
            <div class="form-group">
                <label for="newPassword">새 비밀번호</label>
                <input type="password" id="newPassword" name="memberPw" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" required>
            </div>
            <button type="submit" class="submit-btn">비밀번호 변경</button>
        </form>
    </div>

    <script>
        // 폼 제출 전 비밀번호 검증
        document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            // 비밀번호 일치 여부 확인
            if (newPassword !== confirmPassword) {
                alert('비밀번호가 일치하지 않습니다.');
                return;
            }
            
            // 비밀번호 유효성 검사 (8자 이상, 영문+숫자+특수문자)
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
            if (!passwordRegex.test(newPassword)) {
                alert('비밀번호는 8자 이상이며, 영문, 숫자, 특수문자를 포함해야 합니다.');
                return;
            }
            
            // 폼 제출
            this.submit();
        });

        // 페이지를 벗어날 때 세션 정리
        window.addEventListener('beforeunload', function(e) {
            fetch('${path}/member/clearPasswordSession.do', {
                method: 'POST',
                credentials: 'same-origin'
            });
        });
    </script>
</body>
</html>

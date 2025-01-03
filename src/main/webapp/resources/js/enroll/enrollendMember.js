/** 
 *  enrollmain.jsp에서 회원가입시 필요한 로직을 처리하기 위한 자바스크립트 제공
*/

// ID 중복 확인
function checkId() {
    const memberId = $("#memberId").val();
    
    if(!memberId || memberId.length < 4) {
        alert("아이디는 4글자 이상 입력해주세요.");
        return;
    }

    $.ajax({
        url: `${contextPath}/member/checkIdDuplicate`,
        method: "POST",
        data: { memberId: memberId },
        success: function(result) {
            if(result.duplicate) {
                alert("이미 사용중인 아이디입니다.");
                $("#memberId").val("").focus();
            } else {
                if(confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")) {
                    $("#memberId").prop("readonly", true);
                    $("#idCheckBtn").prop("disabled", true);
                    $("input[name='idCheckYN']").val("Y");
                }
            }
        },
        error: function() {
            alert("아이디 중복 확인 중 오류가 발생했습니다.");
        }
    });
}

// 비밀번호 일치 확인
function validatePasswordMatch(e) {
    const password = $("#password_").val();
    const passwordCheck = $(e.target).val();
    const $span = $("#checkResult");
    const $submitBtn = $("input[type='submit']");
    
    if(password.length >= 4 && passwordCheck.length >= 4) {
        if(password === passwordCheck) {
            $span.text("비밀번호가 일치합니다.")
                 .css({
                     "color": "green",
                     "font-weight": "bold"
                 });
            $submitBtn.prop("disabled", false);
        } else {
            $span.text("비밀번호가 일치하지 않습니다.")
                 .css({
                     "color": "red",
                     "font-weight": "bold"
                 });
            $submitBtn.prop("disabled", true);
        }
    }
}

// 폼 제출 전 최종 유효성 검사
function validateForm() {
    // 필수 입력 필드 검사
    const requiredFields = {
        "memberName": "이름을",
        "memberId": "아이디를",
        "emailId": "이메일을",
        "emailDomain": "이메일 도메인을",
        "password_": "비밀번호를",
        "password_2": "비밀번호 확인을"
    };

    for(const [fieldId, message] of Object.entries(requiredFields)) {
        const value = $(`#${fieldId}`).val();
        if(!value || value.trim() === "") {
            alert(`${message} 입력해주세요.`);
            $(`#${fieldId}`).focus();
            return false;
        }
    }

    // ID 중복확인 여부 검사
    if(!$("#memberId").prop("readonly")) {
        alert("아이디 중복확인을 해주세요.");
        return false;
    }

    // 비밀번호 일치 여부 검사
    if($("#password_").val() !== $("#password_2").val()) {
        alert("비밀번호가 일치하지 않습니다.");
        $("#password_2").focus();
        return false;
    }

    // 이메일 인증 여부 검사
    if($("input[name='emailVerified']").val() !== "Y") {
        alert("이메일 인증이 필요합니다.");
        return false;
    }

    // 회원 구분에 따른 학교/학원 정보 검사
    const eduType = $("input[name='eduType']:checked").val();
    if(eduType === "1") {
        if(!$("#school-name").val()) {
            alert("학교를 선택해주세요.");
            return false;
        }
    } else {
        if(!$("#academyName").val()) {
            alert("학원명을 입력해주세요.");
            return false;
        }
    }

    return true;
}

// 이벤트 리스너 설정
$(document).ready(function() {
    // 폼 제출 이벤트
    $("form").on("submit", function(e) {
        if(!validateForm()) {
            e.preventDefault();
            return false;
        }
    });

    // 비밀번호 확인 이벤트
    $("#password_2").on("keyup", validatePasswordMatch);

    // ID 중복확인 버튼 이벤트
    $("#idCheckBtn").on("click", checkId);

    // 폼 초기화시 읽기전용 해제
    $("input[type='reset']").on("click", function() {
        $("#memberId").prop("readonly", false);
        $("#idCheckBtn").prop("disabled", false);
        $("input[name='idCheckYN']").val("N");
    });
});
/**
 * enrollmain.jsp 회원가입 페이지의 유효성 검사 및 이벤트 처리를 위한 스크립트
 */
// DOM이(페이지가) 로드되면 이벤트 리스너 초기화
$(document).ready(function() {
    initializeEventListeners();
    initializeFormValidation();
});

/**
 * 기본 이벤트 리스너 초기화 함수
 */
function initializeEventListeners() {
    // 로고 클릭시 메인으로 이동
    $(".logo-container").off("click").click(() => location.assign(contextPath));
    
    // ID 중복 확인 이벤트
    $("#idCheckBtn").off("click").click(checkId);
	
	// 비밀번호 일치여부 확인 이벤트
	$("#password_2").off("keyup").keyup(validatePasswordMatch);
    
    // 주소 검색 이벤트
    $("#postcodeFindBtn").off("click").click(sample4_execDaumPostcode);
   
	// 이메일 인증 버튼 클릭 이벤트 추가
	$("#emailCheckBtn").off("click").click(checkEmail);
}

/**
 * 폼 유효성 검사 관련 이벤트 초기화
 */
function initializeFormValidation() {
    // 비밀번호 확인 이벤트
    $("#password_2").keyup(validatePasswordMatch);
    
    // 폼 제출 이벤트
    $("form").submit(function(e) {
        if(!validateForm()) {
            e.preventDefault();
            return false;
        }
    });
    
    // 폼 초기화 이벤트
    $("input[type='reset']").click(resetForm);
}

// 회원가입 폼 유효성 검사
function fn_invalidate() {
    const passwordReg = /(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()]).{8,}/;
    const password = $("#password_2").val();
    if(!passwordReg.test(password)) {
        alert("비밀번호는 영문자,숫자,특수기호(!@#$%^&*())를 포함한 8글자 이상으로 입력해 주세요");
        return false;
    }
    return true;
}

// 아이디 중복검사를 실행하는 함수
function checkId() {
    const memberId = $('#memberId').val();

    if (!memberId) {
        alert('아이디를 입력해주세요.');
        return;
    }
    $.ajax({
        url: path + '/member/checkid', 
        type: "GET",
        data: { memberId: memberId },
        dataType: "json",
        success: function(response) {
            console.log('서버 응답:', response);
            if(response === true) {
                alert('이미 사용 중인 아이디입니다. 다른 아이디를 입력해주세요.');
            } else {
                alert('사용 가능한 아이디입니다.');
                $("input[name='idCheckYN']").val("Y");
            }
        },
        error: function(xhr, status, error) {
            console.log('에러 상태:', status);
            console.log('에러 내용:', error);
            alert('아이디 확인 중 오류가 발생했습니다. 다시 시도해주세요.');
        }
    });
}

//비밀번호 일치 확인
function validatePasswordMatch(e) {
    const password = $("#password_").val();
    const passwordcheck = $(e.target).val();
    const $span = $("#checkResult");
    
    if(password.length >= 4 && passwordcheck.length >= 4) {
        if(password === passwordcheck) {
            $span.text("비밀번호가 일치합니다.").css("color", "green");
            $("input[value='가입']").prop("disabled", false);
        } else {
            $span.text("비밀번호가 일치하지 않습니다.").css("color", "red");
            $("input[value='가입']").prop("disabled", true);
        }
    }
}

//이메일 도메인 선택시 입력창에 표시
$("#emailSelect").change(function() {
        const selectedValue = $(this).val(); // 선택된 값 가져오기

        if (selectedValue === "직접입력") {
            $("#emailDomain").prop("readonly", false).val(""); // 직접 입력 가능하게 설정
        } else{
            $("#emailDomain").prop("readonly", true).val(selectedValue); // 선택된 도메인 설정
        }
    });
	// 이메일 인증 처리
	function checkEmail() {
	    const emailId = $("#emailId").val();
	    const emailDomain = $("#emailDomain").val();
		const email = emailId + '@' + emailDomain;
	    
	    if(!emailId || !emailDomain) {
	        alert("이메일을 입력해주세요.");
	        return;
	    }
	    
	    if(!validateEmail(email)) {
	        alert("유효한 이메일 형식이 아닙니다.");
	        return;
	    }

		// 이메일 중복 체크
		$.ajax({
		    url: path + '/auth/checkEmailDuplicate.do',
		    method: "POST",
		    data: { email: email, searchType: 'emailDuplicate'},
		    success: function(response) {
		        if(response.exists) {
		            alert("이미 사용중인 이메일입니다.");
		            return;
		        } else {
		            // 중복이 아닌 경우에만 인증 이메일 발송
		            sendVerificationEmail(email);
		        }
		    },
		    error: function() {
		        alert("이미 사용중인 이메일 입니다.");
		    }
		});
	}

	// 인증 이메일 발송 함수 분리
	function sendVerificationEmail(email) {
	    const form = document.createElement('form');
	    form.method = 'POST';
	    form.action = path + '/auth/sendEmail';
	    form.target = 'emailVerify';
	    
	    const emailInput = document.createElement('input');
	    emailInput.type = 'hidden';
	    emailInput.name = 'email';
	    emailInput.value = email;
	    
	    const typeInput = document.createElement('input');
	    typeInput.type = 'hidden';
	    typeInput.name = 'authType';
	    typeInput.value = 'signup';
	    
	    form.appendChild(emailInput);
	    form.appendChild(typeInput);
	    
	    window.open('', 'emailVerify', 'width=400,height=300,left=500,top=200');
	    
	    document.body.appendChild(form);
	    form.submit();
	    document.body.removeChild(form);
	}

// 이메일 관련 입력값이 변경될 때마다 인증 상태 초기화
$("#emailId, #emailDomain, #emailSelect").on("change", function() {
    const existingHidden = $("input[name='emailVerified']");
    if(existingHidden.length > 0) {
        existingHidden.val("N");
        
        // 입력 필드 잠금 해제
        $("#emailId").prop("readonly", false);
        $("#emailDomain").prop("readonly", false);
        $("#emailSelect").prop("disabled", false);
        
        // 스타일 원복
        $("#emailId, #emailDomain").css("backgroundColor", "");
        $("input[value='이메일 인증']").prop("disabled", false)
            .css("backgroundColor", "");
    }
});

/**
 * 이메일 형식 검사
 */
function validateEmail(email) {
    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    return emailPattern.test(email);
}

// 우편번호 검색
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            const roadAddr = data.roadAddress;
            let extraRoadAddr = '';

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }
            if(data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            
            // 우편번호와 주소 정보 입력
            $("#sample4_postcode").val(data.zonecode);
            $("#sample4_roadAddress").val(roadAddr);
            $("#sample4_detailAddress").val('');

            // 안내 텍스트 처리
            const $guide = $("#guide");
            if(data.autoRoadAddress) {
                $guide.html('(예상 도로명 주소 : ' + data.autoRoadAddress + extraRoadAddr + ')').show();
            } else {
                $guide.html('').hide();
            }
        }
    }).open();
}

/**
 * 폼 초기화
 */
function resetForm() {
    $("#memberId").prop("readonly", false);
    $("#idCheckBtn").prop("disabled", false);
    $("input[name='idCheckYN']").val("N");
    $("#checkResult").text("");
}

// [이전 코드와 동일한 부분 유지]
// handleEmailSelect, handleEduTypeChange, validatePasswordMatch, 
// validateForm, sample4_execDaumPostcode 함수들은 동일하게 유지

/**
 * 전체 폼 유효성 검사 업데이트
 */
function validateForm() {
    
    // ID 중복확인 검사
    if($("input[name='idCheckYN']").val() !== "Y") {
        alert("아이디 중복확인이 필요합니다.");
        return false;
    }
    
    
    return true;
}



/* eduType 선택에 따라 지역,학교 선택칸 출력 */
const selector = document.getElementById("selector");

selector.addEventListener("change", function() {
	const val = selector.value;
	if(val==="8") {
		$("#region-container").removeClass("hidden");
	} else {
		$("#region-container").addClass("hidden");
	}
});
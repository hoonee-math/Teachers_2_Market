// 전역 변수 선언
var editor; // Toast UI Editor 인스턴스
var uploadedImages = []; // 업로드된 이미지 배열

// 페이지 로드 시 초기화
$(document).ready(function() {
    initializeEditor();
    initializeFormHandlers();
	initializeSelectors();  // 카테고리 객체를 활용한 카테고리 선택 옵션
});

// Toast UI Editor 초기화
function initializeEditor() {
    editor = new toastui.Editor({
        el: document.querySelector('#editor'),
        height: '500px',
        initialEditType: 'wysiwyg',
        previewStyle: 'vertical',
        hooks: {
            addImageBlobHook: handleImageUpload
        }
    });
}

// 에디터 이미지 업로드 처리 (서버 구현 전 임시 버전)
function handleImageUpload(blob, callback) {
    /* 
    * 추후 구현 사항:
    * 1. 이미지 서버 업로드 (/post/uploadImage)
    * 2. 업로드된 이미지의 URL 반환
    * 3. DB에 이미지 정보 저장 (IMAGE 테이블에 저장)
    * 4. using_type=2로 설정하여 본문 이미지임을 표시
    */
    try {
        // 임시: File을 URL로 변환하여 바로 보여주기
        var url = URL.createObjectURL(blob);
        callback(url, 'image');
    } catch (error) {
        console.error('이미지 업로드 실패:', error);
        alert('이미지 업로드에 실패했습니다.');
    }
}


// 이미지 미리보기 추가
function addImagePreview(url, imgNo) {
    var previewHtml = 
        '<div class="image-preview" data-img-no="' + imgNo + '">' +
            '<img src="' + url + '" alt="미리보기">' +
            '<span class="remove-image">&times;</span>' +
        '</div>';
    
    $('.image-upload-box').before(previewHtml);
}


// 폼 제출 및 임시저장 처리
function initializeFormHandlers() {
    // 임시저장
    $('#tempSaveBtn').on('click', function() {
        $('input[name="isTemp"]').val('1');
        submitForm();
    });

    // 폼 제출
    $('#writeForm').on('submit', function(e) {
        e.preventDefault();
        $('input[name="isTemp"]').val('0');
        submitForm();
    });

    // 취소
    $('#cancelBtn').on('click', function() {
        if(confirm('작성을 취소하시겠습니까? 작성중인 내용은 저장되지 않습니다.')) {
            location.href = '/board/list';
        }
    });
}

// 폼 제출 처리 (서버 구현 전 임시 버전)
function submitForm() {
    if (!validateForm()) {
        return;
    }

    /* 
    * 추후 구현 사항:
    * 1. FormData 생성 및 데이터 수집
    * 2. 서버에 데이터 전송 (/post/write)
    * 3. POST, PRODUCT/FILE, IMAGE 테이블에 데이터 저장
    * 4. 임시저장/등록 완료 후 적절한 페이지로 리다이렉트
    */

    // 임시: alert으로 동작 확인
    // alert($('input[name="isTemp"]').val() === '1' ? '임시저장되었습니다.' : '게시글이 등록되었습니다.');
    // location.href = '/board/list'; // 실제 구현 시 활성화

	// 에디터의 내용을 가져옴
	const content = editor.getHTML();
	console.log("content: "+content);
	
	// 전송할 데이터 객체 생성
	const data = {
	    postTitle: $('#title').val(),
	    postContent: content,
	    isFix: $('#isFix').is(':checked') ? 1 : 0
	};

	// 임시저장 여부
	const isTemp = $('input[name="isTemp"]').val() === '1';
	console.log("isTemp: "+isTemp);

	$.ajax({
		url: contextPath + '/admin/notify/submit',
		type: 'POST',
		data: JSON.stringify(data),  // JSON 문자열로 변환
		contentType: 'application/json;charset=UTF-8', // Content-Type 헤더 설정
		success: function(response) {
			if (response.success) {
				alert(isTemp ? '임시저장되었습니다.' : '공지사항이 등록되었습니다.');
				// 성공 시 공지사항 목록 페이지로 이동
				location.href = contextPath + '/admin/menu';
			} else {
				alert(response.message || '등록에 실패했습니다.');
			}
		},
		error: function(xhr, status, error) {
			console.error('Error:', error);
			alert('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
		}
	});
}

// 폼 유효성 검사
function validateForm() {
    // 제목 검사
    var title = $('#title').val().trim();
    if (!title) {
        alert('제목을 입력해주세요.');
        $('#title').focus();
        return false;
    }

    // 내용 검사
    if (editor.getHTML().trim() === '') {
        alert('내용을 입력해주세요.');
        editor.focus();
        return false;
    }

    return true;
}
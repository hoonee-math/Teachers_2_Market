// 전역 변수 선언
var editor; // Toast UI Editor 인스턴스
var uploadedImages = []; // 업로드된 이미지 배열
var imageOrder = []; // 이미지 순서 배열
const categoryData = { // 카테고리 데이터 객체
    1: "미취학아동",
    2: "초등",
    3: "중등",
    4: "고등",
    5: "수험생"
};
const subjectData = { // 과목 데이터 객체
    1: "국어",
    2: "영어",
    3: "수학",
    4: "사회",
    5: "과학",
    6: "예체능",
    7: "기타"
};

// 페이지 로드 시 초기화
$(document).ready(function() {
    initializeEditor();
    initializeImageUpload();
    initializeFormHandlers();
    initializeTypeHandlers();
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

// select 옵션 초기화를 위한 함수
function initializeSelectors() {
    // 카테고리 select 옵션 생성
    const categorySelect = $('#category');
    categorySelect.empty().append('<option value="">카테고리 선택</option>');
    
    for(let key in categoryData) {
        categorySelect.append(`<option value="${key}">${categoryData[key]}</option>`);
    }

    // 과목 select 옵션 생성
    const subjectSelect = $('#subject');
    subjectSelect.empty().append('<option value="">과목 선택</option>');
    
    for(let key in subjectData) {
        subjectSelect.append(`<option value="${key}">${subjectData[key]}</option>`);
    }
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

// 썸네일 이미지 업로드 초기화
function initializeImageUpload() {
	// 요소 존재 여부 확인을 위한 로그
	console.log('Elements found:', {
	    dropZone: $("#imagePreviewContainer").length,
	    fileInput: $("#imageUpload").length,
	    uploadBox: $(".image-upload-box").length
	});
	
	var dropZone = $("#imagePreviewContainer");
	var fileInput = $("#imageUpload");
	var uploadLabel = $(".upload-label");
	
	// label 클릭으로 처리
	uploadLabel.on('click', function(e) {
	    console.log('Upload label clicked');
	    // label과 input이 연결되어 있으므로 추가 처리 필요 없음
	});
	
	// 파일 선택 이벤트
	fileInput.on('change', function(e) {
	    console.log('File selected', e.target.files);
	    if(e.target.files && e.target.files.length > 0) {
	        handleThumbnailUpload(e.target.files);
	    }
	});

    // 드래그 앤 드롭 이벤트
    dropZone.on('dragover', function(e) {
        e.preventDefault();
        dropZone.addClass('dragover');
    }).on('dragleave', function() {
        dropZone.removeClass('dragover');
    }).on('drop', function(e) {
        e.preventDefault();
        dropZone.removeClass('dragover');
        
        var files = e.originalEvent.dataTransfer.files;
        handleThumbnailUpload(files);
    });

    // 이미지 순서 변경 기능
    $("#imagePreviewContainer").sortable({
        items: '.image-preview',
        update: updateImageOrder
    });

    // 이미지 삭제 이벤트 추가
    dropZone.on('click', '.remove-image', function(e) {
        e.stopPropagation();  // 버블링 방지
        var preview = $(this).closest('.image-preview');
        var imgNo = preview.data('img-no');
        uploadedImages = uploadedImages.filter(function(id) {
            return id !== imgNo;
        });
        preview.remove();
        updateImageOrder();
    });
}

// 썸네일 이미지 업로드 처리 (서버 구현 전 임시 버전)
function handleThumbnailUpload(files) {
    if (uploadedImages.length + files.length > 10) {
        alert('최대 10개의 이미지만 업로드 가능합니다.');
        return;
    }

    /* 
    * 추후 구현 사항:
    * 1. 이미지 서버 업로드
    * 2. DB에 이미지 정보 저장 (IMAGE 테이블)
    * 3. using_type=1로 설정하여 썸네일 이미지임을 표시
    * 4. 실제 업로드된 이미지 정보로 미리보기 생성
    */

    // 임시: 파일을 URL로 변환하여 미리보기 생성
    for (var i = 0; i < files.length; i++) {
        var file = files[i];
        if (!file.type.startsWith('image/')) {
            alert('이미지 파일만 업로드 가능합니다.');
            continue;
        }

        var imgUrl = URL.createObjectURL(file);
        var tempImgNo = 'temp_' + new Date().getTime() + i; // 임시 ID 생성
        addImagePreview(imgUrl, tempImgNo);
        uploadedImages.push(tempImgNo);
        updateImageOrder();
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

// 이미지 순서 업데이트
function updateImageOrder() {
    imageOrder = $('.image-preview').map(function() {
        return $(this).data('img-no');
    }).get();
}

// 판매 유형에 따른 UI 변경
function initializeTypeHandlers() {
    $('input[name="type"]').on('change', function() {
        var type = $(this).val();
        if (type === 'product') {
            $('.product-only').show();
			$('.file-only').hide();
        } else {
            $('.product-only').hide();
			$('.file-only').show();
        }
    });

	// 파일 선택 이벤트
	$('#fileUpload').on('change', function(e) {
		var files = e.target.files;
	
		for(var i = 0; i < files.length; i++) {
		    var file = files[i];
		    
		    // 파일 크기 체크
		    if (file.size > 100 * 1024 * 1024) {
		        alert('파일 크기는 100MB를 초과할 수 없습니다.');
		        continue;
		    }
	
		    // 파일 정보 표시
		    var fileSize = (file.size / (1024 * 1024)).toFixed(2);
		    var fileId = 'file_' + new Date().getTime() + i;
		    
		    var fileHtml = `
		        <div class="file-item" id="${fileId}">
		            <div class="file-info">
		                ${file.name} (${fileSize}MB)
		            </div>
		            <button type="button" class="remove-file" data-file-id="${fileId}">&times;</button>
		        </div>
		    `;
		    
		    $('.file-list').append(fileHtml);
		}
	
		// input 초기화 (같은 파일 다시 선택 가능하도록)
		this.value = '';
	});

	// 파일 삭제 버튼 클릭
	$(document).on('click', '.remove-file', function() {
		var fileId = $(this).data('file-id');
		$('#' + fileId).remove();
	});

	// 선택된 파일들 정보 저장을 위한 배열
	var selectedFiles = [];

	// 파일 선택시 배열에 추가
	$('#fileUpload').on('change', function(e) {
	    var files = e.target.files;
	    for(var i = 0; i < files.length; i++) {
	        selectedFiles.push(files[i]);
	    }
	});

	// 파일 삭제시 배열에서도 제거
	$(document).on('click', '.remove-file', function() {
	    var fileId = $(this).data('file-id');
	    var index = selectedFiles.findIndex(f => f.id === fileId);
	    if(index > -1) {
	        selectedFiles.splice(index, 1);
	    }
	});
	
    $('#isFree').on('change', function() {
        var isChecked = $(this).prop('checked');
        $('#price').prop('disabled', isChecked);
        if (isChecked) {
            $('#price').val('0');
        }
    });

    $('#hasDeliveryFee').on('change', function() {
        var isChecked = $(this).prop('checked');
        $('#deliveryFee').prop('disabled', !isChecked);
        if (!isChecked) {
            $('#deliveryFee').val('0');
        }
    });
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


	// FormData 객체 생성
	const formData = new FormData();

	// 기본 게시글 데이터
	formData.append('postTitle', $('#title').val());
	formData.append('postContent', editor.getHTML());
	formData.append('categoryNo', $('#category').val());
	formData.append('subjectNo', $('#subject').val());
	formData.append('productType', $('input[name="type"]:checked').val() === 'product' ? 1 : 2);
	formData.append('isTemp', $('input[name="isTemp"]').val());

	// 상품/파일 타입별 추가 데이터
	if ($('input[name="type"]:checked').val() === 'product') {
		formData.append('isFree', $('#isFree').is(':checked') ? 1 : 0);
		formData.append('productPrice', $('#price').val() || 0);
		formData.append('hasDeliveryFee', $('#hasDeliveryFee').is(':checked') ? 1 : 0);
		formData.append('deliveryFee', $('#deliveryFee').val() || 0);
		formData.append('stockCount', $('#stock').val() || 1);

		// 상품 이미지 파일들 추가
		const imageFiles = $('#imageUpload')[0].files;
		for (let i = 0; i < imageFiles.length; i++) {
			formData.append('upfile' + i, imageFiles[i]);
		}
	} else {
		formData.append('isFree', $('#isFree').is(':checked') ? 1 : 0);
		formData.append('filePrice', $('#price').val() || 0);
		formData.append('salePeriod', $('#salePeriod').val());

		// 상품 이미지 파일들 추가
		const imageFiles = $('#imageUpload')[0].files;
		for (let i = 0; i < imageFiles.length; i++) {
			formData.append('upfile' + i, imageFiles[i]);
		}
		
		// 판매할 파일들 추가
		const uploadFiles = $('#fileUpload')[0].files;
		for (let i = 0; i < uploadFiles.length; i++) {
			formData.append('uploadFile' + i, uploadFiles[i]);
		}

	}

	// 임시저장 여부
	const isTemp = $('input[name="isTemp"]').val() === '1';

	$.ajax({
		url: contextPath + '/post/write/submit',
		type: 'POST',
		data: formData,
		processData: false,  // FormData 처리 방지
		contentType: false,  // Content-Type 자동 설정
		success: function(response) {
			if (response.success) {
				alert(isTemp ? '임시저장되었습니다.' : '공지사항이 등록되었습니다.');
				// 성공 시 공지사항 목록 페이지로 이동
				location.href = contextPath + '/board/listu';
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

    // 카테고리 검사
    if (!$('#category').val()) {
        alert('카테고리를 선택해주세요.');
        $('#category').focus();
        return false;
    }

    // 과목 검사
    if (!$('#subject').val()) {
        alert('과목을 선택해주세요.');
        $('#subject').focus();
        return false;
    }

    // 가격 검사
    if (!$('#isFree').prop('checked') && (!$('#price').val() || $('#price').val() < 0)) {
        alert('올바른 가격을 입력해주세요.');
        $('#price').focus();
        return false;
    }

    // 배송비 검사
    if ($('#hasDeliveryFee').prop('checked') && (!$('#deliveryFee').val() || $('#deliveryFee').val() < 0)) {
        alert('올바른 배송비를 입력해주세요.');
        $('#deliveryFee').focus();
        return false;
    }

    // 상품 이미지 검사
    if (uploadedImages.length === 0) {
        alert('최소 1개의 상품 이미지를 등록해주세요.');
        return false;
    }
	
	// 파일 검사
	if ($('input[name="type"]:checked').val() === 'file' && !$('#fileUpload').val()) {
	    alert('판매할 파일을 선택해주세요.');
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
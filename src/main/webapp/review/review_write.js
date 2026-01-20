document.addEventListener("DOMContentLoaded", () => {
	
	// ================== 로그인 확인 - 프론트 ==================
	const reviewBtn = document.getElementById("reviewBtn");

	reviewBtn.addEventListener("click", function (e) {
	    const isLogin = this.dataset.login === "true";

	    if (!isLogin) {
	        e.preventDefault(); // 모달 안 열리게
	        alert("로그인이 필요합니다.");
	        location.href = ctxPath + "/login/login_form.jsp"; 
	        return;
	    }
	});

	// ================== 모달 열기==================
    const reviewModal = document.getElementById('reviewModal');

    reviewModal.addEventListener('show.bs.modal', event => {
        const btn = event.relatedTarget;
        const storeIdx = btn.getAttribute('data-store-idx');
        document.getElementById('storeIdx').value = storeIdx;
    });

    // ================== 별점 ==================
	const starGroup = document.querySelectorAll("#starGroup span");
	const starText = document.getElementById("starText");
	const reviewRating = document.getElementById("reviewRating");
	let starDrag= false;
	
    function updateStars(value) {
        reviewRating.value = value;
        starGroup.forEach(eachStar => {
            eachStar.classList.toggle("active", eachStar.dataset.starRating <= value);
        });
        starText.innerText = `${value}점을 선택하셨습니다!`;
        starText.classList.add("star-text-change");
    }

    starGroup.forEach(eachStar => {
        eachStar.addEventListener("mousedown", () => {
            starDrag = true;
            updateStars(eachStar.dataset.starRating);
        });
        eachStar.addEventListener("mouseenter", () => {
            if (starDrag) 
				updateStars(eachStar.dataset.starRating);
        });
        eachStar.addEventListener("click", () => updateStars(eachStar.dataset.starRating));
    });

    window.addEventListener("mouseup", () => starDrag  = false);

    // ================== 이미지 업로드 ==================
	const reviewImg = document.getElementById("reviewImg");
	const reviewImgPreview = document.getElementById("reviewImgPreview");
	const imgCount = document.getElementById("imgCount");
	const MAX_IMAGES = 5;
	const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
	let reviewImgFiles = [];
	
    function updateImgCount() {
        imgCount.innerText = reviewImgFiles.length;
    }

    function createImgPreview(file) {
        const reader = new FileReader();
        reader.onload = e => {
            const wrapper = document.createElement("div");
            wrapper.className = "preview-item";

            const img = document.createElement("img");
            img.src = e.target.result;

            const delBtn = document.createElement("button");
            delBtn.className = "preview-delete";
            delBtn.innerText = "✕";
            delBtn.onclick = () => {
                reviewImgFiles = reviewImgFiles.filter(existFile => existFile !== file);
                wrapper.remove();
                updateImgCount();
            };

            wrapper.appendChild(img);
            wrapper.appendChild(delBtn);
            reviewImgPreview.appendChild(wrapper);
        };
        reader.readAsDataURL(file);
    }

	reviewImg.addEventListener("change", function () {
    	const selectedFiles = Array.from(this.files);
		
		// 중복 파일 존재 여부
    	let hasDuplicate = false;
		// 검사 후 유효한 파일만 모은 배열
    	let validFiles = [];

		// 1. 중복 제거
    	selectedFiles.forEach(selectFile  => {
			// 1️.이미지 타입 체크
        	if (!selectFile.type.startsWith("image/")) {
				alert("이미지 파일만 업로드 가능합니다!");
				return;
			}
		
			// 2️.용량 체크
			if (selectFile .size > MAX_FILE_SIZE) {
		    	alert(`"${selectFile.name}"은(는) 5MB를 초과합니다! (${(selectFile.size / 1024 / 1024).toFixed(2)}MB)`);
		    	return;
			}
		
			// 3️.중복 체크
        	const isDuplicate = reviewImgFiles.some(existFile => 
				existFile.name === selectFile.name && existFile.size === selectFile.size);

        	if (isDuplicate) {
            	hasDuplicate = true;
        	} else {
            	validFiles.push(selectFile);
        	}
    	});

    	if (hasDuplicate) {
        	alert("이미 등록된 사진이 포함되어 있습니다!");
    	}

    	// 2. 장수 초과면 전부 취소
    	if (reviewImgFiles.length + validFiles.length > MAX_IMAGES) {
        	const remain = MAX_IMAGES - reviewImgFiles.length;
        	alert(`📸 추가로 넣을 수 있는 사진은 ${remain}장입니다.`);
        	this.value = "";
        	return;
    	}

    	// 3. 정상일 때만 추가
    	validFiles.forEach(selectFile  => {
        	reviewImgFiles.push(selectFile);
        	createImgPreview(selectFile);
    	});

    	updateImgCount();
    	this.value = "";
	});

    // ================== 리뷰 폼 초기화 ==================
    function hasInput() {
        return (
            reviewRating.value !== "" ||
            document.querySelector("textarea[name='review_content']").value.trim() !== "" ||
            reviewImgFiles.length > 0
        );
    }
	
	// 초기화 함수
    function resetReviewForm() {
        // 별점 초기화
        starGroup.forEach(star => star.classList.remove("active"));
        starText.innerText = "별을 드래그하여 점수를 매겨주세요";
        starText.className = "star-text";
        reviewRating.value = "";

        // 텍스트 초기화
        document.querySelector("textarea[name='review_content']").value = "";

        // 이미지 초기화
        reviewImgFiles = [];
        reviewImgPreview.innerHTML = "";
        reviewImg.value = "";
        updateImgCount();
    }

    let allowClose = false;
	
    reviewModal.addEventListener("hide.bs.modal", e => {
        if (!allowClose && hasInput()) {
            if (!confirm("작성 중인 내용이 있습니다. 정말 닫을까요?"))
				e.preventDefault();
            else allowClose = true;
        }
    });

    reviewModal.addEventListener("hidden.bs.modal", () => {
        resetReviewForm();
        allowClose = false;
    });

    // ================== 폼 제출 ==================
	
	$("#reviewModal form").on("submit", function (e) {
    	e.preventDefault();
	
    	if (!reviewRating.value) {
        	alert("별점을 선택해주세요!");
        	return;
    	}

    	const formData = new FormData(this);
    	reviewImgFiles.forEach((file, idx) => {
        	formData.append("reviewImg"+(idx + 1), file);
    	});

    	$.ajax({
        	url: ctxPath +"/review/review_save.jsp",
        	type: "POST",
        	data: formData,
        	processData: false, // jQuery가 데이터를 문자열로 변환하지 않도록 설정 (파일 업로드 시 필수)
        	contentType: false, // 폼 데이터의 Content-Type을 자동 설정
        	dataType: "json",  
        	success: function (res) {

            	if (res.reviewResult === "success") {
					
					// 로그인 확인 - 프론트(서버 결과 처리)
					if (res.reviewResult === "login_required") {
					    alert("로그인이 필요합니다.");
					    location.href = ctxPath + "/login/login_form.jsp"; 
					    return;
					}
					
					// 리뷰 수, 리뷰 순서 갱신
					document.getElementById('reviewCount').innerText = res.reviewCount;
					document.getElementById('reviewOrder').innerText = res.reviewOrder;
					
					// 평균 평점 갱신
					const ratingEl = document.querySelector(".store-rating");
					ratingEl.innerText =
					    res.avgRating.toFixed(1) + " (" + res.reviewCount + ")";
					
					// 리뷰 목록 맨 위에 추가
					const reviewSection = document.querySelector(".review-section");
					const header = reviewSection.querySelector(".review-header");

					header.insertAdjacentHTML("afterend", res.reviewHtml);
					
					allowClose = true;
					
					alert("리뷰 등록 성공");

					// 모달 닫기
					const modal = bootstrap.Modal.getInstance(
					    document.getElementById("reviewModal"));
					modal.hide();

            	} else {
                	alert("리뷰 등록 실패");
            	}
        	},
        	error: function () {
            	alert("서버 오류 발생");
        	}
    	});
	});
	

});

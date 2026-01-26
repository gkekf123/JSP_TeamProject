document.addEventListener("DOMContentLoaded", () => {

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
	const reviewImgPreview = document.getElementById("reviewImgPreview");
	const imgCount = document.getElementById("imgCount");
	const MAX_IMAGES = 5;
	const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
	let reviewImgFiles = [];

	function updateImgCount() {
	    imgCount.innerText = reviewImgFiles.length;
	}

	// 미리보기 재렌더링
	function renderPreviews() {
		reviewImgPreview.innerHTML = "";

		reviewImgFiles.forEach((file, index) => {
		    const preview = document.createElement("div");
		    preview.className = "preview-item";

		    const img = document.createElement("img");
		    if (file instanceof File) {
		        const reader = new FileReader();
		        reader.onload = e => img.src = e.target.result;
		        reader.readAsDataURL(file);
		    } else if (file.existing) {
		        img.src = ctxPath + "/images/review_upload/" + file.name;
		        preview.classList.add("existing-item");
			
				const hiddenInput = document.createElement("input");
				hiddenInput.type = "hidden";
				hiddenInput.name = "existing_img" + (index + 1);
				hiddenInput.value = file.name;
				preview.appendChild(hiddenInput);
		    }

		    const delBtn = document.createElement("button");
		    delBtn.type = "button";
		    delBtn.className = "preview-delete";
		    delBtn.innerText = "✕";
		    delBtn.onclick = function() {
		        if (file.existing) {
		            removeExistingImg(this, file.name);
		        } else {
		            reviewImgFiles.splice(index, 1);
		            updateInputs();
		            renderPreviews();
		        }
		    };

		    preview.appendChild(img);
		    preview.appendChild(delBtn);
		    reviewImgPreview.appendChild(preview);
		});
		
		updateImgCount();
	}

	// input에 파일 재할당
	function updateInputs() {
		// 모든 input 초기화
	    for (let i = 1; i <= MAX_IMAGES; i++) {
	    	const input = document.getElementById('reviewImg' + i);
	        if (input) 
				input.value = "";
	    }
	      
	    // 배열 순서대로 input에 할당
	    reviewImgFiles.forEach((file, index) => {
			if (file instanceof File) {  // 기존 이미지 dummy는 건너뜀
				const input = document.getElementById('reviewImg' + (index + 1));
			    if (input) {
			    	const dataTransfer = new DataTransfer();
			        dataTransfer.items.add(file);
			        input.files = dataTransfer.files;
			    }
			}
		});
	}
	  
	// 사진 추가 버튼
	window.addPhoto = function() {
	    if (reviewImgFiles.length >= MAX_IMAGES) {
	        alert('최대 5장까지 업로드 가능합니다.');
	        return;
	    }
	      
	    // multiple input 클릭
	    document.getElementById('reviewImgMultiple').click();
	};

	// 파일 검사
	window.checkFiles = function(multiInput) {
	    const selectedFiles = Array.from(multiInput.files);
	    
	    let validFiles = [];
		let hasDuplicate = false;
	    
	    // 각 파일 검증
	    for (let file of selectedFiles) {
	        // 이미지 타입 체크
	        if (!file.type.startsWith("image/")) {
	            alert(`"${file.name}"은(는) 이미지 파일이 아닙니다!`);
	            continue;
	        }
	    
	        // 용량 체크
	        if (file.size > MAX_FILE_SIZE) {
	            alert(`"${file.name}"은(는) 5MB를 초과합니다! (${(file.size / 1024 / 1024).toFixed(2)}MB)`);
	            continue;
	        }
	      
	        // 중복 체크
	        const isDuplicate = reviewImgFiles.some(existFile => 
	            existFile.name === file.name && existFile.size === file.size
	        );
	        
			if (isDuplicate) {
				hasDuplicate = true; 
			    continue;            
			}
	        
	        validFiles.push(file);
	    }
		
		// 중복 알림
		if (hasDuplicate) {
			alert("이미 등록된 사진이 선택 항목에 포함되어 제외되었습니다.");
		}		
	    
		// 개수 체크
		if (reviewImgFiles.length + validFiles.length > MAX_IMAGES) {
			const remain = MAX_IMAGES - reviewImgFiles.length;
		    alert(`📸 추가 가능한 사진은 ${remain}장입니다.\n선택하신 사진(${validFiles.length}장)이 개수를 초과하여 추가되지 않았습니다.`);
		    multiInput.value = "";
		    return;
		}
	    
		// 개수가 적절할 때만 배열에 추가 및 화면 갱신
		if (validFiles.length > 0) {
			reviewImgFiles.push(...validFiles);
		    updateInputs();    
		    renderPreviews();  
		}
	    
	    multiInput.value = "";
	};

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
		const form = document.querySelector("#reviewModal form");

		// 수정 모드 해제
		delete form.dataset.mode;
		
	    // 별점 초기화
	    starGroup.forEach(star => star.classList.remove("active"));
	    starText.innerText = "별을 드래그하여 점수를 매겨주세요";
	    starText.className = "star-text";
	    reviewRating.value = "";

	    // 텍스트 초기화
	    document.querySelector("textarea[name='review_content']").value = "";

	    // 이미지 초기화
	    reviewImgFiles = [];
		
		for (let i = 1; i <= MAX_IMAGES; i++) {
		    const input = document.getElementById('reviewImg' + i);
		    if (input) input.value = "";
		}
		document.getElementById('reviewImgMultiple').value = "";
	    reviewImgPreview.innerHTML = "";
	    updateImgCount();
		
		// reviewOrder 초기화
		reviewOrder.textContent = "";
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

    window.addEventListener("mouseup", () => starDrag = false);

    // ================== 리뷰 수정 폼 제출 ==================
    $("#reviewModal form").on("submit", function(e) {
        e.preventDefault();

        if (!reviewRating.value) {
            alert("별점을 선택해주세요!");
            return;
        }

        const form = this;
        const formData = new FormData(form);

        const url = ctxPath + "/review/review_update.jsp"; // 수정 전용 URL

        $.ajax({
            url: url,
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            dataType: "json",
            success: function(res) {
                if (res.reviewResult === "success") {
                    alert("리뷰 수정 성공");
                    location.reload();
                } else {
                    alert("리뷰 수정 실패: " + res.message);
                }
            },
            error: function() {
                alert("서버 오류 발생");
            }
        });
    });
	
	// 수정-데이터 가져오기
	$(document).on("click", ".review-edit-btn", function() {
		// 1. 수정 모드임을 알리기 위한 변수 설정 (필요 시)
	    const form = document.querySelector("#reviewModal form");
	    form.dataset.mode = "edit";
		
		const reviewItem = $(this).closest(".review-item");
		const reviewIdx = reviewItem.data("review-idx");
		const storeIdx = reviewItem.data("store-idx");
		
		document.getElementById("reviewIdx").value = reviewIdx;
		document.getElementById("storeIdx").value = storeIdx;

	    $.ajax({
	        url: ctxPath + "/review/review_get_review.jsp", 
	        type: "GET",
	        data: { "reviewIdx": reviewIdx },
	        dataType: "json",
	        success: function(res) {
				
				// 별점 세팅
				updateStars(res.reviewRating);
				// 내용 세팅
				form.querySelector("textarea[name='review_content']").value = res.reviewContent;
	            
	            // 기존 이미지 미리보기 세팅
	            reviewImgFiles = []; // 파일 배열 초기화 (수정 시 새로 올릴 파일들을 담기 위함)
	            
	            const existingImgs = [res.reviewImg1, res.reviewImg2, res.reviewImg3, res.reviewImg4, res.reviewImg5];
	            
	            existingImgs.forEach((path) => {
	                if(path && path !== "") {							
						// 기존 이미지는 서버 파일이라 File 객체는 못 만들지만 자리 유지용 dummy 객체 넣어둠
						reviewImgFiles.push({ existing: true, name: path });
	                }
	            });
				
				reviewOrder.textContent = res.reviewOrder
				renderPreviews();
				
	            const updateModal = bootstrap.Modal.getInstance(reviewModal) || new bootstrap.Modal(reviewModal);
	            updateModal.show();
	        },
	        error: function() {
	            alert("리뷰 정보를 가져오는데 실패했습니다.");
	        }
	    });
	});
	
	// 수정-기존 이미지를 미리보기에서 제거하는 함수
	window.removeExistingImg = function(btn, path) {
	    if(confirm("기존 이미지를 삭제하시겠습니까? 등록 시 실제 파일이 삭제됩니다.")) {
	        const preview = btn.parentElement;
			
			reviewImgFiles = reviewImgFiles.filter(f => f.name !== path);
			
	        // hidden input의 값을 비워서 서버에 삭제 대상임을 알림
	        const hiddenInput = preview.querySelector("input[type='hidden']");
	        if(hiddenInput) hiddenInput.value = ""; 
	        preview.style.display = "none"; // 화면에서만 숨김 (제출 시 데이터 처리를 위해)
			updateImgCount();
	    }
	};

});

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
		
		const reviewCount = parseInt(this.dataset.reviewCount, 10) || 0;
		document.getElementById("reviewOrder").textContent = reviewCount + 1;
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
		delete form.dataset.editIdx;
		
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
		const orderEl = document.getElementById("reviewOrder");
		if (orderEl) orderEl.textContent = "";
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
		const isEditMode = this.dataset.mode === "edit";
		const form = this;
		const editIdx = form.dataset.editIdx;

		// 수정 모드일 경우 reviewIdx 추가
		if (isEditMode) {
		    formData.append("review_idx", editIdx);
		}

		const url = isEditMode 
		    ? ctxPath + "/review/review_update.jsp"
		    : ctxPath + "/review/review_save.jsp";

    	$.ajax({
        	url: url,
        	type: "POST",
        	data: formData,
        	processData: false, // jQuery가 데이터를 문자열로 변환하지 않도록 설정 (파일 업로드 시 필수)
        	contentType: false, // 폼 데이터의 Content-Type을 자동 설정
        	dataType: "json",  
        	success: function (res) {
				
				// 로그인 확인 - 프론트(서버 결과 처리)
				if (res.reviewResult === "login_required") {
				    alert("로그인이 필요합니다.");
				    location.href = ctxPath + "/login/login_form.jsp"; 
				    return;
				}

            	if (res.reviewResult === "success") {
					
					// 평균 평점 갱신
					const storeRating = document.querySelector(".store-rating");
					storeRating.innerText =
					    res.avgRating.toFixed(1) + " (" + res.reviewCount + ")";
						
					if (isEditMode) {
					    const target = document.getElementById("review-" + editIdx);
					    if (target) {
					        target.outerHTML = res.reviewHtml;
					    }
					} else {
						// 리뷰 목록 맨 위에 추가
					    const reviewSection = document.querySelector(".review-section");
					    const header = reviewSection.querySelector(".review-header");
					    header.insertAdjacentHTML("afterend", res.reviewHtml);

					    // 리뷰 순서 갱신 (신규일 때만 의미 있음)
					    document.getElementById('reviewOrder').innerText = res.reviewOrder;
					}				
											
					allowClose = true;
					
					alert(isEditMode ? "리뷰 수정 성공" : "리뷰 등록 성공");

					// 모달 닫기
					const modal = bootstrap.Modal.getInstance(reviewModal);
					modal.hide();

            	} else {
                	alert(isEditMode ? "리뷰 수정 실패" : "리뷰 등록 실패");
					alert(res.reviewResult + " / " + res.message);
            	}
        	},
        	error: function () {
            	alert("서버 오류 발생");
        	}
    	});
	});
	// ================== 리뷰 수정용 함수 ==================
	window.openUpdateReviewModal = function(reviewIdx, storeIdx) {
		// 1. 수정 모드임을 알리기 위한 변수 설정 (필요 시)
	    const form = document.querySelector("#reviewModal form");
	    form.dataset.mode = "edit";
	    form.dataset.editIdx = reviewIdx;
		
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
				
				document.getElementById("reviewOrder").textContent = res.reviewOrder
				renderPreviews();
				
	            const updateModal = bootstrap.Modal.getInstance(reviewModal) || new bootstrap.Modal(reviewModal);
	            updateModal.show();
	        },
	        error: function() {
	            alert("리뷰 정보를 가져오는데 실패했습니다.");
	        }
	    });
	};

	// 기존 이미지를 미리보기에서 제거하는 함수
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
	
	//수정 버튼
	$(document).on("click", ".review-edit-btn", function() {
	    const reviewIdx = $(this).closest(".review-item").attr("id").split("-")[1];
	    window.openUpdateReviewModal(reviewIdx);
	});
	
	//삭제
	$(document).on("click", ".review-delete-btn", function() {
	    const reviewItem = $(this).closest(".review-item");
	    const reviewIdx = reviewItem.attr("id").split("-")[1];

	    if (confirm("정말 이 리뷰를 삭제하시겠습니까?")) {
	        $.ajax({
	            url: ctxPath + "/review/review_delete.jsp",
	            type: "POST",
	            data: { "reviewIdx": reviewIdx, "storeIdx": reviewItem.data("store-idx")},
	            dataType: "json",
	            success: function(res) {
	                if (res.deleteResult === "success") {
	                    alert("삭제되었습니다.");
	                    reviewItem.remove();
						const storeRating = document.querySelector(".store-rating");
						storeRating.innerText =
						    res.avgRating.toFixed(1) + " (" + res.reviewCount + ")";
	                } else {
	                    alert("삭제 실패");
	                }
	            }
	    	});
		}
	});
	
	
});

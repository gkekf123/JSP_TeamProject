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
	const reviewImgPreview = document.getElementById("reviewImgPreview");
	const imgCount = document.getElementById("imgCount");
	const MAX_IMAGES = 5;
	const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
	let reviewImgFiles = [];
	
    function updateImgCount() {
        imgCount.innerText = reviewImgFiles.length;
    }
	
	// 미리보기 재렌더링 함수 (순서 보장)
	function renderPreviews() {
	    reviewImgPreview.innerHTML = ""; 
	    
	    if (reviewImgFiles.length === 0) {
	        updateImgCount();
	        return;
	    }

	    // 순차적으로 이미지를 읽기 위한 내부 함수
	    function readAndPreview(index) {
	        if (index >= reviewImgFiles.length) {
	            updateImgCount();
	            return;
	        }

	        const reader = new FileReader(); 
	        const file = reviewImgFiles[index]; ////////

	        reader.onload = function(e) {
	            const wrapper = document.createElement("div"); 
	            wrapper.className = "preview-item";

	            const img = document.createElement("img");
	            img.src = e.target.result;

	            const delBtn = document.createElement("button"); 
	            delBtn.type = "button";
	            delBtn.className = "preview-delete";
	            delBtn.innerText = "✕";
	            
	            delBtn.onclick = function() {
	                reviewImgFiles.splice(index, 1); // 특정위치에 있는 요소를 제거, 교체
	                updateInputs();
	                renderPreviews();
	            };

	            wrapper.appendChild(img);
	            wrapper.appendChild(delBtn);
	            reviewImgPreview.appendChild(wrapper);

	            // 다음 이미지 읽기
	            readAndPreview(index + 1);
	        };

	        reader.readAsDataURL(file);
	    }

	    readAndPreview(0);
	}

	  // input에 파일 재할당 함수(순서대로)
	  function updateInputs() {
	      // 모든 input 초기화
	      for (let i = 1; i <= MAX_IMAGES; i++) {
	          const input = document.getElementById('reviewImg' + i);
	          if (input) 
				input.value = "";
	      }
	      
	      // 배열 순서대로 input에 할당
	      reviewImgFiles.forEach((file, index) => {
	          const input = document.getElementById('reviewImg' + (index + 1));
	          if (input) {
	              const dataTransfer = new DataTransfer();
	              dataTransfer.items.add(file);
	              input.files = dataTransfer.files;
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
				hasDuplicate = true; // 중복이 있음을 기록
			    continue;            // 중복된 파일은 validFiles에 넣지 않고 건너뜀
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
		    updateInputs();    // input들에 파일 재할당
		    renderPreviews();  // 미리보기 렌더링
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
/*        reviewImg.value = "";*/
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

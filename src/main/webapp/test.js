document.addEventListener("DOMContentLoaded", () => {

	var modal = document.getElementById('modernBsModal');

	modal.addEventListener('show.bs.modal', function (event) {
	    var btn = event.relatedTarget; // 클릭한 버튼
	    var storeIdx = btn.getAttribute('data-store-idx');

	    document.getElementById('modalStoreIdx').value = storeIdx;
	});

	/* ================= 별점 드래그 ================= */
	const stars = document.querySelectorAll("#bsStarGroup span");
	const starText = document.getElementById("bsStarText");
	const scoreInput = document.getElementById("score");
	let isDragging = false;

	function updateStars(value) {
    	scoreInput.value = value;

    	stars.forEach(star => {
        	star.classList.toggle("active", star.dataset.v <= value);
    	});

    	starText.innerText = value + "점을 선택하셨습니다!";
    	starText.classList.remove("text-muted");
    	starText.classList.add("star-selected");
	}

	stars.forEach(star => {
    	star.addEventListener("mousedown", () => {
        	isDragging = true;
        	updateStars(star.dataset.v);
    	});

    	star.addEventListener("mouseenter", () => {
        	if (isDragging) updateStars(star.dataset.v);
    	});

    	star.addEventListener("click", () => {
        	updateStars(star.dataset.v);
    	});
	});

	window.addEventListener("mouseup", () => isDragging = false);


	/* ================= 이미지 누적 업로드 (수정본) ================= */
	    const fileInput = document.getElementById("reviewImg");
	    const previewBox = document.getElementById("previewBox");
	    const imgCountText = document.getElementById("imgCount");
	    const MAX_IMAGES = 5;
	    let imageFiles = [];

		fileInput.addEventListener("change", function () {
		    const selectedFiles = Array.from(this.files);

		    // 1. 개수 제한 체크 (합계가 5장을 넘으면 바로 차단)
		    if (imageFiles.length + selectedFiles.length > MAX_IMAGES) {
		        alert(`📸 이미지는 최대 ${MAX_IMAGES}장까지 등록할 수 있습니다.\n(현재 ${imageFiles.length}장 등록됨)`);
		        this.value = ""; // 입력창 초기화
		        return; // 여기서 함수를 종료하여 팝업이 여러번 뜨지 않게 함
		    }

		    // 2. 파일 처리
		    selectedFiles.forEach(file => {
		        if (!file.type.startsWith("image/")) return;

		        // 중복 체크 (이름, 크기 기준)
		        const isDuplicate = imageFiles.some(f =>
		            f.name === file.name && f.size === file.size
		        );

		        if (!isDuplicate) {
		            imageFiles.push(file);
		            createPreview(file);
		        }
		    });

		    // 3. UI 갱신
		    updateImageCount();
		    this.value = ""; // 같은 파일을 다시 올릴 수 있도록 초기화
		});
		
	function createPreview(file) {
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
	            imageFiles = imageFiles.filter(f => f !== file);
	            wrapper.remove();
	            imgCountText.innerText = imageFiles.length; // ✅ 삭제 시 카운트 갱신
	        };

	        wrapper.appendChild(img);
	        wrapper.appendChild(delBtn);
	        previewBox.appendChild(wrapper);
	    };

	    reader.readAsDataURL(file);
	}



	/* ================= 닫기 전 경고 + 초기화 ================= */

	const modalEl = document.getElementById("modernBsModal");
	let allowClose = false;

	// 입력 상태 체크
	function hasInput() {
    	return (
        	scoreInput.value !== "" ||
        	document.querySelector("textarea[name='content']").value.trim() !== "" ||
        	imageFiles.length > 0
    	);
	}

	// 닫히기 직전 이벤트
	modalEl.addEventListener("hide.bs.modal", e => {

    	if (!allowClose && hasInput()) {
			if(!confirm("작성 중인 내용이 있습니다. 정말 닫을까요?")) 
				e.preventDefault();
			else 
				allowClose = true;
    	}
	});

	// 닫힌 후 초기화
	modalEl.addEventListener("hidden.bs.modal", () => {
    	resetReviewForm();
    	allowClose = false;
	});

	// 초기화 함수
	function resetReviewForm() {

    // ⭐ 별점 초기화
    stars.forEach(star => star.classList.remove("active"));
    starText.innerText = "별을 드래그하여 점수를 매겨주세요";
    starText.className = "text-muted";
    scoreInput.value = "";

    // 📝 텍스트 초기화
    document.querySelector("textarea[name='content']").value = "";

    // 📷 이미지 초기화
    imageFiles = [];
    previewBox.innerHTML = "";
    fileInput.value = "";
	
	// ✅ 카운트 초기화
	imgCountText.innerText = "0";
	}
	
	// 폼 전송 시점에 배열에 담긴 파일들을 input에 넣어줌
	document.querySelector("#modernBsModal form").addEventListener("submit", function(e) {
	    const dataTransfer = new DataTransfer();
	    
		// 우리가 배열(imageFiles)에 따로 모아둔 파일들을 전송용 데이터로 변환
	    imageFiles.forEach(file => {
	        dataTransfer.items.add(file);
	    });
	    
	    // input 태그에 우리가 관리한 imageFiles 배열의 파일들을 할당
	    document.getElementById("reviewImg").files = dataTransfer.files;
	    
	    // 만약 별점이나 내용을 입력 안했다면 체크
	    if(!scoreInput.value) {
	        alert("별점을 선택해주세요!");
	        e.preventDefault();
			return;
	    }
	});

});
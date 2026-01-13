<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.modal-content { 
    border: none; 
    border-radius: 25px; 
    box-shadow: 0 15px 35px rgba(0,0,0,0.1); 
}
.modal-header { 
    border-bottom: none; 
    padding-top: 30px; 
}
.modal-footer {
    border-top: none; 
    padding-bottom: 30px; 
}
.btn-submit { 
   	background: #6366f1; 
   	border: none; 
   	border-radius: 12px; 
   	padding: 12px; 
   	font-weight: 600; 
   	color: white; 
}
.btn-submit:hover { 
    background: #4f46e5; 
}

/* 별점 스타일 */
.bs-stars { 
    font-size: 40px; 
    color: #e5e7eb; 
    cursor: pointer; 
    transition: 0.2s; 
}
.bs-stars span.active {
     color: #fbbf24; 
     text-shadow: 0 0 10px rgba(251, 191, 36, 0.4); 
}
.upload-box {
     background: #f9fafb; 
     border: 2px dashed #e5e7eb; 
     border-radius: 15px; 
     padding: 20px; 
     cursor: pointer; 
}
.bs-stars span {
	user-select: none;
    -webkit-user-select: none;
}
</style>
</head>
<body>
<!-- modal fade: 이 요소가 모달임을 선언하며, fade는 열리고 닫힐 때 부드러운 애니메이션 효과  -->
<div class="modal fade" id="modernBsModal" tabindex="-1"> 
	<!-- modal-dialog-centered: 모달창을 화면 정중앙(세로 기준)에 배치 -->
    <div class="modal-dialog modal-dialog-centered">   
    	<!-- modal-content: 실제 흰색 배경과 내용이 들어가는 본체 +css추가 -->
        <div class="modal-content">
        
        	<!-- justify-content-center: 제목을 가운데 정렬합니다. -->
            <div class="modal-header justify-content-center">
            	<!-- fw-bold: 글자를 굵게  -->
                <h4 class="modal-title fw-bold">리뷰 작성하기✍️</h4>                
            </div>
            
            <div class="modal-body px-4">
                <div class="text-center mb-4">
                    <div class="bs-stars" id="bsStarGroup">
                    <!-- 사용자 지정 -->
                        <span data-v="1">★</span>
                        <span data-v="2">★</span>
                        <span data-v="3">★</span>
                        <span data-v="4">★</span>
                        <span data-v="5">★</span>
                    </div>
                    <small class="text-muted" id="bsStarHint">별을 드래그하여 점수를 매겨주세요</small>
                </div>
                
                <div class="upload-box text-center mb-3" onclick="document.getElementById('bsFile').click()">
                    <span class="text-muted">📷 사진을 여기에 드래그하거나 클릭하세요</span>
                    <input type="file" id="bsFile" hidden multiple>
                </div>
                
                <textarea class="form-control border-0 bg-light p-3" rows="4" placeholder="작성하신 리뷰는 다른 구매자들에게 큰 도움이 됩니다." style="border-radius: 15px;"></textarea>
            </div>
            
            <div class="modal-footer px-4">
                <button type="button" class="btn btn-submit w-100 shadow-sm">리뷰 등록하기</button>
            </div>
            
        </div>
    </div>
</div>

<button class="btn btn-dark px-4 py-2" data-bs-toggle="modal" data-bs-target="#modernBsModal">부트스트랩 버전 실행</button>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", () => {
    const stars = document.querySelectorAll("#bsStarGroup span");
    let isDragging = false;
    let score = 0;

    const updateStars = (value) => {
        score = value;
        stars.forEach(star => {
            star.classList.toggle("active", star.dataset.v <= value);
        });
    };

    // 마우스 누르면 드래그 시작
    stars.forEach(star => {
        star.addEventListener("mousedown", () => {
            isDragging = true;
            updateStars(star.dataset.v);
        });

        // 드래그 중 별 위에 올라가면 점수 변경
        star.addEventListener("mouseenter", () => {
            if (isDragging) {
                updateStars(star.dataset.v);
            }
        });

        // 클릭만 해도 선택 가능
        star.addEventListener("click", () => {
            updateStars(star.dataset.v);
        });
    });

    // 마우스 떼면 드래그 종료
    window.addEventListener("mouseup", () => {
        isDragging = false;
    });
});
</script>
</body>
</html>
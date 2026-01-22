
//슬라이드
document.addEventListener("DOMContentLoaded", () => {
    const slides = document.querySelectorAll(".slide");
    const dots = document.querySelectorAll(".dot");
    const prevBtn = document.querySelector(".slider-btn.prev");
    const nextBtn = document.querySelector(".slider-btn.next");

    let current = 0;
    const total = slides.length;
    let timer;

    function showSlide(index) {
        slides.forEach(slide => slide.classList.remove("active"));
        dots.forEach(dot => dot.classList.remove("active"));

        slides[index].classList.add("active");
        dots[index].classList.add("active");

        current = index;
    }

    function nextSlide() {
        let next = (current + 1) % total;
        showSlide(next);
    }

    function prevSlide() {
        let prev = (current - 1 + total) % total;
        showSlide(prev);
    }

    function startAuto() {
        timer = setInterval(nextSlide, 3000); // ⏱ 3초
    }

    function stopAuto() {
        clearInterval(timer);
    }

    // 버튼 이벤트
    nextBtn.addEventListener("click", () => {
        stopAuto();
        nextSlide();
        startAuto();
    });

    prevBtn.addEventListener("click", () => {
        stopAuto();
        prevSlide();
        startAuto();
    });

    // dot 클릭
    dots.forEach((dot, idx) => {
        dot.addEventListener("click", () => {
            stopAuto();
            showSlide(idx);
            startAuto();
        });
    });

    startAuto();
});


//찜 버튼 (ctxPath는 전역 변수로 사용)
function toggleBookmark(btn, storeIdx, storeName, storeAddr) {
    console.log("찜 버튼 클릭");
    
    var isEmpty = $(btn).text().trim() === '♡';

    // 서버 요청
    $.ajax({
        type: "POST",
        url: ctxPath + "/bookmark/bookmark_action.jsp",
        data: {
            store_idx: storeIdx,
            place_name: storeName,
            place_addr: storeAddr
        },
        success: function(res) {
            console.log("서버 응답:", res);
            res = res.trim();
            
            if (res === "login_needed") {
                alert("로그인이 필요합니다.");
                location.href = ctxPath + "/login/login_form.jsp";
            } else if (res === "added") {
                // 찜 추가 성공
                $(btn).text('♥').css("transform", "scale(1.4)");
                setTimeout(() => $(btn).css("transform", "scale(1)"), 200);
                console.log("찜 추가됨");
            } else if (res === "removed") {
                // 찜 제거 성공
                $(btn).text('♡');
                console.log("찜 제거됨");
            } else if (res === "error") {
                alert("처리 실패");
            } else {
                console.log("알 수 없는 응답:", res);
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error:", status, error);
            console.error("Response:", xhr.responseText);
            alert("서버 오류");
        }
    });
}
	
	
	//메뉴 수정
	function openEditMenuModal(menuIdx, menuName, menuPrice, menuImg) {

	    // hidden 값 세팅
	    document.querySelector("input[name='menuIdx']").value = menuIdx;

	    // 기존 값 채우기
	    document.querySelector("input[name='menuName']").value = menuName;
	    document.querySelector("input[name='menuPrice']").value = menuPrice;

	    // 이미지 미리보기 (선택)
	    if (menuImg) {
	        document.getElementById("menuPreview").src =
	            "<%= ctxPath %>/images/menu/" + menuImg;
	        document.getElementById("menuPreview").style.display = "block";
	    }

	    // 제목 변경
	    document.getElementById("menuModalTitle").innerText = "메뉴 수정";

	    // 모달 열기
	    new bootstrap.Modal(document.getElementById("menuAddModal")).show();
	}
	
	//메뉴추가버튼
	function openMenuModal(storeIdx) {
	    document.getElementById("menuStoreIdx").value = storeIdx;
	    document.getElementById("menuModalTitle").innerText = "메뉴 추가";
	    new bootstrap.Modal(document.getElementById("menuAddModal")).show();
	}

	
	//리뷰더보기
	function showMoreReviews() {
	    // 숨겨진 리뷰 전부 가져오기
	    const hiddenReviews = document.querySelectorAll('.review-hidden');

	    hiddenReviews.forEach(review => {
	        review.classList.remove('review-hidden');
	    });

	    // 더보기 버튼 숨기기
	    document.querySelector('.review-more-btn').style.display = 'none';
	}
	
	
	//리뷰이미지 모달
	function showReviewImages(img1, img2, img3, img4, img5) {
	    const images = [img1, img2, img3, img4, img5];
	    const modalBody = document.getElementById('reviewModalImages');
	    
	    // 1. 기존 모달 내용 비우기
	    modalBody.innerHTML = '';
	    
	    // 2. 이미지가 있는 것만 찾아서 img 태그 생성
	    images.forEach(imgName => {
	        if (imgName && imgName !== 'null' && imgName !== '') {
	            const imgTag = document.createElement('img');
	            imgTag.src = ctxPath + '/images/review_upload/' + imgName;
	            imgTag.className = 'img-fluid mb-2 w-100 rounded'; // Bootstrap 클래스로 스타일 지정
	            modalBody.appendChild(imgTag);
	        }
	    });
	    
	    // 3. 모달 띄우기
	    const imageModal = new bootstrap.Modal(document.getElementById('reviewImageModal'));
	    imageModal.show();
	}

	
	//지도
	var mapContainer = document.getElementById('map');
	    var mapOption = {
	        center: new kakao.maps.LatLng(37.5665, 126.9780), // 임시 서울
	        level: 3
	    };

	    var map = new kakao.maps.Map(mapContainer, mapOption);
	    var geocoder = new kakao.maps.services.Geocoder();

	    // 가게 주소
	    var storeAddr = "<%= dto.getStoreAddr() %>";
	    var storeName = "<%= dto.getStoreName() %>";

	    geocoder.addressSearch(storeAddr, function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {

	            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	            // 마커 생성
	            var marker = new kakao.maps.Marker({
	                map: map,
	                position: coords
	            });

	            // 인포윈도우
	            var infowindow = new kakao.maps.InfoWindow({
	                content: '<div style="padding:5px;font-size:13px;">' + storeName + '</div>'
	            });
	            infowindow.open(map, marker);

	            map.setCenter(coords);
	        }
	    });
	
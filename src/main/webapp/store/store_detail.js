// 슬라이드 기능
document.addEventListener("DOMContentLoaded", () => {
    const slides = document.querySelectorAll(".slide");
    const dots = document.querySelectorAll(".dot");
    const prevBtn = document.querySelector(".slider-btn.prev");
    const nextBtn = document.querySelector(".slider-btn.next");

    if (slides.length === 0) return; // 슬라이드가 없으면 실행하지 않음

    let current = 0;
    const total = slides.length;
    let timer;

    function showSlide(index) {
        slides.forEach(slide => slide.classList.remove("active"));
        dots.forEach(dot => dot.classList.remove("active"));

        if(slides[index]) slides[index].classList.add("active");
        if(dots[index]) dots[index].classList.add("active");

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
    if(nextBtn) {
        nextBtn.addEventListener("click", () => {
            stopAuto();
            nextSlide();
            startAuto();
        });
    }

    if(prevBtn) {
        prevBtn.addEventListener("click", () => {
            stopAuto();
            prevSlide();
            startAuto();
        });
    }

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


// 찜 버튼 (ctxPath는 전역 변수로 사용)
function toggleBookmark(btn, storeIdx, storeName, storeAddr) {
    console.log("찜 버튼 클릭");
    
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
            res = res.trim();
            
            if (res === "login_needed") {
                alert("로그인이 필요합니다.");
                location.href = ctxPath + "/login/login_form.jsp";
            } else if (res === "added") {
                // 찜 추가 성공
                $(btn).text('♥').css("transform", "scale(1.4)");
                setTimeout(() => $(btn).css("transform", "scale(1)"), 200);
            } else if (res === "removed") {
                // 찜 제거 성공
                $(btn).text('♡');
            } else if (res === "error") {
                alert("처리 실패");
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error:", status, error);
            alert("서버 오류");
        }
    });
}

// ★★★ [수정됨] 메뉴 수정 모달 열기 함수 ★★★
function openEditMenuModal(menuIdx, menuName, menuPrice, menuImg) {
    // 1. 폼의 Action을 '수정 처리 페이지'로 변경 (중요)
    var form = document.getElementById("menuForm");
    if(form) {
        form.action = ctxPath + "/menu/menu_update_action.jsp";
    }

    // 2. 기존 데이터 채워넣기 (ID는 menu_add.jsp의 input id와 일치해야 함)
    document.getElementById("updateMenuIdx").value = menuIdx;
    document.getElementById("updateMenuName").value = menuName;
    document.getElementById("updateMenuPrice").value = menuPrice;
    document.getElementById("oldMenuImg").value = menuImg; // 기존 이미지명 hidden에 저장

    // 3. UI 변경 (제목, 버튼 텍스트)
    document.getElementById("menuModalTitle").innerText = "메뉴 수정";
    document.getElementById("menuSubmitBtn").innerText = "수정 완료";
    
    // 4. 기존 이미지 미리보기 텍스트 (선택사항)
    var imgArea = document.getElementById("currentImgPath");
    if(imgArea) {
        imgArea.innerText = menuImg ? "현재 등록된 이미지: " + menuImg : "현재 등록된 이미지 없음";
    }

    // 5. 모달 띄우기
    var myModal = new bootstrap.Modal(document.getElementById('menuAddModal'));
    myModal.show();
}

// 메뉴 추가 버튼 (단순 모달 호출용, 초기화는 아래 이벤트 리스너에서 처리)
function openMenuModal(storeIdx) {
    var myModal = new bootstrap.Modal(document.getElementById('menuAddModal'));
    myModal.show();
}


// 리뷰 더보기
function showMoreReviews() {
    // 숨겨진 리뷰 전부 가져오기
    const hiddenReviews = document.querySelectorAll('.review-hidden');

    hiddenReviews.forEach(review => {
        review.classList.remove('review-hidden');
    });

    // 더보기 버튼 숨기기
    const moreBtn = document.querySelector('.review-more-btn');
    if(moreBtn) moreBtn.style.display = 'none';
}


// 리뷰 이미지 모달
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
            imgTag.className = 'img-fluid mb-2 w-100 rounded'; 
            modalBody.appendChild(imgTag);
        }
    });
    
    // 3. 모달 띄우기
    const imageModal = new bootstrap.Modal(document.getElementById('reviewImageModal'));
    imageModal.show();
}

// 메뉴 모달 초기화 (추가 버튼 눌렀을 때 리셋)
// jQuery를 사용한 부트스트랩 모달 이벤트
$('#menuAddModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget); // 모달을 열게 만든 버튼
    
    // 'menu-add-btn' 클래스를 가진 버튼(추가 버튼)일 때만 실행
    if (button.hasClass('menu-add-btn')) {
        // 1. 폼 Action을 '추가 처리 페이지'로 복구
        var form = document.getElementById("menuForm");
        if(form) {
            form.reset(); // 입력값 비우기
            form.action = ctxPath + "/menu/menu_add_action.jsp";
        }

        // 2. UI 복구
        $("#menuModalTitle").text("메뉴 추가");
        $("#menuSubmitBtn").text("등록");
        
        // 3. Hidden 값 및 텍스트 초기화
        $("#updateMenuIdx").val("");
        $("#oldMenuImg").val("");
        $("#currentImgPath").text("");
    }
});


// 지도 기능 (JSP 변수가 포함되어 있으므로 JSP 파일 내 <script>에 있어야 작동함)
document.addEventListener("DOMContentLoaded", function() {
    var mapContainer = document.getElementById('map');
    if (mapContainer && typeof kakao !== 'undefined') {
        var mapOption = {
            center: new kakao.maps.LatLng(37.5665, 126.9780), // 임시 서울
            level: 3
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);
        var geocoder = new kakao.maps.services.Geocoder();

        // JSP에서 값을 받아와야 하는 변수들 (외부 JS 파일일 경우 전역변수로 선언되어 있어야 함)
        if(typeof storeAddr !== 'undefined' && typeof storeName !== 'undefined') {
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
        }
    }
});

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


//찜 버튼
function toggleBookmark(btn, storeIdx, storeName, storeAddr) {

    var isEmpty = $(btn).text().trim() === '♡';

    // UI 먼저 변경
    if (isEmpty) {
        $(btn).text('♥').css("transform", "scale(1.4)");
        setTimeout(() => $(btn).css("transform", "scale(1)"), 200);
    } else {
        $(btn).text('♡');
    }

    // 서버 요청
    $.ajax({
        type: "POST",
        url: "<%= ctxPath %>/bookmark/bookmark_action.jsp",
        data: {
            store_idx: storeIdx,
            place_name: storeName,
            place_addr: storeAddr
        },
        success: function(res) {
            res = res.trim();
            if (res === "login_needed") {
                alert("로그인이 필요합니다.");
                location.href = "<%= ctxPath %>/login/login.jsp";
                $(btn).text(isEmpty ? '♡' : '♥');
            } else if (res === "error") {
                alert("처리 실패");
                $(btn).text(isEmpty ? '♡' : '♥');
            }
        },
        error: function() {
            alert("서버 오류");
            $(btn).text(isEmpty ? '♡' : '♥');
        }
    });
	
	
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
	
	
}
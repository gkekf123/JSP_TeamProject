// 카테고리 선택 함수
function selectCategory(catCode) {
    var catInput = document.getElementById("categoryInput");
    if(catInput) {
        catInput.value = catCode;
    }

    var searchInput = document.querySelector('input[name="q"]');
    if (searchInput) {
        searchInput.value = "";
        searchInput.setAttribute("value", "");
    }

    var form = document.getElementById("searchForm");
    if(form) {
        form.submit();
    }
}

// 정렬 변경 함수
function changeSort() {
    var sortVal = document.getElementById("sortFilter").value;
    document.querySelector('input[name="sort"]').value = sortVal;
    document.getElementById("searchForm").submit();
}

// 찜하기 토글 함수
function toggleBookmark(btn, storeIdx, storeName, storeAddr) {
    var currentText = $(btn).text().trim();
    var isEmpty = (currentText === '♡');
    
    if(isEmpty) {
        $(btn).text('♥');
        $(btn).css({transform: "scale(1.5)", transition: "0.2s"});
        setTimeout(() => $(btn).css("transform", "scale(1)"), 200);
    } else {
        $(btn).text('♡');
        $(btn).css("transform", "scale(1)");
    }
    
    $.ajax({
        type: "POST",
        url: ctxPath + "/bookmark/bookmark_action.jsp", 
        data: {
            store_idx: storeIdx,
            place_name: storeName,
            place_addr: storeAddr
        },
        success: function(response) {
            var res = response.trim();
            if(res === "login_needed") {
                alert("로그인이 필요합니다.");
                location.href = ctxPath + "/login/login_form.jsp";
                $(btn).text(isEmpty ? '♡' : '♥'); 
            } else if(res === "error") {
                alert("처리 실패");
                $(btn).text(isEmpty ? '♡' : '♥'); 
            }
        },
        error: function() {
            console.log("AJAX Error");
            $(btn).text(isEmpty ? '♡' : '♥'); 
        }
    });
}

// 마우스 호버 시에만 이미지 변경 기능
document.addEventListener("DOMContentLoaded", function() {
    // 1. 개별 이미지가 아니라 '카드(store-card)' 전체를 선택
    const cards = document.querySelectorAll(".store-card");

    cards.forEach(card => {
        // 카드 안에 있는 이미지 태그 찾기
        const imgElement = card.querySelector(".slide-img");
        
        // 이미지가 없거나, data-imgs 속성이 없으면 패스
        if (!imgElement || !imgElement.getAttribute("data-imgs")) return;

        const imgListStr = imgElement.getAttribute("data-imgs");
        const imgList = imgListStr.split(",");
        
        // 이미지가 1개 이하면 롤링할 필요 없음
        if (imgList.length <= 1) return;

        let intervalId = null; // 타이머 ID 저장용
        let currentIndex = 0;

        // 2. 마우스를 올렸을 때 (mouseenter) -> 타이머 시작
        card.addEventListener("mouseenter", () => {
            if (intervalId) clearInterval(intervalId); // 혹시 모를 중복 방지

            // 1초마다 이미지 변경 (호버 시에는 좀 더 빨리 바뀌는 게 반응감이 좋음)
            intervalId = setInterval(() => {
                currentIndex = (currentIndex + 1) % imgList.length;
                imgElement.src = imgList[currentIndex];
            }, 1000); 
        });

        // 3. 마우스가 떠났을 때 (mouseleave) -> 타이머 멈춤 & 초기화
        card.addEventListener("mouseleave", () => {
            if (intervalId) {
                clearInterval(intervalId); // 타이머 삭제
                intervalId = null;
            }
            // (선택사항) 마우스 떼면 다시 첫 번째 대표 이미지로 복귀
            currentIndex = 0;
            imgElement.src = imgList[0];
        });
    });
});
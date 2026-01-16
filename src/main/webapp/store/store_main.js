/* store_main.js */

// 카테고리 선택 함수 (검색어 초기화 기능 추가)
function selectCategory(catCode) {
    // 1. 선택한 카테고리 값(hidden input) 설정
    var catInput = document.getElementById("categoryInput");
    if(catInput) {
        catInput.value = catCode;
    }

    // 2. 검색어 빈칸으로 초기화
    var searchInput = document.querySelector('input[name="q"]');
    if (searchInput) {
        searchInput.value = "";
		searchInput.setAttribute("value", "");
    }

    // 3. 폼 제출 (화면 이동)
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
    
    // 1. 화면 먼저 변경
    if(isEmpty) {
        $(btn).text('♥');
        $(btn).css({transform: "scale(1.5)", transition: "0.2s"});
        setTimeout(() => $(btn).css("transform", "scale(1)"), 200);
    } else {
        $(btn).text('♡');
        $(btn).css("transform", "scale(1)");
    }
    
    // 2. 서버 요청
    $.ajax({
        type: "POST",
        url: "/bookmark/bookmark_action.jsp", 
        data: {
            store_idx: storeIdx,
            place_name: storeName,
            place_addr: storeAddr
        },
        success: function(response) {
            var res = response.trim();
            if(res === "login_needed") {
                alert("로그인이 필요합니다.");
                location.href = "/login/login.jsp";
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
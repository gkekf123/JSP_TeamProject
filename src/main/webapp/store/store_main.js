// 정렬 변경
function changeSort() {
    var sortVal = document.getElementById("sortFilter").value;
    document.querySelector('input[name="sort"]').value = sortVal;
    document.querySelector('.search-box').submit();
}

// 찜하기 토글
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

    // 2. 서버 요청 (비동기)
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
                alert("로그인이 필요한 서비스입니다.");
                location.href = "/login/login.jsp";
                $(btn).text(isEmpty ? '♡' : '♥'); // 롤백
            } else if(res === "error") {
                alert("처리 실패");
                $(btn).text(isEmpty ? '♡' : '♥'); // 롤백
            }
        },
        error: function() {
            console.log("AJAX Error");
            $(btn).text(isEmpty ? '♡' : '♥'); // 롤백
        }
    });
}
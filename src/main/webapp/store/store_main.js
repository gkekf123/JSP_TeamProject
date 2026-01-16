/* * store_main.js 
 * 카테고리 선택, 정렬 변경, 찜하기 기능
 */

// 카테고리 선택 함수
function selectCategory(catCode) {
    // 1. hidden input에 선택한 카테고리 값 넣기
    document.getElementById("categoryInput").value = catCode;
    // 2. 폼 제출 (화면 새로고침)
    document.getElementById("searchForm").submit();
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
                $(btn).text(isEmpty ? '♡' : '♥'); // 실패 시 롤백
            } else if(res === "error") {
                alert("처리 실패: 잠시 후 다시 시도해주세요.");
                $(btn).text(isEmpty ? '♡' : '♥'); // 실패 시 롤백
            }
        },
        error: function() {
            console.log("AJAX Error");
            alert("서버 통신 오류");
            $(btn).text(isEmpty ? '♡' : '♥'); // 실패 시 롤백
        }
    });
}
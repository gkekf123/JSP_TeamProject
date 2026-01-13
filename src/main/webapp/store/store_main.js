// 정렬(Select Box) 변경 시 form 제출
function changeSort() {
    var sortVal = document.getElementById("sortFilter").value;
    // hidden input에 값 설정
    document.querySelector('input[name="sort"]').value = sortVal;
    // form 강제 제출
    document.querySelector('.search-box').submit();
}

// 찜하기 토글 함수
function toggleBookmark(btn, storeIdx, storeName, storeAddr) {
    // 1. 현재 하트 상태 확인
    var currentText = $(btn).text().trim();
    var isEmpty = (currentText === '♡'); // 비어있으면 true
    
    // 서버 응답 기다리지 않고 즉시 화면 변경
    if(isEmpty) {
        $(btn).text('♥'); // 채운 하트로 변경
        $(btn).css({transform: "scale(1.5)", transition: "0.2s"});
        setTimeout(() => $(btn).css("transform", "scale(1)"), 200);
    } else {
        $(btn).text('♡'); // 빈 하트로 변경
        $(btn).css("transform", "scale(1)");
    }

    // 서버에 비동기 요청
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
                // 로그인이 필요하면 롤백(원상복구) 및 이동
                alert("로그인이 필요한 서비스입니다.");
                location.href = "/login/login.jsp"; 
                // 화면 원상복구
                $(btn).text(isEmpty ? '♡' : '♥'); 
            } else if(res === "error") {
                // 에러나면 롤백
                alert("서버 오류로 처리에 실패했습니다.");
                $(btn).text(isEmpty ? '♡' : '♥');
            }
        },
        error: function() {
            // 통신 에러 시 롤백
            console.log("AJAX Error");
            $(btn).text(isEmpty ? '♡' : '♥'); 
        }
    });
}
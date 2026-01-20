// 찜 삭제 함수
function deleteBookmark(btn, storeIdx, kakaoId, url) {
    if(!confirm("이 가게를 찜 목록에서 삭제하시겠습니까?")) {
        return;
    }

    $.ajax({
        type: "POST",
        url: ctxPath + "/bookmark/bookmark_action.jsp", 
        data: {
            store_idx: storeIdx, // 내부 가게면 번호, 아니면 0
            kakao_id: kakaoId,   // 외부 가게 ID
            place_url: url       // 외부 가게 URL (식별자 역할)
        },
        success: function(response) {
            var res = response.trim();
            
            if(res === "removed") {
                // 화면에서 카드 부드럽게 삭제
                $(btn).closest('.bookmark-card').fadeOut(300, function() {
                    $(this).remove();
                    
                    // 만약 다 지워서 카드가 하나도 없으면 메시지 표시
                    if($('.bookmark-card').length === 0) {
                        $('.bookmark-grid').html(
                            '<div class="no-data">' +
                            '<p>아직 찜한 가게가 없습니다.</p>' +
                            '<p>맛집을 검색해서 하트를 눌러보세요!</p>' +
                            '</div>'
                        );
                    }
                    
                    // 제목의 숫자도 갱신 (선택사항)
                    var currentCount = parseInt($('.page-title').text().match(/\d+/)[0]);
                    $('.page-title').text('♥ 내가 찜한 맛집 (' + (currentCount - 1) + ')');
                });
            } else if (res === "login_needed") {
                alert("로그인이 필요합니다.");
                location.href = ctxPath + "/login/login_form.jsp";
            } else {
                alert("삭제 처리에 실패했습니다.");
            }
        },
        error: function() {
            alert("서버 통신 오류가 발생했습니다.");
        }
    });
}
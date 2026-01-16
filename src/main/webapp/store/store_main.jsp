<%@page import="com.team.project.dao.BookmarkDAO"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dto.StoreDTO"%>
<%@page import="com.team.project.dao.StoreDAO"%>
<%@page import="com.team.project.dao.SearchLogDAO"%>
<%@page import="com.team.project.util.GeminiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 0. 기본 설정
    request.setCharacterEncoding("UTF-8");
    String ctxPath = request.getContextPath();
    
    // 1. 파라미터 받기
    String sort = request.getParameter("sort");
    if (sort == null) sort = "latest"; 
    
    String question = request.getParameter("q"); // 검색어

    // 카테고리 파라미터 받기
    String category = request.getParameter("category");
    if (category == null || category.trim().isEmpty()) {
        category = "all";
    }
    
    // 2. DB 데이터 가져오기
    StoreDAO dao = new StoreDAO();
    List<StoreDTO> storeList = dao.selectStoreList(sort, question, category);
    
    // 3. 로그인 및 관리자 권한 확인
    boolean isAdmin = false;
    String myId = null;
    Object loginObj = session.getAttribute("loginMember");
    if (loginObj != null) {
        if (loginObj instanceof MemberDTO) {
            MemberDTO loginMember = (MemberDTO) loginObj;
            myId = loginMember.getMemberId(); 
            if ("admin".equals(loginMember.getMemberRole())) { 
                isAdmin = true;
            }
        } else if (loginObj instanceof String) {
            myId = (String)loginObj;
            if ("admin".equals(myId)) isAdmin = true;
        }
    }
    
    // 4. 내가 찜한 가게 목록 가져오기
    Set<Integer> myBookmarkSet = new HashSet<>();
    if(myId != null) {
        BookmarkDAO bookmarkDao = new BookmarkDAO();
        myBookmarkSet = bookmarkDao.getMyBookmarkStoreIdxSet(myId);
    }
    
    // 5. AI 답변 준비
    String answer = "";
    if(question != null && !question.trim().isEmpty()) {
        StringBuilder prompt = new StringBuilder();
        if (storeList != null && !storeList.isEmpty()) {
            prompt.append("다음은 우리 서비스에 등록된 맛집 데이터야. 일치하는 데이터를 전부 보여줘\n[우리 DB 데이터]\n");
            int maxLimit = 30; int count = 0;
            for(StoreDTO s : storeList) {
                 if(count >= maxLimit) break;
                 prompt.append(String.format("- 가게명:%s | 평점:%.1f | 주소:%s\n", s.getStoreName(), s.getStoreRatingAvg(), s.getStoreAddr()));
                 count++;
            }
            prompt.append("\n[사용자 질문]\n" + question);
        } else {
            prompt.append("사용자가 '" + question + "'에 대해 검색했는데, 우리 DB에는 관련 정보가 없어. 추천해줘.");
        }
        answer = GeminiUtil.getGeminiResponse(prompt.toString());
        new SearchLogDAO().insertSearchLog(question, answer);
    }

    // 카테고리 배열 정의
    String[][] catArr = {
        {"all", "allCategory.png", "전체"},
        {"한식", "korean.png", "한식"},
        {"중식", "chinese.png", "중식"},
        {"일식", "japanese.png", "일식"},
        {"양식", "western.png", "양식"},
        {"카페/디저트", "cafe.png", "카페/디저트"}
    };
%>
<!DOCTYPE html>
<html>
<head>
    <title>맛집 추천 리스트</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="<%= ctxPath %>/store/store_main.css?v=8">
</head>
<body>
    <jsp:include page="/header/header.jsp" />
    <div class="container">
        <div class="header">
            <h1>맛집추천</h1>
            
            <form action="store_main.jsp" method="post" class="search-box" id="searchForm">
                <input type="hidden" name="sort" value="<%= sort %>">
                <input type="hidden" name="category" id="categoryInput" value="<%= category %>">
                
                <input type="text" name="q" placeholder="가게명, 주소 또는 메뉴 추천!" value="<%= (question != null) ? question : "" %>">
                <button type="submit">검색</button>
            </form>
            
            <div class="header-right">
                <% if(isAdmin) { %>
                    <button type="button" class="write-btn" onclick="location.href='store_write.jsp'">맛집등록</button>
                <% } %>
                <select id="sortFilter" onchange="changeSort()">
                    <option value="rating" <%= "rating".equals(sort) ? "selected" : "" %>>별점 높은순</option>
                    <option value="review" <%= "review".equals(sort) ? "selected" : "" %>>리뷰 많은순</option>
                    <option value="view"   <%= "view".equals(sort) ? "selected" : "" %>>조회수순</option>
                </select>
            </div>
        </div>

        <div class="category-section">
            <% for(String[] cat : catArr) { 
                String cCode = cat[0];
                String cImg = cat[1];
                String cName = cat[2];
                // 현재 선택된 카테고리인지 확인
                String activeClass = category.equals(cCode) ? "active" : "";
            %>
            <div class="category-item <%= activeClass %>" onclick="selectCategory('<%= cCode %>')">
                <div class="img-wrap">
                    <img src="<%= ctxPath %>/images/store_category/<%= cImg %>" alt="<%= cName %>">
                </div>
                <span><%= cName %></span>
            </div>
            <% } %>
        </div>
        <% if(question != null && !answer.isEmpty()) { %>
            <div class="ai-result-box">
                <div class="ai-question">Q. <%= question %></div>
                <div class="ai-answer"><%= answer %></div>
            </div>
        <% } %>
        
        <div class="store-grid">
            <% 
            if (storeList != null && !storeList.isEmpty()) {
                for(StoreDTO store : storeList) { 
                    String imgPath = store.getStoreImg();
                    boolean hasImage = (imgPath != null && !imgPath.trim().isEmpty());
                    boolean isBookmarked = myBookmarkSet.contains(store.getStoreIdx());
                    String heartShape = isBookmarked ? "♥" : "♡";
            %>
                <div class="store-card">
                    <button type="button" class="store-jjim-btn" 
                            onclick="toggleBookmark(this, '<%= store.getStoreIdx() %>', '<%= store.getStoreName() %>', '<%= store.getStoreAddr() %>')">
                        <%= heartShape %>
                    </button>
                    <a href="store_detail.jsp?idx=<%= store.getStoreIdx() %>" class="img-link">
                        <% if(hasImage) { %>
                            <img src="<%= ctxPath %>/images/store_image<%= imgPath %>" class="store-img" alt="가게사진">
                        <% } else { %>
                            <div class="no-img-box">이미지 없음</div>
                        <% } %>
                    </a>
                    <div class="store-info">
                        <div class="store-name"><%= store.getStoreName() %></div>
                        <div class="store-stats">
                            <span class="star-icon">★</span> <%= store.getStoreRatingAvg() %> 
                            (리뷰 <%= store.getStoreRatingCount() %>)
                        </div>
                        <div class="store-addr"><%= store.getStoreAddr() %></div>
                    </div>
                </div>
            <% 
                }
            } else { 
            %>
                <div style="grid-column: 1 / -1; text-align: center; padding: 50px; color: #666;">
                    <h2>🚫 조건에 맞는 맛집이 없습니다.</h2>
                </div>
            <% } %>
        </div>
    </div>
    <jsp:include page="/footer/footer.jsp" />
    <script>
        // 정렬 변경 시 폼 전체 제출
        function changeSort() {
            var sortVal = document.getElementById("sortFilter").value;
            document.querySelector('input[name="sort"]').value = sortVal;
            document.getElementById("searchForm").submit();
        }

        // 카테고리 선택 함수
        function selectCategory(catCode) {
            document.getElementById("categoryInput").value = catCode;
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
                url: "<%= ctxPath %>/bookmark/bookmark_action.jsp", 
                data: {
                    store_idx: storeIdx,
                    place_name: storeName,
                    place_addr: storeAddr
                },
                success: function(response) {
                    var res = response.trim();
                    if(res === "login_needed") {
                        alert("로그인이 필요합니다.");
                        location.href = "<%= ctxPath %>/login/login.jsp"; 
                        $(btn).text(isEmpty ? '♡' : '♥'); 
                    } else if(res === "error") {
                        alert("처리 실패: 잠시 후 다시 시도해주세요.");
                        $(btn).text(isEmpty ? '♡' : '♥'); 
                    }
                },
                error: function() {
                    alert("서버 연결 실패");
                    $(btn).text(isEmpty ? '♡' : '♥'); 
                }
            });
        }
    </script>
</body>
</html>
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
    request.setCharacterEncoding("UTF-8");
    String ctxPath = request.getContextPath();
    
    String sort = request.getParameter("sort");
    if (sort == null) sort = "latest"; 
    
    String question = request.getParameter("q"); 

    String category = request.getParameter("category");
    if (category == null || category.trim().isEmpty()) {
        category = "all";
    }
    
    StoreDAO dao = new StoreDAO();
    List<StoreDTO> storeList = dao.selectStoreList(sort, question, category);
    
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
    
    Set<Long> myBookmarkSet = new HashSet<>(); 

    if(myId != null) {
        BookmarkDAO bookmarkDao = new BookmarkDAO();
        myBookmarkSet = bookmarkDao.getMyBookmarkStoreIdxSet(myId);
    }
    
    // AI 답변 로직 (검색어가 있을 때만 실행)
    String answer = "";
    
    // 사용자가 명시적으로 검색했을 때만 AI 호출 (카테고리 클릭 시엔 q가 없으므로 호출 안됨)
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
    
    <script>
        const ctxPath = "<%= ctxPath %>";
    </script>
    
    <script src="<%= ctxPath %>/store/store_main.js?v=<%= System.currentTimeMillis() %>"></script>
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
                    boolean isBookmarked =
                    	    (store.getStoreIdx() > 0 && myBookmarkSet.contains(store.getStoreIdx()));
                    String heartShape = isBookmarked ? "♥" : "♡";
            %>
                <div class="store-card">
                    <button type="button" class="store-jjim-btn" 
                            onclick="toggleBookmark(this, '<%= store.getStoreIdx() %>', '<%= store.getStoreName() %>', '<%= store.getStoreAddr() %>')">
                        <%= heartShape %>
                    </button>
                    <a href="store_detail.jsp?idx=<%= store.getStoreIdx() %>" class="img-link">
                        <% if(hasImage) { %>
                            <img src="<%= ctxPath %>/images/store_image/<%= imgPath %>" class="store-img" alt="가게사진">
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
    
    </body>
</html>
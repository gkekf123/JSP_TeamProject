<%@page import="java.io.File"%> <%@page import="java.util.Map"%>
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

// 파라미터 수신
String sort = request.getParameter("sort");
if (sort == null) sort = "latest"; 
String question = request.getParameter("q"); 
String category = request.getParameter("category");
if (category == null || category.trim().isEmpty()) category = "all";

// 데이터 조회
StoreDAO dao = new StoreDAO();
List<StoreDTO> storeList = dao.selectStoreList(sort, question, category);

// 카테고리별 개수 가져오기
Map<String, Integer> countMap = dao.getCategoryCounts();

// 전체 개수 계산
int totalCount = 0;
for(int c : countMap.values()) {
    totalCount += c;
}

// 로그인 및 관리자 체크
boolean isAdmin = false;
String myId = (String) session.getAttribute("member_id");   
String myRole = (String) session.getAttribute("member_role"); 
if (myRole != null && "admin".equals(myRole)) isAdmin = true;

// 찜 목록
Set<Long> myBookmarkSet = new HashSet<>(); 
if(myId != null) {
    BookmarkDAO bookmarkDao = new BookmarkDAO();
    myBookmarkSet = bookmarkDao.getMyBookmarkStoreIdxSet(myId);
}

// AI 답변
String answer = "";
if(question != null && !question.trim().isEmpty()) {
    StringBuilder prompt = new StringBuilder();
    if (storeList != null && !storeList.isEmpty()) {
        prompt.append("다음 맛집 데이터 중 일치하는 것 보여줘:\\n");
        int maxLimit = 30; int count = 0;
        for(StoreDTO s : storeList) {
             if(count >= maxLimit) break;
             prompt.append(String.format("- %s (평점:%.1f, 주소:%s)\\n", s.getStoreName(), s.getStoreRatingAvg(), s.getStoreAddr()));
             count++;
        }
        prompt.append("\\n질문: " + question);
    } else {
        prompt.append("'" + question + "'에 대한 정보가 없어. 추천해줘.");
    }
    answer = GeminiUtil.getGeminiResponse(prompt.toString());
    new SearchLogDAO().insertSearchLog(question, answer);
}

String[][] catArr = {
    {"all", "allCategory.png", "전체"}, {"한식", "korean.png", "한식"},
    {"중식", "chinese.png", "중식"}, {"일식", "japanese.png", "일식"},
    {"양식", "western.png", "양식"}, {"카페/디저트", "cafe.png", "카페/디저트"}
};

%>
<!DOCTYPE html>
<html>
<head>
    <title>맛집 추천 리스트</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="<%= ctxPath %>/store/store_main.css?v=12">
    <script>
        const ctxPath = "<%= ctxPath %>";

    function deleteStore(idx) {
        if(confirm("정말로 이 맛집을 삭제하시겠습니까? (복구 불가)")) {
            location.href = "store_delete_action.jsp?idx=" + idx;
        }
    }
</script>
<script src="<%= ctxPath %>/store/store_main.js?v=<%= System.currentTimeMillis() %>"></script>

<style>
    .cat-count {
        font-size: 12px;
        color: #888;
        background: #eee;
        padding: 2px 6px;
        border-radius: 10px;
        margin-left: 4px;
        font-weight: bold;
    }
    .category-item.active .cat-count {
        background: #f39c12;
        color: white;
    }
</style>

</head>
<body>
    <jsp:include page="/header/header.jsp" />

<div class="container">
    <div class="header">
        <h1>맛집추천</h1>
        <form action="store_main.jsp" method="post" class="search-box" id="searchForm">
            <input type="hidden" name="sort" value="<%= sort %>">
            <input type="hidden" name="category" id="categoryInput" value="<%= category %>">
            <input type="text" name="q" placeholder="가게명, 주소, 메뉴 검색" value="<%= (question != null) ? question : "" %>">
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
            
            // 해당 카테고리의 개수 찾기
            int count = 0;
            if("all".equals(cCode)) {
                count = totalCount; // 전체 개수
            } else {
                if(countMap.containsKey(cName)) {
                    count = countMap.get(cName);
                }
            }
        %>
        <div class="category-item <%= activeClass %>" onclick="selectCategory('<%= cCode %>')">
            <div class="img-wrap"><img src="<%= ctxPath %>/images/store_category/<%= cImg %>" alt="<%= cName %>"></div>
            <span><%= cName %> <span class="cat-count"><%= count %></span></span>
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
        <% if (storeList != null && !storeList.isEmpty()) {
            for(StoreDTO store : storeList) { 
                
                // ★★★ [수정됨] 실제 파일 존재 여부 확인 로직 ★★★
                java.util.List<String> validImgs = new java.util.ArrayList<>();
                String[] rawImgs = {store.getStoreImg(), store.getStoreImg2(), store.getStoreImg3()};
                
                for(String raw : rawImgs) {
                    if (raw != null && !raw.trim().isEmpty()) {
                        // 1. 파일명 정리 (DB에 /가 없거나 있으면 처리)
                        String fileName = raw;
                        if (fileName.startsWith("/")) fileName = fileName.substring(1);
                        
                        // 2. 웹 경로 (브라우저용)
                        String webPath = "/images/store_image/" + fileName;
                        
                        // 3. 실제 물리 경로 (서버 디스크용)
                        String realPath = application.getRealPath(webPath);
                        
                        // 4. 파일 존재 여부 확인
                        File f = new File(realPath);
                        if(f.exists()) {
                            // 파일이 실제로 있을 때만 리스트에 추가
                            validImgs.add(ctxPath + webPath);
                        }
                        // 파일이 없으면 리스트에 추가되지 않음 -> 404 에러 방지
                    }
                }
                
                // 유효한(실제로 존재하는) 이미지가 하나라도 있는지 확인
                boolean hasImage = (validImgs.size() > 0);
                
                // 첫 번째 이미지 경로 (있을 경우)
                String mainImgSrc = hasImage ? validImgs.get(0) : "";
                
                // 슬라이드용 데이터
                String dataImgs = String.join(",", validImgs);

                boolean isBookmarked = (store.getStoreIdx() > 0 && myBookmarkSet.contains(store.getStoreIdx()));
                String heartShape = isBookmarked ? "♥" : "♡";
                String tel = store.getStoreTel();
                if(tel == null || tel.trim().isEmpty()) tel = "전화번호 없음";
        %>
            <div class="store-card" onclick="location.href='store_detail.jsp?idx=<%= store.getStoreIdx() %>'">
                
                <button type="button" class="store-jjim-btn" 
                        onclick="event.stopPropagation(); toggleBookmark(this, '<%= store.getStoreIdx() %>', '<%= store.getStoreName() %>', '<%= store.getStoreAddr() %>')">
                    <%= heartShape %>
                </button>
                
                <div class="img-link">
                    <% if(hasImage) { %>
                        <img src="<%= mainImgSrc %>" 
                             class="store-img slide-img" 
                             alt="가게사진" 
                             data-imgs="<%= dataImgs %>">
                    <% } else { %>
                        <div class="no-img-box">이미지<br>없음</div>
                    <% } %>
                </div>
                
                <div class="store-info">
                    <div class="store-name"><%= store.getStoreName() %></div>
                    
                    <div class="store-stats">
                        <span class="star-icon">★</span> <%= String.format("%.1f", store.getStoreRatingAvg()) %> 
                        <span style="color:#999; font-size:0.9em;">/ 5</span>
                        
                        <span style="color:#888; font-size:0.9em; margin-left:5px;">
                            (리뷰 <%= store.getStoreRatingCount() %> · 조회 <%= store.getStoreViewCount() %>)
                        </span>
                    </div>
                    
                    <div class="store-addr"><%= store.getStoreAddr() %></div>
                    <div class="store-tel"><%= tel %></div>
                </div>

                <% if(isAdmin) { %>
                <div class="admin-btn-group" onclick="event.stopPropagation()" style="padding: 10px; border-top: 1px solid #eee; text-align: right; background: #f9f9f9;">
                    <button type="button" onclick="location.href='store_update.jsp?idx=<%= store.getStoreIdx() %>'" 
                            style="background:#3498db; color:white; border:none; padding:5px 12px; border-radius:4px; cursor:pointer; font-size:12px;">수정</button>
                    <button type="button" onclick="deleteStore('<%= store.getStoreIdx() %>')" 
                            style="background:#e74c3c; color:white; border:none; padding:5px 12px; border-radius:4px; cursor:pointer; margin-left:5px; font-size:12px;">삭제</button>
                </div>
                <% } %>
            </div>
        <% } 
        } else { %>
            <div style="grid-column: 1 / -1; text-align: center; padding: 50px; color: #666;"><h2>🚫 맛집이 없습니다.</h2></div>
        <% } %>
    </div>
</div>
<jsp:include page="/footer/footer.jsp" />

</body>
</html>
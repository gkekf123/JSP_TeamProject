<%@page import="com.team.project.dao.SearchLogDAO"%>
<%@page import="com.team.project.util.GeminiUtil"%>
<%@page import="com.team.project.dto.StoreDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.team.project.dao.StoreDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 0. 기본 설정
    request.setCharacterEncoding("UTF-8");
    String ctxPath = request.getContextPath(); // 경로 변수 선언 (중요!)

    // 1. 파라미터 받기
    String sort = request.getParameter("sort");
    if (sort == null) sort = "latest"; 
    
    String question = request.getParameter("q"); // 검색어

    // 2. DB 데이터 가져오기
    StoreDAO dao = new StoreDAO();
    List<StoreDTO> storeList = dao.selectStoreList(sort, question);
    
    // 3. AI 답변 준비
    String answer = "";
    
    if(question != null && !question.trim().isEmpty()) {
        StringBuilder prompt = new StringBuilder();
        
        // DB 결과 유무에 따라 프롬프트 변경
        if (storeList != null && !storeList.isEmpty()) {
            // 1. DB에 데이터가 있을 때
            prompt.append("다음은 우리 서비스에 등록된 맛집 데이터야. 일치하는 데이터를 전부 보여줘\n");
            prompt.append("[우리 DB 데이터]\n");
            
            // 데이터 과부하 방지 (최대 30개만 전송)
            int maxLimit = 30;
            int count = 0;
            for(StoreDTO s : storeList) {
                 if(count >= maxLimit) break;
                 prompt.append(String.format("- 가게명:%s | 평점:%.1f | 주소:%s\n", s.getStoreName(), s.getStoreRatingAvg(), s.getStoreAddr()));
                 count++;
            }
            prompt.append("\n[사용자 질문]\n" + question);
            
        } else {
            // 2. DB에 데이터가 없을 때
            prompt.append("사용자가 '" + question + "'에 대해 검색했는데, 우리 DB에는 관련 정보가 없어.\n");
            prompt.append("네가 알고 있는 한국의 실제 맛집 정보 중에서 '" + question + "'와 관련된 가장 유명한 곳을 **딱 2군데만** 추천해줘.\n");
            prompt.append("형식은 [가게명-주소] - [추천이유] 로 간단하게 해줘.");
        }
        
        // GeminiUtil 호출
        answer = GeminiUtil.getGeminiResponse(prompt.toString());
        
        // 로그 저장
        SearchLogDAO logDao = new SearchLogDAO();
        logDao.insertSearchLog(question, answer);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>맛집 추천 리스트</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= ctxPath %>/store/store_main.css">
    <script src="<%= ctxPath %>/store/store_main.js"></script>
</head>
<body>

    <jsp:include page="/header/header.jsp" />

    <div class="container">
        <div class="header">
            <h1>맛집추천 메인메뉴</h1>
            
            <form action="store_main.jsp" method="post" class="search-box">
                <input type="hidden" name="sort" value="<%= sort %>">
                <input type="text" name="q" placeholder="가게명, 주소 또는 메뉴 추천!" value="<%= (question != null) ? question : "" %>">
                <button type="submit">검색</button>
            </form>
    
            <select id="sortFilter" onchange="changeSort()">
                <option value="latest" <%= "latest".equals(sort) ? "selected" : "" %>>최신순</option>
                <option value="rating" <%= "rating".equals(sort) ? "selected" : "" %>>별점 높은순</option>
                <option value="review" <%= "review".equals(sort) ? "selected" : "" %>>리뷰 많은순</option>
                <option value="view"   <%= "view".equals(sort) ? "selected" : "" %>>조회수순</option>
            </select>
        </div>
    
        <% if(question != null && !answer.isEmpty()) { %>
            <div class="ai-result-box">
                <div class="ai-question">Q. <%= question %></div>
                <div class="ai-answer">
                    <% if(storeList == null || storeList.isEmpty()) { %>
                        <strong style="color: #e74c3c;">등록된 정보 없음.</strong> <br><br>
                    <% } else { %>
                        <strong>🤖 AI 추천 :</strong><br>
                    <% } %>
                    <%= answer %>
                </div>
            </div>
        <% } %>
    
        <div class="store-grid">
            <% 
            if (storeList != null && !storeList.isEmpty()) {
                for(StoreDTO store : storeList) { 
                    String imgPath = store.getStoreImg();
                    // 이미지 유효성 체크
                    boolean hasImage = (imgPath != null && !imgPath.trim().isEmpty() && !imgPath.equals("no_image.png"));
            %>
                <div class="store-card">
                    <a href="store_detail.jsp?idx=<%= store.getStoreIdx() %>" class="img-link">
                        <% if(hasImage) { %>
                            <img src="<%= ctxPath %>/images/<%= imgPath %>" class="store-img" alt="가게사진">
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
                    <h2>🚫 검색 결과가 없습니다.</h2>
                    <p>위의 AI 추천 결과를 참고하시거나, 다른 검색어로 시도해보세요!</p>
                </div>
            <% } %>
        </div>
    </div>
    
    <script src="<%= ctxPath %>/store/store.js"></script>
    
    <jsp:include page="/footer/footer.jsp" />

</body>
</html>
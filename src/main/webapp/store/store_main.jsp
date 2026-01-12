<%@page import="com.team.project.dao.SearchLogDAO"%>
<%@page import="com.team.project.util.GeminiUtil"%>
<%@page import="com.team.project.dto.StoreDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.team.project.dao.StoreDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 1. 파라미터 받기
    request.setCharacterEncoding("UTF-8");
    
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
    
    <style>
        /* 기본 스타일 */
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f4f4f4; margin: 0; }
        
        /* 반응형 컨테이너 */
        .container { 
            max-width: 1200px; 
            width: 90%; 
            margin: 30px auto; 
            padding: 20px; 
            background: #fff; 
            border-radius: 10px; 
            box-shadow: 0 0 10px rgba(0,0,0,0.1); 
            box-sizing: border-box; 
        }
        
        /* 헤더 */
        .header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 20px; 
            border-bottom: 2px solid #eee; 
            padding-bottom: 15px; 
            flex-wrap: wrap; 
            gap: 15px;
        }
        .header h1 { margin: 0; color: #333; font-size: 24px; }

        /* 검색창 */
        .search-box { display: flex; gap: 10px; }
        .search-box input { padding: 10px; width: 300px; border: 1px solid #ddd; border-radius: 5px; }
        .search-box button { padding: 10px 20px; background: #f39c12; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; white-space: nowrap; }
        .search-box button:hover { background: #e67e22; }

        #sortFilter { padding: 8px; border-radius: 5px; border: 1px solid #ddd; }

        /* AI 결과 박스 */
        .ai-result-box { background-color: #f8f9fa; border-left: 5px solid #f39c12; padding: 20px; margin-bottom: 30px; border-radius: 5px; }
        .ai-result-box strong { color: #d35400; }
        .ai-question { font-size: 1.1em; margin-bottom: 10px; font-weight: bold; }
        .ai-answer { line-height: 1.6; color: #555; white-space: pre-wrap; word-break: break-all; }

        /* 그리드 (카드 리스트) */
        .store-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .store-card { border: 1px solid #ddd; border-radius: 8px; overflow: hidden; background: #fff; transition: transform 0.2s; }
        .store-card:hover { transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }

        .img-link { display: block; text-decoration: none; color: inherit; }
        .store-img { width: 100%; height: 180px; background-color: #eee; object-fit: cover; border-bottom: 1px solid #eee; }
        
        /* 이미지 없을 때 회색 박스 */
        .no-img-box { width: 100%; height: 180px; background-color: #eee; display: flex; align-items: center; justify-content: center; color: #888; font-size: 14px; font-weight: bold; border-bottom: 1px solid #ddd; }
        
        .store-info { padding: 15px; }
        .store-name { font-size: 18px; font-weight: bold; margin-bottom: 5px; }
        .store-stats { color: #666; font-size: 14px; margin-bottom: 5px; }
        .store-addr { color: #999; font-size: 12px; }
        .star-icon { color: #f39c12; }

        /* 반응형 (태블릿) */
        @media screen and (max-width: 900px) {
            .store-grid { grid-template-columns: repeat(2, 1fr); }
            .header { flex-direction: column; align-items: stretch; }
            .search-box { width: 100%; justify-content: center; }
            .search-box input { width: 100%; }
        }

        /* 반응형 (모바일) */
        @media screen and (max-width: 600px) {
            .store-grid { grid-template-columns: repeat(1, 1fr); }
            .container { width: 100%; margin: 0; border-radius: 0; }
            .header h1 { text-align: center; }
        }
    </style>
</head>
<body>

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
                // 이미지 유효성 체크 (null, 빈값, no_image.png 제외)
                boolean hasImage = (imgPath != null && !imgPath.trim().isEmpty() && !imgPath.equals("no_image.png"));
        %>
            <div class="store-card">
                <a href="store_detail.jsp?idx=<%= store.getStoreIdx() %>" class="img-link">
                    <% if(hasImage) { %>
                        <img src="<%= request.getContextPath() %>/images/<%= imgPath %>" class="store-img" alt="가게사진">
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

<script>
    // 정렬 변경 시에도 POST 방식을 유지하기 위해 form을 제출하도록 변경
    function changeSort() {
        var sortVal = document.getElementById("sortFilter").value;
        
        // 1. form 안에 있는 hidden input 값을 내가 선택한 정렬값으로 바꿈
        document.querySelector('input[name="sort"]').value = sortVal;
        
        // 2. form 강제 제출 (이렇게 해야 POST로 전송되어 한글이 안 깨짐)
        document.querySelector('.search-box').submit();
    }
</script>

</body>
</html>
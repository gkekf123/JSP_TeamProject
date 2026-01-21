<%@page import="java.util.List"%>
<%@page import="com.team.project.dao.BookmarkDAO"%>
<%@page import="com.team.project.dto.BookmarkDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String ctxPath = request.getContextPath();

    // 1. 로그인 체크
    String memberId = (String) session.getAttribute("member_id");

    if (memberId == null) {
%>
    <script>
        alert("로그인이 필요한 서비스입니다.");
        location.href = "<%= ctxPath %>/login/login_form.jsp";
    </script>
<%
        return;
    }

    // 2. 찜 목록 가져오기
    BookmarkDAO dao = new BookmarkDAO();
    List<BookmarkDTO> list = dao.selectMyBookmarkList(memberId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 찜 목록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="<%= ctxPath %>/bookmark/bookmark_list.css?v=4">
    
    <script>
        const ctxPath = "<%= ctxPath %>";
    </script>
    <script src="<%= ctxPath %>/bookmark/bookmark_list.js"></script>
</head>
<body>

    <jsp:include page="/header/header.jsp" />

    <div class="container">
        <h2 class="page-title">내가 찜한 맛집 (<%= list.size() %>)</h2>

        <div class="bookmark-grid">
            <% 
            if (list != null && !list.isEmpty()) {
                for (BookmarkDTO dto : list) {
                    boolean isInternal = (dto.getStoreIdx() > 0); 
                    String detailLink = "";
                    String target = "_self";
                    String badgeClass = isInternal ? "internal" : "external";
                    String badgeText = isInternal ? "등록된 맛집" : "카카오 장소";
                    
                    boolean hasImage = false;
                    String imgSrc = "";

                    if (isInternal) {
                        // 내부 가게: DB에 이미지가 있는지 확인
                        String dbImg = dto.getStoreImg();
                        if (dbImg != null && !dbImg.trim().isEmpty()) {
                            if(!dbImg.startsWith("/")) dbImg = "/" + dbImg;
                            imgSrc = ctxPath + "/images/store_image" + dbImg;
                            hasImage = true;
                        }
                    } else {
                        // 외부(카카오) 가게: 지도 아이콘을 이미지로 사용
                        imgSrc = ctxPath + "/images/map_icon.png";
                        hasImage = true;
                    }

                    // 링크 설정
                    if (isInternal) {
                        detailLink = ctxPath + "/store/store_detail.jsp?idx=" + dto.getStoreIdx();
                    } else {
                        detailLink = dto.getPlaceUrl();
                        target = "_blank"; 
                    }
                    
                    String kakaoId = (dto.getKakaoId() == null) ? "" : dto.getKakaoId();
                    String placeUrl = (dto.getPlaceUrl() == null) ? "" : dto.getPlaceUrl();
                    
                    // 전화번호 처리
                    String phone = dto.getPlacePhone();
                    if(phone == null || phone.trim().isEmpty()) {
                        phone = "전화번호 없음";
                    }
            %>
                <div class="bookmark-card">
                    <button type="button" class="delete-btn" title="찜 해제"
                            onclick="deleteBookmark(this, <%= dto.getStoreIdx() %>, '<%= kakaoId %>', '<%= placeUrl %>')">
                        ♥
                    </button>

                    <a href="<%= detailLink %>" target="<%= target %>" class="card-left">
                        <% if(hasImage) { %>
                            <img src="<%= imgSrc %>" alt="가게 이미지" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                            <div class="no-img-box" style="display:none;">이미지 없음</div>
                        <% } else { %>
                            <div class="no-img-box">이미지 없음</div>
                        <% } %>
                    </a>

                    <div class="card-right">
                        <span class="badge <%= badgeClass %>"><%= badgeText %></span>
                        
                        <a href="<%= detailLink %>" target="<%= target %>" class="place-name">
                            <%= dto.getPlaceName() %>
                        </a>
                        
                        <div class="place-addr"><%= dto.getPlaceAddr() %></div>
                        
                        <% if(isInternal) { %>
                            <div class="place-stats">
                                <span class="star">★</span> <%= String.format("%.1f", dto.getStoreRatingAvg()) %> 
                                <span class="view-count">(조회 <%= dto.getStoreViewCount() %>)</span>
                            </div>
                        <% } else { %>
                            <div class="place-stats external-info">지도 정보</div>
                        <% } %>
                        
                        <div class="place-phone"><%= phone %></div>
                    </div>
                </div>
            <% 
                } 
            } else { 
            %>
                <div class="no-data">
                    <p>아직 찜한 가게가 없습니다.</p>
                    <p>맛집을 검색해서 하트를 눌러보세요!</p>
                </div>
            <% } %>
        </div>
    </div>

    <jsp:include page="/footer/footer.jsp" />

</body>
</html>
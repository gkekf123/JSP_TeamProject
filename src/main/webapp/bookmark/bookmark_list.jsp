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
    <link rel="stylesheet" href="<%= ctxPath %>/bookmark/bookmark_list.css?v=6">
    
    <script>
        const ctxPath = "<%= ctxPath %>";
        
        // 카드 클릭 시 이동 함수 (내부/외부 구분)
        function goDetail(url, isNewWindow) {
            if(isNewWindow) {
                window.open(url, '_blank');
            } else {
                location.href = url;
            }
        }
    </script>
    <script src="<%= ctxPath %>/bookmark/bookmark_list.js"></script>
</head>
<body>

    <jsp:include page="/header/header.jsp" />

    <div class="container">
        <h2 class="page-title">내가 찜한 맛집 (<%= list.size() %>)</h2>
		<h5>'등록된 맛집'은 사이트 내 정식 등록된 가게</h5>
		<h5>'카카오 장소'는 지도에서 검색해 찜 목록에만 추가된 외부 장소입니다.</h5>
		<br>
		        
        <div class="bookmark-grid">
            <% 
            if (list != null && !list.isEmpty()) {
                for (BookmarkDTO dto : list) {
                    boolean isInternal = (dto.getStoreIdx() > 0); 
                    String detailLink = "";
                    boolean isNewWindow = false; // 새 창 열기 여부
                    
                    String badgeClass = isInternal ? "internal" : "external";
                    String badgeText = isInternal ? "등록된 맛집" : "카카오 장소";
                    
                    boolean hasImage = false;
                    String imgSrc = "";

                    // 이미지 처리
                    if (isInternal) {
                        String dbImg = dto.getStoreImg();
                        if (dbImg != null && !dbImg.trim().isEmpty()) {
                            if(!dbImg.startsWith("/")) dbImg = "/" + dbImg;
                            imgSrc = ctxPath + "/images/store_image" + dbImg;
                            hasImage = true;
                        }
                    } else {
                        imgSrc = ctxPath + "/images/map_icon.png";
                        hasImage = true;
                    }

                    // 링크 설정
                    if (isInternal) {
                        detailLink = ctxPath + "/store/store_detail.jsp?idx=" + dto.getStoreIdx();
                    } else {
                        detailLink = dto.getPlaceUrl();
                        isNewWindow = true; // 외부 링크는 새 창으로
                    }
                    
                    String kakaoId = (dto.getKakaoId() == null) ? "" : dto.getKakaoId();
                    String placeUrl = (dto.getPlaceUrl() == null) ? "" : dto.getPlaceUrl();
                    
                    String phone = dto.getPlacePhone();
                    if(phone == null || phone.trim().isEmpty()) {
                        phone = "전화번호 없음";
                    }
            %>
                <div class="bookmark-card" onclick="goDetail('<%= detailLink %>', <%= isNewWindow %>)">
                    
                    <button type="button" class="delete-btn" title="찜 해제"
                            onclick="event.stopPropagation(); deleteBookmark(this, <%= dto.getStoreIdx() %>, '<%= kakaoId %>', '<%= placeUrl %>')">
                        ♥
                    </button>

                    <div class="card-left">
                        <% if(hasImage) { %>
                            <img src="<%= imgSrc %>" alt="가게 이미지" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                            <div class="no-img-box" style="display:none;">이미지 없음</div>
                        <% } else { %>
                            <div class="no-img-box">이미지 없음</div>
                        <% } %>
                    </div>

                    <div class="card-right">
                        <span class="badge <%= badgeClass %>"><%= badgeText %></span>
                        
                        <div class="place-name">
                            <%= dto.getPlaceName() %>
                        </div>
                        
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
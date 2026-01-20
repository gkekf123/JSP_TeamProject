<%@page import="java.util.List"%>
<%@page import="com.team.project.dao.BookmarkDAO"%>
<%@page import="com.team.project.dto.BookmarkDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String ctxPath = request.getContextPath();

    // 1. 로그인 체크
    String memberId = (String) session.getAttribute("member_id");

    // 비로그인 상태면 로그인 페이지로 리다이렉트
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
    <link rel="stylesheet" href="<%= ctxPath %>/bookmark/bookmark_list.css">
    
    <script>
        const ctxPath = "<%= ctxPath %>";
    </script>
    <script src="<%= ctxPath %>/bookmark/bookmark_list.js"></script>
</head>
<body>

    <jsp:include page="/header/header.jsp" />

    <div class="container">
        <h2 class="page-title">♥ 내가 찜한 맛집 (<%= list.size() %>)</h2>

        <div class="bookmark-grid">
            <% 
            if (list != null && !list.isEmpty()) {
                for (BookmarkDTO dto : list) {
                    boolean isInternal = (dto.getStoreIdx() > 0); // 내부 가게 여부
                    String detailLink = "";
                    String target = "_self";
                    String badgeClass = isInternal ? "internal" : "external";
                    String badgeText = isInternal ? "등록된 맛집" : "카카오 장소";
                    
                    // 링크 설정 (내부 가게면 상세페이지, 외부면 카카오맵)
                    if (isInternal) {
                        detailLink = ctxPath + "/store/store_detail.jsp?idx=" + dto.getStoreIdx();
                    } else {
                        detailLink = dto.getPlaceUrl();
                        target = "_blank"; // 새 창 열기
                    }
                    
                    // null 처리
                    String kakaoId = (dto.getKakaoId() == null) ? "" : dto.getKakaoId();
                    String placeUrl = (dto.getPlaceUrl() == null) ? "" : dto.getPlaceUrl();
            %>
                <div class="bookmark-card">
                    <span class="badge <%= badgeClass %>"><%= badgeText %></span>
                    
                    <button type="button" class="delete-btn" title="찜 해제"
                            onclick="deleteBookmark(this, <%= dto.getStoreIdx() %>, '<%= kakaoId %>', '<%= placeUrl %>')">
                        ♥
                    </button>

                    <div>
                        <a href="<%= detailLink %>" target="<%= target %>" class="place-name">
                            <%= dto.getPlaceName() %>
                        </a>
                        <div class="place-addr"><%= dto.getPlaceAddr() %></div>
                        <div class="place-phone"><%= (dto.getPlacePhone() != null) ? dto.getPlacePhone() : "" %></div>
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
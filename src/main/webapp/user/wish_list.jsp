<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.team.project.dao.BookmarkDAO" %>
<%@ page import="com.team.project.dto.BookmarkDTO" %>

<%
    // 1. 세션 체크 (로그인 여부)
    String loginOk = (String) session.getAttribute("loginok");
    String memberId = (String) session.getAttribute("member_id");

    if (loginOk == null || memberId == null) {
        %>
        <script>
            alert("로그인이 필요한 서비스입니다.");
            location.href = "<%= request.getContextPath() %>/login/login_form.jsp";
        </script>
        <%
        return;
    }

    // 2. 찜 목록 데이터 가져오기
    BookmarkDAO dao = new BookmarkDAO();
    List<BookmarkDTO> list = dao.selectMyBookmarkList(memberId);

    String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 찜 목록</title>

<style>
    body {
        margin: 0;
        padding-top: 80px; /* 헤더 높이만큼 여백 */
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f4f4f4;
    }

    .container {
        display: flex;
        max-width: 1000px;
        margin: 30px auto;
        gap: 20px;
    }

    /* 사이드바 스타일 */
    .sidebar {
        width: 220px;
        background-color: #fff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        height: fit-content;
    }

    .sidebar ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .sidebar li {
        margin-bottom: 15px;
        padding: 10px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 500;
        transition: 0.2s;
        color: #555;
    }

    .sidebar li:hover {
        background-color: #f39c12;
        color: #fff;
    }

    /* 오른쪽 컨텐츠 영역 */
    .content {
        flex: 1;
        background-color: #fff;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        min-height: 500px;
    }

    h2 {
        text-align: center;
        margin-bottom: 40px;
        color: #333;
    }
    
    /* 찜 카드 리스트 스타일 */
    .wish-list {
        display: flex;
        flex-direction: column;
        gap: 0;
    }

    .wish-card {
        border-bottom: 1px solid #eee;
        padding: 25px 10px;
        transition: background-color 0.2s;
    }

    .wish-card:hover {
        background-color: #fafafa;
    }

    .wish-card:last-child {
        border-bottom: none;
    }

    /* 제목 및 링크 스타일 */
    .place-name {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 8px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .place-name a {
        text-decoration: none;
        color: #333;
        transition: color 0.2s;
    }

    .place-name a:hover {
        color: #f39c12;
        text-decoration: underline;
    }

    /* 뱃지 스타일 */
    .badge {
        font-size: 11px;
        color: #fff;
        padding: 3px 8px;
        border-radius: 12px;
        font-weight: normal;
        vertical-align: middle;
        white-space: nowrap;
    }
    .badge-internal { background-color: #f39c12; } /* 등록된 맛집 (주황) */
    .badge-external { background-color: #3498db; } /* 카카오 장소 (파랑) */

    .place-addr {
        color: #666;
        font-size: 14px;
        margin-bottom: 5px;
    }

    .like-date {
        font-size: 12px;
        color: #999;
    }

    /* 목록 없을 때 */
    .empty {
        text-align: center;
        color: #888;
        margin-top: 100px;
    }
    
    .go-btn {
        padding: 10px 20px;
        background: #f39c12;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 15px;
        font-weight: bold;
        transition: 0.3s;
    }
    .go-btn:hover { background: #e67e22; }
    
    /* 모바일 반응형 */
    @media (max-width: 768px) {
        .container { flex-direction: column; padding: 10px; }
        .sidebar { width: 100%; box-sizing: border-box; }
    }
</style>
</head>

<body>

    <jsp:include page="/header/header.jsp" />

    <div class="container">

        <div class="sidebar">
            <ul>
                <li onclick="location.href='<%=ctxPath%>/store/store_main.jsp'">맛집 목록</li>
                <li onclick="location.href='<%=ctxPath%>/member/my_page.jsp'">마이페이지</li>
                <li style="font-weight:bold; background-color:#f39c12; color:#fff;">찜 목록</li>
                <li onclick="location.href='<%=ctxPath%>/review/my_review.jsp'">내가 쓴 리뷰</li>
                <li onclick="location.href='<%=ctxPath%>/login/logout_action.jsp'" style="color:#e74c3c; margin-top:20px;">로그아웃</li>
            </ul>
        </div>

        <div class="content">
            <h2>내 찜 목록</h2>

            <% if (list == null || list.isEmpty()) { %>
                <div class="empty">
                    <p>아직 찜한 맛집이 없습니다.</p>
                    <button class="go-btn" onclick="location.href='<%=ctxPath%>/store/store_main.jsp'">
                        맛집 보러가기
                    </button>
                </div>
            <% } else { %>
                <div class="wish-list">
                    <%
                    for (BookmarkDTO dto : list) {
                        
                        long sIdx = dto.getStoreIdx();
                        String pUrl = dto.getPlaceUrl();
                        
                        String targetLink = "#";
                        String targetAttr = "";
                        String badgeHtml = "";

                        // 1. 등록된 맛집인 경우 -> 내부 상세 페이지 이동
                        if (sIdx > 0) {
                            targetLink = ctxPath + "/store/store_detail.jsp?idx=" + sIdx;
                            badgeHtml = "<span class='badge badge-internal'>등록된 맛집</span>";
                        } 
                        // 2. 외부(카카오) 장소인 경우 -> 새 창으로 카카오맵 열기
                        else {
                            if (pUrl != null && !pUrl.isEmpty()) {
                                targetLink = pUrl;
                                targetAttr = "target='_blank'"; // 새 창 열기
                            }
                            badgeHtml = "<span class='badge badge-external'>카카오 장소</span>";
                        }
                    %>

                    <div class="wish-card">
                        <div class="place-name">
                            <%= badgeHtml %>
                            <a href="<%= targetLink %>" <%= targetAttr %>>
                                <%= dto.getPlaceName() %>
                            </a>
                        </div>
                        <div class="place-addr"><%= dto.getPlaceAddr() %></div>
                        <div class="like-date">찜한 날짜 : <%= dto.getLikeDate() %></div>
                    </div>

                    <% } // for end %>
                </div>
            <% } // else end %>
        </div>
    </div>

</body>
</html>
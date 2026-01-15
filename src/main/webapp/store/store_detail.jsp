<%@page import="com.team.project.dto.MenuDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.team.project.dao.MenuDAO"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.StoreDetailDAO"%>
<%@page import="com.team.project.dto.StoreDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // 0. 기본 설정
    request.setCharacterEncoding("UTF-8");
    String ctxPath = request.getContextPath();

    String storeIdxParam = request.getParameter("idx");
    if (storeIdxParam == null) {
        response.sendRedirect(ctxPath + "/main.jsp");
        return;
    }

    long storeIdx = Long.parseLong(storeIdxParam);

    StoreDetailDAO dao = new StoreDetailDAO();
    StoreDTO dto = dao.selectDetailIntro(storeIdx);

    if (dto == null) {
        response.sendRedirect(ctxPath + "/main.jsp");
        return;
    }
    
    
    //로그인할시 메뉴추가 보임
    boolean isAdmin = false;
    Object loginObj = session.getAttribute("loginMember");

    if (loginObj != null && loginObj instanceof MemberDTO) {
        MemberDTO m = (MemberDTO) loginObj;
        if ("admin".equals(m.getMemberRole())) {
            isAdmin = true;
        }
    }
    
    MenuDAO menuDao = new MenuDAO();
    List<MenuDTO> menuList = menuDao.selectMenu(storeIdx);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= dto.getStoreName() %></title>

<link rel="stylesheet" href="<%= ctxPath %>/store/store_detail.css">

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<!-- jQuery (찜하기 AJAX 필수) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- 슬라이더 JS -->
<script src="<%= ctxPath %>/store/store_detail.js" defer></script>
</head>

<body>

<jsp:include page="/header/header.jsp" />

<div class="container">
    <div class="info">

        <!-- 이미지 슬라이드 -->
        <div class="slider-container">
            <div class="custom-slider">

                <div class="slides">
                    <% if (dto.getStoreImg() != null) { %>
                        <img src="<%= ctxPath %>/images/<%= dto.getStoreImg() %>" class="slide active">
                    <% } %>

                    <% if (dto.getStoreImg2() != null) { %>
                        <img src="<%= ctxPath %>/images/<%= dto.getStoreImg2() %>" class="slide">
                    <% } %>

                    <% if (dto.getStoreImg3() != null) { %>
                        <img src="<%= ctxPath %>/images/<%= dto.getStoreImg3() %>" class="slide">
                    <% } %>
                </div>

                <!-- 좌우 버튼 -->
                <button class="slider-btn prev">
                    <i class="bi bi-chevron-left caret"></i>
                </button>
                <button class="slider-btn next">
                    <i class="bi bi-chevron-right caret"></i>
                </button>

                <!-- 하단 점 -->
                <div class="slider-dots">
                    <span class="dot active"></span>
                    <span class="dot"></span>
                    <span class="dot"></span>
                </div>
            </div>
        </div>

        <!-- 가게 정보 -->
        <div class="store-info">

            <span class="store-category"><%= dto.getStoreCategory() %></span>

            <div class="store-title-row">
                <div>
                    <h2 class="store-name"><%= dto.getStoreName() %></h2>
                    <p class="store-intro"><%= dto.getStoreIntro() %></p>
                </div>

                <!-- 찜 버튼 -->
                <button type="button" class="store-jjim-btn"
                    onclick="toggleBookmark(this, '<%= dto.getStoreIdx() %>', '<%= dto.getStoreName() %>', '<%= dto.getStoreAddr() %>')">
                    ♡
                </button>
            </div>

            <!-- 상세 정보 -->
            <div class="storeinfomation">

                <div class="info-row">
                    <i class="bi bi-star-fill"></i>
                    <p class="store-rating">
                        <%= dto.getStoreRatingAvg() %> (<%= dto.getStoreRatingCount() %>)
                    </p>
                </div>

                <div class="info-row">
                    <i class="bi bi-telephone-fill"></i>
                    <p class="store-tel"><%= dto.getStoreTel() %></p>
                </div>

                <div class="info-row">
                    <i class="bi bi-geo-alt-fill"></i>
                    <p class="store-addr"><%= dto.getStoreAddr() %></p>
                </div>

            </div>
        </div>
    </div>
    
    
    <!-- 메뉴창 -->
    <div class="menu-section">
	    <div class="menu-header">
	        <h3>메뉴</h3>
	
	        <% if (isAdmin) { %>
			    <button class="menu-add-btn" data-bs-toggle="modal" data-bs-target="#menuAddModal">
			        메뉴추가
			    </button>
			<% } %>
	    </div>
	
	    <div class="menu-list">

	        <% if (menuList == null || menuList.isEmpty()) { %>
	            <p style="color:#999;">등록된 메뉴가 없습니다.</p>
	        <% } else {
	            for (MenuDTO m : menuList) { %>
	
	        <div class="menu-item">
			    <div class="menu-img">
			        <% if (m.getMenuImg() != null) { %>
			            <img src="<%= ctxPath %>/images/menu/<%= m.getMenuImg() %>" />
			        <% } %>
			    </div>
			
			    <div class="menu-text">
			        <p class="menu-name"><%= m.getMenuName() %></p>
			        <p class="menu-price"><%= m.getMenuPrice() %>원</p>
			    </div>
	        
	        <%-- 관리자 전용 버튼 --%>
		    <% if (isAdmin) { %>
			    <div class="menu-admin-btns">
			        <button class="btn-edit"
			            onclick="openEditMenuModal(<%= m.getMenuIdx() %>,'<%= m.getMenuName() %>',<%= m.getMenuPrice() %>,'<%= m.getMenuImg() == null ? "" : m.getMenuImg() %>')">
			            수정
			        </button>
			
			        <button class="btn-delete"
    				onclick="deleteMenu(<%= m.getMenuIdx() %>, <%= storeIdx %>)">
    				삭제
					</button>

			    </div>
			    <% } %>
			</div>
	        <% } } %>
	    </div>
	</div>
    
</div>

<jsp:include page="/footer/footer.jsp" />

<jsp:include page="../menu/menu_add.jsp">
    <jsp:param name="storeIdx" value="<%= storeIdx %>" />
</jsp:include>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

//삭제
function deleteMenu(menuIdx, storeIdx) {
    if (confirm("정말로 이 메뉴를 삭제하시겠습니까?")) {
        location.href =
            "<%= request.getContextPath() %>/menu/menu_delete.jsp"
            + "?menuIdx=" + menuIdx
            + "&storeIdx=" + storeIdx;
    }
}

</script>

</body>
</html>

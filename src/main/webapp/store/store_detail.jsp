<%@page import="com.team.project.dao.BookmarkDAO"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@page import="com.team.project.dao.ReviewDAO"%>
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
    MemberDTO loginMember = null;
    Object loginObj = session.getAttribute("loginMember");

    if (loginObj instanceof MemberDTO) {
        loginMember = (MemberDTO) loginObj;
        if ("admin".equals(loginMember.getMemberRole())) {
            isAdmin = true;
        }
    }
    
    //메뉴 불러오기
    MenuDAO menuDao = new MenuDAO();
    List<MenuDTO> menuList = menuDao.selectMenu(storeIdx);

    
    //리뷰 불러오기
    ReviewDAO reviewDao=new ReviewDAO();
    List<ReviewDTO> reviewList=reviewDao.selectReview(storeIdx);
    
    //평점 불러오기
    Double avgRating = reviewDao.avgReview(storeIdx);
    int reviewCount = reviewDao.countReview(storeIdx);
    
    //찜하기 여부 확인
    boolean isBookmarked = false;
    if (loginMember != null) {
        BookmarkDAO bookmarkDao = new BookmarkDAO();
        isBookmarked = bookmarkDao.isBookmarked(loginMember.getMemberId(), (int)storeIdx);
    }
    
	//리뷰
    int reviewOrder = reviewCount +1 ; 
	request.setAttribute("reviewOrder", reviewOrder);
	String memberId=(String)session.getAttribute("member_id");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= dto.getStoreName() %></title>
<script>
    var ctxPath = '<%= ctxPath %>';
</script>

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
                    <%= isBookmarked ? "♥" : "♡" %>
                </button>
            </div>

            <!-- 상세 정보 -->
            <div class="storeinfomation">

                <div class="info-row">
				    <i class="bi bi-star-fill"></i>
				    <p class="store-rating">
				        <%= String.format("%.1f", avgRating) %> <span id="reviewCount">(<%= reviewCount %>)</span> 
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
	
	
	<%-- 리뷰쓰기 --%>
	
	<!-- 리뷰 영역 -->
<div class="review-section">

    <div class="review-header">
        <h3>리뷰</h3>

		<button class="review-write-btn"
			id="reviewBtn"
			data-bs-toggle="modal"
        	data-bs-target="#reviewModal"
        	data-store-idx="<%=storeIdx%>"
        	data-login="<%= (memberId!= null) %>">
    		리뷰 쓰기
		</button>

    </div>

    <% if (reviewList == null || reviewList.isEmpty()) { %>
        <p class="no-review">작성된 리뷰가 없습니다.</p>
    <% } else { %>

        <%  
        	int index = 0; 
        
        	for (ReviewDTO r : reviewList) { 
        		boolean isMyReview = (memberId != null 
        			    && memberId.equals(r.getMemberId()));
        %>
		
        <div class="review-item <%= (index >= 5 ? "review-hidden" : "") %>">

            <!-- 프로필 -->
            <div class="review-profile">
                <% if (r.getMemberImg() != null) { %>
                    <img src="<%= ctxPath %>/images/profile/<%= r.getMemberImg() %>">
                <% } else { %>
                    <div class="profile-circle"><i class="bi bi-person-circle"></i></div>
                <% } %>
                <span class="review-writer"><%= r.getMemberName() %></span>
                <span class="review-rating">
                    평점 <%= r.getReviewRating() %>점
                </span>
            </div>

            <!-- 리뷰 본문 -->
            <div class="review-content">
                <!-- 왼쪽 : 텍스트 -->
		        <div class="review-text-wrap">
		            <p class="review-text">
		                <%= r.getReviewContent() %>
		            </p>
		
		            <span class="review-date">
		                <%= r.getReviewCreatedAt() %>
		            </span>
		        </div>
		        
		        <!-- 오른쪽 : 대표 이미지 -->
		        	<% if (r.getReviewImg1() != null && !r.getReviewImg1().equals("")) { %>
						<div class="review-img-thumb">
		        			<img src="<%= ctxPath %>/images/review_upload/<%= r.getReviewImg1() %>">
		        		</div>
		        	<% } %>
            </div>
            
            <% if (isMyReview) { %>
		        <div class="review-actions">
		            <button class="review-edit-btn"
		                onclick="openEditReviewModal(
		                    <%= r.getReviewIdx() %>,
		                    '<%= r.getReviewContent().replace("'", "\\'") %>',
		                    <%= r.getReviewRating() %>
		                )">
		                수정
		            </button>
		
		            <button class="review-delete-btn"
		                onclick="deleteReview(<%= r.getReviewIdx() %>, <%= storeIdx %>)">
		                삭제
		            </button>
		        </div>
		    <% } %>

        </div>
		<% index++; } %>

        <% } %>

    <% if (reviewList != null && reviewList.size() > 5) { %>
    	<button class="review-more-btn" onclick="showMoreReviews()">더보기</button>
	<% } %>

</div>

<!-- 지도 -->
<div class="map-section">
	<div class="map-header">
		<h3>지도</h3>
	</div>

	<div id="map" style="width:100%; height:350px; border-radius:10px;"></div>
</div>
	
    
</div>

<jsp:include page="/review/review_write.jsp"/>

<jsp:include page="/footer/footer.jsp" />

<jsp:include page="../menu/menu_add.jsp">
    <jsp:param name="storeIdx" value="<%= storeIdx %>" />
</jsp:include>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

//메뉴삭제
function deleteMenu(menuIdx, storeIdx) {
    if (confirm("정말로 이 메뉴를 삭제하시겠습니까?")) {
        location.href =
            "<%= request.getContextPath() %>/menu/menu_delete.jsp"
            + "?menuIdx=" + menuIdx
            + "&storeIdx=" + storeIdx;
    }
}


//리뷰삭제
function deleteReview(reviewIdx, storeIdx) {
    if (confirm("리뷰를 삭제하시겠습니까?")) {
        location.href =
            "<%= ctxPath %>/review/review_delete.jsp"
            + "?reviewIdx=" + reviewIdx
            + "&storeIdx=" + storeIdx;
    }
}
</script>

</body>
</html>

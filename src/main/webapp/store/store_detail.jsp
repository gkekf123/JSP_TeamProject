<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.team.project.dao.BookmarkDAO"%>
<%@page import="com.team.project.dto.ReviewDTO"%>
<%@page import="com.team.project.dao.ReviewDAO"%>
<%@page import="com.team.project.dto.MenuDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.team.project.dao.MenuDAO"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.StoreDetailDAO"%>
<%@page import="com.team.project.dto.StoreDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 0. 기본 설정
    request.setCharacterEncoding("UTF-8");
    String ctxPath = request.getContextPath();

    String storeIdxParam = request.getParameter("idx");
    if (storeIdxParam == null) {
        %>
        <script>
            alert("잘못된 접근입니다.");
            location.href = "<%= ctxPath %>/store/store_main.jsp";
        </script>
        <%
        return;
    }

    long storeIdx = Long.parseLong(storeIdxParam);

    // 1. 가게 정보 가져오기
    StoreDetailDAO dao = new StoreDetailDAO();
    StoreDTO dto = dao.selectDetailIntro(storeIdx);

    // 데이터가 없으면 목록으로 튕겨내기
    if (dto == null) {
        %>
        <script>
            alert("삭제되거나 존재하지 않는 맛집입니다.");
            location.href = "<%= ctxPath %>/store/store_main.jsp";
        </script>
        <%
        return;
    }

    // 2. 관리자 여부 확인
    boolean isAdmin = false;
    String memberId = (String) session.getAttribute("member_id");
    String memberRole = (String) session.getAttribute("member_role");
    if (memberRole != null && "admin".equals(memberRole)) {
        isAdmin = true;
    }
    
    // 3. 메뉴 불러오기
    MenuDAO menuDao = new MenuDAO();
    List<MenuDTO> menuList = menuDao.selectMenu(storeIdx);

    // 4. 리뷰 불러오기
    ReviewDAO reviewDao = new ReviewDAO();
    List<ReviewDTO> reviewList = reviewDao.selectReview(storeIdx);
    
    // 5. 평점 통계
    Double avgRating = reviewDao.avgReview(storeIdx);
    int reviewCount = reviewDao.countReview(storeIdx);
    
    // 6. 찜하기 여부 확인
    boolean isBookmarked = false;
    if (memberId != null) {
        BookmarkDAO bookmarkDao = new BookmarkDAO();
        isBookmarked = bookmarkDao.isBookmarked(memberId, (int)storeIdx);
    }
    
	//리뷰
    int reviewOrder = reviewCount +1 ; 
	request.setAttribute("reviewOrder", reviewOrder);
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm");
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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4d6ec00692a6f465a841ee2f2e06d862&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="<%= ctxPath %>/store/store_detail.js" defer></script>
</head>

<body>

<jsp:include page="/header/header.jsp" />

<div class="container">
    <div class="info">

        <div class="slider-container">
            <div class="custom-slider">
                <div class="slides">
                    <% 
                        // 이미지 경로 처리 (앞에 /가 없으면 붙여줌)
                        String img1 = dto.getStoreImg();
                        String img2 = dto.getStoreImg2();
                        String img3 = dto.getStoreImg3();
                        
                        if(img1 != null && !img1.startsWith("/")) img1 = "/" + img1;
                        if(img2 != null && !img2.startsWith("/")) img2 = "/" + img2;
                        if(img3 != null && !img3.startsWith("/")) img3 = "/" + img3;
                    %>

                    <%-- 1번 이미지 --%>
                    <% if (dto.getStoreImg() != null && !dto.getStoreImg().trim().isEmpty()) { %>
                        <img src="<%= ctxPath %>/images/store_image<%= img1 %>" class="slide active" onerror="this.style.display='none'">
                    <% } else { %>
                        <div class="slide active" style="background:#f0f0f0; display:flex; align-items:center; justify-content:center; color:#888;">이미지 없음</div>
                    <% } %>

                    <%-- 2번 이미지 --%>
                    <% if (dto.getStoreImg2() != null && !dto.getStoreImg2().trim().isEmpty()) { %>
                        <img src="<%= ctxPath %>/images/store_image<%= img2 %>" class="slide" onerror="this.style.display='none'">
                    <% } %>

                    <%-- 3번 이미지 --%>
                    <% if (dto.getStoreImg3() != null && !dto.getStoreImg3().trim().isEmpty()) { %>
                        <img src="<%= ctxPath %>/images/store_image<%= img3 %>" class="slide" onerror="this.style.display='none'">
                    <% } %>
                </div>

                <button class="slider-btn prev">
                    <i class="bi bi-chevron-left caret"></i>
                </button>
                <button class="slider-btn next">
                    <i class="bi bi-chevron-right caret"></i>
                </button>

                <div class="slider-dots">
                    <span class="dot active"></span>
                    <span class="dot"></span>
                    <span class="dot"></span>
                </div>
            </div>
        </div>

        <div class="store-info">
            <span class="store-category"><%= dto.getStoreCategory() %></span>

            <div class="store-title-row">
                <div>
                    <h2 class="store-name"><%= dto.getStoreName() %></h2>
                    <p class="store-intro"><%= dto.getStoreIntro() %></p>
                </div>

                <button type="button" class="store-jjim-btn"
                    onclick="toggleBookmark(this, '<%= dto.getStoreIdx() %>', '<%= dto.getStoreName() %>', '<%= dto.getStoreAddr() %>')">
                    <%= isBookmarked ? "♥" : "♡" %>
                </button>
            </div>

            <div class="storeinfomation">
                <div class="info-row">
				    <i class="bi bi-star-fill"></i>
				    <p class="store-rating">
				        <%= String.format("%.1f", avgRating)%> (<%=reviewCount%>)
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
                        <img src="<%= ctxPath %>/images/menu/<%= m.getMenuImg() %>" onerror="this.src='<%= ctxPath %>/images/no_img.png'"/>
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
    
    <div class="review-section">
        <div class="review-header">
            <h3>리뷰</h3>
            <button class="review-write-btn" id="reviewBtn"
                data-bs-toggle="modal" data-bs-target="#reviewModal"
                data-store-idx="<%=storeIdx%>" data-login="<%= (memberId!= null) %>"
                data-review-count="<%= reviewCount %>">
                리뷰 쓰기
            </button>
        </div>

        <% if (reviewList == null || reviewList.isEmpty()) { %>
            <p class="no-review">작성된 리뷰가 없습니다.</p>
        <% } else { 
            int index = 0; 
            for (ReviewDTO r : reviewList) { 
                boolean isMyReview = (memberId != null && memberId.equals(r.getMemberId()));
        %>
        
		<!-- 프로필 -->
        <div class="review-item <%= (index >= 5 ? "review-hidden" : "") %>" data-review-idx="<%=r.getReviewIdx()%>" data-store-idx="<%= storeIdx %>">
            <div class="review-profile">
                <% if (r.getMemberImg() != null) { %>
                    <img src="<%= ctxPath %>/images/profile/<%= r.getMemberImg() %>">
                <% } else { %>
                    <div class="profile-circle"><i class="bi bi-person-circle"></i></div>
                <% } %>
                <span class="review-writer"><%= r.getMemberName() %></span>
                <span class="review-rating">평점 <%= r.getReviewRating() %>점</span>
            </div>
        
            <div class="review-content">
                <div class="review-text-wrap">
                    <p class="review-text"><%= r.getReviewContent().replace("\n", "<br>")%></p>
                    <span class="review-date">
                    	<%=sdf.format(r.getReviewCreatedAt())%>
		                <% if (r.getReviewUpdatedAt() != null) { %>
				            (수정됨)
				        <% } %> </span>
                </div>
                
                <% if (r.getReviewImg1() != null && !r.getReviewImg1().equals("")) { %>
                    <div class="review-img-thumb" style="cursor:pointer;" 
                         onclick="showReviewImages('<%= r.getReviewImg1() %>', '<%= r.getReviewImg2() %>', '<%= r.getReviewImg3() %>', '<%= r.getReviewImg4() %>', '<%= r.getReviewImg5() %>')">
                        <img src="<%= ctxPath %>/images/review_upload/<%= r.getReviewImg1() %>">
                        <% if (r.getReviewImg2() != null && !r.getReviewImg2().equals("")) { %>
                            <div class="img-count-badge"><i class="bi bi-images"></i></div>
                        <% } %>
                    </div>
                <% } %>
            </div>
            
            <% if (isMyReview) { %>
                <div class="review-actions">
		            <button class="review-edit-btn">수정</button>
					<button class="review-delete-btn">삭제</button>
                </div>
            <% } %>
        </div>
        <% index++; } } %>

        <% if (reviewList != null && reviewList.size() > 5) { %>
            <button class="review-more-btn" id="reviewMoreBtn" onclick="showMoreReviews()">더보기</button>
        <% } %>
    </div>

    <div class="map-section">
        <div class="map-header">
            <h3>지도</h3>
        </div>
        <div id="map" style="width:100%; height:350px; border-radius:10px;"></div>
    </div>
    
    <div class="modal fade" id="reviewImageModal" tabindex="-1">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">리뷰 이미지</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <div id="reviewModalImages" class="review-modal-images"></div>
          </div>
        </div>
      </div>
    </div>
</div>

<jsp:include page="/review/review_write.jsp"/>
<jsp:include page="/footer/footer.jsp" />
<jsp:include page="../menu/menu_add.jsp">
    <jsp:param name="storeIdx" value="<%= storeIdx %>" />
</jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
    // 메뉴삭제
    function deleteMenu(menuIdx, storeIdx) {
        if (confirm("정말로 이 메뉴를 삭제하시겠습니까?")) {
            location.href = "<%= ctxPath %>/menu/menu_delete.jsp?menuIdx=" + menuIdx + "&storeIdx=" + storeIdx;
        }
    }

    // 메뉴 추가 모달 초기화
    $('#menuAddModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var modal = $(this);
        if (button.hasClass('menu-add-btn')) {
            modal.find('#menuModalTitle').text('메뉴 추가');
            modal.find('#menuIdx').val('');
            modal.find('#menuName').val('');
            modal.find('#menuPrice').val('');
            modal.find('#menuSubmitBtn').text('등록');
        }
    });
</script>

</body>
</html>
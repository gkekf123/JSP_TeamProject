<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
    String ctxPath = request.getContextPath(); 
    
    // 세션에서 로그인 정보 가져오기
    String loginOk = (String) session.getAttribute("loginok");
    String memberId = (String) session.getAttribute("member_id");
%>

<script type="text/javascript">
    const contextPath = "<%= ctxPath %>";
</script>
<link rel="stylesheet" href="<%= ctxPath %>/header/header.css">
<script src="<%= ctxPath %>/header/header.js" defer></script>

<header>
    <div class="header-logo" id="headerLogo" onclick="location.href='<%= ctxPath %>/index.jsp'" style="cursor:pointer;">
    	맛집<img src='<%= ctxPath %>/images/logo.png' alt="로고">리뷰
    </div>

    <nav>
        <ul>
            <li><a href="<%= ctxPath %>/store/store_main.jsp" class="nav">맛집추천</a></li> 
        	<li><a href="<%= ctxPath %>/map/map_main.jsp" class="nav">맛집지도</a></li>
        	<li><a href="<%= ctxPath %>/news/news.jsp" class="nav">맛집공유</a></li>
        </ul>
    </nav>

    <div class="header-right" style="display: flex; align-items: center;">
        <%-- 분기 처리: 로그인 안 함 vs 로그인 함 --%>
        <% if(loginOk == null) { %>
            <div class="header-login" id="headerLogin" style="margin-right: 15px; cursor: pointer;">로그인</div>
        <% } else { %>
            <div class="header-user-info" style="margin-right: 15px; font-weight: bold; font-size: 14px;">
                <%= memberId %>님
            </div>
        <% } %>
        
        <div class="header-open-sidebar" id="headerOpenSidebar" style="cursor: pointer;">☰</div>
    </div>
</header>

<div class="header-sidebar" id="headerSidebar">
    <h6 id="headerCloseSidebar" style="cursor: pointer;">X</h6>
    <ul>
        <li>
            <a href="<%= (loginOk != null) 
            ? (ctxPath + "/member/my_page.jsp") : (ctxPath + "/login/login_form.jsp") %>">마이페이지</a>
        </li>
        <li>
            <a href="<%= (loginOk != null) 
            ? (ctxPath + "/bookmark/bookmark_list.jsp") : (ctxPath + "/login/login_form.jsp") %>">찜</a>
        </li>
        <li>
            <a href="<%= (loginOk != null) 
            ? (ctxPath + "/review/my_review.jsp") : (ctxPath + "/login/login_form.jsp") %>">내 리뷰</a>
        </li>

        <%-- 로그인 상태일 때만 로그아웃 메뉴 출력 --%>
        <% if(loginOk != null) { %>
            <li><a href="<%= ctxPath %>/login/logout_action.jsp">로그아웃</a></li>
        <% } %>
	</ul>
</div>
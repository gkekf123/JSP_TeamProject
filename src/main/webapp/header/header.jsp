<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
    const contextPath = "<%= ctxPath %>";
</script>
<link rel="stylesheet" href="<%= ctxPath %>/header/header.css">
<script src="<%= ctxPath %>/header/header.js" defer></script>
<!-- 로그인여부 변수 loginMember-->
<!-- ===== 헤더 ===== -->
<header>
    <div class="header-logo" id="headerLogo">🍽 맛집리뷰</div>

    <nav>
        <ul>
            <li><a href="<%= ctxPath %>/store/store_main.jsp" class="nav">맛집추천</a></li> 
        	<li><a href="<%= ctxPath %>/map/map_main.jsp" class="nav">맛집지도</a></li>
        	<li><a href="<%= ctxPath %>/news/news.jsp" class="nav">맛집공유</a></li>
        </ul>
    </nav>

    <div class="header-right">
        <%-- 로그인 정보가 없을 때만 로그인 버튼 출력 --%>
        <% if(session.getAttribute("loginok") == null) { %>
            <div class="header-login" id="headerLogin">로그인</div>
        <% } %>
        <div class="header-open-sidebar" id="headerOpenSidebar">☰</div>
    </div>
</header>

<!-- ===== 사이드바 ===== -->
<div class="header-sidebar" id="headerSidebar">
    <h6 id="headerCloseSidebar">X</h6>
    <ul>
        <li>
            <a href="<%= (session.getAttribute("loginok") != null) 
            ? (ctxPath + "/member/my_page.jsp") : (ctxPath + "/login/login_form.jsp") %>">마이페이지</a>
        </li>
        <li>
            <a href="<%= (session.getAttribute("loginok") != null) 
            ? (ctxPath + "/bookmark/bookmark_list.jsp") : (ctxPath + "/login/login_form.jsp") %>">찜</a>
        </li>
        <li>
            <a href="<%= (session.getAttribute("loginok") != null) 
            ? (ctxPath + "/review/my_review.jsp") : (ctxPath + "/login/login_form.jsp") %>">내 리뷰</a>
        </li>

        <%-- 로그인 상태일 때만 로그아웃 메뉴 출력 --%>
        <% if(session.getAttribute("loginok") != null) { %>
            <li><a href="#" id="headerLogout">로그아웃</a></li>
        <% } %>
	</ul>
</div>
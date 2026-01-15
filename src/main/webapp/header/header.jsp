<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
    const contextPath = "<%= ctxPath %>";
</script>
<link rel="stylesheet" href="<%= ctxPath %>/header/header.css">
<script src="<%= ctxPath %>/header/header.js" defer></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<!-- 로그인여부 임의변수 loginMember-->
<!-- ===== 헤더 ===== -->
<header>
    <div class="header-logo" id="headerLogo">
		맛집리뷰<img src="<%= ctxPath %>/images/logo.png" alt="로고" class="main-logo-img">     
    </div>

    <nav>
        <ul>
        	<!-- 링크 수정 필요 -->
            <li><a href="<%= ctxPath %>/store/store_main.jsp">맛집추천</a></li> 
        	<li><a href="<%= ctxPath %>/map/map_main.jsp">맛집지도</a></li>
        	<li><a href="<%= ctxPath %>/news/news.jsp">맛집공유</a></li>
        </ul>
    </nav>

    <div class="header-right">
        <%-- 로그인 정보가 없을 때만 로그인 버튼 출력 --%>
        <% if(session.getAttribute("loginMember") == null) { %>
            <div class="header-login" id="headerLogin">로그인</div>
        <% } %>
        <div class="header-open-sidebar" id="headerOpenSidebar">☰</div>
    </div>
</header>

<!-- ===== 사이드바 ===== -->
<div class="header-sidebar" id="headerSidebar">
	<i class="bi bi-x-lg" id="headerCloseSidebar"></i>
    <ul>
    	<!-- 링크 수정 필요 전자-각각의 페이지 후자-로그인페이지  -->
    	<!-- 로그인 필요합니다 알림창 진행 추후 결정 -->
        <li>
            <a href="<%= (session.getAttribute("loginMember") != null) 
            ? (ctxPath + "/") : (ctxPath + "/") %>">마이페이지</a>
        </li>
        <li>
            <a href="<%= (session.getAttribute("loginMember") != null) 
            ? (ctxPath + "/") : (ctxPath + "/") %>">찜</a>
        </li>
        <li>
            <a href="<%= (session.getAttribute("loginMember") != null) 
            ? (ctxPath + "/") : (ctxPath + "/") %>">내 리뷰</a>
        </li>

        <%-- 로그인 상태일 때만 로그아웃 메뉴 출력 --%>
        <% if(session.getAttribute("loginMember") != null) { %>
            <li><a href="#" id="headerLogout">로그아웃</a></li>
        <% } %>
    </ul>
</div>



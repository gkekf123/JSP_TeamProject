<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<link rel="stylesheet" href="<%= ctxPath %>/public/public.css">
<script src="<%= ctxPath %>/public/public.js" defer></script>
<!-- 로그인여부 변수 loginMember-->
<!-- ===== 헤더 ===== -->
<header>
    <div class="header-logo" id="headerLogo">🍽 맛집리뷰</div>

    <nav>
        <ul>
        	<!-- 링크 수정 필요 -->
            <li><a href="<%= ctxPath %>/">맛집추천</a></li> 
        	<li><a href="<%= ctxPath %>/">맛집지도</a></li>
        	<li><a href="<%= ctxPath %>/">맛집공유</a></li>
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
    <h6 id="headerCloseSidebar">X</h6>
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
            <li id="headerLogout">로그아웃</li>
        <% } %>
    </ul>
</div>



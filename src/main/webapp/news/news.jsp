<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.team.project.dto.NewsDTO"%>
<%@page import="com.team.project.dao.NewsDAO"%>
<%@page import="com.team.project.dto.MemberDTO"%>
<%@page import="com.team.project.dao.SearchLogDAO"%>
<%@page import="com.team.project.util.GeminiUtil"%>
<%@page import="com.team.project.dto.StoreDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.team.project.dao.StoreDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 0. 기본 설정
    request.setCharacterEncoding("UTF-8");
    String ctxPath = request.getContextPath();
    
 // 1. 관리자 권한 확인 (세션 체크)
    boolean isAdmin = false;
    Object loginObj = session.getAttribute("loginMember");
    
    if (loginObj != null) {
        // 경우 1: 세션값이 MemberDTO 객체일 때 (정상적인 경우)
        if (loginObj instanceof MemberDTO) {
            MemberDTO loginMember = (MemberDTO) loginObj;
            
            // DTO 안의 권한(role)이 'admin'인지 확인
            if ("admin".equals(loginMember.getMemberRole())) { 
                isAdmin = true;
            }
        }
        // 경우 2: 세션값이 혹시 문자열일 때 (예외 처리)
        else if (loginObj instanceof String) {
            if ("admin".equals((String)loginObj)) {
                isAdmin = true;
            }
        }
    }
    
    NewsDAO dao=new NewsDAO();
    
    //페이징
    int perPage = 9;          // 한 페이지당 글 수
    int perBlock = 5;         // 페이지 번호 개수

    int currentPage = 1;
    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }

    int totalCount = dao.totalCount();

    int totalPage = (int)Math.ceil((double)totalCount / perPage);
    int start = (currentPage - 1) * perPage;

    List<NewsDTO> paging = dao.selectNewsPaging(start, perPage);

    int startPage = ((currentPage - 1) / perBlock) * perBlock + 1;
    int endPage = startPage + perBlock - 1;
    if (endPage > totalPage) endPage = totalPage;
%>

<!DOCTYPE html>
<html>
<head>
    <title>맛집 공유 리스트</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= ctxPath %>/news/news.css">
    <script src="<%= ctxPath %>/news/news.js" defer></script>
</head>
<body>

    <jsp:include page="/header/header.jsp" />

    <div class="container">
        <div class="header">
            <h1>맛집공유 최신뉴스</h1>
            
            <div class="header-right">
                <%-- 관리자(admin)일 때만 글쓰기 버튼 표시 --%>
                <% if(isAdmin) { %>
                    <button type="button" class="write-btn" onclick="location.href='news_write.jsp'">
                        ✏️ 뉴스등록
                    </button>
                <% } %>
            </div>
        </div>
        
        <div class="news-card-wrap">
        	<% if(paging == null || paging.size() == 0) { %>
    			<p class="no-data">등록된 뉴스가 없습니다.</p>
			<%} else { 
    			for(NewsDTO dto : paging) {%>
    		
    		<div class="news-card">
    			
	    		<div class="news-img">
				    <% if(dto.getNewsImg() != null && !dto.getNewsImg().isEmpty()) { %>
				        <img src="<%= dto.getNewsImg() %>" alt="뉴스 이미지">
				        
				    <% } else { %>
				        <div class="news-no-img">이미지 없음</div>
				    <% } %>
				</div>
	    		
	    		<div class="news-info">
	    			<p class="news-title"  onclick="window.open('<%=dto.getNewsUrl()%>')" ><%=dto.getNewsTitle() %></p>
	    			<div class="news-sourcedate">
		    			<p class="news-source"><%=dto.getNewsSource() %></p>
		    			<span class="news-date">
		    			<%= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(dto.getNewsRegdate()) %>
		    			</span>
	    			</div>
	    		</div>
    		</div>
        <%}
    			}%>
    	</div>
    </div>
    
    <%-- 페이징 --%>
    <div class="paging">
	    <% if (startPage > 1) { %>
	        <a href="news.jsp?page=<%= startPage - 1 %>">◀ 이전</a>
	    <% } %>
	
	    <% for (int i = startPage; i <= endPage; i++) { %>
	        <% if (i == currentPage) { %>
	            <span class="active"><%= i %></span>
	        <% } else { %>
	            <a href="news.jsp?page=<%= i %>"><%= i %></a>
	        <% } %>
	    <% } %>
	
	    <% if (endPage < totalPage) { %>
	        <a href="news.jsp?page=<%= endPage + 1 %>">다음 ▶</a>
	    <% } %>
	</div>
	
    <jsp:include page="/footer/footer.jsp" />
</body>
</html>
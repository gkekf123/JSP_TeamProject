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
    List<NewsDTO> list=dao.selectNews();
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
        	<% if(list == null || list.size() == 0) { %>
    			<p class="no-data">등록된 뉴스가 없습니다.</p>
			<%} else { 
    			for(NewsDTO dto : list) {%>
    		
    		<div class="news-card">
    			
	    		<div class="news-img">
	    			<% if(dto.getNewsImg() !=null && !dto.getNewsImg().isEmpty()){%>
	    				<img alt="" src="<%=ctxPath%>/images/noimage.png" alt="기본 이미지">
	    			<%}else{%>
	    				<img src="<%=dto.getNewsImg()%>" alt="뉴스 이미지">
	    			<%}
	    			%>
	    		</div>
	    		
	    		<div class="news-info">
	    			<p class="news-title"  onclick="window.open('<%=dto.getNewsUrl()%>')" ><%=dto.getNewsTitle() %></p>
	    			<p class="news-source"><%=dto.getNewsSource() %></p>
	    			<span class="news-date">
	    			<%= new SimpleDateFormat("yyyy-MM-dd HH:mm").format(dto.getNewsRegdate()) %>
	    			</span>
	    		</div>
    		</div>
        <%}
    			}%>
    	</div>
    </div>
    
    <jsp:include page="/footer/footer.jsp" />

</body>
</html>
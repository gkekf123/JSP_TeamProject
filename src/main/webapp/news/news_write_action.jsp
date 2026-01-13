<%@page import="java.io.File"%>
<%@page import="com.team.project.dao.NewsDAO"%>
<%@page import="com.team.project.dto.NewsDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String realPath=application.getRealPath("/images/news_upload");
int maxSize = 5 * 1024 * 1024;
String encoding = "UTF-8";

//1. MultipartRequest 생성
MultipartRequest multi = new MultipartRequest(request,realPath, maxSize,encoding,new DefaultFileRenamePolicy());

//2. 파라미터 받기
String news_title = multi.getParameter("news_title");
String news_url = multi.getParameter("news_url");
String news_source = multi.getParameter("news_source");

//3. 파일명 얻기
String fileName = multi.getFilesystemName("news_img");
File uploadDir = new File(realPath);
if (!uploadDir.exists()) {
    uploadDir.mkdirs();
}

//4. DB에 저장할 이미지 경로
String news_img = null;
if (fileName != null) {
    news_img = request.getContextPath() + "/images/news_upload/" + fileName;
}

//5. DTO 세팅
NewsDTO dto = new NewsDTO();
dto.setNews_title(news_title);
dto.setNews_url(news_url);
dto.setNews_img(news_img);
dto.setNews_source(news_source);

// 6. DB insert
NewsDAO dao = new NewsDAO();
dao.insertNews(dto);

// 7. 목록으로 이동
response.sendRedirect("/news.jsp");

%>
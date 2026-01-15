<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String ctxPath = request.getContextPath();
long storeIdx = 5; // 예시: DB에서 가져온 가게 번호
/* 예시) dao선언, 가게idx로 리뷰수 불러오는 메소드, 리뷰수+1로 몇번째인지 변수저장
ReviewDAO rdao = new ReviewDAO();
int reviewCount = rdao.getReviewCountByStore(storeIdx); 
int reviewOrder = reviewCount + 1;
*/
int reviewOrder = 156;
request.setAttribute("reviewOrder", reviewOrder);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>

<button class="btn btn-dark"
        data-bs-toggle="modal"
        data-bs-target="#modernBsModal"
        data-store-idx="<%=storeIdx%>">
    리뷰 작성
</button>
<jsp:include page="/test.jsp"/>


</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
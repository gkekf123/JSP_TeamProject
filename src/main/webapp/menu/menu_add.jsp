<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
//0. 기본 설정
request.setCharacterEncoding("UTF-8");
String ctxPath = request.getContextPath();
String storeIdx = request.getParameter("storeIdx");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= ctxPath %>/menu/menu_add.css">
<script src="<%= ctxPath %>/menu/menu_add.js" defer></script>
</head>
<body>
<div class="modal fade" id="menuAddModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <form action="<%= ctxPath %>/menu/menu_add_action.jsp"
      method="post"
      enctype="multipart/form-data">

        <%
		    // include 시 jsp:param으로 전달된 값을 가져옵니다.
		    String storeIdxFromParam = request.getParameter("storeIdx");
		%>
		<input type="hidden" name="storeIdx" id="menuStoreIdx" value="<%= storeIdxFromParam %>">
        <input type="hidden" name="menuIdx" value="" id="menuIdx">

        <div class="modal-header">
          <h5 class="modal-title" id="menuModalTitle">메뉴 추가</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>

        <div class="modal-body">

          <div class="mb-3">
            <label class="form-label">메뉴명</label>
            <input type="text" name="menuName" id="menuName" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label">가격</label>
            <input type="text" name="menuPrice" id="menuPrice" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label">이미지</label>
            <input type="file" name="menuImg" id="menuImg" class="form-control">
          </div>

        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-primary" id="menuSubmitBtn">등록</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            취소
          </button>
        </div>

      </form>

    </div>
  </div>
</div>
</body>
</html>
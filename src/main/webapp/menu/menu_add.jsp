<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<div class="modal fade" id="menuAddModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <form id="menuForm" action="<%= ctxPath %>/menu/menu_add_action.jsp"
            method="post" enctype="multipart/form-data">

        <input type="hidden" name="storeIdx" id="menuStoreIdx" value="<%= request.getParameter("storeIdx") %>">
        <input type="hidden" name="menuIdx" id="updateMenuIdx" value="">
        <input type="hidden" name="oldMenuImg" id="oldMenuImg" value="">

        <div class="modal-header">
          <h5 class="modal-title" id="menuModalTitle">메뉴 추가</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>

        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label">메뉴명</label>
            <input type="text" name="menuName" id="updateMenuName" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label">가격</label>
            <input type="text" name="menuPrice" id="updateMenuPrice" class="form-control" required>
          </div>

          <div class="mb-3">
            <label class="form-label">이미지</label>
            <input type="file" name="menuImg" id="updateMenuImg" class="form-control">
            <div id="currentImgArea" style="margin-top:5px; font-size:12px; color:blue;"></div>
          </div>
        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-warning" id="menuSubmitBtn">등록</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        </div>

      </form>

    </div>
  </div>
</div>
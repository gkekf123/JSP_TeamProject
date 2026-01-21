<%@page import="com.team.project.dto.StoreDTO"%>
<%@page import="com.team.project.dao.StoreDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. 관리자 체크
    String role = (String) session.getAttribute("member_role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("store_main.jsp");
        return;
    }

    // 2. 데이터 조회
    String idx = request.getParameter("idx");
    StoreDAO dao = new StoreDAO();
    StoreDTO dto = dao.selectStoreOne(idx);

    if (dto == null) {
%>
    <script>alert("존재하지 않는 게시물입니다."); history.back();</script>
<%
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집 수정</title>
<style>
    body { font-family: 'Noto Sans KR', sans-serif; background: #f4f4f4; }
    .container { width: 600px; margin: 50px auto; padding: 30px; background: #fff; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    h2 { text-align: center; color: #333; }
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; font-weight: bold; margin-bottom: 5px; }
    .form-group input, .form-group select, .form-group textarea {
        width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box;
    }
    .btn-area { text-align: center; margin-top: 20px; }
    .btn-submit { background: #3498db; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
    .btn-cancel { background: #95a5a6; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; margin-left: 10px; }
    .current-img { font-size: 12px; color: #009900; margin-top: 5px; }
    .file-group { margin-bottom: 10px; border: 1px solid #eee; padding: 10px; border-radius: 5px; }
</style>

<script>
    function goKakaoPopup() {
        window.open("kakao_map_popup.jsp", "pop", "width=600,height=700,scrollbars=yes"); 
    }

    function kakaoCallBack(name, addr, tel, lat, lng, id, url) {
        document.querySelector('input[name="store_name"]').value = name;
        document.querySelector('input[name="store_addr"]').value = addr;
        document.querySelector('input[name="store_tel"]').value = tel;
        
        // 히든 필드 값 갱신
        document.querySelector('input[name="latitude"]').value = lat;
        document.querySelector('input[name="longitude"]').value = lng;
        document.querySelector('input[name="kakaoId"]').value = id;
        document.querySelector('input[name="placeUrl"]').value = url;
    }
</script>
</head>
<body>
    <jsp:include page="/header/header.jsp" />

    <div class="container">
        <h2>맛집 정보 수정</h2>
        
        <form action="store_update_action.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" name="store_idx" value="<%= dto.getStoreIdx() %>">
            
            <input type="hidden" name="latitude" value="<%= dto.getLatitude() %>">
            <input type="hidden" name="longitude" value="<%= dto.getLongitude() %>">
            <input type="hidden" name="kakaoId" value="<%= dto.getKakaoId() != null ? dto.getKakaoId() : "" %>">
            <input type="hidden" name="placeUrl" value="<%= dto.getPlaceUrl() != null ? dto.getPlaceUrl() : "" %>">
            
            <input type="hidden" name="old_img1" value="<%= dto.getStoreImg() != null ? dto.getStoreImg() : "" %>">
            <input type="hidden" name="old_img2" value="<%= dto.getStoreImg2() != null ? dto.getStoreImg2() : "" %>">
            <input type="hidden" name="old_img3" value="<%= dto.getStoreImg3() != null ? dto.getStoreImg3() : "" %>">

            <div class="form-group">
                <label>주소검색</label>
                <div style="display: flex; gap: 10px;">
                    <input type="text" name="store_name" value="<%= dto.getStoreName() %>" required placeholder="주소 검색 버튼을 눌러주세요" readonly>
                    <button type="button" onclick="goKakaoPopup()" style="width: 120px; padding: 10px; background: #FEE500; color: #000; font-weight:bold; border: none; border-radius: 5px; cursor: pointer;">주소검색</button>
                </div>
            </div>

            <div class="form-group">
                <label>카테고리(꼭 선택해주세요)</label>
                <select name="store_category">
                    <option value="한식" <%= "한식".equals(dto.getStoreCategory()) ? "selected" : "" %>>한식</option>
                    <option value="중식" <%= "중식".equals(dto.getStoreCategory()) ? "selected" : "" %>>중식</option>
                    <option value="일식" <%= "일식".equals(dto.getStoreCategory()) ? "selected" : "" %>>일식</option>
                    <option value="양식" <%= "양식".equals(dto.getStoreCategory()) ? "selected" : "" %>>양식</option>
                    <option value="카페/디저트" <%= "카페/디저트".equals(dto.getStoreCategory()) ? "selected" : "" %>>카페/디저트</option>
                </select>
            </div>

            <div class="form-group">
                <label>전화번호</label>
                <input type="text" name="store_tel" value="<%= dto.getStoreTel() %>">
            </div>

            <div class="form-group">
                <label>주소</label>
                <input type="text" name="store_addr" value="<%= dto.getStoreAddr() %>" readonly>
            </div>

            <div class="form-group">
                <label>한줄 소개</label>
                <textarea name="store_intro" rows="3"><%= dto.getStoreIntro() %></textarea>
            </div>

            <div class="form-group">
                <label>가게 이미지 수정</label>
                <div class="file-group">
                    <label>대표 이미지</label>
                    <% if(dto.getStoreImg() != null) { %> <div class="current-img">현재: <%= dto.getStoreImg() %></div> <% } %>
                    <input type="file" name="store_img1" accept="image/*">
                </div>
                <div class="file-group">
                    <label>추가 이미지</label>
                    <% if(dto.getStoreImg2() != null) { %> <div class="current-img">현재: <%= dto.getStoreImg2() %></div> <% } %>
                    <input type="file" name="store_img2" accept="image/*">
                </div>
                <div class="file-group">
                    <label>추가 이미지</label>
                    <% if(dto.getStoreImg3() != null) { %> <div class="current-img">현재: <%= dto.getStoreImg3() %></div> <% } %>
                    <input type="file" name="store_img3" accept="image/*">
                </div>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn-submit">수정완료</button>
                <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
            </div>
        </form>
    </div>
    <jsp:include page="/footer/footer.jsp" />
</body>
</html>
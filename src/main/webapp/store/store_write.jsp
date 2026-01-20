<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. 관리자 권한 체크
    String member_role = (String) session.getAttribute("member_role");
    boolean isAdmin = false;

    if (member_role != null && "admin".equals(member_role)) {
        isAdmin = true;
    }

    // 관리자 검증
    if (!isAdmin) {
%>
    <script>
        alert("관리자만 접근할 수 있습니다.");
        location.href = "store_main.jsp";
    </script>
<%
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집 등록</title>
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
    .file-group { margin-bottom: 10px; border: 1px solid #eee; padding: 10px; border-radius: 5px; }
</style>

<script>
    // 카카오 지도 팝업 열기
    function goKakaoPopup() {
        window.open("kakao_map_popup.jsp", "pop", "width=600,height=700,scrollbars=yes"); 
    }

    // 팝업에서 데이터 받아오는 콜백 함수
    function kakaoCallBack(name, addr, tel, lat, lng, id, url) {
        document.querySelector('input[name="store_name"]').value = name;
        document.querySelector('input[name="store_addr"]').value = addr;
        document.querySelector('input[name="store_tel"]').value = tel;
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
        <h2>🍽 맛집 정보 등록</h2>
        
        <form action="store_write_action.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" name="latitude">
            <input type="hidden" name="longitude">
            <input type="hidden" name="kakaoId">
            <input type="hidden" name="placeUrl">

            <div class="form-group">
                <label>주소검색</label>
                <div style="display: flex; gap: 10px;">
                    <input type="text" name="store_name" required placeholder="주소 검색 버튼을 눌러주세요" readonly>
                    <button type="button" onclick="goKakaoPopup()" style="width: 120px; padding: 10px; background: #FEE500; color: #000; font-weight:bold; border: none; border-radius: 5px; cursor: pointer;">가게 검색</button>
                </div>
            </div>

            <div class="form-group">
                <label>카테고리</label>
                <select name="store_category">
                    <option value="한식">한식</option>
                    <option value="중식">중식</option>
                    <option value="일식">일식</option>
                    <option value="양식">양식</option>
                    <option value="카페/디저트">카페/디저트</option>
                </select>
            </div>

            <div class="form-group">
                <label>전화번호</label>
                <input type="text" name="store_tel" readonly placeholder="자동 입력됩니다">
            </div>

            <div class="form-group">
                <label>주소</label>
                <input type="text" name="store_addr" required placeholder="자동 입력됩니다" readonly>
            </div>

            <div class="form-group">
                <label>한줄 소개</label>
                <textarea name="store_intro" rows="3" placeholder="가게에 대한 간단한 소개를 입력하세요"></textarea>
            </div>

            <div class="form-group">
                <label>가게 이미지 등록 (최대 3장)</label>
                
                <div class="file-group">
                    <label style="font-size:12px; color:#666;">대표 이미지 (1번)</label>
                    <input type="file" name="store_img1" accept="image/*">
                </div>
                
                <div class="file-group">
                    <label style="font-size:12px; color:#666;">추가 이미지 (2번)</label>
                    <input type="file" name="store_img2" accept="image/*">
                </div>
                
                <div class="file-group">
                    <label style="font-size:12px; color:#666;">추가 이미지 (3번)</label>
                    <input type="file" name="store_img3" accept="image/*">
                </div>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn-submit">등록하기</button>
                <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
            </div>
        </form>
    </div>

    <jsp:include page="/footer/footer.jsp" />

</body>
</html>
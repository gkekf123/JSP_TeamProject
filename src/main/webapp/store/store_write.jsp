<%@page import="com.team.project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. 관리자 권한 체크
    boolean isAdmin = false;
    Object loginObj = session.getAttribute("loginMember");
    
    if (loginObj != null) {
        if (loginObj instanceof MemberDTO) {
            MemberDTO loginMember = (MemberDTO) loginObj;
            // role이 admin인지 확인
            if ("admin".equals(loginMember.getMemberRole())) {
                isAdmin = true;
            }
        }
        else if (loginObj instanceof String) {
            if ("admin".equals((String)loginObj)) {
                isAdmin = true;
            }
        }
    }

    // 2. 관리자체크
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
    
    /* 파일 입력창 간격 */
    .file-group { margin-bottom: 10px; border: 1px solid #eee; padding: 10px; border-radius: 5px; }
</style>
<script>
        // 주소 검색 팝업을 호출하는 함수
        function goPopup() {
            // 팝업 띄우기
        	var pop = window.open("juso_popup.jsp", "pop", "width=600,height=1000, scrollbars=yes, resizable=yes"); 
        }

        // 팝업에서 주소 입력받기 (콜백 함수)
        function jusoCallBack(roadFullAddr) {
            // 팝업에서 전달받은 주소를 입력칸에 넣기
            document.querySelector('input[name="store_addr"]').value = roadFullAddr;
        }
    </script>
</head>
<body>

    <jsp:include page="/header/header.jsp" />

    <div class="container">
        <h2>🍽 맛집 정보 등록</h2>
        
        <form action="store_write_action.jsp" method="post" enctype="multipart/form-data">
            
            <div class="form-group">
                <label>가게 이름</label>
                <input type="text" name="store_name" required placeholder="상호명을 입력하세요">
            </div>

            <div class="form-group">
                <label>카테고리</label>
                <select name="store_category">
                	<option value="전체">전체</option>
                    <option value="한식">한식</option>
                    <option value="중식">중식</option>
                    <option value="일식">일식</option>
                    <option value="양식">양식</option>
                    <option value="카페/디저트">카페/디저트</option>
                    <option value="기타">기타</option>
                </select>
            </div>

            <div class="form-group">
                <label>전화번호</label>
                <input type="text" name="store_tel">
            </div>

            <div class="form-group">
		        <label>주소</label>
		        <div style="display: flex; gap: 10px;">
		            <input type="text" name="store_addr" required placeholder="주소 검색을 클릭하세요" readonly>
		            <button type="button" onclick="goPopup()" style="width: 100px; padding: 10px; background: #333; color: white; border: none; border-radius: 5px; cursor: pointer;">주소 검색</button>
		        </div>
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
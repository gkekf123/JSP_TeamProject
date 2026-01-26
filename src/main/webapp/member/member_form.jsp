<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<style>
body {
    background-color: #f4f4f4;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 카드 */
.container {
    width: 450px;
    margin: 120px auto;
    padding: 40px;
    background-color: #fff;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

.title {
    text-align: center;
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 30px;
}

.input-box {
    margin-bottom: 15px;
}

.input-box input,
.input-box select {
    width: 100%;
    height: 45px;
    border-radius: 10px;
    border: 1px solid #ccc;
    padding: 0 15px;
    font-size: 14px;
}

.inline {
    display: flex;
    gap: 10px;
    align-items: center;
}

.inline input {
    flex: 1;
}

.check-btn {
    height: 45px;
    border-radius: 10px;
    border: none;
    padding: 0 18px;
    background-color: #f39c12;
    color: #fff;
    font-size: 14px;
    cursor: pointer;
    white-space: nowrap;
}

.check-btn:hover {
    background-color: #e67e22;
}

.role-box {
    font-size: 14px;
    margin-bottom: 20px;
}

.submit-btn {
    width: 100%;
    height: 45px;
    border: none;
    border-radius: 10px;
    background-color: #f39c12;
    color: #fff;
    font-size: 16px;
    cursor: pointer;
}

.submit-btn:hover {
    background-color: #e67e22;
}

.reset-btn {
    width: 100%;
    height: 45px;
    margin-top: 10px;
    border-radius: 10px;
    border: 1px solid #f39c12;
    background-color: #fff;
    color: #f39c12;
    font-size: 15px;
    cursor: pointer;
}

.reset-btn:hover {
    background-color: #fdf2e9;
}

.preview {
    margin-top: 10px;
    max-height: 100px;
}
</style>

<script>
function checkForm(f){
    if(f.member_pw1.value !== f.member_pw2.value){
        alert("비밀번호가 다릅니다");
        f.member_pw1.value="";
        f.member_pw2.value="";
        return false;
    }
    return true;
}

function previewImage(input){
    const preview = document.getElementById("preview");
    if(input.files && input.files[0]){
        const reader = new FileReader();
        reader.onload = e => preview.src = e.target.result;
        reader.readAsDataURL(input.files[0]);
    } else {
        preview.src = "<%=request.getContextPath()%>/upload/default_profile.png"; // 기본 이미지
    }
}


$(function(){
    $("#btncheck").click(function(){
        const member_id = $("#member_id").val();
        $.get(
            "<%=request.getContextPath()%>/member/id_check.jsp",
            { member_id },
            function(res){
                if(res.count == 1){
                    alert("이미 사용중인 아이디입니다");
                    $("#member_id").val('');
                } else {
                    alert("사용 가능한 아이디입니다");
                }
            },
            "json"
        );
    });

    $("#selemail").change(function(){
        $("#member_email2").val($(this).val() == '-' ? '' : $(this).val());
    });
});
</script>
</head>

<body>
<jsp:include page="/header/header.jsp" />
<div class="container">
    <div class="title">회원가입</div>

    <form action="<%=request.getContextPath()%>/member/member_add.jsp"
          method="post" enctype="multipart/form-data"
          onsubmit="return checkForm(this);">

        <div class="role-box">
            <label>
                <input type="checkbox" name="member_role" value="admin"> 관리자 계정
            </label>
        </div>

        <div class="input-box inline">
            <input type="text" name="member_id" id="member_id" placeholder="아이디" required>
            <button type="button" id="btncheck" class="check-btn">중복</button>
        </div>

        <div class="input-box">
            <input type="password" name="member_pw1" placeholder="비밀번호" required>
        </div>

        <div class="input-box">
            <input type="password" name="member_pw2" placeholder="비밀번호 확인" required>
        </div>

        <div class="input-box">
            <input type="text" name="member_name" placeholder="이름" required>
        </div>

        <div class="input-box">
            <input type="text" name="member_hp" placeholder="휴대폰 번호" required>
        </div>

        <div class="input-box">
            <input type="text" name="member_addr" placeholder="주소" required>
        </div>

        <div class="input-box">
            <input type="file" name="member_img" accept="image/*" onchange="previewImage(this)">
            <img id="preview" class="preview">
        </div>

        <div class="input-box inline">
            <input type="text" name="member_email1" placeholder="이메일" required>
            <span style="line-height:45px">@</span>
            <input type="text" name="member_email2" id="member_email2" required>
        </div>

        <div class="input-box">
            <select id="selemail">
                <option value="-">직접입력</option>
                <option value="naver.com">naver.com</option>
                <option value="gmail.com">gmail.com</option>
                <option value="hanmail.net">hanmail.net</option>
            </select>
        </div>

        <button type="submit" class="submit-btn">가입하기</button>
        <button type="reset" class="reset-btn">다시작성</button>
    </form>
</div>
<jsp:include page="/footer/footer.jsp" />
</body>
</html>

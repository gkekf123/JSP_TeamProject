<div align="center">
  <img width="100%" alt="logo" src="https://github.com/user-attachments/assets/8b145ecd-323b-465e-82c1-2f9fa9740536" />
  <h2>맛집리뷰</h2>
  <p>
    <b>취향을 분석하는 AI(Gemini) 기반 검색과 카카오맵(Kakao Map) 위치 서비스를 결합한 맛집 커뮤니티입니다.</b><br>
    단순한 검색을 넘어, AI와의 대화를 통해 숨은 맛집을 발견하고,<br>
    실제 방문자들의 별점과 리뷰를 통해 검증된 미식 정보를 지도에서 한눈에 확인할 수 있습니다.
  </p>
</div>

<br>

## Roles & Responsibilities (R&R)
### 황주현 User & Data
  - 로그인 / 회원가입 / 로그아웃 구현
  - 마이페이지 (내 정보 수정, 활동 내역 조회)
  - 초기 데이터 수집 및 DB 구축
### 유지은 Review & Layout
  - 공통 레이아웃 (헤더, 푸터) 구현
  - 리뷰 시스템 (등록, 삭제, 수정 기능)
  - 리뷰 평점 및 통계 처리
### 이태주 Store & Map
  - Gemini 검색 기능 구현
  - 맛집 리스트 조회 및 필터링
  - 맛집 등록 (관리자) 및 지도(Map) 연동
  - 찜하기(Bookmark) 목록 및 기능 구현
### 김민지 Detail & Community
  - 가게 상세 페이지 구현 (디테일 뷰)
  - 맛집 뉴스/공유 게시판 기능
  - 가게별 리뷰 목록 조회 및 UI 구현

<br>

## DB(ERD)
<img width="745" height="829" alt="image" src="https://github.com/user-attachments/assets/9127daf0-79ff-4b94-9276-2d29b350ad72" />

<br>

## Tech Stack
<img width="838" height="464" alt="image" src="https://github.com/user-attachments/assets/c2656030-037f-4d81-ae2f-67822f69f5a6" />

### Frontend
![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)
![jQuery](https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)

### Backend & Database
![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/apache%20tomcat-%23F8DC75.svg?style=for-the-badge&logo=apache-tomcat&logoColor=black)
![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)

### APIs
![Kakao Map](https://img.shields.io/badge/Kakao%20Map-%23FFCD00.svg?style=for-the-badge&logo=kakao&logoColor=black)
![Google Gemini](https://img.shields.io/badge/google%20gemini-8E75B2?style=for-the-badge&logo=google%20gemini&logoColor=white)

### Collaboration & Tools
![Jira](https://img.shields.io/badge/jira-%230A0FFF.svg?style=for-the-badge&logo=jira&logoColor=white)
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
![Figma](https://img.shields.io/badge/figma-%23F24E1E.svg?style=for-the-badge&logo=figma&logoColor=white)
![Canva](https://img.shields.io/badge/Canva-%2300C4CC.svg?style=for-the-badge&logo=Canva&logoColor=white)

<br>

### In Action
<table width="100%">
  <tr>
    <td align="center" width="33%">
      <video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541926768-8c7baa0c-a094-4cb3-af46-be752cdc9c52.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDQ5MTMsIm5iZiI6MTc2OTY0NDYxMywicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjY3NjgtOGM3YmFhMGMtYTA5NC00Y2IzLWFmNDYtYmU3NTJjZGM5YzUyLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjglMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI4VDIzNTY1M1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTNhZWZmNTA0N2JhNDVkZjNjY2QyNThhMjAwZjg1MjJkNzJkYWI4M2Y3OGQ1ZWI1YjcyYTlhNTdjYjU2MzQ0ODgmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.m_g8bALCGnMevG8W2piRAVexf6v6_0RttwTkQe6xN_U" controls width="100%"></video><br>
      <b>1. 로그인 (통합)</b>
    </td>
    <td align="center" width="33%">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>2. 맛집 등록 및 수정</b>
    </td>
    <td align="center" width="33%">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>3. 메뉴 추가 및 삭제</b>
    </td>
  </tr>
  
  <tr>
    <td align="center">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>3-1. 메뉴 수정 및 삭제</b>
    </td>
    <td align="center">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>4. 뉴스 등록</b>
    </td>
    <td align="center">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>4-1. 뉴스 페이징</b>
    </td>
  </tr>

  <tr>
    <td align="center">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>5. 관리자 마이페이지</b>
    </td>
    <td align="center">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>6. 비로그인 기능 제한</b>
    </td>
    <td align="center">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>7. 회원가입 및 프로필 변경</b>
    </td>
  </tr>

  <tr>
    <td align="center">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>8. 맛집 정렬 기능</b>
    </td>
    <td align="center">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>9. 찜(Bookmark) 기능</b>
    </td>
    <td align="center">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>10. 리뷰 기능</b>
    </td>
  </tr>

  <tr>
    <td align="center">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>11. 마이 리뷰 관리</b>
    </td>
    <td align="center">
      <video src="https://github.com/user-attachments/assets/..." controls width="100%"></video><br>
      <b>12. 회원 탈퇴</b>
    </td>
    <td align="center">
      </td>
  </tr>
</table>

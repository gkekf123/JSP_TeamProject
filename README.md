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

## 🎬 In Action (Demonstration)

### 1. 로그인
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541926768-8c7baa0c-a094-4cb3-af46-be752cdc9c52.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjY3NjgtOGM3YmFhMGMtYTA5NC00Y2IzLWFmNDYtYmU3NTJjZGM5YzUyLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWFmNTU5NGJiOTdiMzE3MTM0NjBmMjMzZWVmOGJlOWE0NzE4NmIyZWYxYTZlM2U3YzdmM2VkYzg1ZDIxOWUzYjcmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.zjDPGNgBtCs6-ECcd1eBwpYXSWTGnSCw1BRNUQWiHME" controls width="100%"></video>
<br><br>

### 2. 관리자_맛집등록
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541926786-3c04f773-3a91-4a02-b7ae-52af8bf966b7.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjY3ODYtM2MwNGY3NzMtM2E5MS00YTAyLWI3YWUtNTJhZjhiZjk2NmI3Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTIzNGMxYzdlM2E2Nzg3YWZlM2FkNGQwNGE0OWJiZDA4YzczMGUwZWYzZTE4NjM1MDBlODVmMTlkYzBmNzc0YjImWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.cjzGZoi1GQ-F5NlOtxDemEw94pGHN2KT9oX0rqiI13o" controls width="100%"></video>
<br><br>

### 3. 관리자_메뉴 추가 및 삭제
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541926805-cd3f8a04-d831-40e8-95be-2cd750bb99d6.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjY4MDUtY2QzZjhhMDQtZDgzMS00MGU4LTk1YmUtMmNkNzUwYmI5OWQ2Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWY4MmE5NjBkMWZlNjZkZjZmMGI4NjVjYWNhYWI3MjFiYjkxYmNiNWE2MjY1N2RlOTJjODUxZmJhMzRiYTI3YjMmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.cQ9MhvZ1vTcQ9gjAjywhBGTFcTPBYjhVmU1Lv7clA_A" controls width="100%"></video>
<br><br>

### 3-1. 관라저_메뉴 수정 및 삭제
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541926810-05b1a860-48fb-4e62-830f-1ea79faa8b06.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjY4MTAtMDViMWE4NjAtNDhmYi00ZTYyLTgzMGYtMWVhNzlmYWE4YjA2Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTRmZWFmOGM1MDQ4MjE5ODcyYTM5MzI2YTg5ZjZlYTc4NjkwOTU1N2NlNzFjYTlhYmFkMzZhMTBkZjI2MTJhOTEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.Z3pxuO7rw3xOfQwAIrf5__hbx6hyvMPYxRvseJqk5lA" controls width="100%"></video>
<br><br>

### 4. 관리자_뉴스 등록
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541926810-05b1a860-48fb-4e62-830f-1ea79faa8b06.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjY4MTAtMDViMWE4NjAtNDhmYi00ZTYyLTgzMGYtMWVhNzlmYWE4YjA2Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTRmZWFmOGM1MDQ4MjE5ODcyYTM5MzI2YTg5ZjZlYTc4NjkwOTU1N2NlNzFjYTlhYmFkMzZhMTBkZjI2MTJhOTEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.Z3pxuO7rw3xOfQwAIrf5__hbx6hyvMPYxRvseJqk5lA" controls width="100%"></video>
<br><br>

### 4-1. 관리자_뉴스 페이징
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541926820-69955a7b-655b-4746-9ff0-2aa4e0485f00.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjY4MjAtNjk5NTVhN2ItNjU1Yi00NzQ2LTlmZjAtMmFhNGUwNDg1ZjAwLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWU1MmQ3M2JjODdiNDRhYTJmZWYzOGM0YTY0NjRhNjViZDBiZDgxY2IwODU2ZWQxZWIyYTUyZDU0YWQwYTM1YjgmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.53eGFGZW8ZsCGI6Y3EPMvMrORL6FunFoSHZ30rLFPQc" controls width="100%"></video>
<br><br>

### 5. 관리자_마이페이지
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541926829-8006bc7e-d6e3-43d4-884c-ca06ee840089.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjY4MjktODAwNmJjN2UtZDZlMy00M2Q0LTg4NGMtY2EwNmVlODQwMDg5Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTI4NzVjMDhkNDE1MTI4OGVlOGRmNTczOTcyYmNiYmIzY2NjOTU1Mzg1ZmJhMGZmNTFkMWU1ODk2OWVhOGJkNmEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.c_g4fg5xeKEJ18IXDiAyVxDhhIEWmIvuX61LoCQ-7MA" controls width="100%"></video>
<br><br>

### 6. 비로그인 기능 제한
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541927025-07bddab0-fc04-4e74-bc83-7eb44c1edade.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjcwMjUtMDdiZGRhYjAtZmMwNC00ZTc0LWJjODMtN2ViNDRjMWVkYWRlLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTI5NmY0MTM4ZGUzMWFkYTJiMWZkMjc0ZmUzMTYzMDYwNTc2ZTBhODI5Njg5ZGI1YmZiNDU2NmUxZjBhMDc3YjEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.0vy124R5bkURW6Ysfv67obEW9PQzjbapQud--tbnHbw" controls width="100%"></video>
<br><br>

### 7. 일반_회원가입 및 프로필 변경
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541927039-22ca36e5-0543-4a86-93fe-62d2b983ae3e.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjcwMzktMjJjYTM2ZTUtMDU0My00YTg2LTkzZmUtNjJkMmI5ODNhZTNlLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTQ0ZjU5MTM5YjNlMzM4ODM2MDJjMTY2OTdjM2QyNWJhM2I3MDUwODNhMDM0ZjQ0ZDI2MTZjOWYxMWQyNzY5OTMmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.BgkLEw8vWbA6BoY3BDEYEVU-6nDT1EbwSGOutcmEam4" controls width="100%"></video>
<br><br>

### 8. 일반_맛집 정렬 기능
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541927058-468e1300-ab29-4944-ae25-b8609437ea41.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjcwNTgtNDY4ZTEzMDAtYWIyOS00OTQ0LWFlMjUtYjg2MDk0MzdlYTQxLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWM4ZTJiNTc5ZjJjNWU5YjYwY2JjMjhkNTIzZTg2ZjU5ODBlMDRmM2NkZWM5ZjU4ZDkyYmU3NzUwYmI1ZjQ3MDYmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.MjEJkUcPjOSdeO2DL3xmLXOYdpEPhq5oS1rlRghRyDI" controls width="100%"></video>
<br><br>

### 9. 일반_찜(Bookmark) 기능
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541927188-d00f1e55-7ccf-4fa8-bd61-b834aa9dca18.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjcxODgtZDAwZjFlNTUtN2NjZi00ZmE4LWJkNjEtYjgzNGFhOWRjYTE4Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTBjN2FhNTU5MjRmMWMzYTUwNzhiMDI1OGE5ODEyNDNiZDY0YWMxMWZkZDdiYjU4ZDVmYzFmZWUyYjMyZDBhYjUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.Ab734vbkF8jAP3UfcjZUWKcyelJsiFYAi_PGXtRRMt4" controls width="100%"></video>
<br><br>

### 10. 일반_리뷰 기능
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541927222-436d4490-ea3d-479d-9185-30c0d792aee4.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjcyMjItNDM2ZDQ0OTAtZWEzZC00NzlkLTkxODUtMzBjMGQ3OTJhZWU0Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWFjMWFhNDMxMjE4NzczNDZjYzEwYWI0YmU3ZTgzM2NhOWFmNjFhYTgzMWFlMDljMjQ2YzAxNWM0ODNlOGJjMTkmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.1VOI561ZFbmXhGfdJBZ5KhqmXj59wyuJ8-tIkYmnyb4" controls width="100%"></video>
<br><br>

### 11. 일반_마이 리뷰 관리
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541927352-5b8d4b68-0d7a-4905-9a95-3807d5bc99ac.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjczNTItNWI4ZDRiNjgtMGQ3YS00OTA1LTlhOTUtMzgwN2Q1YmM5OWFjLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTU2NmUzMTFhOTM5YTVlNmMzMGI2MTVhZGEzZTFiZTc3YzE0NDliMzI2MmQ5MWI0NTdkOTA5ZDNjYmEzZGU1MWImWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.CHFE5inBMPVEtqO2qUKkVNfr-QftPCJwDaJ7fUOGeH0" controls width="100%"></video>
<br><br>

### 12. 일반_회원 탈퇴
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541927375-8d3f8173-ece3-47e0-877e-971ff170d8dd.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDUzMjAsIm5iZiI6MTc2OTY0NTAyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MjczNzUtOGQzZjgxNzMtZWNlMy00N2UwLTg3N2UtOTcxZmYxNzBkOGRkLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTI4NDRmNmNiOGViNDdiNGEzODkzMDI5NWQyNjU0MjQxZDJkODllNTQ5ODM4YWRjN2U3YjY5M2NjNTBhMTNmYTgmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.R23PlKQ-FsT-bm12KyxLpG1THy0ci_vCWX_9fVPxNkc" controls width="100%"></video>

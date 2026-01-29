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

## In Action

### 1. 로그인
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933602-d47ed57c-b449-44b6-83f8-9e02de192aa3.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU2NzYsIm5iZiI6MTc2OTY0NTM3NiwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM2MDItZDQ3ZWQ1N2MtYjQ0OS00NGI2LTgzZjgtOWUwMmRlMTkyYWEzLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDkzNlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTg4NjE3ZWIxOTVlNmJjZjZmZDM4NWQ0ZWVjN2IxOTgzNGU0NTVjZjhhZDcwZjVkYTFmYmRhMTkzNzVlMWIwMjEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.ue9cYUTmy5RfpHMvnstB2JBMfqNqhmwBGfxQKZ2SxX0" controls width="100%"></video>
<br><br>

### 2. 관리자_맛집 등록 및 수정
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933705-fc1e760f-07d9-4fb4-a2b2-299f92055984.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU2NzYsIm5iZiI6MTc2OTY0NTM3NiwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM3MDUtZmMxZTc2MGYtMDdkOS00ZmI0LWEyYjItMjk5ZjkyMDU1OTg0Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDkzNlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWFjYzU2MTc5M2ZkYTA3NGJkM2I5MThkMWYwNzY4YmZhNTU0MzQxMmI5ZWFhMWFkMmNmMTMxZjkxYWY4ZjkwYzYmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.d-Ge5DfDqWb9LEureZSzIA3yZ2BPkcIm5PN868I1Pss" controls width="100%"></video>
<br><br>

### 3. 관리자_메뉴 추가 및 삭제
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933724-db5ad847-11ca-431d-92cc-130229f32abf.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU2NzYsIm5iZiI6MTc2OTY0NTM3NiwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM3MjQtZGI1YWQ4NDctMTFjYS00MzFkLTkyY2MtMTMwMjI5ZjMyYWJmLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDkzNlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTI1YzVhNTg1ODY3MWU0MGUyMjViYjUxZTUwYTgxMTMxNmQ4MjkwNjg4OTVmMjU0MjVkZDUwOGU2MWNkYTUxMWMmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.YWqtEqf2ZQnYEBUH-joa1Ak2QKVOq6ZvCLIpxNPuBuA" controls width="100%"></video>
<br><br>

### 4. 관리자_메뉴 수정 및 삭제
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933734-b0be37db-9a47-4ccc-9c25-ec06c83e3742.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU2NzYsIm5iZiI6MTc2OTY0NTM3NiwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM3MzQtYjBiZTM3ZGItOWE0Ny00Y2NjLTljMjUtZWMwNmM4M2UzNzQyLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDkzNlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTM1NDY5NGQ4ODc3NjgxYmVjNDNhYWNhNWU5MWViNjllMzJkMjZjMGY5YTVhNGYxOTcyNjI1ODE3NTFjYWZkOTYmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.9pkt_MlIG1G93qF540tsobz5tW9dZSQP8Fe_OsQDa1I" controls width="100%"></video>
<br><br>

### 5. 관리자_뉴스 등록
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933745-8f4737a1-446a-4f64-af6c-87f65dfc0e1e.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU2NzYsIm5iZiI6MTc2OTY0NTM3NiwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM3NDUtOGY0NzM3YTEtNDQ2YS00ZjY0LWFmNmMtODdmNjVkZmMwZTFlLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDkzNlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTMwNzkzYjhiZmRkMWNjNjg2ZWYyNDU2YTIzYjVjZGIyZTYzNWVjN2JkZWQ5NjU4MDU5ZmYyMzYzMDI2M2FhMTcmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.fYDhYePmF41j30Mv6NtSG_GdSQKUehlFYY2NV4g7tHY" controls width="100%"></video>
<br><br>

### 6. 관리자_뉴스 페이징
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933750-49612d01-7d04-471f-b07a-aebc80e113b5.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU2NzYsIm5iZiI6MTc2OTY0NTM3NiwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM3NTAtNDk2MTJkMDEtN2QwNC00NzFmLWIwN2EtYWViYzgwZTExM2I1Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMDkzNlomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTlmZWZjNDc4YTc4ZjFkMjlhNTU2M2M1Y2JlYTk1NjM2MmNiZDJlZjEzYmE4ZDljYTQ0NGE4Mzc0OWY0MGZkNWUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.rG1Brr0WSyMiBGgUY8kv-4Wza1TA_TEqHEJo6SxlNco" controls width="100%"></video>
<br><br>

### 7. 관리자_마이페이지
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933756-5432add7-4561-4c24-bc25-a09f04011f28.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU5MjAsIm5iZiI6MTc2OTY0NTYyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM3NTYtNTQzMmFkZDctNDU2MS00YzI0LWJjMjUtYTA5ZjA0MDExZjI4Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMTM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWI5OTFlMjAwZmNkZjQ5YmJiZDU2OTlhYzk3YTUwYTliZGVkOWZmYThhOTJkZjk5NGQ0MTM5MTMxNjFhY2Q0MjUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.opkB5ncYF3n3zqSTeJIDNVpxxlttn7STAl8PfEW1wZ0" controls width="100%"></video>
<br><br>

### 8. 비로그인_기능 제한
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933765-f743f949-5940-4d79-a471-085261303c85.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU5MjAsIm5iZiI6MTc2OTY0NTYyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM3NjUtZjc0M2Y5NDktNTk0MC00ZDc5LWE0NzEtMDg1MjYxMzAzYzg1Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMTM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTlmNjg1NmRjODFlZjEwMjk1MWY4NTVjNmYwZjZjY2Y5YTQ0ZjFlY2M4M2M4Njc1MjcwZTk0ZTQ3MzJhMWRjZTMmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.BGKKgWppe2vdyi59n4TeSpACCuKjkjH8VXR0PwLKWgM" controls width="100%"></video>
<br><br>

### 9. 일반_회원가입 및 프로필 변경
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933775-277ce797-4273-4e21-b554-8412cdbd089e.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU5MjAsIm5iZiI6MTc2OTY0NTYyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM3NzUtMjc3Y2U3OTctNDI3My00ZTIxLWI1NTQtODQxMmNkYmQwODllLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMTM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTdmYzAwYzZlMGY0ODIwMjA3NmFjMmExMjZmNzRlMDBkYWVjYTI1ZjVhYWNkZjc1MWFiZjY4NTViMDIzNzhkNjEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.xAHnPFeEUdTXcQ9BwjhJeWcgTIEu4pauIQsDwwj608M" controls width="100%"></video>
<br><br>

### 10. 일반_맛집 정렬 기능
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933783-c2f4ebd2-7422-457e-91cb-2e3d5e233a64.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU5MjAsIm5iZiI6MTc2OTY0NTYyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM3ODMtYzJmNGViZDItNzQyMi00NTdlLTkxY2ItMmUzZDVlMjMzYTY0Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMTM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWZiY2NkM2Y1NmE4M2RjMTI2MWQ3ZTVkYTRiODBkZWVlYTU5YTdlNGE4ODlkNzcwYWIyMjc5OTMzNTcxNmUwYjQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.jdIf0cq60otBtrfpweKzJkxm9Zu87Ypqd3TeaZiF5dU" controls width="100%"></video>
<br><br>

### 11. 일반_찜(Bookmark) 기능
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933795-9b696938-4f8a-414c-88f8-f5198cbb1fb7.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU5MjAsIm5iZiI6MTc2OTY0NTYyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM3OTUtOWI2OTY5MzgtNGY4YS00MTRjLTg4ZjgtZjUxOThjYmIxZmI3Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMTM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWIyNGI3OWMyMTdjN2VkZGYyNGJhOTVhY2UxODFkYjdhZTE2NTk0NWFmMDYxYTM0N2I1NDY2NzM2ZjljZTY5ZWUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.rorqTF5lHCEwDzFOUxlgRlxcK6ZFzZ2fROAZJexCzTc" controls width="100%"></video>
<br><br>

### 12. 일반_리뷰 기능
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933810-43d6576e-60e0-49f9-a39e-676a34d6b2d4.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU5MjAsIm5iZiI6MTc2OTY0NTYyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM4MTAtNDNkNjU3NmUtNjBlMC00OWY5LWEzOWUtNjc2YTM0ZDZiMmQ0Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMTM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTNjNDRmZTY1OTc4N2RkZWMzMTY5Y2E3NDNiZjk1NDFiMjM3Y2MwZDFmZjJkOWIwZTg4NGQ0ZTUxOWY3OWI0ZWQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.EMdn20nSmyq-9wiZ0sBGUUhVotc9UAwAlZG4VS2cZXs" controls width="100%"></video>
<br><br>

### 13. 일반_마이 리뷰 관리
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933815-37ea8359-5129-4d1e-842b-b8a85ce73342.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU5MjAsIm5iZiI6MTc2OTY0NTYyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM4MTUtMzdlYTgzNTktNTEyOS00ZDFlLTg0MmItYjhhODVjZTczMzQyLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMTM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTRhN2QyYTM1ZTVlNGRlZGZmMDlhMjVjYTUxZDc4NmJhYTcxMDJhZWQ1YmRmNWE2MTdiZTUxODg3N2E2M2ExNDEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.hyxuBy-R246DEZHSHAo1UNmZNXVvKSZdvET6Xe5D3Go" controls width="100%"></video>
<br><br>

### 14. 일반_회원 탈퇴
<video src="https://github.com/user-attachments/assets/https://private-user-images.githubusercontent.com/92421686/541933819-196f384c-b423-463b-a31f-195686484f7f.mp4?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Njk2NDU5MjAsIm5iZiI6MTc2OTY0NTYyMCwicGF0aCI6Ii85MjQyMTY4Ni81NDE5MzM4MTktMTk2ZjM4NGMtYjQyMy00NjNiLWEzMWYtMTk1Njg2NDg0ZjdmLm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjAxMjklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwMTI5VDAwMTM0MFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWJjNjI1MTk5MmJlNmVmYTQ3Y2U1NWM5MmM1NWY3NTdmZDA1YjUyM2ZjMGRmMDU5YTIzZTc0MWJkYTFhNjg0NjQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.ugCb2wkpExecHT0ASUP2EsEzrdZzZOZur1Pro4EwVE4" controls width="100%"></video>

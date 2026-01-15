<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String ctxPath = request.getContextPath();
String memberId = (String)session.getAttribute("memberId");
Integer reviewOrder = (Integer)request.getAttribute("reviewOrder");
if(reviewOrder == null) reviewOrder = 1;
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- modal fade: 이 요소가 모달임을 선언하며, fade는 열리고 닫힐 때 부드러운 애니메이션 효과  -->
<!-- id="modernBsModal": 이 모달의 고유 이름입니다. 버튼의 data-bs-target과 연결됩니다. -->
<div class="modal fade" id="modernBsModal" tabindex="-1">
	<!-- modal-dialog-centered: 모달창을 화면 정중앙(세로 기준)에 배치 -->
	<div class="modal-dialog modal-dialog-centered">
		<!-- modal-content: 실제 흰색 배경과 내용이 들어가는 본체 +css추가 -->
		<div class="modal-content">

			<form action="review_save.jsp" method="post" enctype="multipart/form-data">

				<input type="hidden" name="store_idx" id="modalStoreIdx">
				<input type="hidden" name="member_id" value="<%=memberId%>">
				<input type="hidden" name="score" id="score">
				
				<!-- justify-content-center: 제목을 가운데 정렬합니다. -->
				<div class="modal-header">
					<h4 class="modal-title fw-bold">리뷰 작성하기 ✍️</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<!-- px-4는: "이 몸통 박스의 왼쪽과 오른쪽에 넉넉한 **여백(4단계)**을 주어라"라는 뜻입니다.  -->
				<div class="modal-body px-4">

					<!-- 별점 -->
					<!-- text-center / mb-4: 텍스트를 중앙 정렬하고 아래쪽 여백(margin-bottom)을 줍니다. -->
					<div class="text-center mb-4">
						<div class="bs-stars" id="bsStarGroup">
							<span data-v="1">★</span>
							<span data-v="2">★</span>
							<span data-v="3">★</span>
							<span data-v="4">★</span>
							<span data-v="5">★</span>
						</div>
						<!-- text-muted: 글자 색상을 연한 회색으로 만들어 부가적인 설명임을 보여줍니다. -->
						<small id="bsStarText" class="text-muted">
							별을 드래그하여 점수를 매겨주세요
						</small>
					</div>

					<!-- 업로드 -->
					<div class="upload-box text-center mb-2"
						onclick="document.getElementById('reviewImg').click()">
						📷 사진을 클릭해서 선택하세요 (여러번 추가 가능)
						<input type="file" id="reviewImg" hidden multiple accept="image/*">
					</div>

					<!-- 미리보기 -->
					<div id="previewBox" class="d-flex gap-2 flex-wrap mb-3"></div>
					
					<!-- ✅ 이미지 카운트 -->
					<div class="image-count-text text-end mb-3">
    					<span id="imgCount">0</span> / 5 장
					</div>
	
					<!-- 내용 -->
					<textarea name="content"
						class="form-control border-0 bg-light p-3"
						rows="4"
						placeholder="리뷰를 입력해주세요"
						style="border-radius: 15px;"></textarea>
						
					<!-- ✅ 리뷰 순번 배지 -->
					<div class="review-order-wrapper text-center mb-3">
    					<span class="review-order-badge">
        					😊 이 매장의 <span id="reviewOrder"><%= request.getAttribute("reviewOrder") %></span>번째 리뷰입니다
    					</span>
					</div>

				</div>

				<div class="modal-footer px-4">
					<button type="submit" class="btn btn-submit w-100">
						리뷰 등록하기
					</button>
				</div>

			</form>

		</div>
	</div>
</div>

<script src="<%=ctxPath%>/test.js" defer></script>
<link rel="stylesheet" href="<%=ctxPath%>/test.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

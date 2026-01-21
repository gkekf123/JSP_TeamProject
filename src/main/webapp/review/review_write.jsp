<%@page import="com.team.project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String ctxPath = request.getContextPath();
%>

<script>
    const ctxPath = "<%= ctxPath %>";
</script>

<link rel="stylesheet" href="<%= ctxPath %>/review/review_write.css">
<script src="<%= ctxPath %>/review/review_write.js" defer></script>

<div class="modal fade" id="reviewModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <form action="review_save.jsp" method="post" enctype="multipart/form-data">

                <input type="hidden" name="store_idx" id="storeIdx">
                <input type="hidden" name="review_rating" id="reviewRating">

                <!-- 모달 헤더 -->
                <div class="review-modal-header">
                    <h2 class="review-modal-title">리뷰 작성하기</h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <!-- 모달 본문 -->
                <div class="review-modal-body">

                    <!-- 별점 -->
                    <div class="review-stars">
                        <div class="star-group" id="starGroup">
                            <span data-star-rating="1">★</span>
                            <span data-star-rating="2">★</span>
                            <span data-star-rating="3">★</span>
                            <span data-star-rating="4">★</span>
                            <span data-star-rating="5">★</span>
                        </div>
                        
                        <small id="starText" class="star-text">
                            별을 드래그하여 점수를 매겨주세요
                        </small>
                    </div>

                    <!-- 이미지 업로드 -->
                    <div class="review-upload">
						<input type="file" id="reviewImg1" name="review_img1" hidden accept="image/*">
    					<input type="file" id="reviewImg2" name="review_img2" hidden accept="image/*">
    					<input type="file" id="reviewImg3" name="review_img3" hidden accept="image/*">
    					<input type="file" id="reviewImg4" name="review_img4" hidden accept="image/*">
    					<input type="file" id="reviewImg5" name="review_img5" hidden accept="image/*">
    
    					<input type="file" id="reviewImgMultiple" hidden multiple accept="image/*" 
    					onchange="checkFiles(this)">
                        <!-- 미리보기  -->
                        <div id="reviewImgPreview" class="review-img-preview"></div>
                        <!-- 선택된 이미지 수  -->
                        <div class="image-count-wrapper">
                            <span id="imgCount">0</span> / 5 장
                        </div>
                        
                            <button type="button" class="upload-box" onclick="addPhoto()">
        📷 사진을 클릭해서 선택하세요
    </button>
                    </div>

                    <!-- 리뷰 내용-->
                    <div class="review-content-wrapper">
                        <textarea name="review_content" class="review-content" rows="6" placeholder="리뷰를 입력해주세요"></textarea>
                    </div>

                    <!-- 리뷰 순서 -->
                    <div class="review-order-wrapper">
                        <span class="review-order-text">
                            😊 이 매장의 <span id="reviewOrder"><%=request.getAttribute("reviewOrder")%></span>번째 리뷰입니다
                        </span>
                    </div>
                </div>

                <!-- 모달 푸터 -->
                <div class="review-modal-footer">
                    <button type="submit" class="btn btn-submit w-100">리뷰 등록하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

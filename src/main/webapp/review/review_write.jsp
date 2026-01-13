<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="<%= ctxPath %>/review/review_write.css">
<script src="<%= ctxPath %>/review/review_write.js" defer></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<div class="modal fade" id="modernBsModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
        
            <div class="modal-header justify-content-center">
                <h4 class="modal-title fw-bold">리뷰 작성하기✍️</h4>
            </div>
            
            <div class="modal-body px-4">
                <div class="text-center mb-4">
                    <div class="bs-stars" id="bsStarGroup">
                        <span data-v="1">★</span>
                        <span data-v="2">★</span>
                        <span data-v="3">★</span>
                        <span data-v="4">★</span>
                        <span data-v="5">★</span>
                    </div>
                    <small class="text-muted" id="bsStarHint">별을 드래그하여 점수를 매겨주세요</small>
                </div>
                
                <div class="upload-box text-center mb-3" onclick="document.getElementById('bsFile').click()">
                    <span class="text-muted">📷 사진을 여기에 드래그하거나 클릭하세요</span>
                    <input type="file" id="bsFile" hidden multiple>
                </div>
                
                <textarea class="form-control border-0 bg-light p-3" rows="4" placeholder="작성하신 리뷰는 다른 구매자들에게 큰 도움이 됩니다." style="border-radius: 15px;"></textarea>
            </div>
            
            <div class="modal-footer px-4">
                <button type="button" class="btn btn-submit w-100 shadow-sm">리뷰 등록하기</button>
            </div>
            
        </div>
    </div>
</div>
</body>
</html>
package com.team.project.dto;

import java.sql.Timestamp;

public class ReviewDTO {
	private long reviewIdx;
	private long storeIdx;
	private String memberId;
	private String memberName;
	private String memberImg;
	private int reviewRating;
	private String reviewContent;
	private String reviewImg1;
	private String reviewImg2;
	private String reviewImg3;
	private String reviewImg4;
	private String reviewImg5;
	private Timestamp reviewCreatedAt;
	private Timestamp reviewUpdatedAt;
	public long getReviewIdx() {
		return reviewIdx;
	}
	public void setReviewIdx(long reviewIdx) {
		this.reviewIdx = reviewIdx;
	}
	public long getStoreIdx() {
		return storeIdx;
	}
	public void setStoreIdx(long storeIdx) {
		this.storeIdx = storeIdx;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberImg() {
		return memberImg;
	}
	public void setMemberImg(String memberImg) {
		this.memberImg = memberImg;
	}
	public int getReviewRating() {
		return reviewRating;
	}
	public void setReviewRating(int reviewRating) {
		this.reviewRating = reviewRating;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getReviewImg1() {
		return reviewImg1;
	}
	public void setReviewImg1(String reviewImg1) {
		this.reviewImg1 = reviewImg1;
	}
	public String getReviewImg2() {
		return reviewImg2;
	}
	public void setReviewImg2(String reviewImg2) {
		this.reviewImg2 = reviewImg2;
	}
	public String getReviewImg3() {
		return reviewImg3;
	}
	public void setReviewImg3(String reviewImg3) {
		this.reviewImg3 = reviewImg3;
	}
	public String getReviewImg4() {
		return reviewImg4;
	}
	public void setReviewImg4(String reviewImg4) {
		this.reviewImg4 = reviewImg4;
	}
	public String getReviewImg5() {
		return reviewImg5;
	}
	public void setReviewImg5(String reviewImg5) {
		this.reviewImg5 = reviewImg5;
	}
	public Timestamp getReviewCreatedAt() {
		return reviewCreatedAt;
	}
	public void setReviewCreatedAt(Timestamp reviewCreatedAt) {
		this.reviewCreatedAt = reviewCreatedAt;
	}
	public Timestamp getReviewUpdatedAt() {
		return reviewUpdatedAt;
	}
	public void setReviewUpdatedAt(Timestamp reviewUpdatedAt) {
		this.reviewUpdatedAt = reviewUpdatedAt;
	}
}
package com.team.project.dto;

import java.sql.Timestamp;

public class ReviewDTO {
	private long reviewIdx;
	private int storeIdx;
	private int memberId;
	private String memberName;
	private String memberImg;
	private int reviewRating;
	private String reviewContent;
	private String reviewimg;
	private Timestamp reviewCreateAt;
	private Timestamp reviewUpdateAt;
	public long getReviewIdx() {
		return reviewIdx;
	}
	public void setReviewIdx(long reviewIdx) {
		this.reviewIdx = reviewIdx;
	}
	public int getStoreIdx() {
		return storeIdx;
	}
	public void setStoreIdx(int storeIdx) {
		this.storeIdx = storeIdx;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
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
	public String getReviewimg() {
		return reviewimg;
	}
	public void setReviewimg(String reviewimg) {
		this.reviewimg = reviewimg;
	}
	public Timestamp getReviewCreateAt() {
		return reviewCreateAt;
	}
	public void setReviewCreateAt(Timestamp reviewCreateAt) {
		this.reviewCreateAt = reviewCreateAt;
	}
	public Timestamp getReviewUpdateAt() {
		return reviewUpdateAt;
	}
	public void setReviewUpdateAt(Timestamp reviewUpdateAt) {
		this.reviewUpdateAt = reviewUpdateAt;
	}
	
}

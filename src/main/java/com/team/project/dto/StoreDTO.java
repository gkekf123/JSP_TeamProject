package com.team.project.dto;

import java.sql.Timestamp;

public class StoreDTO {
    private long storeIdx;          // store_idx
    private String storeName;       // store_name
    private String storeCategory;   // store_category
    private String storeAddr;       // store_addr
    private String storeImg;        // store_img
    private int storeRatingCount;   // store_rating_count
    private double storeRatingAvg;  // store_rating_avg (DECIMAL -> double)
    private int storeViewCount;     // store_view_count
    
    private String storeIntro;           // 가게 한줄 소개
    private String storeTel;             // 전화번호
    private double latitude;             // 위도
    private double longitude;            // 경도
    private Timestamp storeCreatedAt;    // 등록일
    private Timestamp storeUpdateAt;     // 수정일
    
	public long getStoreIdx() {
		return storeIdx;
	}
	public void setStoreIdx(long storeIdx) {
		this.storeIdx = storeIdx;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getStoreCategory() {
		return storeCategory;
	}
	public void setStoreCategory(String storeCategory) {
		this.storeCategory = storeCategory;
	}
	public String getStoreAddr() {
		return storeAddr;
	}
	public void setStoreAddr(String storeAddr) {
		this.storeAddr = storeAddr;
	}
	public String getStoreImg() {
		return storeImg;
	}
	public void setStoreImg(String storeImg) {
		this.storeImg = storeImg;
	}
	public int getStoreRatingCount() {
		return storeRatingCount;
	}
	public void setStoreRatingCount(int storeRatingCount) {
		this.storeRatingCount = storeRatingCount;
	}
	public double getStoreRatingAvg() {
		return storeRatingAvg;
	}
	public void setStoreRatingAvg(double storeRatingAvg) {
		this.storeRatingAvg = storeRatingAvg;
	}
	public int getStoreViewCount() {
		return storeViewCount;
	}
	public void setStoreViewCount(int storeViewCount) {
		this.storeViewCount = storeViewCount;
	}
	
	
	public String getStoreIntro() {
		return storeIntro;
	}
	public void setStoreIntro(String storeIntro) {
		this.storeIntro = storeIntro;
	}
	public String getStoreTel() {
		return storeTel;
	}
	public void setStoreTel(String storeTel) {
		this.storeTel = storeTel;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public Timestamp getStoreCreatedAt() {
		return storeCreatedAt;
	}
	public void setStoreCreatedAt(Timestamp storeCreatedAt) {
		this.storeCreatedAt = storeCreatedAt;
	}
	public Timestamp getStoreUpdateAt() {
		return storeUpdateAt;
	}
	public void setStoreUpdateAt(Timestamp storeUpdateAt) {
		this.storeUpdateAt = storeUpdateAt;
	}
	
	
}
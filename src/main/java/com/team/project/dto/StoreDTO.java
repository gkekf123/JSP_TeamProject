package com.team.project.dto;

public class StoreDTO {
    private long storeIdx;          // store_idx
    private String storeName;       // store_name
    private String storeCategory;   // store_category
    private String storeAddr;       // store_addr
    private String storeImg;        // store_img
    private int storeRatingCount;   // store_rating_count
    private double storeRatingAvg;  // store_rating_avg (DECIMAL -> double)
    private int storeViewCount;     // store_view_count
    
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
}
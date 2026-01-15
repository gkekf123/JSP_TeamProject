package com.team.project.dto;

public class MenuDTO {
	private int menuIdx;
    private long storeIdx;
    private String menuName;
    private int menuPrice;
    private String menuImg;
    
    
	public int getMenuIdx() {
		return menuIdx;
	}
	public void setMenuIdx(int menuIdx) {
		this.menuIdx = menuIdx;
	}
	public long getStoreIdx() {
		return storeIdx;
	}
	public void setStoreIdx(long storeIdx) {
		this.storeIdx = storeIdx;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public int getMenuPrice() {
		return menuPrice;
	}
	public void setMenuPrice(int menuPrice) {
		this.menuPrice = menuPrice;
	}
	public String getMenuImg() {
		return menuImg;
	}
	public void setMenuImg(String menuImg) {
		this.menuImg = menuImg;
	}
    
    
}

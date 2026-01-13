package com.team.project.dto;

import java.sql.Timestamp;

public class NewsDTO {
	private long newsIdx;
	private String newsTitle;
	private String newsUrl;
	private String newsImg;
	private String newsSource;
	private Timestamp newsRegdate;
	
	
	public long getNewsIdx() {
		return newsIdx;
	}
	public void setNewsIdx(long newsIdx) {
		this.newsIdx = newsIdx;
	}
	public String getNewsTitle() {
		return newsTitle;
	}
	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}
	public String getNewsUrl() {
		return newsUrl;
	}
	public void setNewsUrl(String newsUrl) {
		this.newsUrl = newsUrl;
	}
	public String getNewsImg() {
		return newsImg;
	}
	public void setNewsImg(String newsImg) {
		this.newsImg = newsImg;
	}
	public String getNewsSource() {
		return newsSource;
	}
	public void setNewsSource(String newsSource) {
		this.newsSource = newsSource;
	}
	public Timestamp getNewsRegdate() {
		return newsRegdate;
	}
	public void setNewsRegdate(Timestamp newsRegdate) {
		this.newsRegdate = newsRegdate;
	}
	
	

}

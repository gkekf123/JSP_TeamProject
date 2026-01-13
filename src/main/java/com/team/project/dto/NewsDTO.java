package com.team.project.dto;

import java.sql.Timestamp;

public class NewsDTO {
	private long news_idx;
	private String news_title;
	private String news_url;
	private String news_img;
	private String news_source;
	private Timestamp news_regdate;
	
	
	public long getNews_idx() {
		return news_idx;
	}
	public void setNews_idx(long news_idx) {
		this.news_idx = news_idx;
	}
	public String getNews_title() {
		return news_title;
	}
	public void setNews_title(String news_title) {
		this.news_title = news_title;
	}
	public String getNews_url() {
		return news_url;
	}
	public void setNews_url(String news_url) {
		this.news_url = news_url;
	}
	public String getNews_img() {
		return news_img;
	}
	public void setNews_img(String news_img) {
		this.news_img = news_img;
	}
	public String getNews_source() {
		return news_source;
	}
	public void setNews_source(String news_source) {
		this.news_source = news_source;
	}
	public Timestamp getNews_regdate() {
		return news_regdate;
	}
	public void setNews_regdate(Timestamp news_regdate) {
		this.news_regdate = news_regdate;
	}
	
	

}

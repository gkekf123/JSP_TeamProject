package com.team.project.dto;

import java.security.Timestamp;

public class SearchLogDTO {

	private Long logIdx;
	private String searchQuery;
	private String aiResponse;
	private Timestamp searchDate;
	
	public Long getLogIdx() {
		return logIdx;
	}
	public void setLogIdx(Long logIdx) {
		this.logIdx = logIdx;
	}
	public String getSearchQuery() {
		return searchQuery;
	}
	public void setSearchQuery(String searchQuery) {
		this.searchQuery = searchQuery;
	}
	public String getAiResponse() {
		return aiResponse;
	}
	public void setAiResponse(String aiResponse) {
		this.aiResponse = aiResponse;
	}
	public Timestamp getSearchDate() {
		return searchDate;
	}
	public void setSearchDate(Timestamp searchDate) {
		this.searchDate = searchDate;
	}
}

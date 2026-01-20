package com.team.project.dto;

import java.sql.Timestamp;

public class BookmarkDTO {
    private long likeIdx;       // like_idx
    private String memberId;    // member_id
    private int storeIdx;       // store_idx
    private String placeName;   // place_name
    private String placeAddr;   // place_addr
    private String placeUrl;    // place_url
    private String placePhone;  // place_phone
    private Timestamp likeDate; // like_date
    private String kakaoId;     // kakao_id

    public BookmarkDTO() {}

    public long getLikeIdx() {
        return likeIdx;
    }
    public void setLikeIdx(long likeIdx) {
        this.likeIdx = likeIdx;
    }
    public String getMemberId() {
        return memberId;
    }
    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }
    public int getStoreIdx() {
        return storeIdx;
    }
    public void setStoreIdx(int storeIdx) {
        this.storeIdx = storeIdx;
    }
    public String getPlaceName() {
        return placeName;
    }
    public void setPlaceName(String placeName) {
        this.placeName = placeName;
    }
    public String getPlaceAddr() {
        return placeAddr;
    }
    public void setPlaceAddr(String placeAddr) {
        this.placeAddr = placeAddr;
    }
    public String getPlaceUrl() {
        return placeUrl;
    }
    public void setPlaceUrl(String placeUrl) {
        this.placeUrl = placeUrl;
    }
    public String getPlacePhone() {
        return placePhone;
    }
    public void setPlacePhone(String placePhone) {
        this.placePhone = placePhone;
    }
    public Timestamp getLikeDate() {
        return likeDate;
    }
    public void setLikeDate(Timestamp likeDate) {
        this.likeDate = likeDate;
    }
    public String getKakaoId() {
        return kakaoId;
    }
    public void setKakaoId(String kakaoId) {
        this.kakaoId = kakaoId;
    }
    @Override
    public String toString() {
        return "BookmarkDTO [likeIdx=" + likeIdx + ", placeName=" + placeName + ", kakaoId=" + kakaoId + "]";
    }
}
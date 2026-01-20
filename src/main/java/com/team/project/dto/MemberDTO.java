package com.team.project.dto;

import java.sql.Timestamp;

public class MemberDTO {

	private int member_idx;
    private String memberId;
    private String memberPw;
    private String memberName;
    private String memberRole;   
    private String memberEmail;
    private String memberHp;
    private String memberAddr;
    private String memberImg;
    private Timestamp memberJoinday;
	public int getMember_idx() {
		return member_idx;
	}
	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberRole() {
		return memberRole;
	}
	public void setMemberRole(String memberRole) {
		this.memberRole = memberRole;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getMemberHp() {
		return memberHp;
	}
	public void setMemberHp(String memberHp) {
		this.memberHp = memberHp;
	}
	public String getMemberAddr() {
		return memberAddr;
	}
	public void setMemberAddr(String memberAddr) {
		this.memberAddr = memberAddr;
	}
	public String getMemberImg() {
		return memberImg;
	}
	public void setMemberImg(String memberImg) {
		this.memberImg = memberImg;
	}
	public Timestamp getMemberJoinday() {
		return memberJoinday;
	}
	public void setMemberJoinday(Timestamp memberJoinday) {
		this.memberJoinday = memberJoinday;
	}
}

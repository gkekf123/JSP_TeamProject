package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.team.project.dto.MemberDTO;
import com.team.project.util.DBConn;

public class MemberDAO {

    DBConn db = new DBConn();
    
    //아이디 체크
  	public int getIdCheck(String member_id)
  	{
  		int isid=0;
  		
  		Connection conn = db.getConnection();
  		PreparedStatement pstmt=null;
  		ResultSet rs=null;
  		
  		String sql="select count(*) from member where member_id=?";
  		
  		try {
  			pstmt=conn.prepareStatement(sql);
  			pstmt.setString(1, member_id);
  			rs=pstmt.executeQuery();
  			
  			if(rs.next())
  			   isid=rs.getInt(1);
  				
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}finally {
  			db.close(rs, pstmt, conn);
  		}

  		return isid;
  	}
    
    
    /* ==============================
       로그인 체크
    ============================== */
  	public MemberDTO loginCheck(String member_id, String member_pw) {

  	    MemberDTO dto = null;

  	    Connection conn = db.getConnection();
  	    PreparedStatement pstmt = null;
  	    ResultSet rs = null;

  	    String sql = "select * from member where member_id=? and member_pw=?";

  	    try {
  	        pstmt = conn.prepareStatement(sql);
  	        pstmt.setString(1, member_id);
  	        pstmt.setString(2, member_pw);

  	        rs = pstmt.executeQuery();

  	        if (rs.next()) {
  	            dto = new MemberDTO();
  	            dto.setMemberId(rs.getString("member_id"));
  	            dto.setMemberPw(rs.getString("member_pw"));
  	            dto.setMemberRole(rs.getString("member_role"));
  	            dto.setMemberName(rs.getString("member_name"));
  	        }

  	    } catch (SQLException e) {
  	        e.printStackTrace();
  	    } finally {
  	        db.close(rs, pstmt, conn);
  	    }

  	    return dto;
  	}


    //insert
  	public void insertMember(MemberDTO dto) {
  	    Connection conn = db.getConnection();
  	    PreparedStatement pstmt = null;

  	    String sql = "insert into member "
  	               + "(member_id, member_pw, member_name, member_role, "
  	               + " member_email, member_hp, member_addr, member_img, member_joinday) "
  	               + "values (?,?,?,?,?,?,?,?,now())";

  	    try {
  	        pstmt = conn.prepareStatement(sql);

  	        pstmt.setString(1, dto.getMemberId());
  	        pstmt.setString(2, dto.getMemberPw());
  	        pstmt.setString(3, dto.getMemberName());

  	        // role이 없으면 USER로 강제
  	        String role = dto.getMemberRole();
  	        if (role == null || role.trim().isEmpty()) {
  	            role = "USER";
  	        }
  	        pstmt.setString(4, role);

  	        pstmt.setString(5, dto.getMemberEmail());
  	        pstmt.setString(6, dto.getMemberHp());
  	        pstmt.setString(7, dto.getMemberAddr());
  	        pstmt.setString(8, dto.getMemberImg());

  	        pstmt.executeUpdate();

  	    } catch (SQLException e) {
  	        e.printStackTrace();
  	    } finally {
  	        DBConn.close(pstmt, conn);
  	    }
  	}

    /* ==============================
       1. 마이페이지 - 내 정보 조회
    ============================== */
    public MemberDTO getMyInfo(String member_id) {

        MemberDTO dto = null;

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select * from member where member_id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new MemberDTO();
            	dto = new MemberDTO();
                dto.setMemberId(rs.getString("member_id"));
                dto.setMemberPw(rs.getString("member_pw"));
                dto.setMemberName(rs.getString("member_name"));
                dto.setMemberEmail(rs.getString("member_email"));
                dto.setMemberHp(rs.getString("member_hp"));
                dto.setMemberAddr(rs.getString("member_addr"));
                dto.setMemberImg(rs.getString("member_img"));
                dto.setMemberJoinday(rs.getTimestamp("member_joinday"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(rs, pstmt, conn);
        }

        return dto;
    }

    /* ==============================
       2. 회원 정보 수정
    ============================== */
    public void updateMyInfo(MemberDTO dto) {

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;

        String sql =
            "update member set " +
            "member_pw = ?, " +
            "member_name = ?, " +
            "member_email = ?, " +
            "member_hp = ?, " +
            "member_addr = ? " +   // ⭐ 공백 중요
            "where member_id = ?";

        try {
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, dto.getMemberPw());
            pstmt.setString(2, dto.getMemberName());
            pstmt.setString(3, dto.getMemberEmail());
            pstmt.setString(4, dto.getMemberHp());
            pstmt.setString(5, dto.getMemberAddr());
            pstmt.setString(6, dto.getMemberId());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(pstmt, conn);
        }
    }

    /* ==============================
       3. 회원 탈퇴
    ============================== */
    public void deleteMember(String member_id) {

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;

        String sql = "delete from member where member_id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, member_id);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(pstmt, conn);
        }
    }

    /* ==============================
       4. 비밀번호 확인
    ============================== */
    public boolean checkPassword(String member_id, String member_pw) {

        boolean result = false;

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select * from member where member_id = ? and member_pw = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, member_id);
            pstmt.setString(2, member_pw);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                result = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close(rs, pstmt, conn);
        }

        return result;
    }

	
}


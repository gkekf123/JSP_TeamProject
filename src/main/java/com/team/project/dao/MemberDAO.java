package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.team.project.dto.MemberDTO;
import com.team.project.util.DBConn;

public class MemberDAO {

	DBConn db = new DBConn();
	
	public void insertMember(MemberDTO dto) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into member(member_id, member_pw, member_name, member_role,member_email, member_hp, member_addr, member_img, member_joinday)VALUES (?,?,?,?,?,?,?,?,NOW())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getMemberId());
            pstmt.setString(2, dto.getMemberPw());
            pstmt.setString(3, dto.getMemberName());
            
         //: 체크 안 하면 null
            if(dto.getMemberRole() == null || dto.getMemberRole().isEmpty()) {
                pstmt.setNull(4, java.sql.Types.VARCHAR);
            } else {
                pstmt.setString(4, dto.getMemberRole()); // admin
            }
            
            pstmt.setString(5, dto.getMemberEmail());
            pstmt.setString(6, dto.getMemberHp());
            pstmt.setString(7, dto.getMemberAddr());
            pstmt.setString(8, dto.getMemberImg());
            
            pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBConn.close(pstmt, conn);
		}
	}
	
	public MemberDTO selectMember(String member_id, String member_pw) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberDTO dto=new MemberDTO();
		
		String sql="select * from member where member_id=? and member_pw=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setString(2, member_pw);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setMemberId(rs.getString("member_id"));
				dto.setMemberName(rs.getString("member_name"));
				dto.setMemberRole(rs.getString("member_role"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBConn.close(rs, pstmt, conn);
		}
		
		return dto;
	}
	
}

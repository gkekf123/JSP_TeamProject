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
			
			pstmt.setString(1, dto.getMember_id());
            pstmt.setString(2, dto.getMember_pw());
            pstmt.setString(3, dto.getMember_name());
            
         //: 체크 안 하면 null
            if(dto.getMember_role() == null || dto.getMember_role().isEmpty()) {
                pstmt.setNull(4, java.sql.Types.VARCHAR);
            } else {
                pstmt.setString(4, dto.getMember_role()); // admin
            }
            
            pstmt.setString(5, dto.getMember_email());
            pstmt.setString(6, dto.getMember_hp());
            pstmt.setString(7, dto.getMember_addr());
            pstmt.setString(8, dto.getMember_img());
            
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
				dto.setMember_id(rs.getString("member_id"));
				dto.setMember_name(rs.getString("member_name"));
				dto.setMember_role(rs.getString("member_role"));
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

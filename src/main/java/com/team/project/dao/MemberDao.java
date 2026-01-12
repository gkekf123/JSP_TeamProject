package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.team.project.dto.MemberDto;
import com.team.project.util.DBConn;

public class MemberDao {

	DBConn db = new DBConn();
	
	public void insertMember(MemberDto dto) {
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
		}
	}
	
}

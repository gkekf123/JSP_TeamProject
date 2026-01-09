package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.team.project.dto.StoreDTO;
import com.team.project.util.DBConn;

public class Store_DetailDao {

	DBConn db=new DBConn();
	
	//가게 정보 출력
	public StoreDTO selectDetailIntro(long storeIdx) {
		StoreDTO dto=new StoreDTO();
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from store where store_idx=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, storeIdx);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {;
				dto.setStoreIdx(rs.getLong("store_idx"));
				dto.setStoreImg(rs.getString("store_img"));
				dto.setStoreName(rs.getString("store_name"));
				dto.setStoreCategory(rs.getString("store_category"));
				dto.setStoreAddr(rs.getString("store_addr"));
				dto.setStoreIntro(rs.getString("store_intro"));
                dto.setStoreTel(rs.getString("store_tel"));
                dto.setStoreRatingAvg(rs.getDouble("store_rating_avg"));
                dto.setStoreRatingCount(rs.getInt("store_rating_count"));
                dto.setStoreViewCount(rs.getInt("store_view_count"));
                dto.setStoreCreatedAt(rs.getTimestamp("store_created_at"));
                dto.setStoreUpdateAt(rs.getTimestamp("store_update_at"));
                
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.close(rs, pstmt, conn);
		}return dto;
	}
	
}

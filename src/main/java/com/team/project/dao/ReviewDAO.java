package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.team.project.dto.ReviewDTO;
import com.team.project.util.DBConn;

public class ReviewDAO {
	DBConn db=new DBConn();
	
	public void insertReview(ReviewDTO dto) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into review (store_idx, member_id, member_name, member_img, review_content, review_rating, review_create_at) VALUES (?, ?, ?, ?, ?, ?, NOW())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getStoreIdx());
			pstmt.setInt(2, dto.getMemberId());
			pstmt.setString(3, dto.getMemberName());
			pstmt.setString(4, dto.getMemberImg());
			pstmt.setString(5, dto.getReviewContent());
			pstmt.setString(6, dto.getReviewRating());
			pstmt.setTimestamp(7, dto.getReviewCreateAt());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.close(pstmt, conn);
		}
	}
	
	public List<ReviewDTO> selectReview(int storeIdx){
		List<ReviewDTO> list=new ArrayList<ReviewDTO>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from review where store_idx=? order by review_idx desc";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, storeIdx);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO dto=new ReviewDTO();
				
				dto.setReviewIdx(rs.getLong("review_idx"));
				dto.setStoreIdx(rs.getInt("store_idx"));
				dto.setMemberId(rs.getInt("member_id"));
				dto.setMemberName(rs.getString("member_name"));
				dto.setMemberImg(rs.getString("member_img"));
				dto.setReviewContent(rs.getString("review_content"));
				dto.setReviewRating(rs.getString("review_rating"));
				dto.setReviewCreateAt(rs.getTimestamp("review_create_at"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.close(rs, pstmt, conn);
		}
		
		return list;
	}
	
	public void deleteReview(long reviewIdx, int memberId) {
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="delete from review where review_idx=? and member_id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, reviewIdx);
			pstmt.setInt(2, memberId);
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.close(pstmt, conn);
		}
	}
	
	public ReviewDTO oneSelectReview(long reviewIdx) {
		ReviewDTO dto=new ReviewDTO();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from review where review_idx=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, reviewIdx);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setReviewIdx(reviewIdx);
				dto.setStoreIdx(rs.getInt("store_idx"));
				dto.setMemberId(rs.getInt("member_id"));
				dto.setMemberName(rs.getString("member_name"));
				dto.setMemberImg(rs.getString("member_img"));
				dto.setReviewContent(rs.getString("review_content"));
				dto.setReviewRating(rs.getString("review_rating"));
				dto.setReviewUpdateAt(rs.getTimestamp("review_update_at"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.close(rs, pstmt, conn);
		}
		
		return dto;
	}
	
	public Double avgReview(int storeIdx) {
		Double avgRating=null;
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select avg(review_rating) as avg from review where store_idx=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, storeIdx);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				avgRating=rs.getDouble("avg");
				if(rs.wasNull()) {
					avgRating=0.0;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.close(rs, pstmt, conn);
		}
		return avgRating;
	}
}

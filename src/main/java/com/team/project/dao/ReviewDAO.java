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
	
	public int insertReview(ReviewDTO dto) {
		int reviewResult=0;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into review (store_idx, member_id, member_name, member_img, review_rating, review_content, "
				+ "review_img1, review_img2, review_img3, review_img4, review_img5, review_created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getStoreIdx());
			pstmt.setString(2, dto.getMemberId());
			pstmt.setString(3, dto.getMemberName());
			pstmt.setString(4, dto.getMemberImg());
			pstmt.setInt(5, dto.getReviewRating());
			pstmt.setString(6, dto.getReviewContent());			
			pstmt.setString(7, dto.getReviewImg1());
			pstmt.setString(8, dto.getReviewImg2());
			pstmt.setString(9, dto.getReviewImg3());
			pstmt.setString(10, dto.getReviewImg4());
			pstmt.setString(11, dto.getReviewImg5());
			
			reviewResult = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.close(pstmt, conn);
		} 
		return reviewResult;
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
				dto.setMemberId(rs.getString("member_id"));
				dto.setMemberName(rs.getString("member_name"));
				dto.setMemberImg(rs.getString("member_img"));
				dto.setReviewRating(rs.getInt("review_rating"));
				dto.setReviewContent(rs.getString("review_content"));
				dto.setReviewImg1(rs.getString("review_img1"));
				dto.setReviewImg2(rs.getString("review_img2"));
				dto.setReviewImg3(rs.getString("review_img3"));
				dto.setReviewImg4(rs.getString("review_img4"));
				dto.setReviewImg5(rs.getString("review_img5"));
				dto.setReviewCreatedAt(rs.getTimestamp("review_created_at"));
				
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
				dto.setReviewIdx(rs.getLong("review_idx"));
				dto.setStoreIdx(rs.getInt("store_idx"));
				dto.setMemberId(rs.getString("member_id"));
				dto.setMemberName(rs.getString("member_name"));
				dto.setMemberImg(rs.getString("member_img"));
				dto.setReviewRating(rs.getInt("review_rating"));
				dto.setReviewContent(rs.getString("review_content"));
				dto.setReviewImg1(rs.getString("review_img1"));
				dto.setReviewImg2(rs.getString("review_img2"));
				dto.setReviewImg3(rs.getString("review_img3"));
				dto.setReviewImg4(rs.getString("review_img4"));
				dto.setReviewImg5(rs.getString("review_img5"));
				dto.setReviewCreatedAt(rs.getTimestamp("review_created_at"));
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
	
	public int countReview(int storeIdx) {
		
		int reviewCount=0;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select count(*) as review_count from review where store_idx=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, storeIdx);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				reviewCount=rs.getInt("review_count");

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.close(rs, pstmt, conn);
		}
		
		return reviewCount;
		
	}
}
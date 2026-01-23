package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.team.project.dto.ReviewDTO;
import com.team.project.util.DBConn;

public class ReviewDAO {
	DBConn db=new DBConn();
	
	//전체조회
	public List<ReviewDTO> selectReview(long storeIdx){
		List<ReviewDTO> list=new ArrayList<ReviewDTO>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from review where store_idx=? order by review_idx desc";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, storeIdx);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO dto=new ReviewDTO();
				
				dto.setReviewIdx(rs.getLong("review_idx"));
				dto.setStoreIdx(rs.getLong("store_idx"));
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
				dto.setReviewUpdatedAt(rs.getTimestamp("review_updated_at"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.close(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//한개조회
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
				dto.setStoreIdx(rs.getLong("store_idx"));
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
				dto.setReviewUpdatedAt(rs.getTimestamp("review_updated_at"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close(rs, pstmt, conn);
		}
		
		return dto;
	}
	
	//입력
	public int insertReview(ReviewDTO dto) {
		int reviewResult=0;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="insert into review (store_idx, member_id, member_name, member_img, review_rating, review_content, "
				+ "review_img1, review_img2, review_img3, review_img4, review_img5, review_created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
		
		try {
			pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setLong(1, dto.getStoreIdx());
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
			
	        // 생성된 reviewIdx 가져오기
	        rs = pstmt.getGeneratedKeys();
	        if(rs.next()) {
	            dto.setReviewIdx(rs.getLong(1));
	        }
	        
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close(rs, pstmt, conn);
		} 
		return reviewResult;
	}
	
	//수정
	public int updateReview(ReviewDTO dto) {
		
	    Connection conn = db.getConnection();
	    PreparedStatement pstmt = null;
	    
	    int updateResult = 0;
	    
	    try {
	        
	        String sql = "UPDATE review SET "
	                   + "review_rating = ?, "
	                   + "review_content = ?, "
	                   + "review_img1 = ?, "
	                   + "review_img2 = ?, "
	                   + "review_img3 = ?, "
	                   + "review_img4 = ?, "
	                   + "review_img5 = ?, "
	                   + "review_updated_at = CURRENT_TIMESTAMP "
	                   + "WHERE review_idx = ? AND member_id = ?";
	        
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, dto.getReviewRating());
	        pstmt.setString(2, dto.getReviewContent());
	        pstmt.setString(3, dto.getReviewImg1());
	        pstmt.setString(4, dto.getReviewImg2());
	        pstmt.setString(5, dto.getReviewImg3());
	        pstmt.setString(6, dto.getReviewImg4());
	        pstmt.setString(7, dto.getReviewImg5());
	        pstmt.setLong(8, dto.getReviewIdx());
	        pstmt.setString(9, dto.getMemberId());
	        
	        updateResult = pstmt.executeUpdate();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	    	db.close(pstmt, conn);
	    }
	    
	    return updateResult;
	}
	
	//삭제
	public int deleteReview(long reviewIdx, String memberId) {
		
		int deleteResult = 0;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="delete from review where review_idx=? and member_id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, reviewIdx);
			pstmt.setString(2, memberId);
			
			deleteResult=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.close(pstmt, conn);
		}
		return deleteResult;
	}
	

	//별점평균
	public Double avgReview(long storeIdx) {
		Double avgRating=null;
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select avg(review_rating) as avg from review where store_idx=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, storeIdx);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				avgRating=rs.getDouble("avg");
				if(rs.wasNull()) {
					avgRating=0.0;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.close(rs, pstmt, conn);
		}
		return avgRating;
	}
	
	//리뷰수
	public int countReview(long storeIdx) {
		
		int reviewCount=0;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select count(*) as review_count from review where store_idx=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, storeIdx);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				reviewCount=rs.getInt("review_count");

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close(rs, pstmt, conn);
		}
		
		return reviewCount;
		
	}
	
	//본인리뷰
	public List<ReviewDTO> getMyReviews(String memberId) {
	    List<ReviewDTO> list = new ArrayList<>();

	    String sql = """
	        SELECT r.*, s.store_name
	        FROM review r
	        JOIN store s ON r.store_idx = s.store_idx
	        WHERE r.member_id = ?
	        ORDER BY r.review_created_at DESC
	    """;

	    try (Connection conn = db.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, memberId);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            ReviewDTO dto = new ReviewDTO();
	            dto.setReviewIdx(rs.getLong("review_idx"));
	            dto.setStoreIdx(rs.getLong("store_idx"));
	            dto.setStoreName(rs.getString("store_name")); // ⭐ 핵심
	            dto.setReviewContent(rs.getString("review_content"));
	            dto.setReviewRating(rs.getInt("review_rating"));
	            dto.setReviewCreatedAt(rs.getTimestamp("review_created_at"));
	            dto.setReviewImg1(rs.getString("review_img1"));
	            dto.setReviewImg2(rs.getString("review_img2"));
	            dto.setReviewImg3(rs.getString("review_img3"));
	            dto.setReviewImg4(rs.getString("review_img4"));
	            dto.setReviewImg5(rs.getString("review_img5"));
	            list.add(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
}
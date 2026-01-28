package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.team.project.dto.StoreDTO;
import com.team.project.util.DBConn;

public class StoreDetailDAO {

    // 가게 정보 출력
    public StoreDTO selectDetailIntro(Long storeIdx) {
        // 1. null로 초기화 (데이터 없으면 null 리턴)
        StoreDTO dto = null; 
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM store WHERE store_idx=?";
        
        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, storeIdx);
            rs = pstmt.executeQuery();
            
            // 2. 데이터가 존재할 때만 객체 생성
            if(rs.next()) {
                dto = new StoreDTO();
                
                dto.setStoreIdx(rs.getLong("store_idx"));
                dto.setStoreImg(rs.getString("store_img"));
                dto.setStoreImg2(rs.getString("store_img2"));
                dto.setStoreImg3(rs.getString("store_img3"));
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
                dto.setLatitude(rs.getDouble("latitude"));
                dto.setLongitude(rs.getDouble("longitude"));
                dto.setKakaoId(rs.getString("kakao_id"));
                dto.setPlaceUrl(rs.getString("place_url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConn.close(rs, pstmt, conn);
        }
        
        return dto;
    }
    
 // 가게 정보 수정 (UPDATE)
    public int updateStore(StoreDTO dto) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        // SQL 쿼리: 이미지와 좌표, 카카오ID 등 모든 정보를 업데이트
        String sql = "UPDATE store SET "
                   + "store_name=?, store_category=?, store_tel=?, store_intro=?, "
                   + "store_addr=?, latitude=?, longitude=?, kakao_id=?, place_url=?, "
                   + "store_img=?, store_img2=?, store_img3=?, store_update_at=NOW() "
                   + "WHERE store_idx=?";
        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            
            // 파라미터 순서대로 값 설정
            pstmt.setString(1, dto.getStoreName());
            pstmt.setString(2, dto.getStoreCategory());
            pstmt.setString(3, dto.getStoreTel());
            pstmt.setString(4, dto.getStoreIntro());
            pstmt.setString(5, dto.getStoreAddr());
            pstmt.setDouble(6, dto.getLatitude());
            pstmt.setDouble(7, dto.getLongitude());
            pstmt.setString(8, dto.getKakaoId());
            pstmt.setString(9, dto.getPlaceUrl());
            pstmt.setString(10, dto.getStoreImg());
            pstmt.setString(11, dto.getStoreImg2());
            pstmt.setString(12, dto.getStoreImg3());
            pstmt.setLong(13, dto.getStoreIdx()); // WHERE 조건의 idx
            
            result = pstmt.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("[StoreDAO] 정보 수정 실패");
            e.printStackTrace();
        } finally {
            DBConn.close(null, pstmt, conn);
        }
        return result;
    }
}
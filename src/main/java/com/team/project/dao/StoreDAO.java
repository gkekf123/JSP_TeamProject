package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.team.project.dto.StoreDTO;
import com.team.project.util.DBConn;

public class StoreDAO {
    
    // 맛집 등록
    public int insertStore(StoreDTO dto) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConn.getConnection();
            StringBuilder sql = new StringBuilder();
            
            sql.append("INSERT INTO store ");
            sql.append("(store_name, store_category, store_addr, store_img, store_img2, store_img3, store_intro, store_tel, latitude, longitude, kakao_id, place_url) ");
            sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            
            pstmt = conn.prepareStatement(sql.toString());
            
            pstmt.setString(1, dto.getStoreName());
            pstmt.setString(2, dto.getStoreCategory());
            pstmt.setString(3, dto.getStoreAddr());
            pstmt.setString(4, dto.getStoreImg());
            pstmt.setString(5, dto.getStoreImg2());
            pstmt.setString(6, dto.getStoreImg3());
            pstmt.setString(7, dto.getStoreIntro());
            pstmt.setString(8, dto.getStoreTel());
            pstmt.setDouble(9, dto.getLatitude());    
            pstmt.setDouble(10, dto.getLongitude()); 
            pstmt.setString(11, dto.getKakaoId());    
            pstmt.setString(12, dto.getPlaceUrl());   
            
            result = pstmt.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("[DAO] 맛집 등록 실패");
            e.printStackTrace();
        } finally {
            DBConn.close(null, pstmt, conn);
        }
        return result;
    }
    
    // 맛집 목록 조회
    public List<StoreDTO> selectStoreList(String sortType, String searchWord, String category) {
        List<StoreDTO> list = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuilder sql = new StringBuilder();
        
        sql.append("SELECT store_idx, store_name, store_img, store_img2, store_img3, ");
        sql.append("store_rating_avg, store_rating_count, store_view_count, store_addr, store_tel, latitude, longitude, kakao_id, place_url ");
        sql.append("FROM store ");
        sql.append("WHERE 1=1 "); 
        
        // 2. 조건 확인 변수 설정
        boolean hasSearch = (searchWord != null && !searchWord.trim().isEmpty());
        boolean hasCategory = (category != null && !category.equals("all") && !category.trim().isEmpty());

        // 3. SQL 조건 추가
        if (hasCategory) {
            sql.append(" AND store_category = ? ");
        }
        
        if (hasSearch) {
            sql.append(" AND (store_name LIKE ? OR store_addr LIKE ? OR store_category LIKE ?) ");
        }
        
        // 4. 정렬 조건 추가
        if ("rating".equals(sortType)) {
            sql.append("ORDER BY store_rating_avg DESC, store_idx DESC ");
        } else if ("review".equals(sortType)) {
            sql.append("ORDER BY store_rating_count DESC, store_idx DESC ");
        } else if ("view".equals(sortType)) {
            sql.append("ORDER BY store_view_count DESC, store_idx DESC ");
        } else {
            sql.append("ORDER BY store_created_at DESC ");
        }

        try {
            conn = DBConn.getConnection(); 
            pstmt = conn.prepareStatement(sql.toString());
            
            // 5. 물음표(?) 값 채우기
            int paramIndex = 1;

            if (hasCategory) {
                pstmt.setString(paramIndex++, category);
            }
            
            if (hasSearch) {
                String keyword = "%" + searchWord + "%"; 
                pstmt.setString(paramIndex++, keyword); 
                pstmt.setString(paramIndex++, keyword); 
                pstmt.setString(paramIndex++, keyword); 
            }
            
            rs = pstmt.executeQuery();

            while (rs.next()) {
                StoreDTO dto = new StoreDTO();
                dto.setStoreIdx(rs.getLong("store_idx"));
                dto.setStoreName(rs.getString("store_name"));
                dto.setStoreImg(rs.getString("store_img"));
                dto.setStoreImg2(rs.getString("store_img2"));
                dto.setStoreImg3(rs.getString("store_img3"));
                dto.setStoreRatingAvg(rs.getDouble("store_rating_avg"));
                dto.setStoreRatingCount(rs.getInt("store_rating_count"));
                dto.setStoreViewCount(rs.getInt("store_view_count"));
                dto.setStoreAddr(rs.getString("store_addr"));
                dto.setStoreTel(rs.getString("store_tel"));
                dto.setLatitude(rs.getDouble("latitude"));
                dto.setLongitude(rs.getDouble("longitude"));
                dto.setKakaoId(rs.getString("kakao_id"));
                dto.setPlaceUrl(rs.getString("place_url"));
                
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("[DAO] 맛집 목록 조회 실패");
            e.printStackTrace();
        } finally {
            DBConn.close(rs, pstmt, conn);
        }
        
        return list;
    }
    
    // 조회수 증가 메서드
    public void updateReadCount(String storeIdx) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE store SET store_view_count = store_view_count + 1 WHERE store_idx = ?";
        
        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, storeIdx);
            
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("[DAO] 조회수 증가 실패");
            e.printStackTrace();
        } finally {
            DBConn.close(null, pstmt, conn);
        }
    }
    
    // 카테고리별 게시글 개수 조회 (Map<카테고리명, 개수> 형태)
    public java.util.Map<String, Integer> getCategoryCounts() {
        java.util.Map<String, Integer> map = new java.util.HashMap<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        // 카테고리별로 그룹화해서 개수 세기
        String sql = "SELECT store_category, COUNT(*) as cnt FROM store GROUP BY store_category";

        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                String category = rs.getString("store_category");
                int count = rs.getInt("cnt");
                if(category != null) {
                    map.put(category, count);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close(rs, pstmt, conn);
        }
        return map;
    }
    
    // 수정을 위한 단건 조회 (idx로 가게 정보 가져오기)
    public StoreDTO selectStoreOne(String storeIdx) {
        StoreDTO dto = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM store WHERE store_idx = ?";

        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, storeIdx);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dto = new StoreDTO();
                dto.setStoreIdx(rs.getLong("store_idx"));
                dto.setStoreName(rs.getString("store_name"));
                dto.setStoreCategory(rs.getString("store_category"));
                dto.setStoreAddr(rs.getString("store_addr"));
                dto.setStoreTel(rs.getString("store_tel"));
                dto.setStoreIntro(rs.getString("store_intro"));
                dto.setStoreImg(rs.getString("store_img"));
                dto.setStoreImg2(rs.getString("store_img2"));
                dto.setStoreImg3(rs.getString("store_img3"));
                dto.setLatitude(rs.getDouble("latitude"));
                dto.setLongitude(rs.getDouble("longitude"));
                dto.setKakaoId(rs.getString("kakao_id"));
                dto.setPlaceUrl(rs.getString("place_url"));
            }
        } catch (Exception e) {
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
        
        String sql = "UPDATE store SET "
                   + "store_name=?, store_category=?, store_tel=?, store_intro=?, "
                   + "store_addr=?, latitude=?, longitude=?, kakao_id=?, place_url=?, "
                   + "store_img=?, store_img2=?, store_img3=?, store_update_at=NOW() "
                   + "WHERE store_idx=?";
        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            
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
            pstmt.setLong(13, dto.getStoreIdx());
            
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close(null, pstmt, conn);
        }
        return result;
    }

    // 가게 삭제 (DELETE)
    public int deleteStore(String storeIdx) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE FROM store WHERE store_idx = ?";

        try {
            conn = DBConn.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, storeIdx);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close(null, pstmt, conn);
        }
        return result;
    }
}
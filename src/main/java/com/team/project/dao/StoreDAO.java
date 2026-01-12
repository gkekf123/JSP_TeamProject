package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.team.project.dto.StoreDTO;
import com.team.project.util.DBConn;

public class StoreDAO {
    
    public List<StoreDTO> selectStoreList(String sortType, String searchWord) {
        List<StoreDTO> list = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 1. SQL 작성
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT store_idx, store_name, store_img, store_rating_avg, store_rating_count, store_addr ");
        sql.append("FROM store ");
        
        // 검색어가 있을 경우 WHERE절 추가
        boolean hasSearch = (searchWord != null && !searchWord.trim().isEmpty());
        if (hasSearch) {
            sql.append("WHERE store_name LIKE ? OR store_addr LIKE ? ");
        }
        
        // 2. 동적 정렬
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
            
            // 물음표(?) 채우기
            if (hasSearch) {
                String keyword = "%" + searchWord + "%"; 
                pstmt.setString(1, keyword); // 첫 번째 ? (이름)
                pstmt.setString(2, keyword); // 두 번째 ? (주소)
            }
            
            rs = pstmt.executeQuery();

            int count = 0;
            while (rs.next()) {
                StoreDTO dto = new StoreDTO();
                dto.setStoreIdx(rs.getLong("store_idx"));
                dto.setStoreName(rs.getString("store_name"));
                dto.setStoreImg(rs.getString("store_img"));
                dto.setStoreRatingAvg(rs.getDouble("store_rating_avg"));
                dto.setStoreRatingCount(rs.getInt("store_rating_count"));
                dto.setStoreAddr(rs.getString("store_addr"));
                
                list.add(dto);
                count++;
            }
        } catch (Exception e) {
            System.out.println("[DAO] ❌ 에러 발생!");
            e.printStackTrace();
        } finally {
           DBConn.close(rs, pstmt, conn);
        }
        
        return list;
    }
}
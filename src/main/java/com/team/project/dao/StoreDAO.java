package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.team.project.dto.StoreDTO;
import com.team.project.util.DBConn;

public class StoreDAO {
    
    public List<StoreDTO> selectStoreList(String sortType) {
        List<StoreDTO> list = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 1. SQL 작성
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT store_idx, store_name, store_img, store_rating_avg, store_rating_count, store_addr ");
        sql.append("FROM store ");
        
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
            rs = pstmt.executeQuery();

            // 4. 결과 매핑
            while (rs.next()) {
                StoreDTO dto = new StoreDTO();
                dto.setStoreIdx(rs.getLong("store_idx"));
                dto.setStoreName(rs.getString("store_name"));
                dto.setStoreImg(rs.getString("store_img"));
                dto.setStoreRatingAvg(rs.getDouble("store_rating_avg"));
                dto.setStoreRatingCount(rs.getInt("store_rating_count"));
                dto.setStoreAddr(rs.getString("store_addr"));
                
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
           DBConn.close(rs, pstmt, conn);
        }
        
        return list;
    }
}
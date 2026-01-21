package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.team.project.dto.BookmarkDTO;
import com.team.project.util.DBConn;

public class BookmarkDAO {

    // 1. 내가 찜한 '내부 가게(store_idx)' 목록만 빠르게 조회
    public Set<Long> getMyBookmarkStoreIdxSet(String memberId) {
        Set<Long> set = new HashSet<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConn.getConnection();
            String sql = "SELECT store_idx FROM bookmark WHERE member_id = ? AND store_idx IS NOT NULL";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                set.add(rs.getLong("store_idx"));
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close(rs, pstmt, conn);
        }
        return set;
    }

    // 2. 찜 여부 단건 확인
    public boolean isBookmarked(String memberId, int storeIdx) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConn.getConnection();
            String sql = "SELECT count(*) FROM bookmark WHERE member_id = ? AND store_idx = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            pstmt.setInt(2, storeIdx);
            rs = pstmt.executeQuery();
            
            if(rs.next() && rs.getInt(1) > 0) {
                result = true;
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close(rs, pstmt, conn);
        }
        return result;
    }

    // 3. 찜 추가
    public int addBookmark(String memberId, int storeIdx, String name, String addr, String url, String phone, String kakaoId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;
        
        try {
            conn = DBConn.getConnection();
            
            // 카카오 ID로 store_idx 찾기
            if (storeIdx == 0 && kakaoId != null && !kakaoId.isEmpty()) {
                String checkSql = "SELECT store_idx FROM store WHERE kakao_id = ?";
                pstmt = conn.prepareStatement(checkSql);
                pstmt.setString(1, kakaoId);
                rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    storeIdx = rs.getInt("store_idx");
                }
                rs.close();
                pstmt.close();
            }

            // store_idx로 카카오 정보 찾기
            if (storeIdx > 0 && (kakaoId == null || kakaoId.isEmpty())) {
                 String infoSql = "SELECT kakao_id, place_url FROM store WHERE store_idx = ?";
                 pstmt = conn.prepareStatement(infoSql);
                 pstmt.setInt(1, storeIdx);
                 rs = pstmt.executeQuery();
                 if(rs.next()) {
                     kakaoId = rs.getString("kakao_id");
                     if(url == null || url.isEmpty()) url = rs.getString("place_url");
                 }
                 rs.close();
                 pstmt.close();
            }

            // INSERT
            StringBuilder sql = new StringBuilder();
            sql.append("INSERT INTO bookmark ");
            sql.append("(member_id, store_idx, place_name, place_addr, place_url, place_phone, kakao_id) ");
            sql.append("VALUES (?, ?, ?, ?, ?, ?, ?)");
            
            pstmt = conn.prepareStatement(sql.toString());
            
            pstmt.setString(1, memberId);
            if (storeIdx > 0) {
                pstmt.setInt(2, storeIdx);
            } else {
                pstmt.setNull(2, java.sql.Types.INTEGER);
            }
            pstmt.setString(3, name);
            pstmt.setString(4, addr);
            pstmt.setString(5, url);
            pstmt.setString(6, phone);
            pstmt.setString(7, kakaoId);
            
            result = pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close(rs, pstmt, conn);
        }
        return result;
    }

    // 4. 찜 삭제
    public int removeBookmark(String memberId, int storeIdx) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConn.getConnection();
            String sql = "DELETE FROM bookmark WHERE member_id = ? AND store_idx = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            pstmt.setInt(2, storeIdx);
            
            result = pstmt.executeUpdate();
            
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close(null, pstmt, conn);
        }
        return result;
    }
    
    // 5. 내 찜 목록 전체 조회
    public List<BookmarkDTO> selectMyBookmarkList(String memberId) {
        List<BookmarkDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConn.getConnection();
            
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT b.*, s.store_img, s.store_rating_avg, s.store_view_count, s.store_tel ");
            sql.append("FROM bookmark b ");
            sql.append("LEFT JOIN store s ON b.store_idx = s.store_idx "); 
            sql.append("WHERE b.member_id = ? ");
            sql.append("ORDER BY b.like_date DESC");

            pstmt = conn.prepareStatement(sql.toString());
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                BookmarkDTO dto = new BookmarkDTO();
                
                dto.setLikeIdx(rs.getLong("like_idx"));
                dto.setMemberId(rs.getString("member_id"));
                int storeIdx = rs.getInt("store_idx");
                dto.setStoreIdx(storeIdx); 
                dto.setPlaceName(rs.getString("place_name"));
                dto.setPlaceAddr(rs.getString("place_addr"));
                dto.setPlaceUrl(rs.getString("place_url"));
                dto.setLikeDate(rs.getTimestamp("like_date"));
                dto.setKakaoId(rs.getString("kakao_id"));
                
                String storeTel = rs.getString("store_tel");
                String bookmarkPhone = rs.getString("place_phone");
                
                if (storeIdx > 0 && storeTel != null && !storeTel.trim().isEmpty()) {
                    dto.setPlacePhone(storeTel);
                } else {
                    dto.setPlacePhone(bookmarkPhone);
                }
                
                dto.setStoreImg(rs.getString("store_img"));
                dto.setStoreRatingAvg(rs.getDouble("store_rating_avg"));
                dto.setStoreViewCount(rs.getInt("store_view_count"));
                
                list.add(dto);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close(rs, pstmt, conn);
        }
        return list;
    }
}
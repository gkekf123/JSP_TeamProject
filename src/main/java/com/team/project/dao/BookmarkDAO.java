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
    public Set<Integer> getMyBookmarkStoreIdxSet(String memberId) {
        Set<Integer> set = new HashSet<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConn.getConnection();
            // store_idx가 NULL이 아닌(우리 DB에 있는 가게) 것만 조회
            String sql = "SELECT store_idx FROM bookmark WHERE member_id = ? AND store_idx IS NOT NULL";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                set.add(rs.getInt("store_idx"));
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close(rs, pstmt, conn);
        }
        return set;
    }

    // 2. 찜 여부 단건 확인 (특정 가게를 찜했는지?)
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

    // 3. 찜 추가 (INSERT) - 내부 가게/외부 가게 공용
    public int addBookmark(String memberId, int storeIdx, String name, String addr, String url, String phone) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConn.getConnection();
            String sql = "INSERT INTO bookmark (member_id, store_idx, place_name, place_addr, place_url, place_phone) VALUES (?, ?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            
            // storeIdx가 0보다 크면 값 저장, 아니면(외부가게) NULL 저장
            if(storeIdx > 0) {
                pstmt.setInt(2, storeIdx);
            } else {
                pstmt.setNull(2, java.sql.Types.INTEGER);
            }
            
            pstmt.setString(3, name);
            pstmt.setString(4, addr);
            pstmt.setString(5, url);
            pstmt.setString(6, phone);
            
            result = pstmt.executeUpdate();
            
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBConn.close(null, pstmt, conn);
        }
        return result;
    }

    // 4. 찜 삭제 (DELETE) - store_idx 기준 (내부 가게용)
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
    
    // 5. [마이페이지용] 내 찜 목록 전체 조회 (DTO 리스트 반환)
    public List<BookmarkDTO> selectMyBookmarkList(String memberId) {
        List<BookmarkDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConn.getConnection();
            // 최신순(찜한 날짜 내림차순) 정렬
            String sql = "SELECT * FROM bookmark WHERE member_id = ? ORDER BY like_date DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                BookmarkDTO dto = new BookmarkDTO();
                
                dto.setLikeIdx(rs.getLong("like_idx"));
                dto.setMemberId(rs.getString("member_id"));
                
                // store_idx가 NULL이면 0으로 들어옴 (int 기본값)
                dto.setStoreIdx(rs.getInt("store_idx")); 
                
                dto.setPlaceName(rs.getString("place_name"));
                dto.setPlaceAddr(rs.getString("place_addr"));
                dto.setPlaceUrl(rs.getString("place_url"));
                dto.setPlacePhone(rs.getString("place_phone"));
                dto.setLikeDate(rs.getTimestamp("like_date"));
                
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
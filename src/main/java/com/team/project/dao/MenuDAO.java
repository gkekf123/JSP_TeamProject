package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.team.project.dto.MenuDTO;
import com.team.project.util.DBConn;

public class MenuDAO {
	
	DBConn db=new DBConn();
	
	//insert
	public void insertMenu(MenuDTO dto) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into menu (store_idx, menu_name, menu_price, menu_img) values (?,?,?,?)";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, dto.getStoreIdx());
			pstmt.setString(2, dto.getMenuName());
			pstmt.setInt(3, dto.getMenuPrice());
			pstmt.setString(4, dto.getMenuImg());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.close(pstmt, conn);
		}
	}
	
	//select
	public List<MenuDTO> selectMenu(long storeIdx){
		List<MenuDTO> list=new ArrayList<MenuDTO>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from menu where store_idx=? order by menu_idx";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, storeIdx);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				 MenuDTO dto = new MenuDTO();

                dto.setMenuIdx(rs.getInt("menu_idx"));
                dto.setStoreIdx(rs.getLong("store_idx"));
                dto.setMenuName(rs.getString("menu_name"));
                dto.setMenuPrice(rs.getInt("menu_price"));
                dto.setMenuImg(rs.getString("menu_img"));

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
	
	
	//oneselect
	public MenuDTO oneselectMenu() {
		MenuDTO dto=new MenuDTO();
		
		return dto;
	}

	//삭제
	public boolean deleteMenu(int menuIdx) {
		boolean isSuccess = false;
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;

        String sql = "delete from menu where menu_idx=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, menuIdx);
            
            int n = pstmt.executeUpdate();
            if (n > 0) {
                isSuccess = true;
            }
            
            pstmt.execute();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.close(pstmt, conn);
        }
        return isSuccess;
    }
	
	//수정
	public void updateMenu(MenuDTO dto) {
	    Connection conn = db.getConnection();
	    PreparedStatement pstmt = null;

	    String sql = "update menu set menu_name=?, menu_price=?, menu_img=? where menu_idx=?";

	    try {
	        pstmt = conn.prepareStatement(sql);

	        pstmt.setString(1, dto.getMenuName());
	        pstmt.setInt(2, dto.getMenuPrice());
	        pstmt.setString(3, dto.getMenuImg());
	        pstmt.setInt(4, dto.getMenuIdx());

	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        db.close(pstmt, conn);
	    }
	}
}

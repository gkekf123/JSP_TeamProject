package com.team.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.team.project.dto.NewsDTO;
import com.team.project.util.DBConn;

public class NewsDAO {
	
	DBConn db=new DBConn();

	public void insertNews(NewsDTO dto){
		Connection conn=DBConn.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into news (news_title, news_url, news_img, news_source, news_regdate)VALUES (?, ?, ?, ?, NOW())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNews_title());
			pstmt.setString(2, dto.getNews_url());
			pstmt.setString(3, dto.getNews_img());
			pstmt.setString(4, dto.getNews_source());
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBConn.close(pstmt, conn);
		}
	}
	
	public List<NewsDTO> selectNews(){
		List<NewsDTO> list=new ArrayList<NewsDTO>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from news order by news_idx desc";
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				NewsDTO dto=new NewsDTO();
				dto.setNews_idx(rs.getLong("news_idx"));
				dto.setNews_title(rs.getString("news_title"));
				dto.setNews_url(rs.getString("news_url"));
				dto.setNews_img(rs.getString("news_img"));
				dto.setNews_source(rs.getString("news_source"));
				dto.setNews_regdate(rs.getTimestamp("news_regdate"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBConn.close(rs, pstmt, conn);
		}
		
		return list;
	}
	
}

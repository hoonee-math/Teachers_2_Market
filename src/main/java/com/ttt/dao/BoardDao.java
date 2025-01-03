package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Image2;
import com.ttt.dto.Post2;

public class BoardDao {
	public List<Post2> selectPostByCategory(SqlSession session, Map<String, Integer> param) {
		int cPage = param.get("cPage");
	    int categoryNo = param.get("categoryNo");
	    
	    List<Post2> result = session.selectList("post2.selectPostByCategory",
	            Map.of("categoryNo", categoryNo, "start", (cPage-1)*16+1, "end", cPage*16));
	    
	    return result;
	}
	
	public int getTotalCount(SqlSession session, int categoryNo) {
		return session.selectOne("post2.getTotalCount", categoryNo);
	}
	
	public List<Post2> selectNotice(SqlSession session) {
		return session.selectList("post2.selectNotice");
	}
	
	public Image2 selectThumbnailByPost(SqlSession session, int postNo) {
		return session.selectOne("post2.selectThumbnailByPost", postNo);
	}
}

package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.BoardDao;
import com.ttt.dto.Image2;
import com.ttt.dto.Post2;

public class BoardService {
	private BoardDao dao = new BoardDao();
	
	public List<Post2> selectPostByCategory(Map<String, Integer> param) {
		SqlSession session = getSession();
		
		List<Post2> posts = dao.selectPostByCategory(session, param);
		session.close();
		
		return posts;
	}
	
	public int getTotalCount(int categoryNo) {
		SqlSession session = getSession();
		int result = dao.getTotalCount(session, categoryNo);
		session.close();
		return result;
	}
	
	public List<Post2> selectNotice() {
		SqlSession session = getSession();
		List<Post2> notice = dao.selectNotice(session);
		session.close();
		
		return notice;
	}
	
	public Image2 selectThumbnailByPost(int postNo) {
	    SqlSession session = getSession();
	    Image2 thumbnail = dao.selectThumbnailByPost(session, postNo);
	    session.close();
	    return thumbnail;
	}
}

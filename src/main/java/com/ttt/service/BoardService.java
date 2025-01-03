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
	
	public List<Post2> selectAllNotify() {
		SqlSession session = getSession();
		return dao.selectAllNotify(session);
	}
	
	public Image2 selectThumbnailByPost(int postNo) {
	    SqlSession session = getSession();
	    Image2 thumbnail = dao.selectThumbnailByPost(session, postNo);
	    session.close();
	    return thumbnail;
	}
	
	//메인 페이지에서 사용할 인기글 조회 로직
	public List<Post2> selectPostByPopular() {
		SqlSession session = getSession();
		List<Post2> populars = dao.selectPostByPopular(session);
		session.close();
		
		return populars;
	}
}

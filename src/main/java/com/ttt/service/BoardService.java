package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.BoardDao;
import com.ttt.dto.Post2;

public class BoardService {
	private BoardDao dao = new BoardDao();
	
	public List<Post2> selectPostByCategory(Map<String, Integer> param) {
		SqlSession session = getSession();
		
		List<Post2> posts = dao.selectPostByCategory(session, param);
		session.close();
		
		return posts;
	}
}

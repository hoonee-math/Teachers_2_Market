package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.PostDao;
import com.ttt.dto.Image2;
import com.ttt.dto.Post2;

public class PostService {
	private PostDao dao = new PostDao();
	
	//post2 객체불러오기
	public Post2 selectPostByNo(int postNo) {
		SqlSession session = getSession();
		Post2 p = dao.selectPostByNo(session, postNo);
		session.close();
		return p;
	}
	//viewpost.jsp에 이미지 불러오기
	public List<Image2> selectImageNo(int postNo) {
		SqlSession session = getSession();
		List<Image2> img = dao.selectImageNo(session, postNo);
		session.close();
		return img;
	}
}

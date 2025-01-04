package com.ttt.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Image2;
import com.ttt.dto.Post2;

public class PostDao {
	
	/* 사용자 메뉴
	 * uploadPost : 글 등록 
	 * */
	
	/* 관리자 메뉴
	 * deletePost : 글 삭제(IS_DELETED 값을 1로)
	 * */
	
	/////////////////////
	/* 사용자 메뉴        */
	/////////////////////
	
	public int uploadPost(SqlSession session, Post2 p) {
		return session.insert("post.insertPost",p);
	}

	/////////////////////
	/* 관리자 메뉴        */
	/////////////////////
	
	public int deletePost(SqlSession session, Post2 p) {
		return session.update("post.deletePost",p);
	}
	
	//post2 객체불러오기
	public Post2 selectPostJoinAll(SqlSession session, int postNo) {
		return session.selectOne("post2.selectPostJoinAll", postNo);
	}
	//viewpost.jsp에 이미지 불러오기
	public List<Image2> selectImageNo(SqlSession session, int postNo) {
		return session.selectList("post2.selectImageNo", postNo);
	}

	public int toggleNotifyFix(SqlSession session, int postNo) {
		return session.update("post2.toggleNotifyFix",postNo);
	}

	public Post2 selectPostByNoOnAdminMenu(SqlSession session, int postNo) {
		return session.selectOne("post2.selectPostByNoOnAdminMenu",postNo);
	}
	
	public int insertNotify(SqlSession session, Post2 p) {
		return session.insert("post2.insertNotify",p);
	}
	
}

package com.ttt.dao;

import org.apache.ibatis.session.SqlSession;

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
	
}

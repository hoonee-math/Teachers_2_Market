package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.File2;
import com.ttt.dto.Image2;
import com.ttt.dto.Post2;

public class PostDao {
	
	/* 사용자 메뉴
	 * insertPost : 글 등록 
	 * selectLastPostNo : 마지막 post_no 조회 - 트랜잭션 안에서만 사용 가능
	 * insertProduct : 상품 정보 저장
	 * insertFile : 파일 정보 저장
	 * insertImageByPostNo : 이미지 정보 저장
	 * */
	
	/* 관리자 메뉴
	 * deletePost : 글 삭제(IS_DELETED 값을 1로)
	 * */
	
	/////////////////////
	/* 사용자 메뉴        */
	/////////////////////
	
	public int insertPost(SqlSession session, Post2 p) {
		return session.insert("post2.insertPost",p);
	}
	public int selectLastPostNo(SqlSession session) {
		return session.selectOne("post2.selectLastPostNo");
	}
	public int insertProduct(SqlSession session, Post2 product) {
		return session.insert("post2.insertProduct", product);
	}
	public int insertFile(SqlSession session, File2 file) {
		return session.insert("post2.insertFile",file);
	}
	public int insertImageByPostNo(SqlSession session, Image2 image) {
		return session.insert("image2.insertImageByPostNo",image);
	}


	/////////////////////
	/* 관리자 메뉴        */
	/////////////////////
	
	public int deletePost(SqlSession session, Post2 p) {
		return session.update("post2.deletePost",p);
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
	
	// notifyWrite.jsp 공지사항 등록을 위한 메서드
	public int insertNotify(SqlSession session, Post2 p) {
		return session.insert("post2.insertNotify",p);
	}
	// insertNotify 로 등록한 공지사항의 번호를 조회하는 메서드
	public int selectLastNotifyNo(SqlSession session) {
		return session.selectOne("post2.selectLastNotifyNo");
	}
	
	public List<Post2> selectAllPost(SqlSession session, Map<String, Integer> param) {
		int cPage = param.get("cPage");
		String memberId = param.get("memberId").toString();

	    List<Post2> result = session.selectList("post2.selectAllPost",
	            Map.of("memberId", memberId, "start", (cPage-1)*10+1, "end", cPage*10));
		
		return result;
	}
	public List<Post2> selectAllPostById(SqlSession session, Map<String, Integer> param) {
		int cPage = param.get("cPage");
		int memberNo = param.get("memberNo");

	    List<Post2> result = session.selectList("post2.selectAllPostById",
	            Map.of("memberNo", memberNo, "start", (cPage-1)*10+1, "end", cPage*10));
		
		return result;	}
	
}

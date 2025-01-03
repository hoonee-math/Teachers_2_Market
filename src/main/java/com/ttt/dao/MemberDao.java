package com.ttt.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Member2;

public class MemberDao {

	/* 사용자 메뉴 - 만든 후 등록해놓기
	 * 
	 * */
	
	/* 관리자 메뉴 - 만든 후 등록해놓기
	 * selectAllMember : 전체 멤버 리스트 출력
	 * */
	
	
	

	// 관리자 메뉴 : 전체 멤버 리스트 출력
	public List<Member2> selectAllMember(SqlSession session){
		System.out.println("DAO - 전체 멤버 리스트 출력 시작");
		return session.selectList("member2.selectAllMember");
	}
	// 관리자 메뉴 : 전체 멤버 업데이트
	public List<Member2> updateAllMember(SqlSession session, int updateType){
		System.out.println("DAO - 전체 멤버 업데이트");
		return session.selectList("member2.selectAllMember");
	}
	// 사용자 메뉴 : 회원 정보 등록
	public int insertMember(SqlSession session, Member2 m) {
		return session.insert("member2.insertMember",m);
	}
}

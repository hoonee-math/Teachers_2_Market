package com.ttt.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Member2;

public class MemberDao {
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
	// 사용자 메뉴 : 로그인
	public Member2 selectMemberById(SqlSession session, String memberId) {
		return session.selectOne("member2.selectMemberById", memberId);
	}
	// 사용자 메뉴 : 아이디 중복 검사
	public Member2 checkMemberById(SqlSession session, String memberId) {
		return session.selectOne("member2.selectMemberById", memberId);
	}
	
	// 비밀번호 찾기
	public Member2 selectMemberByIdAndEmail(SqlSession session, Member2 m) {
	   return session.selectOne("member2.selectMemberByIdAndEmail", m);
	}
	// 비밀번호 변경
	public int updatePassword(SqlSession session, Member2 m) {
		return session.update("member2.updatePassword", m);
	}
	
	//아이디 찾기
	public String selectMemberIdByNameAndEmail(SqlSession session, Member2 m) {
		return session.selectOne("member2.selectMemberIdByNameAndEmail", m);
	}
	
	public int updateMember(SqlSession session, Member2 m) {
		return session.update("Member2.updateMember", m);
	}
}

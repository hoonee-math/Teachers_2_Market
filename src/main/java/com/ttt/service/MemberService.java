package com.ttt.service;
import static com.ttt.common.SqlSessionTemplate.getSession;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.MemberDao;
import com.ttt.dto.Member2;

public class MemberService {
	
	private MemberDao dao = new MemberDao();
	
	public int insertMember(Member2 m) {
		SqlSession session = getSession();
		int result = 0;
		try {
			result = dao.insertMember(session, m);
			if(result>0) {
				session.commit();
			}else {
				session.rollback();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			session.rollback();
			throw e;
		}finally {
			session.close();
		} return result;
	}
	
	public Member2 selectMemberById(String memberId) {
		SqlSession session = getSession();
		return dao.selectMemberById(session, memberId);
	}
	public Member2 memberCheckId(String memberId) {
		SqlSession session = getSession();
		return dao.checkMemberById(session, memberId);
	}
	
	//비밀번호 찾기 
	public Member2 selectMemberByIdAndEmail(Member2 m) {
		SqlSession session=getSession();
	    Member2 result = dao.selectMemberByIdAndEmail(session, m);
	    System.out.println("Service layer result: " + result);
	    return result;
	}
	public int updatePassword(Member2 m) {
		SqlSession session=getSession();
	    int result = 0;
	    try {
	        result = dao.updatePassword(session, m);
	        if(result > 0) session.commit();
	        else session.rollback();
	    } catch(Exception e) {
	        session.rollback();
	        throw e;
	    } finally {
	        session.close();
	    }
	    return result;
	}
	
	//아이디 찾기
	public String selectMemberIdByNameAndEmail(Member2 m) {
		SqlSession session = getSession();
		String memberId = dao.selectMemberIdByNameAndEmail(session, m);
		return memberId;
	}
	
	public int updateMember(Member2 m) {
		SqlSession session = getSession();
		int result = 0;
		try {
			result = dao.updateMember(session, m);
			if(result > 0) session.commit();
			else session.rollback();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
			throw e;
		} finally {
			session.close();
		}
		return result;
	}
}

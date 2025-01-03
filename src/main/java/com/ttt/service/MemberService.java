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
}

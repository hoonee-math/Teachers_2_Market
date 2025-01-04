package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.PostDao;
import com.ttt.dto.Post2;

public class AdminPostService {
	
		private PostDao dao=new PostDao();

		// notifyWrite.jsp 공지사항 등록을 위한 메서드
		// 등록 성공시 ajax를 통해서 작성된 글 바로확인할 수 있게 처리
		public int insertNotify(Post2 p) {
			SqlSession session=getSession();
		    int result = 0;
			try {
				result = dao.insertNotify(session, p);
		        if(result > 0) {
		            // 성공시 생성된 공지사항 번호를 객체에 설정
		            int postNo = dao.selectLastNotifyNo(session);
		            p.setPostNo(postNo);
		            session.commit();
		        } else {
		            session.rollback();
		        }
			} catch(Exception e) {
				e.printStackTrace();
		        session.rollback();
				System.out.println("RollBack 완료: DB에 insert문 실행중 오류가 발생함.");
				return 0;
			} finally {
		        session.close();
		    }
		    return result;
		}
}

package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.PostDao;
import com.ttt.dto.Post2;

public class AdminPostService {
	
		private PostDao dao=new PostDao();

		public int uploadPost(Post2 p) {
			SqlSession session=getSession();
			try {
				return dao.uploadPost(session, p);
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("DB에 insert문 실행중 오류가 발생함.");
				return 0;
			}
		}
}

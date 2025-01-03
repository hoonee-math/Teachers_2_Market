package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.PaymentDao;
import com.ttt.dto.Cart2;

public class PaymentService {
	private PaymentDao dao = new PaymentDao();
	
	public int insertCart(Cart2 cart) {
		SqlSession session = getSession();
		int result = 0;
		try {
			result = dao.insertCart(session, cart);
			if(result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
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

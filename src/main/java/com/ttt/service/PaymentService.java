package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.sql.Connection;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.PaymentDao;
import com.ttt.dto.Cart2;
import com.ttt.dto.Post2;

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
	
	// 장바구니 : 리스트 출력
	public List<Cart2> selectShoppingList(int memberNo) {
		SqlSession session = getSession();
		List<Cart2> posts = dao.selectShoppingList(session, memberNo);
		session.close();
		
		return posts;
	}
	
	//장바구니 : 선택 상품 삭제 
	public int deleteSelectedCarts(List<Integer> cartNos) {
		SqlSession session = getSession();
		int result = dao.deleteSelectedCarts(session, cartNos);
		session.close();
		
		return result;
	}
}

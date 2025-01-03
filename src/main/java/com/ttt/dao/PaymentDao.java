package com.ttt.dao;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Cart2;

public class PaymentDao {
	
	public int insertCart(SqlSession session, Cart2 cart) {
		return session.insert("cart2.insertCart", cart);
	}
}

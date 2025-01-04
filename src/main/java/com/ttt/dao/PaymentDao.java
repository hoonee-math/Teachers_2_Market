package com.ttt.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Cart2;
import com.ttt.dto.Post2;

public class PaymentDao {
	
	public int insertCart(SqlSession session, Cart2 cart) {
		return session.insert("cart2.insertCart", cart);
	}
	
	public List<Cart2> selectShoppingList(SqlSession session, int memberNo) {
		return session.selectList("cart2.selectShoppingList", memberNo);
	}
}

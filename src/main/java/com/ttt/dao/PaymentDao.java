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
	
	//장바구니 : 전체 삭제 
	public int deleteSelectedCarts(SqlSession session, List<Integer> cartNos) {
		return session.delete("cart2.deleteSelectedCarts", cartNos);
	}
	
	//장바구니 -> 구매하기 정보 넘기기 
	public List<Cart2> selectCartsByCartNo(SqlSession session, List<Integer> cartNos) {
		System.out.println("===== PaymentDao =====");
	    System.out.println("전달받은 cartNos: " + cartNos);
	    List<Cart2> result = session.selectList("cart2.selectCartsByCartNo", cartNos);
	    System.out.println("조회 결과: " + result);
	    return result;	}
}

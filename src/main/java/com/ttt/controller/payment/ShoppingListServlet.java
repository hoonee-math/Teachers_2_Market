package com.ttt.controller.payment;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Cart2;
import com.ttt.dto.Image2;
import com.ttt.dto.Member2;
import com.ttt.dto.Post2;
import com.ttt.service.BoardService;
import com.ttt.service.PaymentService;

@WebServlet("/payment/shoppinglist")
public class ShoppingListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ShoppingListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//세션에서 로그인한 회원 정보 가져오기 
		HttpSession session = request.getSession();
		Member2 loginMember = (Member2)session.getAttribute("loginMember");
		
		
		if (loginMember != null) {
			//서비스 호출하여 데이터 조회
			List<Cart2> carts = new PaymentService().selectShoppingList(loginMember.getMemberNo());
			
			//게시글별 대표 이미지 조회
			for(Cart2 cart : carts) {
		        Image2 thumbnail = new BoardService().selectThumbnailByPost(cart.getPost().getPostNo());
		        // Cart2 객체에 이미지 설정
		        if(thumbnail != null) {
		            List<Image2> images = new ArrayList<>();
		            images.add(thumbnail);
		            cart.setPostImg(images);
		        }
		    }
			System.out.println(carts);
			request.setAttribute("carts", carts);
		}
		
		
		request.getRequestDispatcher("/WEB-INF/views/payment/shoppingList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

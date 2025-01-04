package com.ttt.controller.payment;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.service.PaymentService;

@WebServlet("/payment/deletecart")
public class CartDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CartDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//선택된 cartNo 배열 받기
		String[] cartNoArr = request.getParameterValues("cartNo");
		
		if(cartNoArr == null || cartNoArr.length == 0) {
			response.sendRedirect(request.getContextPath() + "/payment/shoppinglist");
			return;
		}
		
		//String 배열을 Integer List로 반환
		List<Integer> cartNos = Arrays.stream(cartNoArr)
										.map(Integer::parseInt)
										.collect(Collectors.toList());
		
		try {
			int result = new PaymentService().deleteSelectedCarts(cartNos);
			
			//삭제 후 장바구니 페이지로 리다이렉트
			response.sendRedirect(request.getContextPath() + "/payment/shoppinglist");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

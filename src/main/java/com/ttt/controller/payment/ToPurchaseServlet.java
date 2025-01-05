package com.ttt.controller.payment;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/payment/purchase")
public class ToPurchaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToPurchaseServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//선택된 상품들의 정보를 받아서 처리
		String[] cartNos = request.getParameterValues("cartNo");
		String[] postNos = request.getParameterValues("postNo");
		String[] productTypes = request.getParameterValues("productType");
		String[] productPrices = request.getParameterValues("productPrice");
		String[] deliveryFees = request.getParameterValues("deliveryFee");
		String[] filePrices = request.getParameterValues("filePrice");
		
		request.setAttribute("cartNos", cartNos);
		request.setAttribute("postNos", postNos);
		request.setAttribute("productTypes", productTypes);
		request.setAttribute("productPrices", productPrices);
		request.setAttribute("deliveryFees", deliveryFees);
		request.setAttribute("filePrices", filePrices);
		
		request.getRequestDispatcher("/WEB-INF/views/payment/purchase.jsp").forward(request, response);
	}

}

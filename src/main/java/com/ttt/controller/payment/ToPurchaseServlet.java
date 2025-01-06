package com.ttt.controller.payment;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Cart2;
import com.ttt.dto.Image2;
import com.ttt.service.BoardService;
import com.ttt.service.PaymentService;

@WebServlet("/payment/purchase")
public class ToPurchaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToPurchaseServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//선택된 상품들의 정보를 받아서 처리
		String[] cartNos = request.getParameterValues("cartNo");
		
		String totalProductPrice = request.getParameter("totalProductPrice");
		request.setAttribute("totalProductPrice", totalProductPrice);
		String totalDeliveryFee = request.getParameter("totalDeliveryFee");
		request.setAttribute("totalDeliveryFee", totalDeliveryFee);
		String totalPrice = request.getParameter("totalPrice");
		request.setAttribute("totalPrice", totalPrice);
			
			List<Integer> cartNoList = Arrays.stream(cartNos)
											.filter(cartNo -> {
						                        boolean isValid = cartNo != null && !cartNo.trim().isEmpty();
						                        return isValid;
						                    })
						                    .map(cartNo -> {
						                        int parsed = Integer.parseInt(cartNo);
						                        return parsed;
						                    })
											.collect(Collectors.toList());
			
			if(!cartNoList.isEmpty()) {
				List<Cart2> selectedCarts = new PaymentService().selectCartsByCartNo(cartNoList);
				
				for (Cart2 cart : selectedCarts) {
					Image2 thumbnail = new BoardService().selectThumbnailByPost(cart.getPost().getPostNo());
					if(thumbnail != null) {
						List<Image2> images = new ArrayList<>();
						images.add(thumbnail);
						cart.setPostImg(images);
					}
				}
				request.setAttribute("carts", selectedCarts);
			}
			
		
		//file 판매기한 끝나면 "판매종료" 띄우기 위한 오늘 날짜 받아옴
		LocalDate today = LocalDate.now();
		request.setAttribute("today", today);
		
		request.getRequestDispatcher("/WEB-INF/views/payment/purchase.jsp").forward(request, response);
	}

}

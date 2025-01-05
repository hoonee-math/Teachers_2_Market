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
		
		System.out.println("전송된 cartNo 개수 : " + (cartNos!=null?cartNos.length:0));
		
		if (cartNos != null) {
			System.out.println("==== 전송된 cartNo 값 확인 ====");
		    for (String cartNo : cartNos) {
		        System.out.println("cartNo: [" + cartNo + "]");
		    }
			
			List<Integer> cartNoList = Arrays.stream(cartNos)
											.filter(cartNo -> {
						                        boolean isValid = cartNo != null && !cartNo.trim().isEmpty();
						                        System.out.println("cartNo [" + cartNo + "] 유효성: " + isValid);
						                        return isValid;
						                    })
						                    .map(cartNo -> {
						                        int parsed = Integer.parseInt(cartNo);
						                        System.out.println("변환된 cartNo: " + parsed);
						                        return parsed;
						                    })
											.collect(Collectors.toList());
			
			 System.out.println("최종 cartNoList 크기: " + cartNoList.size());
			 System.out.println("cartNoList 내용: " + cartNoList);
			
			if(!cartNoList.isEmpty()) {
				List<Cart2> selectedCarts = new PaymentService().selectCartsByCartNo(cartNoList);
				System.out.println("cartNoList 크기: " + cartNoList.size());
			    System.out.println("selectedCarts 크기: " + selectedCarts.size());
			    System.out.println("가져온 리스트 출력: " + selectedCarts);
				
				
				for (Cart2 cart : selectedCarts) {
					System.out.println("처리중인 cart: " + cart);
					Image2 thumbnail = new BoardService().selectThumbnailByPost(cart.getPost().getPostNo());
					if(thumbnail != null) {
						List<Image2> images = new ArrayList<>();
						images.add(thumbnail);
						cart.setPostImg(images);
						System.out.println("이미지 설정 완료: " + images);
					}
				}
				request.setAttribute("carts", selectedCarts);
			}
		}
		
		//file 판매기한 끝나면 "판매종료" 띄우기 위한 오늘 날짜 받아옴
				LocalDate today = LocalDate.now();
				request.setAttribute("today", today);
		
		request.getRequestDispatcher("/WEB-INF/views/payment/purchase.jsp").forward(request, response);
	}

}

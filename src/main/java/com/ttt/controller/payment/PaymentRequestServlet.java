package com.ttt.controller.payment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PaymentRequestServlet
 */
@WebServlet("/payment/requestpay/*")
public class PaymentRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PaymentRequestServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String uri = request.getRequestURI();
        String path = uri.substring(request.getContextPath().length());
        String msg;
        String loc;

        switch(path) {
        case "/payment/requestpay/success":

			msg="상품 구매에 성공했습니다!";
			loc="/";
			
    		request.setAttribute("msg",msg);
    		request.setAttribute("loc",loc);
    		
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
            break;
        case "/payment/requestpay/fail":

			msg="상품 구매에 실패했습니다!";
			loc="/";
			
    		request.setAttribute("msg",msg);
    		request.setAttribute("loc",loc);
    		
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
            break;
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

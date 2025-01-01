package com.ttt.controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/enroll/form")
public class MemberEnrollCheckAndFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MemberEnrollCheckAndFormServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 동의 체크 여부를 판단하는 로직
		String[] values = {
	            request.getParameter("sign"),
	            request.getParameter("sign2"),
	            request.getParameter("sign3")
	        };
		// 하나라도 null이면 동의하지 않은 것으로 처리
		for (String value : values) {
            if (value == null) {
                request.setAttribute("errorMessage", "모든 동의 항목에 동의해야 합니다.");
                request.getRequestDispatcher("/WEB-INF/views/register/termsofservice.jsp").forward(request, response);
                return;
            }
        }
		request.getRequestDispatcher("/WEB-INF/views/enroll/enroll.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

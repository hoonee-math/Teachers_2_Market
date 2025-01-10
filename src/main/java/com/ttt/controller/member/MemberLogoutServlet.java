package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/member/logout")
public class MemberLogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MemberLogoutServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		//로그인 유지용 쿠키 삭제
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for (Cookie c : cookies) {
				if(c.getName().equals("saveId")) {
					c.setValue("");
					c.setMaxAge(0);
					c.setPath("/");
					response.addCookie(c);
					break;
				}
			}
		}
		
		//세션 무효화 - 진짜 로그아웃
		if(session != null) {
			session.invalidate();
		}
		
		//요청 처리후, 메시지창 띄우기
		request.setAttribute("msg", "로그아웃 되었습니다.");
		request.setAttribute("loc", "/");
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

}
